use bank_db;

-- TASK 3
create table test_table (id int auto_increment primary key, name varchar(50)) engine=InnoDB;
insert into test_table (name) values ('Rahul'),('Rohan');
select * from test_table;
delete from test_table;
insert into test_table (name) values ('Amit');
select * from test_table;
start transaction;
delete from test_table;
rollback;
select * from test_table;
truncate table test_table;
insert into test_table (name) values ('Neha');
select * from test_table;
drop table test_table;

-- TASK 4
insert into Customers (customer_name,address) values ('Kavin','Chennai, Tamil Nadu');
update Accounts set balance=55000.00 where account_number='1000000005';
delete from Customers where customer_name='Kavin';
select * from Accounts
where opened_date >= '2026-07-01' and opened_date < '2026-10-01' and balance > 20000;
select * from Accounts where account_type='Savings' or account_type='Current';
select * from Accounts where account_type in ('Savings','Fixed Deposit');
select * from Accounts where balance between 10000 and 100000;
select * from Accounts where account_number like '100%';
select * from Customers where customer_name like 'R%';

-- TASK 5 (run once)
alter table Customers add column kyc_status varchar(20) not null default 'Pending';
rename table Relationship_Managers to Bank_Relationship_Managers;
alter table Accounts drop check chk_account_balance;
