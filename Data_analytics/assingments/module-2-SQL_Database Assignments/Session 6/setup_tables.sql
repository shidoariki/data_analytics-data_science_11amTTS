-- =====================================================================
-- SESSION 6: Aggregate Functions
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- 1. Demo Tables: demo_sales, demo_employees, demo_orders
DROP TABLE IF EXISTS demo_sales;
CREATE TABLE demo_sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    revenue DECIMAL(12,2)
);

INSERT INTO demo_sales (sale_id, product_name, revenue) VALUES
(1, 'Laptop', 75000.00),
(2, 'Smart TV', 42000.00),
(3, 'Smartphone', 28000.00),
(4, 'Air Conditioner', 36500.00),
(5, 'Refrigerator', 29000.00);

DROP TABLE IF EXISTS demo_employees;
CREATE TABLE demo_employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO demo_employees (emp_id, emp_name, department, salary) VALUES
(1, 'Rohan Sharma', 'Analytics', 85000.00),
(2, 'Neha Verma', 'Marketing', 62000.00),
(3, 'Amit Patel', 'Engineering', 98000.00),
(4, 'Priya Singh', 'Analytics', 74000.00),
(5, 'Vikas Joshi', 'Sales', 58000.00);

DROP TABLE IF EXISTS demo_orders;
CREATE TABLE demo_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_value DECIMAL(10,2)
);

INSERT INTO demo_orders (order_id, customer_id, order_value) VALUES
(101, 1, 12500.00),
(102, 2, 45000.00),
(103, 3, 8900.00),
(104, 4, 62000.00),
(105, 5, 23500.00);

-- 2. Task 1 Table: food_orders (Zomato-style order history)
DROP TABLE IF EXISTS food_orders;
CREATE TABLE food_orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_name VARCHAR(100),
    amount DECIMAL(8,2) NOT NULL
);

INSERT INTO food_orders (order_id, user_id, restaurant_name, amount) VALUES
(1, 101, 'Dominos Pizza', 450.00),
(2, 102, 'Biryani By Kilo', 680.00),
(3, 101, 'Subway', 320.00),
(4, 103, 'McDonalds', 540.00),
(5, 104, 'KFC', 410.00),
(6, 102, 'Barbeque Nation', 1450.00),
(7, 101, 'Haldirams', 290.00),
(8, 105, 'Burger King', 360.00),
(9, 103, 'Pizza Hut', 720.00),
(10, 101, 'Chai Point', 180.00);

-- 3. Task 2 Table: spotify_playlists
DROP TABLE IF EXISTS spotify_playlists;
CREATE TABLE spotify_playlists (
    playlist_id INT,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    added_date DATE,
    PRIMARY KEY (playlist_id, user_id, song_id)
);

INSERT INTO spotify_playlists (playlist_id, user_id, song_id, added_date) VALUES
(1, 101, 501, '2024-03-01'),
(1, 101, 502, '2024-03-02'),
(1, 101, 503, '2024-03-05'),
(1, 101, 504, '2024-03-10'),
(1, 101, 505, '2024-03-12'),
(1, 101, 506, '2024-03-15'),
(1, 101, 507, '2024-03-18'),
(2, 102, 501, '2024-03-04'),
(2, 102, 508, '2024-03-08'),
(2, 102, 509, '2024-03-11'),
(3, 103, 510, '2024-03-14');

-- 4. Task 3 Table: bookmyshow_reviews
DROP TABLE IF EXISTS bookmyshow_reviews;
CREATE TABLE bookmyshow_reviews (
    review_id INT PRIMARY KEY,
    movie_id INT NOT NULL,
    user_id INT,
    rating DECIMAL(3,2) NOT NULL
);

INSERT INTO bookmyshow_reviews (review_id, movie_id, user_id, rating) VALUES
(1, 201, 11, 4.5),
(2, 201, 12, 4.8),
(3, 201, 13, 4.2),
(4, 201, 14, 4.6),
(5, 201, 15, 3.9),
(6, 201, 16, 4.7),
(7, 201, 17, 4.4),
(8, 202, 11, 3.8),
(9, 202, 12, 3.5),
(10, 202, 13, 4.0);

-- 5. Task 4 Table: paytm_transactions
DROP TABLE IF EXISTS paytm_transactions;
CREATE TABLE paytm_transactions (
    txn_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    txn_type VARCHAR(30)
);

INSERT INTO paytm_transactions (txn_id, user_id, amount, txn_type) VALUES
(301, 101, 20.00, 'UPI P2M (Tea Stall)'),
(302, 101, 1450.00, 'Electricity Bill'),
(303, 101, 350.00, 'Groceries'),
(304, 101, 8500.00, 'Flight Booking'),
(305, 101, 150.00, 'Metro Card Recharge'),
(306, 101, 12000.00, 'Rent Payment Transfer'),
(307, 101, 45.00, 'Snacks'),
(308, 102, 120.00, 'Auto Fare'),
(309, 102, 4500.00, 'Online Shopping');

-- 6. Task 5 Table: myntra_orders
DROP TABLE IF EXISTS myntra_orders;
CREATE TABLE myntra_orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_date DATE
);

INSERT INTO myntra_orders (order_id, user_id, total_price, order_date) VALUES
(401, 101, 1499.00, '2024-01-10'),
(402, 101, 2999.00, '2024-01-25'),
(403, 101, 899.00, '2024-02-14'),
(404, 102, 4500.00, '2024-01-15'),
(405, 102, 6200.00, '2024-02-05'),
(406, 103, 1299.00, '2024-02-18'),
(407, 104, 3499.00, '2024-01-20'),
(408, 104, 1899.00, '2024-02-10'),
(409, 104, 5499.00, '2024-03-01'),
(410, 105, 799.00, '2024-03-05');
