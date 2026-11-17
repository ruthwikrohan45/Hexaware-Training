
CREATE DATABASE insurance_reporting;

USE insurance_reporting;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    dob DATE,
    email VARCHAR(100)
);
INSERT INTO customers VALUES
(1, 'Asha Kumar', '1995-04-10', 'asha@gmail.com'),
(2, 'Bala Raj', '1988-08-22', 'bala@gmail.com'),
(3, 'Charan Das', '2001-02-14', 'charan@gmail.com'),
(4, 'Divya Sri', '1978-11-05', 'divya@gmail.com'),
(5, 'Ezhil Mani', '1965-06-18', 'ezhil@gmail.com'),
(6, 'Farah Khan', '1999-09-12', 'farah@gmail.com'),
(7, 'Gokul Anand', '1990-03-30', 'gokul@gmail.com'),
(8, 'Hari Prasad', '2005-01-25', 'hari@gmail.com'),
(9, 'Ishita Roy', '1982-07-07', 'ishita@gmail.com'),
(10, 'Jai Kumar', '1970-12-19', 'jai@gmail.com');

CREATE TABLE agents (
    agent_id INT PRIMARY KEY AUTO_INCREMENT,
    agent_name VARCHAR(100)
);INSERT INTO agents VALUES
(1, 'Anita'),
(2, 'Bharath'),
(3, 'Chitra'),
(4, 'Deepak'),
(5, 'Farooq');

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100)
);INSERT INTO products VALUES
(1, 'Health'),
(2, 'Life'),
(3, 'Motor'),
(4, 'Travel');

CREATE TABLE policies (
    policy_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_number VARCHAR(30),
    customer_id INT,
    product_id INT,
    agent_id INT,
    premium DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);INSERT INTO policies VALUES
(1001, 'POL-2026-0001', 1, 1, 1, 12000, '2026-01-10', DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'Active'),

(1002, 'POL-2026-0002', 1, 2, 2, 18000, '2026-02-01', DATE_ADD(CURDATE(), INTERVAL 300 DAY), 'Active'),

(1003, 'POL-2026-0003', 2, 3, 1, 9000, '2026-03-15', DATE_ADD(CURDATE(), INTERVAL 20 DAY), 'Active'),

(1004, 'POL-2026-0004', 3, 1, 3, 15000, '2026-04-10', DATE_ADD(CURDATE(), INTERVAL 400 DAY), 'Active'),

(1005, 'POL-2026-0005', 4, 2, 2, 22000, '2026-05-01', DATE_ADD(CURDATE(), INTERVAL 500 DAY), 'Active'),

(1006, 'POL-2026-0006', 5, 3, 4, 11000, '2026-06-01', DATE_ADD(CURDATE(), INTERVAL 600 DAY), 'Active'),

(1007, 'POL-2026-0007', 6, 4, 3, 5000, '2026-07-01', DATE_ADD(CURDATE(), INTERVAL 15 DAY), 'Active'),

(1008, 'POL-2026-0008', 7, 1, 1, 14000, '2026-08-01', DATE_ADD(CURDATE(), INTERVAL 45 DAY), 'Active'),

(1009, 'POL-2026-0009', 8, 4, 5, 6000, '2026-09-01', DATE_ADD(CURDATE(), INTERVAL 700 DAY), 'Active'),

(1010, 'POL-2026-0010', 9, 3, 4, 10000, '2026-10-01', DATE_ADD(CURDATE(), INTERVAL 800 DAY), 'Active'),

(1011, 'POL-2026-0011', 10, 2, 5, 25000, '2026-11-01', DATE_ADD(CURDATE(), INTERVAL 900 DAY), 'Active'),

(1012, 'POL-2026-0012', 2, 1, 2, 13000, '2026-11-05', DATE_ADD(CURDATE(), INTERVAL 700 DAY), 'Active'),

(1013, 'POL-2026-0013', 3, 3, 3, 8000, '2026-11-10', DATE_ADD(CURDATE(), INTERVAL 700 DAY), 'Active'),

(1014, 'POL-2026-0014', 4, 4, 4, 7000, '2026-09-15', DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'Active'),

(1015, 'POL-2026-0015', 6, 1, 5, 16000, '2026-10-15', DATE_ADD(CURDATE(), INTERVAL 900 DAY), 'Active');

CREATE TABLE claims (
    claim_id INT PRIMARY KEY AUTO_INCREMENT,
    policy_id INT,
    claim_amount DECIMAL(10,2),
    claim_date DATE,
    claim_status VARCHAR(30),
    FOREIGN KEY (policy_id) REFERENCES policies(policy_id)
);INSERT INTO claims VALUES
(1, 1001, 8000, '2026-02-10', 'Approved'),
(2, 1004, 10000, '2026-05-10', 'Approved'),
(3, 1008, 3000, '2026-09-10', 'Pending'),
(4, 1012, 10000, '2026-11-08', 'Approved'),
(5, 1002, 15000, '2026-03-10', 'Approved'),
(6, 1005, 20000, '2026-06-10', 'Approved'),
(7, 1011, 10000, '2026-11-05', 'Pending');


SELECT
    p.policy_id,
    p.policy_number,
    c.customer_name,
    p.end_date,
    DATEDIFF(p.end_date, CURDATE()) AS days_remaining
FROM policies p
INNER JOIN customers c
ON p.customer_id = c.customer_id
WHERE p.status = 'Active'
AND p.end_date BETWEEN CURDATE()
AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY p.end_date;


SELECT
    pr.product_name,
    SUM(p.premium) AS total_premium
FROM policies p
INNER JOIN products pr
ON p.product_id = pr.product_id
GROUP BY pr.product_name;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(p.policy_id) AS active_policy_count
FROM customers c
INNER JOIN policies p
ON c.customer_id = p.customer_id
WHERE p.status = 'Active'
AND p.end_date >= CURDATE()
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(p.policy_id) > 1;


SELECT
    pr.product_name,
    SUM(p.premium) AS total_premium,
    SUM(COALESCE(cl.total_claim, 0)) AS total_claims,
    ROUND(
        SUM(COALESCE(cl.total_claim, 0))
        / SUM(p.premium) * 100, 2
    ) AS claim_ratio
FROM products pr
INNER JOIN policies p
ON pr.product_id = p.product_id
LEFT JOIN (
    SELECT policy_id, SUM(claim_amount) AS total_claim
    FROM claims
    GROUP BY policy_id
) cl
ON p.policy_id = cl.policy_id
GROUP BY pr.product_name
HAVING claim_ratio > 60;


SELECT
    p.policy_id,
    CONCAT('****', SUBSTRING(p.policy_number, -4))
        AS masked_policy_number,
    c.customer_name,
    pr.product_name
FROM policies p
INNER JOIN customers c
ON p.customer_id = c.customer_id
INNER JOIN products pr
ON p.product_id = pr.product_id
LEFT JOIN claims cl
ON p.policy_id = cl.policy_id
WHERE cl.claim_id IS NULL;


SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE())
             BETWEEN 18 AND 30 THEN '18-30'
        WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE())
             BETWEEN 31 AND 45 THEN '31-45'
        WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE())
             BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_band,
    ROUND(AVG(p.premium), 2) AS average_premium
FROM customers c
CROSS JOIN (SELECT CURDATE() AS report_date) d
INNER JOIN policies p
ON c.customer_id = p.customer_id
WHERE p.status = 'Active'
AND TIMESTAMPDIFF(YEAR, c.dob, d.report_date) >= 18
GROUP BY age_band;


SELECT
    DATE_FORMAT(start_date, '%Y-%m') AS policy_month,
    COUNT(*) AS new_policies
FROM policies
GROUP BY DATE_FORMAT(start_date, '%Y-%m')
ORDER BY policy_month;


SELECT
    a.agent_id,
    a.agent_name,
    SUM(p.premium) AS total_premium
FROM agents a
INNER JOIN policies p
ON a.agent_id = p.agent_id
GROUP BY a.agent_id, a.agent_name
ORDER BY total_premium DESC
LIMIT 5;

SELECT
    c.customer_name,

    DATEDIFF(CURDATE(), c.dob) AS age_in_days,

    CASE
        WHEN CURDATE() < DATE_ADD(c.dob, INTERVAL 18 YEAR)
            THEN 'Below 18'
        WHEN CURDATE() < DATE_ADD(c.dob, INTERVAL 31 YEAR)
            THEN '18-30'
        WHEN CURDATE() < DATE_ADD(c.dob, INTERVAL 46 YEAR)
            THEN '31-45'
        WHEN CURDATE() < DATE_ADD(c.dob, INTERVAL 61 YEAR)
            THEN '46-60'
        ELSE '60+'
    END AS age_band,

    CONCAT('****', SUBSTRING(p.policy_number, -4))
        AS masked_policy_number

FROM customers c
INNER JOIN policies p
ON c.customer_id = p.customer_id;


SELECT
    pr.product_name,
    SUM(p.premium) AS total_premium,
    SUM(cl.claim_amount) AS total_claim
FROM products pr
JOIN policies p
ON pr.product_id = p.product_id
JOIN claims cl
ON p.policy_id = cl.policy_id
GROUP BY pr.product_name
HAVING (SUM(cl.claim_amount) / SUM(p.premium)) * 100 > 60;

SELECT *
FROM customers c
INNER JOIN policies p
ON c.customer_id = p.customer_id;

SELECT p.policy_number
FROM policies p
LEFT JOIN claims c
ON p.policy_id = c.policy_id
WHERE c.claim_id IS NULL;

SELECT c.customer_name, a.age_band
FROM customers c
CROSS JOIN (
    SELECT '18-30' AS age_band
    UNION ALL
    SELECT '31-45'
    UNION ALL
    SELECT '46-60'
    UNION ALL
    SELECT '60+'
) a;

