-- =====================================================================
-- SESSION 14: Window Functions (Part 2: ROW_NUMBER, RANK, DENSE_RANK)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: regional_product_sales (Top 3 Selling Products Per Region)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS regional_product_sales;
CREATE TABLE regional_product_sales (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    units_sold INT NOT NULL
);

INSERT INTO regional_product_sales (product_id, product_name, region, units_sold) VALUES
(1, 'iPhone 15', 'North', 15400),
(2, 'OnePlus Nord', 'North', 12100),
(3, 'Redmi Note 13', 'North', 14200),
(4, 'Samsung S23', 'North', 9800),
(5, 'iPhone 15', 'South', 18200),
(6, 'Samsung S23', 'South', 16500),
(7, 'OnePlus Nord', 'South', 11900),
(8, 'Realme 12', 'South', 8400),
(9, 'boAt Rockerz', 'West', 24000),
(10, 'Sony WH-1000XM5', 'West', 15000),
(11, 'JBL Flip 6', 'West', 18500),
(12, 'Noise Smartwatch', 'West', 16200);

-- ---------------------------------------------------------------------
-- Task 1 Table: Orders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(101, 1, '2024-01-10', 450.00),
(102, 1, '2024-02-14', 1200.00),
(103, 1, '2024-03-01', 890.00),
(104, 2, '2024-01-05', 620.00),
(105, 2, '2024-02-20', 1450.00),
(106, 2, '2024-03-15', 310.00),
(107, 3, '2024-01-18', 2100.00),
(108, 3, '2024-02-28', 1750.00),
(109, 3, '2024-03-22', 950.00),
(110, 3, '2024-04-05', 3200.00);

-- ---------------------------------------------------------------------
-- Task 2 Table: Songs (Demonstrates Ties in RANK)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Songs;
CREATE TABLE Songs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    streams BIGINT NOT NULL
);

INSERT INTO Songs (song_id, song_title, artist, streams) VALUES
(201, 'Kesariya', 'Arijit Singh', 450000000),
(202, 'Tum Hi Ho', 'Arijit Singh', 380000000),
(203, 'Channa Mereya', 'Arijit Singh', 380000000), -- Tie for Rank 2
(204, 'Apna Bana Le', 'Arijit Singh', 290000000), -- Should get Rank 4 (RANK has gap)
(205, 'Shape of You', 'Ed Sheeran', 920000000),
(206, 'Perfect', 'Ed Sheeran', 850000000),
(207, 'Bad Habits', 'Ed Sheeran', 850000000),     -- Tie for Rank 2
(208, 'Shivers', 'Ed Sheeran', 610000000);        -- Should get Rank 4

-- ---------------------------------------------------------------------
-- Task 3 Table: Movies (Demonstrates Ties in DENSE_RANK)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Movies;
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

INSERT INTO Movies (movie_id, movie_name, genre, rating) VALUES
(301, 'John Wick: Chapter 4', 'Action', 8.2),
(302, 'Top Gun: Maverick', 'Action', 8.4),
(303, 'The Dark Knight', 'Action', 9.0),
(304, 'The Batman', 'Action', 8.2),              -- Tie for Dense Rank 3
(305, 'Mission Impossible 7', 'Action', 7.9),     -- Should get Dense Rank 4 (NO gap)
(306, 'Oppenheimer', 'Drama', 8.9),
(307, '12th Fail', 'Drama', 9.1),
(308, 'The Whale', 'Drama', 8.5),
(309, 'Killers of the Flower Moon', 'Drama', 8.5);-- Tie for Dense Rank 3

-- ---------------------------------------------------------------------
-- Task 4 Table: Influencers
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS Influencers;
CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    influencer_name VARCHAR(100) NOT NULL,
    platform VARCHAR(50) NOT NULL,
    followers INT NOT NULL
);

INSERT INTO Influencers (id, influencer_name, platform, followers) VALUES
(1, 'CarryMinati', 'YouTube', 42000000),
(2, 'Total Gaming', 'YouTube', 38000000),
(3, 'Ashish Chanchlani', 'YouTube', 30000000),
(4, 'Bhuvan Bam', 'YouTube', 26000000),
(5, 'Sandeep Maheshwari', 'YouTube', 28000000),
(6, 'Virat Kohli', 'Instagram', 270000000),
(7, 'Priyanka Chopra', 'Instagram', 91000000),
(8, 'Shraddha Kapoor', 'Instagram', 88000000),
(9, 'Alia Bhatt', 'Instagram', 84000000),
(10, 'Narendra Modi', 'X/Twitter', 98000000),
(11, 'Amitabh Bachchan', 'X/Twitter', 48000000),
(12, 'Shah Rukh Khan', 'X/Twitter', 44000000),
(13, 'Salman Khan', 'X/Twitter', 45000000);
