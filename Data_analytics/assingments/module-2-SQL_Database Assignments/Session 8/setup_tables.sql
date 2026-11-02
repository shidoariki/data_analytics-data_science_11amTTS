-- =====================================================================
-- SESSION 8: JOINS: INNER, LEFT, RIGHT (Foundation Session)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Task 5 & Demo Pre-requisite: CustomerSegments Table
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS CustomerSegments;

CREATE TABLE CustomerSegments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(50) NOT NULL
);

INSERT INTO CustomerSegments (segment_id, segment_name) VALUES
(1, 'Premium Gold'),
(2, 'Regular Diner'),
(3, 'Occasional Saver'),
(4, 'New Customer');

-- ---------------------------------------------------------------------
-- Task 1: Users Table (user_id, username, city, [segment_id for Task 5])
-- ---------------------------------------------------------------------
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    segment_id INT,
    FOREIGN KEY (segment_id) REFERENCES CustomerSegments(segment_id)
);

-- Insert 4 users (user 3 'karan_patel' and user 4 'sneha_rao' will demonstrate cases)
INSERT INTO Users (user_id, username, city, segment_id) VALUES
(1, 'rohan_sharma', 'Mumbai', 1),
(2, 'priya_mehta', 'Bengaluru', 2),
(3, 'karan_patel', 'Ahmedabad', 3),
(4, 'sneha_rao', 'Pune', 4);

-- ---------------------------------------------------------------------
-- Task 1: Orders Table (order_id, user_id, product, amount)
-- Note: User 3 (karan_patel) and User 4 (sneha_rao) have NO orders.
--       Order 106 has user_id = 99 (orphaned order to test RIGHT JOIN).
-- ---------------------------------------------------------------------
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, product, amount) VALUES
(101, 1, 'Margherita Pizza', 350.00),
(102, 1, 'Garlic Breadsticks', 150.00),
(103, 2, 'Paneer Butter Masala', 420.00),
(104, 2, 'Butter Naan (Pack of 3)', 120.00),
(105, 1, 'Choco Lava Cake', 110.00),
(106, 99, 'Chicken Biryani', 380.00); -- user_id 99 does not exist in Users table (orphaned order)
