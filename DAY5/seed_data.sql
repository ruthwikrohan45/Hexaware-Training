use bank_db;
insert into Branches (branch_name) values ('Cuddalore Main'), ('Chennai Central');
insert into Customers (customer_name,address) values
('Rahul','Cuddalore, Tamil Nadu'),('Neha','Chennai, Tamil Nadu'),
('Amit','Villupuram, Tamil Nadu'),('Priya','Pondicherry');
insert into Relationship_Managers (manager_name,branch_id) values ('Arun',1),('Meena',2);
insert into Accounts (account_number,account_type,balance,opened_date,manager_id) values
('1000000001','Savings',25000.00,'2026-01-10',1),
('1000000002','Current',75000.00,'2026-02-15',2),
('1000000003','Fixed Deposit',150000.00,'2026-03-05',1),
('1000000004','Savings',8000.00,'2026-04-20',2),
('1000000005','Savings',45000.00,'2026-08-10',1),
('1000000006','Current',80000.00,'2026-09-05',2);
insert into Account_Customers values (1,1),(2,2),(3,1),(4,3),(2,4),(5,3),(6,4);
