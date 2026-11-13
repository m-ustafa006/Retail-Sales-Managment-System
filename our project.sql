CREATE DATABASE IF NOT EXISTS `our project`;
USE `our project`;

-- Remove old tables if they exist
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS sale_items;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS branches;
DROP TABLE IF EXISTS regions;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Regions
CREATE TABLE regions (
    region_id INT AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Branches
CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    region_id INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    FOREIGN KEY (region_id)
        REFERENCES regions(region_id)
);

-- 3. Employees
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    branch_id INT NOT NULL,
    manager_id INT NULL,
    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id),
    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

-- 4. Customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(100),
    registration_date DATE NOT NULL
);

-- 5. Products
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

-- 6. Sales
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    employee_id INT NOT NULL,
    branch_id INT NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),
    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

-- 7. Sale Items
CREATE TABLE sale_items (
    sale_item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (sale_id)
        REFERENCES sales(sale_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Insert Regions
INSERT INTO regions (region_name) VALUES
('Kigali'),
('Eastern Province'),
('Northern Province');

-- Insert Branches
INSERT INTO branches (branch_name, region_id, city) VALUES
('Kigali Main Branch', 1, 'Kigali'),
('Kigali City Branch', 1, 'Kigali'),
('Rwamagana Branch', 2, 'Rwamagana'),
('Musanze Branch', 3, 'Musanze');

-- Insert Employees
INSERT INTO employees
(employee_name, job_title, branch_id, manager_id)
VALUES
('Ahmed', 'Branch Manager', 1, NULL),
('Mohammad', 'Sales Representative', 1, 1),
('Mustafa', 'Sales Representative', 2, 1),
('Amaar', 'Branch Manager', 3, NULL),
('Daniel', 'Sales Representative', 3, 4),
('Sarah', 'Branch Manager', 4, NULL);

-- Insert Customers
INSERT INTO customers
(customer_name, email, city, registration_date)
VALUES
('Ahmed', 'ahmed@example.com', 'Kigali', '2026-01-05'),
('Mohammad', 'mohammad@example.com', 'Kigali', '2026-01-12'),
('Mustafa', 'mustafa@example.com', 'Rwamagana', '2026-02-03'),
('Amaar', 'amaar@example.com', 'Musanze', '2026-02-15'),
('James', 'james@example.com', 'Kigali', '2026-03-01'),
('Grace', 'grace@example.com', 'Rwamagana', '2026-03-10'),
('Peter', 'peter@example.com', 'Musanze', '2026-04-02'),
('Amina', 'amina@example.com', 'Kigali', '2026-04-18');

-- Insert Products
INSERT INTO products
(product_name, category, unit_price)
VALUES
('Laptop', 'Electronics', 850.00),
('Smartphone', 'Electronics', 450.00),
('Headphones', 'Accessories', 45.00),
('Keyboard', 'Accessories', 30.00),
('Office Chair', 'Furniture', 120.00),
('Desk', 'Furniture', 200.00),
('Monitor', 'Electronics', 180.00),
('Mouse', 'Accessories', 20.00);

-- Insert Sales
INSERT INTO sales
(customer_id, employee_id, branch_id, sale_date)
VALUES
(1, 2, 1, '2026-01-10'),
(2, 2, 1, '2026-01-18'),
(3, 5, 3, '2026-01-25'),
(4, 6, 4, '2026-02-05'),
(5, 3, 2, '2026-02-14'),
(6, 5, 3, '2026-02-20'),
(1, 2, 1, '2026-03-03'),
(7, 6, 4, '2026-03-15'),
(8, 3, 2, '2026-03-22'),
(2, 2, 1, '2026-04-04'),
(3, 5, 3, '2026-04-12'),
(4, 6, 4, '2026-04-25'),
(5, 3, 2, '2026-05-06'),
(6, 5, 3, '2026-05-17'),
(7, 6, 4, '2026-05-28'),
(8, 3, 2, '2026-06-08'),
(1, 2, 1, '2026-06-16'),
(2, 2, 1, '2026-06-24');

-- Insert Sale Items
INSERT INTO sale_items
(sale_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 850.00),
(1, 3, 2, 45.00),
(2, 2, 1, 450.00),
(2, 4, 2, 30.00),
(3, 5, 2, 120.00),
(3, 8, 3, 20.00),
(4, 6, 1, 200.00),
(4, 7, 2, 180.00),
(5, 1, 1, 850.00),
(5, 8, 2, 20.00),
(6, 2, 2, 450.00),
(6, 3, 1, 45.00),
(7, 7, 2, 180.00),
(7, 4, 3, 30.00),
(8, 5, 1, 120.00),
(8, 6, 1, 200.00),
(9, 2, 1, 450.00),
(9, 3, 2, 45.00),
(10, 1, 1, 850.00),
(10, 4, 1, 30.00),
(11, 8, 5, 20.00),
(11, 5, 1, 120.00),
(12, 7, 1, 180.00),
(12, 6, 1, 200.00),
(13, 2, 2, 450.00),
(13, 3, 2, 45.00),
(14, 1, 1, 850.00),
(14, 8, 4, 20.00),
(15, 5, 2, 120.00),
(15, 4, 2, 30.00),
(16, 7, 2, 180.00),
(16, 3, 3, 45.00),
(17, 1, 1, 850.00),
(17, 2, 1, 450.00),
(18, 6, 2, 200.00),
(18, 8, 5, 20.00);

-- Check all tables
SELECT * FROM regions;
SELECT * FROM branches;
SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sales;
SELECT * FROM sale_items;

-- Create Sales Details View
CREATE OR REPLACE VIEW sales_details AS
SELECT
    s.sale_id,
    s.sale_date,
    c.customer_id,
    c.customer_name,
    e.employee_id,
    e.employee_name,
    b.branch_id,
    b.branch_name,
    r.region_id,
    r.region_name,
    p.product_id,
    p.product_name,
    p.category,
    si.quantity,
    si.unit_price,
    (si.quantity * si.unit_price) AS line_total
FROM sales s
JOIN customers c
    ON s.customer_id = c.customer_id
JOIN employees e
    ON s.employee_id = e.employee_id
JOIN branches b
    ON s.branch_id = b.branch_id
JOIN regions r
    ON b.region_id = r.region_id
JOIN sale_items si
    ON s.sale_id = si.sale_id
JOIN products p
    ON si.product_id = p.product_id;

-- Display the View
SELECT * FROM sales_details;

-- 1. INNER JOIN
-- Display sales with customer names
SELECT
    s.sale_id,
    s.sale_date,
    c.customer_name
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id;


-- 2. LEFT JOIN
-- Display all customers, even if they have no sales
SELECT
    c.customer_id,
    c.customer_name,
    s.sale_id,
    s.sale_date
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id;


-- 3. RIGHT JOIN
-- Display all branches, even if they have no sales
SELECT
    b.branch_id,
    b.branch_name,
    s.sale_id,
    s.sale_date
FROM sales s
RIGHT JOIN branches b
    ON s.branch_id = b.branch_id;


-- 4. FULL OUTER JOIN equivalent in MySQL
-- MySQL does not directly support FULL OUTER JOIN.
SELECT
    c.customer_id,
    c.customer_name,
    s.sale_id,
    s.sale_date
FROM customers c
LEFT JOIN sales s
    ON c.customer_id = s.customer_id

UNION ALL

SELECT
    c.customer_id,
    c.customer_name,
    s.sale_id,
    s.sale_date
FROM customers c
RIGHT JOIN sales s
    ON c.customer_id = s.customer_id
WHERE c.customer_id IS NULL;


-- 5. SELF JOIN
-- Display employees and their managers
SELECT
    e.employee_name AS employee,
    e.job_title,
    m.employee_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;


-- Sales by product, branch and region
SELECT
    region_name,
    branch_name,
    product_name,
    SUM(quantity) AS units_sold,
    SUM(line_total) AS total_sales
FROM sales_details
GROUP BY
    region_name,
    branch_name,
    product_name
ORDER BY
    region_name,
    total_sales DESC;
    
    -- 1. ROW_NUMBER()
WITH product_region_sales AS (
    SELECT
        region_name,
        product_name,
        SUM(line_total) AS total_sales
    FROM sales_details
    GROUP BY region_name, product_name
)
SELECT
    region_name,
    product_name,
    total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY region_name
        ORDER BY total_sales DESC
    ) AS row_num
FROM product_region_sales;


-- 2. RANK()
WITH product_region_sales AS (
    SELECT
        region_name,
        product_name,
        SUM(line_total) AS total_sales
    FROM sales_details
    GROUP BY region_name, product_name
)
SELECT
    region_name,
    product_name,
    total_sales,
    RANK() OVER (
        PARTITION BY region_name
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM product_region_sales;


-- 3. DENSE_RANK()
WITH product_region_sales AS (
    SELECT
        region_name,
        product_name,
        SUM(line_total) AS total_sales
    FROM sales_details
    GROUP BY region_name, product_name
)
SELECT
    region_name,
    product_name,
    total_sales,
    DENSE_RANK() OVER (
        PARTITION BY region_name
        ORDER BY total_sales DESC
    ) AS dense_sales_rank
FROM product_region_sales;


-- 4. PERCENT_RANK()
WITH product_region_sales AS (
    SELECT
        region_name,
        product_name,
        SUM(line_total) AS total_sales
    FROM sales_details
    GROUP BY region_name, product_name
)
SELECT
    region_name,
    product_name,
    total_sales,
    PERCENT_RANK() OVER (
        PARTITION BY region_name
        ORDER BY total_sales
    ) AS percent_rank_value
FROM product_region_sales;


-- SUCCESS CRITERION 1:
-- Top five products in each region
WITH product_region_sales AS (
    SELECT
        region_name,
        product_name,
        SUM(line_total) AS total_sales
    FROM sales_details
    GROUP BY region_name, product_name
),
ranked_products AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY region_name
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_region_sales
)
SELECT
    region_name,
    product_name,
    total_sales,
    product_rank
FROM ranked_products
WHERE product_rank <= 5
ORDER BY region_name, product_rank;
-- SUM, AVG, MIN, MAX and COUNT
SELECT
    sale_id,
    sale_date,
    line_total,
    SUM(line_total) OVER () AS grand_total,
    AVG(line_total) OVER () AS overall_average,
    MIN(line_total) OVER () AS minimum_sale,
    MAX(line_total) OVER () AS maximum_sale,
    COUNT(*) OVER () AS total_records
FROM sales_details
ORDER BY sale_date;


-- Aggregate functions by region
SELECT
    region_name,
    sale_id,
    line_total,
    SUM(line_total) OVER (
        PARTITION BY region_name
    ) AS region_total,
    AVG(line_total) OVER (
        PARTITION BY region_name
    ) AS region_average
FROM sales_details
ORDER BY region_name;


-- SUCCESS CRITERION 2:
-- Cumulative monthly sales
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        SUM(line_total) AS monthly_total
    FROM sales_details
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_total,
    SUM(monthly_total) OVER (
        ORDER BY sales_month
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_sales
FROM monthly_sales
ORDER BY sales_month;


-- Three-row moving average using ROWS BETWEEN
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        SUM(line_total) AS monthly_total
    FROM sales_details
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_total,
    AVG(monthly_total) OVER (
        ORDER BY sales_month
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS moving_average
FROM monthly_sales
ORDER BY sales_month;


-- RANGE BETWEEN
WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR_MONTH FROM sale_date) AS month_number,
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        SUM(line_total) AS monthly_total
    FROM sales_details
    GROUP BY
        EXTRACT(YEAR_MONTH FROM sale_date),
        DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_total,
    SUM(monthly_total) OVER (
        ORDER BY month_number
        RANGE BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS range_running_total
FROM monthly_sales
ORDER BY month_number;


-- SUCCESS CRITERION 5:
-- Three-month moving average
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        SUM(line_total) AS monthly_total
    FROM sales_details
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_total,
    ROUND(
        AVG(monthly_total) OVER (
            ORDER BY sales_month
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW
        ), 2
    ) AS three_month_moving_average
FROM monthly_sales
ORDER BY sales_month;
-- LAG and LEAD
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        SUM(line_total) AS monthly_total
    FROM sales_details
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_total,
    LAG(monthly_total) OVER (
        ORDER BY sales_month
    ) AS previous_month_sales,
    LEAD(monthly_total) OVER (
        ORDER BY sales_month
    ) AS next_month_sales
FROM monthly_sales
ORDER BY sales_month;


-- SUCCESS CRITERION 3:
-- Compare monthly sales
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        SUM(line_total) AS monthly_total
    FROM sales_details
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_total,
    LAG(monthly_total, 1) OVER (
        ORDER BY sales_month
    ) AS previous_month,
    LEAD(monthly_total, 1) OVER (
        ORDER BY sales_month
    ) AS following_month,
    monthly_total - LAG(monthly_total, 1) OVER (
        ORDER BY sales_month
    ) AS change_from_previous
FROM monthly_sales
ORDER BY sales_month;
-- Customer spending
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(
            SUM(si.quantity * si.unit_price), 0
        ) AS total_spending
    FROM customers c
    LEFT JOIN sales s
        ON c.customer_id = s.customer_id
    LEFT JOIN sale_items si
        ON s.sale_id = si.sale_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spending,
    NTILE(4) OVER (
        ORDER BY total_spending DESC
    ) AS customer_group
FROM customer_spending
ORDER BY customer_group;


-- SUCCESS CRITERION 4:
-- Divide customers into four groups
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(
            SUM(si.quantity * si.unit_price), 0
        ) AS total_spending
    FROM customers c
    LEFT JOIN sales s
        ON c.customer_id = s.customer_id
    LEFT JOIN sale_items si
        ON s.sale_id = si.sale_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_name,
    total_spending,
    NTILE(4) OVER (
        ORDER BY total_spending DESC
    ) AS spending_group
FROM customer_spending;


-- CUME_DIST
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(
            SUM(si.quantity * si.unit_price), 0
        ) AS total_spending
    FROM customers c
    LEFT JOIN sales s
        ON c.customer_id = s.customer_id
    LEFT JOIN sale_items si
        ON s.sale_id = si.sale_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_name,
    total_spending,
    CUME_DIST() OVER (
        ORDER BY total_spending
    ) AS cumulative_distribution
FROM customer_spending
ORDER BY total_spending;
-- 1. Total revenue by branch
SELECT
    branch_name,
    region_name,
    SUM(line_total) AS total_revenue
FROM sales_details
GROUP BY branch_name, region_name
ORDER BY total_revenue DESC;


-- 2. Best-selling products
SELECT
    product_name,
    SUM(quantity) AS total_units_sold
FROM sales_details
GROUP BY product_name
ORDER BY total_units_sold DESC;


-- 3. Employee sales performance
SELECT
    employee_name,
    COUNT(DISTINCT sale_id) AS number_of_sales,
    SUM(line_total) AS total_revenue
FROM sales_details
GROUP BY employee_name
ORDER BY total_revenue DESC;


-- 4. Customer purchase summary
SELECT
    customer_name,
    COUNT(DISTINCT sale_id) AS number_of_orders,
    SUM(line_total) AS total_spending
FROM sales_details
GROUP BY customer_name
ORDER BY total_spending DESC;
