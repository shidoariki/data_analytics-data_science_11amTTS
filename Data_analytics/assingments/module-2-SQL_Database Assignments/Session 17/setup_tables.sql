-- =====================================================================
-- SESSION 17: CASE WHEN (Conditional Logic)
-- Setup Script: Database Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: customers (Customer Value Classification)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    total_spend DECIMAL(10,2) NOT NULL
);

INSERT INTO customers (customer_id, customer_name, total_spend) VALUES
(1, 'Aarav Patel', 15400.00),
(2, 'Diya Sharma', 4200.00),
(3, 'Rohan Verma', 850.00),
(4, 'Ananya Iyer', 18900.00),
(5, 'Kabir Mehta', 6500.00);

-- ---------------------------------------------------------------------
-- Task 1 Table: FoodOrders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS FoodOrders;
CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO FoodOrders (order_id, customer_name, total_amount, order_date) VALUES
(101, 'Aarav Patel', 240.00, '2024-04-01'),   -- Small (< 300)
(102, 'Priya Verma', 350.00, '2024-04-02'),   -- Medium (300-999)
(103, 'Rohan Patel', 850.00, '2024-04-03'),   -- Medium (300-999)
(104, 'Ananya Iyer', 1450.00, '2024-04-04'),  -- Large (>= 1000)
(105, 'Kabir Mehta', 120.00, '2024-04-05'),   -- Small (< 300)
(106, 'Sneha Joshi', 2100.00, '2024-04-06');  -- Large (>= 1000)

-- ---------------------------------------------------------------------
-- Task 2 Table: Movies
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Movies;
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    movie_title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1) NOT NULL
);

INSERT INTO Movies (movie_id, movie_title, genre, rating) VALUES
(201, 'The Dark Knight', 'Action', 9.0),        -- Blockbuster (>= 8.0)
(202, 'Oppenheimer', 'Drama', 8.9),             -- Blockbuster (>= 8.0)
(203, 'Brahmastra', 'Fantasy', 5.6),            -- Hit (5.0 - 7.9)
(204, 'Fast X', 'Action', 5.8),                 -- Hit (5.0 - 7.9)
(205, 'Adipurush', 'Mythology', 3.8),           -- Average (< 5.0)
(206, 'Housefull 4', 'Comedy', 3.5);            -- Average (< 5.0)

-- ---------------------------------------------------------------------
-- Task 3 Table: FlipkartProducts
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS FlipkartProducts;
CREATE TABLE FlipkartProducts (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

INSERT INTO FlipkartProducts (product_id, product_name, category, price) VALUES
(301, 'USB-C Cable', 'Accessories', 299.00),       -- Budget (< 500)
(302, 'Wireless Mouse', 'Electronics', 799.00),    -- Standard (500 - 2000)
(303, 'Bluetooth Speaker', 'Audio', 1699.00),      -- Standard (500 - 2000)
(304, 'Mechanical Keyboard', 'Gaming', 3499.00),   -- Premium (> 2000)
(305, 'Cotton T-Shirt', 'Fashion', 450.00),        -- Budget (< 500)
(306, 'Smart Watch', 'Wearables', 8999.00);        -- Premium (> 2000)

-- ---------------------------------------------------------------------
-- Task 4 Table: SpotifyTracks
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS SpotifyTracks;
CREATE TABLE SpotifyTracks (
    track_id INT PRIMARY KEY,
    track_title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration_seconds INT NOT NULL
);

INSERT INTO SpotifyTracks (track_id, track_title, artist, duration_seconds) VALUES
(401, 'Stay', 'Kid LAROI & Justin Bieber', 141),      -- Short (< 180s)
(402, 'Kesariya', 'Arijit Singh', 268),               -- Medium (180 - 300s)
(403, 'Shape of You', 'Ed Sheeran', 233),             -- Medium (180 - 300s)
(404, 'All Too Well (10 Min)', 'Taylor Swift', 613),  -- Long (> 300s)
(405, 'Bohemian Rhapsody', 'Queen', 354),             -- Long (> 300s)
(406, 'Levitating', 'Dua Lipa', 158);                 -- Short (< 180s)
