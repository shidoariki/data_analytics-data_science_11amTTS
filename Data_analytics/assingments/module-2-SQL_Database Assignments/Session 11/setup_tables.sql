-- =====================================================================
-- SESSION 11: Subqueries (Scalar, Row, Table)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: employees
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10,2) NOT NULL
);

INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Rajesh Mehta', 'Executive', 125000.00),
(2, 'Sunita Rao', 'Engineering', 92000.00),
(3, 'Vikram Malhotra', 'Analytics', 78000.00),
(4, 'Amit Verma', 'Engineering', 68000.00),
(5, 'Neha Patel', 'Engineering', 71000.00),
(6, 'Rohan Shah', 'Analytics', 54000.00),
(7, 'Pooja Iyer', 'Human Resources', 62000.00),
(8, 'Kavita Joshi', 'Sales', 58000.00);

-- ---------------------------------------------------------------------
-- Task 1 Table: Restaurants
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Restaurants;
CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    rating DECIMAL(2,1) NOT NULL
);

INSERT INTO Restaurants (id, name, city, rating) VALUES
(1, 'Mocha Cafe', 'Ahmedabad', 4.5),
(2, 'Subway Express', 'Mumbai', 3.8),
(3, 'Barbeque Nation', 'Bengaluru', 4.6),
(4, 'Burger King', 'Delhi', 3.9),
(5, 'Toit Brewpub', 'Bengaluru', 4.8),
(6, 'Pizza Hut', 'Ahmedabad', 3.7),
(7, 'Indian Accent', 'New Delhi', 4.9),
(8, 'Haldirams', 'Nagpur', 4.1);

-- ---------------------------------------------------------------------
-- Task 2 Table: Products (Flipkart-style)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL
);

INSERT INTO Products (product_id, name, price, category) VALUES
(101, 'iPhone 15', 79900.00, 'Mobiles'),
(102, 'Samsung Galaxy S23', 74999.00, 'Mobiles'),
(103, 'Redmi 12 5G', 11999.00, 'Mobiles'),
(104, 'Sony WH-1000XM5', 29990.00, 'Audio'),
(105, 'boAt Rockerz 450', 1499.00, 'Audio'),
(106, 'OnePlus Buds Pro 2', 9999.00, 'Audio'),
(107, 'Nike Air Zoom Pegasus', 9995.00, 'Footwear'),
(108, 'Puma Smash v2', 2499.00, 'Footwear');

-- ---------------------------------------------------------------------
-- Task 3 Tables: Users and Playlists
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Playlists;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

INSERT INTO Users (user_id, username) VALUES
(1, 'arjun_kapoor'),
(2, 'zara_khan'),
(3, 'rohan_verma'),
(4, 'sneha_nair'),
(5, 'karan_johar');

CREATE TABLE Playlists (
    playlist_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Playlists (playlist_id, user_id, playlist_name) VALUES
(1, 1, 'Daily Workout Mix'),
(2, 1, 'Evening Acoustic Drive'),
(3, 1, 'EDM Bass Party'),
(4, 1, 'Chill Lo-Fi Study'),
(5, 2, 'Bollywood Romantic Hits'),
(6, 2, 'Punjabi Beats'),
(7, 3, 'Top 50 Pop Hits'),
(8, 4, '90s Nostalgia Rock'),
(9, 4, 'Heavy Metal Classics'),
(10, 4, 'Indie Folk Discoveries');
-- Note: User 5 has 0 playlists.
-- Users with playlists: User 1 (4), User 2 (2), User 3 (1), User 4 (3).
-- Average per user = 10 / 4 = 2.5 playlists. Users > 2.5 are User 1 (4) and User 4 (3).

-- ---------------------------------------------------------------------
-- Task 4 Table: Orders (Food Delivery App)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(8,2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, total_amount) VALUES
(501, 101, 450.00),
(502, 102, 180.00),
(503, 103, 850.00),
(504, 101, 320.00),
(505, 104, 1250.00),
(506, 105, 220.00),
(507, 102, 690.00),
(508, 103, 310.00),
(509, 106, 1500.00),
(510, 107, 290.00);
-- Average order amount = 6060 / 10 = 606.00.
-- Orders > 606: Order 503 (850, user 103), 505 (1250, user 104), 507 (690, user 102), 509 (1500, user 106).
