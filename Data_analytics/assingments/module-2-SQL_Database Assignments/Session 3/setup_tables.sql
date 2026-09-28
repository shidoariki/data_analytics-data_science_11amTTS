-- =============================================================================
-- SESSION 3: Database and Tables Setup Script
-- Database: session_3_db
-- =============================================================================

CREATE DATABASE IF NOT EXISTS session_3_db;
USE session_3_db;

-- 1. Demo Table: employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO employees (first_name, last_name, department, salary) VALUES
('Rohan', 'Sharma', 'IT', 75000.00),
('Neha', 'Verma', 'IT', 45000.00),
('Amit', 'Patel', 'IT', 82000.00),
('Pooja', 'Singh', 'Finance', 65000.00),
('Rahul', 'Deshmukh', 'HR', 48000.00),
('Kavita', 'Iyer', 'IT', 52000.00),
('Vikas', 'Joshi', 'Marketing', 55000.00);

-- 2. Task 1 Table: restaurants
DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1)
);

INSERT INTO restaurants (name, cuisine, city, rating) VALUES
('Barbeque Nation', 'North Indian / BBQ', 'Mumbai', 4.6),
('Haldiram''s', 'Street Food / Sweets', 'Nagpur', 4.2),
('Toit Brewpub', 'Italian / Craft Beer', 'Bengaluru', 4.7),
('Bawarchi', 'Biryani / Mughlai', 'Hyderabad', 4.4),
('Peter Cat', 'Continental', 'Kolkata', 4.5),
('Burger King', 'Fast Food', 'Pune', 3.9),
('Indian Accent', 'Modern Indian', 'New Delhi', 4.9);

-- 3. Task 2 Table: movies
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(100),
    release_year INT,
    genre VARCHAR(50)
);

INSERT INTO movies (movie_name, release_year, genre) VALUES
('John Wick: Chapter 4', 2023, 'Action'),
('Spider-Man: Across the Spider-Verse', 2023, 'Animation'),
('Top Gun: Maverick', 2022, 'Action'),
('The Dark Knight', 2008, 'Action'),
('Oppenheimer', 2023, 'Biography'),
('The Batman', 2022, 'Action'),
('Avengers: Endgame', 2019, 'Action'),
('Dune: Part Two', 2024, 'Sci-Fi');

-- 4. Task 3 Table: products
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

INSERT INTO products (name, price, category) VALUES
('Wireless Optical Mouse', 450.00, 'Electronics'),
('Mechanical Gaming Keyboard', 3499.00, 'Electronics'),
('Ceramic Coffee Mug', 350.00, 'Home & Kitchen'),
('Stainless Steel Water Bottle', 799.00, 'Fitness'),
('USB-C Fast Charging Cable', 299.00, 'Electronics'),
('Hardcover Notebook & Pen Set', 420.00, 'Stationery'),
('Ergonomic Office Chair', 8500.00, 'Furniture'),
('Wireless Earbuds', 2499.00, 'Electronics');

-- 5. Task 4 Table: users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    city VARCHAR(50),
    followers INT
);

INSERT INTO users (name, city, followers) VALUES
('Aarav Mehta', 'Ahmedabad', 2500),
('Isha Kulkarni', 'Pune', 1800),
('Kabir Roy', 'Kolkata', 850),
('Diya Shah', 'Ahmedabad', 950),
('Siddharth Rao', 'Bengaluru', 3200),
('Ananya Nair', 'Kochi', 1450),
('Manish Patel', 'Ahmedabad', 4100),
('Tanvi Kapoor', 'Delhi', 5200);
