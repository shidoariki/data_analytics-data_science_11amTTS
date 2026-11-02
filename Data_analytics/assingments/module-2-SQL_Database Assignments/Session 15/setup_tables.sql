-- =====================================================================
-- SESSION 15: Date Functions
-- Setup Script: Database Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: customer_visits
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS customer_visits;
CREATE TABLE customer_visits (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    last_visit_date DATE NOT NULL
);

INSERT INTO customer_visits (customer_id, customer_name, last_visit_date) VALUES
(1, 'Aarav Patel', '2024-03-15'),
(2, 'Diya Sharma', '2023-11-20'),
(3, 'Rohan Verma', '2024-04-01'),
(4, 'Ananya Iyer', '2023-08-10'),
(5, 'Kabir Mehta', '2024-02-28');

-- ---------------------------------------------------------------------
-- Task 2 Table: Orders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (order_id, order_date, total_amount) VALUES
(101, '2023-01-15', 799.00),
(102, '2023-06-21', 1499.00),
(103, '2023-10-31', 450.00),
(104, '2024-02-14', 2199.00),
(105, '2024-04-05', 920.00);

-- ---------------------------------------------------------------------
-- Task 3 Table: Deliveries
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Deliveries;
CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    delivery_date DATE NOT NULL
);

INSERT INTO Deliveries (delivery_id, order_id, delivery_date) VALUES
(501, 101, '2024-04-10'),
(502, 102, '2024-04-12'),
(503, 103, '2024-04-15'),
(504, 104, '2024-04-18'),
(505, 105, '2024-04-20');

-- ---------------------------------------------------------------------
-- Task 4 Table: Subscriptions
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Subscriptions;
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_name VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

INSERT INTO Subscriptions (subscription_id, user_id, plan_name, start_date, end_date) VALUES
(1, 1001, 'Zomato Gold 3-Months', '2024-01-01', '2024-03-31'),
(2, 1002, 'Spotify Premium Annual', '2023-05-01', '2024-04-30'),
(3, 1003, 'Netflix Standard Monthly', '2024-03-01', '2024-03-31'),
(4, 1004, 'Flipkart Plus Annual', '2023-01-01', '2023-12-31'),
(5, 1005, 'Hotstar Super 6-Months', '2023-10-01', '2024-03-29');

-- ---------------------------------------------------------------------
-- Task 5 Table: AppLogins
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS AppLogins;
CREATE TABLE AppLogins (
    login_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    last_login_date DATE NOT NULL
);

-- Note: Some users logged in recently (<30 days), others dormant (>30 days)
INSERT INTO AppLogins (login_id, user_id, last_login_date) VALUES
(1, 201, '2024-04-01'),  -- Active recently
(2, 202, '2024-01-15'),  -- Inactive (>30 days)
(3, 203, '2023-12-05'),  -- Inactive (>30 days)
(4, 204, '2024-04-04'),  -- Active recently
(5, 205, '2024-02-10'),  -- Inactive (>30 days)
(6, 206, '2023-09-20');  -- Inactive (>30 days)
