-- =====================================================================
-- SESSION 10: UNION & UNION ALL
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Tables: online_sales and offline_sales
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS online_sales;
CREATE TABLE online_sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    sale_date DATE NOT NULL
);

INSERT INTO online_sales (sale_id, customer_name, amount, sale_date) VALUES
(1, 'Rohan Sharma', 1450.00, '2024-02-10'),
(2, 'Priya Patel', 2800.00, '2024-02-12'),
(3, 'Amit Verma', 390.00, '2024-02-15'),
(4, 'Neha Gupta', 5200.00, '2024-02-18');

DROP TABLE IF EXISTS offline_sales;
CREATE TABLE offline_sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    sale_date DATE NOT NULL
);

INSERT INTO offline_sales (sale_id, customer_name, amount, sale_date) VALUES
(101, 'Vikram Malhotra', 1850.00, '2024-02-11'),
(102, 'Priya Patel', 1200.00, '2024-02-14'), -- Customer Priya Patel bought both online and offline
(103, 'Ananya Sen', 640.00, '2024-02-16'),
(104, 'Siddharth Joshi', 3100.00, '2024-02-19');

-- ---------------------------------------------------------------------
-- Tasks 1 - 4 Tables: AppOrders & InStoreOrders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS AppOrders;
CREATE TABLE AppOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO AppOrders (order_id, customer_name, amount, order_date) VALUES
(1, 'Rohan Sharma', 450.00, '2024-03-01'),
(2, 'Priya Mehta', 620.00, '2024-03-02'),
(3, 'Aarav Patel', 310.00, '2024-03-03'),
(4, 'Sneha Rao', 540.00, '2024-03-04');

DROP TABLE IF EXISTS InStoreOrders;
CREATE TABLE InStoreOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO InStoreOrders (order_id, customer_name, amount, order_date) VALUES
(101, 'Karan Joshi', 780.00, '2024-03-01'),
(102, 'Rohan Sharma', 950.00, '2024-03-02'),  -- Duplicate customer across tables
(103, 'Neha Verma', 410.00, '2024-03-03'),
(104, 'Priya Mehta', 530.00, '2024-03-05');  -- Duplicate customer across tables
