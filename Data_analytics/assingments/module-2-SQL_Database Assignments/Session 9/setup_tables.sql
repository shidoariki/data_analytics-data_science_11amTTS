-- =====================================================================
-- SESSION 9: ADVANCED JOINS (FULL OUTER, SELF JOIN, CROSS JOIN)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo & Task 4: employees Table (Hierarchical Organizational Structure)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    manager_id INT
);

INSERT INTO employees (id, name, department, manager_id) VALUES
(1, 'Rajesh Mehta', 'Executive', NULL),      -- CEO / Top-Level
(2, 'Sunita Rao', 'Engineering', 1),         -- Reports to Rajesh
(3, 'Vikram Malhotra', 'Analytics', 1),       -- Reports to Rajesh
(4, 'Amit Verma', 'Engineering', 2),         -- Reports to Sunita
(5, 'Neha Patel', 'Engineering', 2),         -- Reports to Sunita
(6, 'Rohan Shah', 'Analytics', 3),           -- Reports to Vikram
(7, 'Pooja Iyer', 'Human Resources', NULL);   -- HR Director (Top-level)

-- ---------------------------------------------------------------------
-- Task 1: influencers and brands Tables
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS influencers;
CREATE TABLE influencers (
    influencer_id INT PRIMARY KEY,
    influencer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    followers INT
);

INSERT INTO influencers (influencer_id, influencer_name, city, followers) VALUES
(1, 'Kusha Kapila', 'Delhi', 3500000),
(2, 'Bhuvan Bam', 'Delhi', 18000000),
(3, 'Ranveer Allahbadia', 'Mumbai', 9500000),
(4, 'Dolly Singh', 'Nainital', 1600000),
(5, 'Tech Burner', 'Delhi', 11000000),
(6, 'Tanmay Bhat', 'Bengaluru', 5200000);

DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    category VARCHAR(50)
);

INSERT INTO brands (brand_id, brand_name, city, category) VALUES
(101, 'Boat Lifestyle', 'Delhi', 'Consumer Electronics'),
(102, 'Nykaa Fashion', 'Mumbai', 'Beauty & Apparel'),
(103, 'Zomato', 'Gurugram', 'Food Delivery'),
(104, 'Swiggy', 'Bengaluru', 'Quick Commerce'),
(105, 'Titan Watches', 'Bengaluru', 'Accessories'),
(106, 'Mamaearth', 'Gurugram', 'Personal Care');

-- ---------------------------------------------------------------------
-- Task 2: playlists Table (Nested Music Playlists)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists (
    id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL,
    parent_playlist_id INT
);

INSERT INTO playlists (id, playlist_name, parent_playlist_id) VALUES
(1, 'Workout Motivation', NULL),             -- Root category
(2, 'High Energy Cardio', 1),                -- Child of Workout Motivation
(3, 'Gym EDM Bass Boost', 1),                -- Child of Workout Motivation
(4, 'Chill Vibes', NULL),                    -- Root category
(5, 'Acoustic Sunday Afternoon', 4),         -- Child of Chill Vibes
(6, 'Lo-Fi Study Beats', 4),                 -- Child of Chill Vibes
(7, 'Late Night Coding Lo-Fi', 6);           -- Nested Child of Lo-Fi Study Beats

-- ---------------------------------------------------------------------
-- Task 3 & Task 5: users and offers Tables
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO users (user_id, user_name, city) VALUES
(1, 'Aarav Sharma', 'Mumbai'),
(2, 'Diya Patel', 'Ahmedabad'),
(3, 'Kabir Mehta', 'Mumbai'),
(4, 'Ishaan Verma', 'Bengaluru'),
(5, 'Ananya Desai', 'Ahmedabad'),
(6, 'Rhea Sen', 'Kolkata'),
(7, 'Devansh Joshi', 'Ahmedabad');

DROP TABLE IF EXISTS offers;
CREATE TABLE offers (
    offer_id INT PRIMARY KEY,
    offer_title VARCHAR(100) NOT NULL,
    discount_pct INT NOT NULL
);

INSERT INTO offers (offer_id, offer_title, discount_pct) VALUES
(1, 'Big Billion Days: 50% Off Electronics', 50),
(2, 'Flipkart SuperCoin 20% Cashback', 20),
(3, 'Fashion Weekend: Flat Rs. 500 Off', 30);
