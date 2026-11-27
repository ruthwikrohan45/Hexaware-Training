create database if not exists bank_db;
use bank_db;

create table Branches (
 branch_id int auto_increment primary key,
 branch_name varchar(100) not null unique
) engine=InnoDB;

create table Customers (
 customer_id int auto_increment primary key,
 customer_name varchar(100) not null,
 address varchar(255) not null
) engine=InnoDB;

create table Relationship_Managers (
 manager_id int auto_increment primary key,
 manager_name varchar(100) not null,
 branch_id int not null,
 constraint fk_manager_branch foreign key (branch_id) references Branches(branch_id)
) engine=InnoDB;

create table Accounts (
 account_id int auto_increment primary key,
 account_number varchar(20) not null unique,
 account_type varchar(20) not null,
 balance decimal(15,2) not null,
 opened_date date not null,
 manager_id int not null,
 constraint chk_account_type check (account_type in ('Savings','Current','Fixed Deposit')),
 constraint chk_account_balance check (balance >= 0),
 constraint fk_account_manager foreign key (manager_id) references Relationship_Managers(manager_id)
) engine=InnoDB;

create table Account_Customers (
 account_id int not null,
 customer_id int not null,
 primary key (account_id, customer_id),
 constraint fk_ac_account foreign key (account_id) references Accounts(account_id),
 constraint fk_ac_customer foreign key (customer_id) references Customers(customer_id)
) engine=InnoDB;
