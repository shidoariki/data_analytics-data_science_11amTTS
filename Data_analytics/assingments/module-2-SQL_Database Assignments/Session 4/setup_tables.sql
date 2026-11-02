-- =====================================================================
-- SESSION 4: Wildcards & Pattern Matching (LIKE, BETWEEN, IN)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- 1. Demo Table: Customers
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO customers (customer_id, customer_name, email, city) VALUES
(1, 'Manish Sharma', 'manish.s@example.com', 'Mumbai'),
(2, 'Meera Iyer', 'meera.i@example.com', 'Bengaluru'),
(3, 'Rohan Verma', 'rohan.v@example.com', 'Delhi'),
(4, 'Mohit Patel', 'mohit.p@example.com', 'Ahmedabad'),
(5, 'Ananya Roy', 'ananya.r@example.com', 'Kolkata'),
(6, 'Madhav Joshi', 'madhav.j@example.com', 'Pune'),
(7, 'Sneha Kulkarni', 'sneha.k@example.com', 'Nagpur'),
(8, 'Mukesh Ambani', 'mukesh.a@example.com', 'Mumbai');

-- 2. Task 1 Table: Restaurants
DROP TABLE IF EXISTS Restaurants;
CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50),
    city VARCHAR(50),
    rating DECIMAL(2,1)
);

INSERT INTO Restaurants (restaurant_id, name, cuisine, city, rating) VALUES
(1, 'Mocha Cafe', 'Continental & Coffee', 'Ahmedabad', 4.5),
(2, 'Hard Rock Cafe', 'American & Bar', 'Mumbai', 4.6),
(3, 'Barbeque Nation', 'North Indian / Buffet', 'Bengaluru', 4.4),
(4, 'The Chocolate Room Cafe', 'Desserts & Beverages', 'Surat', 4.2),
(5, 'Haldirams Sweets', 'Indian Snacks', 'Delhi', 4.1),
(6, 'Zen Garden Cafe', 'Asian & Cafe', 'Pune', 4.7),
(7, 'Cafe Coffee Day', 'Beverages', 'Bengaluru', 3.9),
(8, 'Grand Punjab Dhaba', 'North Indian', 'Amritsar', 4.3);

-- 3. Task 2 Table: Products (Flipkart-style)
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT
);

INSERT INTO Products (product_id, product_name, category, price, stock) VALUES
(101, 'boAt Bassheads 100 Wired Earphones', 'Audio', 399.00, 150),
(102, 'Puma Men Running T-Shirt', 'Fashion', 699.00, 80),
(103, 'SanDisk 64GB Ultra microSD Card', 'Storage', 549.00, 200),
(104, 'Portronics Toad Wireless Mouse', 'Accessories', 899.00, 95),
(105, 'Wildcraft Casual 30L Backpack', 'Bags', 1299.00, 60),
(106, 'Fastrack Casual Analog Watch', 'Fashion', 1450.00, 45),
(107, 'JBL Flip 6 Bluetooth Speaker', 'Audio', 8999.00, 30),
(108, 'Noise ColorFit Pulse Smartwatch', 'Wearables', 1499.00, 110),
(109, 'Realme Buds Air 3 Neo', 'Audio', 1899.00, 50),
(110, 'Mi 10000mAh Power Bank 3i', 'Accessories', 1199.00, 120);

-- 4. Task 3 Table: Users
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

INSERT INTO Users (user_id, username, email, city, signup_date) VALUES
(1, 'aarav_shah', 'aarav.shah@gmail.com', 'Ahmedabad', '2024-01-15'),
(2, 'priya_mehta', 'priya.m@yahoo.com', 'Surat', '2024-02-10'),
(3, 'karan_patel', 'karan.p@outlook.com', 'Vadodara', '2024-02-28'),
(4, 'neha_sharma', 'neha.s@gmail.com', 'Mumbai', '2024-03-05'),
(5, 'dev_pandya', 'dev.p@rediffmail.com', 'Ahmedabad', '2024-03-18'),
(6, 'anjali_desai', 'anjali.d@gmail.com', 'Surat', '2024-04-02'),
(7, 'vikram_singh', 'vikram.s@hotmail.com', 'Jaipur', '2024-04-14'),
(8, 'bhavin_gandhi', 'bhavin.g@gmail.com', 'Vadodara', '2024-05-01'),
(9, 'pooja_verma', 'pooja.v@gmail.com', 'Bengaluru', '2024-05-15');

-- 5. Task 4 Table: Songs
DROP TABLE IF EXISTS Songs;
CREATE TABLE Songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist_name VARCHAR(100) NOT NULL,
    album VARCHAR(100),
    duration_sec INT
);

INSERT INTO Songs (song_id, song_name, artist_name, album, duration_sec) VALUES
(201, 'Kesariya', 'Arijit Singh', 'Brahmastra', 268),
(202, 'Tum Hi Ho', 'Arijit Singh', 'Aashiqui 2', 262),
(203, 'Kun Faya Kun', 'A.R. Rahman', 'Rockstar', 473),
(204, 'Shape of You', 'Ed Sheeran', 'Divide', 233),
(205, 'Levitating', 'Dua Lipa', 'Future Nostalgia', 203),
(206, 'Garmi', 'Badshah & Nora Fatehi', 'Street Dancer 3D', 182),
(207, 'Jai Ho', 'A.R. Rahman', 'Slumdog Millionaire', 319),
(208, 'Channa Mereya', 'Arijit Singh', 'Ae Dil Hai Mushkil', 289),
(209, 'Starboy', 'The Weeknd', 'Starboy', 230),
(210, 'Tareefan', 'Qaran ft. Badshah', 'Veere Di Wedding', 185);
