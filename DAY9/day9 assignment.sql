
-- ==========================================
-- TASK 9: INSURANCE POLICY RENEWAL SYSTEM
-- ==========================================

-- 1. CREATE DATABASE

create database if not exists insurance_db;
use insurance_db;

set sql_safe_updates = 0;


-- 2. CREATE TABLES

drop view if exists vw_policy_due;

drop table if exists policy_audit;
drop table if exists claims;
drop table if exists policies;
drop table if exists customers;


-- CUSTOMER TABLE

create table customers (
    customer_id int primary key,
    customer_name varchar(50),
    email varchar(100),
    phone varchar(15),
    address varchar(100),
    aadhaar_no varchar(20)
);


-- POLICY TABLE

create table policies (
    policy_id int primary key,
    customer_id int,
    policy_type varchar(30),
    premium decimal(10,2),
    due_date date,
    status varchar(20),
    no_of_claims int default 0,
    foreign key (customer_id)
    references customers(customer_id)
) engine = innodb;


-- CLAIMS TABLE

create table claims (
    claim_id int primary key,
    policy_id int,
    claim_status varchar(20),
    foreign key (policy_id)
    references policies(policy_id)
);


-- POLICY AUDIT TABLE

create table policy_audit (
    audit_id int auto_increment primary key,
    policy_id int,
    action varchar(50),
    old_premium decimal(10,2),
    new_premium decimal(10,2),
    action_date datetime default current_timestamp
);


-- 3. INSERT SAMPLE RECORDS

insert into customers values
(1, 'Arun', 'arun@gmail.com', '9876543210', 'Chennai', '123456789012'),
(2, 'Bala', 'bala@gmail.com', '9876543211', 'Coimbatore', '123456789013'),
(3, 'Kumar', 'kumar@gmail.com', '9876543212', 'Madurai', '123456789014'),
(4, 'Ravi', 'ravi@gmail.com', '9876543213', 'Salem', '123456789015'),
(5, 'Suresh', 'suresh@gmail.com', '9876543214', 'Trichy', '123456789016');


insert into policies values
(101, 1, 'Health', 10000, curdate() + interval 30 day, 'ACTIVE', 0),
(102, 2, 'Life', 15000, curdate() + interval 30 day, 'ACTIVE', 2),
(103, 3, 'Vehicle', 8000, curdate() + interval 60 day, 'ACTIVE', 1),
(104, 4, 'Health', 12000, curdate() - interval 10 day, 'ACTIVE', 0),
(105, 5, 'Life', 20000, curdate() - interval 20 day, 'ACTIVE', 1);


insert into claims values
(1, 102, 'PENDING'),
(2, 103, 'APPROVED');


-- ==========================================
-- TASK 1: CREATE VIEW
-- ==========================================

create or replace view vw_policy_due as
select
    p.policy_id,
    c.customer_name,
    c.email,
    c.phone,
    p.policy_type,
    p.premium,
    p.due_date,
    p.status
from policies p
join customers c
on p.customer_id = c.customer_id
where p.due_date between curdate()
and curdate() + interval 30 day;


-- DISPLAY VIEW

select * from vw_policy_due;


-- ==========================================
-- TASK 2: STORED PROCEDURE
-- POLICY RENEWAL
-- ==========================================

drop procedure if exists sp_renew_policy;

delimiter //

create procedure sp_renew_policy(in p_policy_id int)
begin

    declare v_status varchar(20);
    declare v_old_premium decimal(10,2);
    declare v_new_premium decimal(10,2);
    declare v_pending_claims int default 0;
    declare v_policy_count int default 0;

    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

    start transaction;

    select count(*) into v_policy_count
    from policies
    where policy_id = p_policy_id;

    if v_policy_count = 0 then
        signal sqlstate '45000'
        set message_text = 'Policy not found';
    end if;

    select status, premium
    into v_status, v_old_premium
    from policies
    where policy_id = p_policy_id
    for update;

    if v_status <> 'ACTIVE' then
        signal sqlstate '45000'
        set message_text = 'Policy is not active';
    end if;

    select count(*) into v_pending_claims
    from claims
    where policy_id = p_policy_id
    and claim_status = 'PENDING';

    if v_pending_claims > 0 then
        signal sqlstate '45000'
        set message_text = 'Policy has a pending claim';
    end if;

    set v_new_premium = v_old_premium * 1.10;

    update policies
    set premium = v_new_premium,
        due_date = date_add(due_date, interval 1 year)
    where policy_id = p_policy_id;

    insert into policy_audit
    (policy_id, action, old_premium, new_premium)
    values
    (p_policy_id, 'RENEWED', v_old_premium, v_new_premium);

    commit;

    select 'Policy renewed successfully' as message,
           v_new_premium as new_premium;

end //

delimiter ;


-- EXECUTE PROCEDURE

call sp_renew_policy(101);


-- ==========================================
-- TASK 3: CREATE FUNCTION
-- NO CLAIM DISCOUNT
-- ==========================================

drop function if exists fn_premium_with_no_claim_discount;

delimiter //

create function fn_premium_with_no_claim_discount(
    p_premium decimal(10,2),
    p_claims int
)
returns decimal(10,2)
deterministic
begin

    if p_claims = 0 then
        return p_premium * 0.90;
    else
        return p_premium;
    end if;

end //

delimiter ;


-- USE FUNCTION IN REPORT

select
    policy_id,
    policy_type,
    premium,
    no_of_claims,
    fn_premium_with_no_claim_discount(
        premium, no_of_claims
    ) as discounted_premium
from policies;


-- ==========================================
-- TASK 4: CURSOR WITH NOT FOUND HANDLER
-- ==========================================

drop procedure if exists update_lapsed_cursor;

delimiter //

create procedure update_lapsed_cursor(inout p_count int)
begin

    declare v_done int default 0;
    declare v_policy_id int;

    declare policy_cursor cursor for
        select policy_id
        from policies
        where due_date < curdate()
        and status = 'ACTIVE';

    declare continue handler for not found
        set v_done = 1;

    open policy_cursor;

    read_loop: loop

        fetch policy_cursor into v_policy_id;

        if v_done = 1 then
            leave read_loop;
        end if;

        update policies
        set status = 'LAPSED'
        where policy_id = v_policy_id;

        insert into policy_audit
        (policy_id, action)
        values
        (v_policy_id, 'LAPSED');

        set p_count = p_count + 1;

    end loop;

    close policy_cursor;

    select p_count as total_processed;

end //

delimiter ;


-- EXECUTE CURSOR PROCEDURE

set @processed = 0;

call update_lapsed_cursor(@processed);

select @processed as final_count;


-- ==========================================
-- TASK 4: SET-BASED APPROACH
-- WITHOUT CURSOR
-- ==========================================

drop procedure if exists update_lapsed_set;

delimiter //

create procedure update_lapsed_set(inout p_count int)
begin

    insert into policy_audit
    (policy_id, action)
    select policy_id, 'LAPSED'
    from policies
    where policy_id > 0
    and due_date < curdate()
    and status = 'ACTIVE';

    update policies
    set status = 'LAPSED'
    where policy_id > 0
    and due_date < curdate()
    and status = 'ACTIVE';

    set p_count = p_count + row_count();

    select p_count as total_processed;

end //

delimiter ;


-- ==========================================
-- TASK 5: INOUT PARAMETER
-- EXECUTE SET-BASED PROCEDURE
-- ==========================================

-- Reset expired policies to ACTIVE
-- ONLY FOR COMPARING BOTH METHODS

update policies
set status = 'ACTIVE'
where policy_id > 0
and due_date < curdate()
and status = 'LAPSED';


-- INITIAL COUNT

set @processed = 0;


-- CALL PROCEDURE

call update_lapsed_set(@processed);


-- DISPLAY FINAL COUNT

select @processed as final_count;


-- ==========================================
-- FINAL OUTPUT
-- ==========================================

select * from customers;

select * from policies;

select * from claims;

select * from policy_audit;

select * from vw_policy_due;
