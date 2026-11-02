-- =====================================================================
-- SESSION 7: GROUP BY & HAVING (Critical Analytics Topic)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- 1. Demo Table: regional_sales
DROP TABLE IF EXISTS regional_sales;
CREATE TABLE regional_sales (
    sale_id INT PRIMARY KEY,
    region VARCHAR(50) NOT NULL,
    sales_rep VARCHAR(50),
    revenue DECIMAL(12,2) NOT NULL
);

INSERT INTO regional_sales (sale_id, region, sales_rep, revenue) VALUES
(1, 'North', 'Amit', 450000.00),
(2, 'North', 'Rohan', 650000.00),
(3, 'South', 'Priya', 800000.00),
(4, 'South', 'Deepa', 750000.00),
(5, 'West', 'Siddharth', 550000.00),
(6, 'West', 'Neha', 620000.00),
(7, 'East', 'Ananya', 320000.00),
(8, 'East', 'Vikram', 410000.00),
(9, 'Central', 'Manoj', 280000.00);

-- 2. Task 1 Table: food_orders
DROP TABLE IF EXISTS food_orders;
CREATE TABLE food_orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_name VARCHAR(100),
    order_amount DECIMAL(8,2) NOT NULL
);

INSERT INTO food_orders (order_id, user_id, restaurant_name, order_amount) VALUES
(101, 1, 'Dominos Pizza', 450.00),
(102, 2, 'Subway', 290.00),
(103, 1, 'Biryani By Kilo', 750.00),
(104, 3, 'McDonalds', 380.00),
(105, 1, 'KFC', 520.00),
(106, 2, 'Haldirams', 310.00),
(107, 4, 'Burger King', 260.00),
(108, 1, 'Chai Point', 150.00),
(109, 3, 'Pizza Hut', 690.00),
(110, 2, 'Taco Bell', 420.00);

-- 3. Task 2 Table: transactions
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL
);

INSERT INTO transactions (transaction_id, user_id, amount, payment_method) VALUES
(1, 101, 2500.00, 'UPI'),
(2, 102, 12000.00, 'Credit Card'),
(3, 103, 450.00, 'Cash on Delivery'),
(4, 104, 1800.00, 'UPI'),
(5, 105, 7500.00, 'Debit Card'),
(6, 106, 3200.00, 'Net Banking'),
(7, 107, 4100.00, 'UPI'),
(8, 108, 15000.00, 'Credit Card'),
(9, 109, 850.00, 'Cash on Delivery'),
(10, 110, 6300.00, 'UPI');

-- 4. Task 3 Table: movies
-- Note: 1 crore = 10,000,000 (10M). Above 10 crore = > 100000000.
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    movie_title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    box_office_collection DECIMAL(14,2) NOT NULL
);

INSERT INTO movies (movie_id, movie_title, genre, box_office_collection) VALUES
(1, 'Jawan', 'Action', 1150000000.00),
(2, 'Pathaan', 'Action', 1050000000.00),
(3, 'Animal', 'Action', 900000000.00),
(4, '12th Fail', 'Drama', 67000000.00),
(5, 'Dunki', 'Comedy-Drama', 470000000.00),
(6, 'Fukrey 3', 'Comedy', 128000000.00),
(7, 'Dream Girl 2', 'Comedy', 140000000.00),
(8, 'The Vaccine War', 'Drama', 14000000.00),
(9, 'Bheed', 'Drama', 3500000.00),
(10, 'Sam Bahadur', 'Biographical', 130000000.00);

-- 5. Task 4 Table: playlist
-- Note: 2 hours = 7200 seconds
DROP TABLE IF EXISTS playlist;
CREATE TABLE playlist (
    playlist_id INT,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    duration INT NOT NULL
);

INSERT INTO playlist (playlist_id, user_id, song_id, duration) VALUES
(1, 101, 1, 1800),
(1, 101, 2, 2400),
(1, 101, 3, 3200),
(1, 101, 4, 1500),
(2, 102, 5, 1200),
(2, 102, 6, 1800),
(2, 102, 7, 2100),
(3, 103, 8, 2600),
(3, 103, 9, 3100),
(3, 103, 10, 2200),
(4, 104, 11, 800),
(4, 104, 12, 1100);
