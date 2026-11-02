-- =====================================================================
-- SESSION 13: Window Functions (Part 1: OVER, PARTITION BY)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: employees (Department Benchmark Comparison)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Rohan Sharma', 'Engineering', 95000.00),
(2, 'Amit Verma', 'Engineering', 75000.00),
(3, 'Neha Patel', 'Engineering', 82000.00),
(4, 'Sunita Rao', 'Analytics', 88000.00),
(5, 'Vikram Malhotra', 'Analytics', 72000.00),
(6, 'Pooja Iyer', 'Human Resources', 65000.00),
(7, 'Kavita Joshi', 'Human Resources', 55000.00);

-- ---------------------------------------------------------------------
-- Task 1 & Task 2 Table: Orders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL,
    app_name VARCHAR(50) NOT NULL
);

INSERT INTO Orders (order_id, user_id, order_amount, app_name) VALUES
(101, 1, 450.00, 'Zomato'),
(102, 1, 1200.00, 'Flipkart'),
(103, 2, 320.00, 'Swiggy'),
(104, 2, 650.00, 'Zomato'),
(105, 3, 2800.00, 'Flipkart'),
(106, 1, 290.00, 'Swiggy'),
(107, 3, 420.00, 'Zomato'),
(108, 4, 1500.00, 'Flipkart'),
(109, 2, 890.00, 'Swiggy'),
(110, 4, 380.00, 'Zomato');

-- ---------------------------------------------------------------------
-- Task 3 Table: Playlist
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Playlist;
CREATE TABLE Playlist (
    song_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    duration_sec INT NOT NULL
);

INSERT INTO Playlist (song_id, user_id, duration_sec) VALUES
(1, 101, 240),
(2, 101, 180),
(3, 101, 310),
(4, 102, 210),
(5, 102, 195),
(6, 103, 360),
(7, 103, 290),
(8, 103, 220),
(9, 103, 185);

-- ---------------------------------------------------------------------
-- Task 4 Table: MovieRatings
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS MovieRatings;
CREATE TABLE MovieRatings (
    rating_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    movie_name VARCHAR(100) NOT NULL,
    rating INT NOT NULL
);

INSERT INTO MovieRatings (rating_id, user_id, movie_name, rating) VALUES
(1, 11, 'Dune: Part Two', 5),
(2, 12, 'Dune: Part Two', 4),
(3, 13, 'Dune: Part Two', 5),
(4, 14, 'Dune: Part Two', 4),
(5, 11, 'Animal', 3),
(6, 12, 'Animal', 5),
(7, 15, 'Animal', 2),
(8, 16, 'Animal', 4),
(9, 11, '12th Fail', 5),
(10, 13, '12th Fail', 5),
(11, 14, '12th Fail', 4);
