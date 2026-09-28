-- =============================================================================
-- SESSION 2: Database and Tables Setup Script
-- Database: session_2_db
-- =============================================================================

CREATE DATABASE IF NOT EXISTS session_2_db;
USE session_2_db;

-- 1. Demo Table: employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

INSERT INTO employees (first_name, last_name, department, salary, hire_date) VALUES
('Aarav', 'Sharma', 'Data Analytics', 75000.00, '2023-01-15'),
('Priya', 'Patel', 'Engineering', 85000.00, '2022-06-10'),
('Rohan', 'Verma', 'Marketing', 62000.00, '2023-03-01'),
('Sneha', 'Reddy', 'Finance', 90000.00, '2021-11-20'),
('Vikram', 'Malhotra', 'Human Resources', 58000.00, '2024-02-18');

-- 2. Task 1 Table: restaurants
DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1),
    avg_cost_for_two INT
);

INSERT INTO restaurants (name, cuisine, city, rating, avg_cost_for_two) VALUES
('Barbeque Nation', 'North Indian / BBQ', 'Mumbai', 4.5, 1600),
('Bawarchi', 'Biryani / Mughlai', 'Hyderabad', 4.3, 800),
('Peter Cat', 'Continental', 'Kolkata', 4.6, 1200),
('Karim''s', 'Mughlai', 'Delhi', 4.4, 900),
('Toit', 'Italian / Brewpub', 'Bengaluru', 4.7, 1800);

-- 3. Task 2 Table: zomato_reviews
DROP TABLE IF EXISTS zomato_reviews;
CREATE TABLE zomato_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    rating DECIMAL(2,1),
    customer_review TEXT,
    review_date DATE
);

INSERT INTO zomato_reviews (name, rating, customer_review, review_date) VALUES
('The Belgian Waffle Co.', 4.6, 'Crispy waffles and amazing chocolate filling!', '2026-09-01'),
('McDonald''s', 4.1, 'Fast service, hot fries as always.', '2026-09-05'),
('Haldiram''s', 4.3, 'Authentic street food taste, clean and hygienic.', '2026-09-12'),
('Domino''s Pizza', 3.9, 'Delivery was on time, pizza crust was fresh.', '2026-09-18'),
('Starbucks Coffee', 4.5, 'Cozy ambiance and great cold brew.', '2026-09-25');

-- 4. Task 3 Table: movies
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(100),
    release_year INT,
    director VARCHAR(100),
    genre VARCHAR(50),
    box_office_millions DECIMAL(10,2)
);

INSERT INTO movies (movie_name, release_year, director, genre, box_office_millions) VALUES
('Inception', 2010, 'Christopher Nolan', 'Sci-Fi / Action', 836.8),
('Interstellar', 2014, 'Christopher Nolan', 'Sci-Fi / Drama', 701.7),
('The Dark Knight', 2008, 'Christopher Nolan', 'Action / Crime', 1006.0),
('Oppenheimer', 2023, 'Christopher Nolan', 'Biography / Drama', 957.0),
('Dune: Part Two', 2024, 'Denis Villeneuve', 'Sci-Fi / Adventure', 714.4);

-- 5. Task 4 Table: products
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Logitech MX Master 3S', 'Electronics', 8999.00, 45),
('Dell UltraSharp 27" 4K', 'Monitors', 45000.00, 15),
('Keychron K2 Mechanical Keyboard', 'Accessories', 7499.00, 30),
('Sony WH-1000XM5 Headphones', 'Audio', 26990.00, 25),
('SanDisk 1TB Portable SSD', 'Storage', 8499.00, 60);
