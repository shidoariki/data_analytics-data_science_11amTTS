-- =====================================================================
-- SESSION 12: Common Table Expressions (CTEs)
-- Setup Script: Database, Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: annual_sales (YoY Growth Calculation)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS annual_sales;
CREATE TABLE annual_sales (
    sale_year INT PRIMARY KEY,
    total_revenue DECIMAL(14,2) NOT NULL
);

INSERT INTO annual_sales (sale_year, total_revenue) VALUES
(2020, 45000000.00),
(2021, 58000000.00),
(2022, 72000000.00),
(2023, 95000000.00),
(2024, 120000000.00);

-- ---------------------------------------------------------------------
-- Task 1 Table: SpotifyArtists
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS SpotifyArtists;
CREATE TABLE SpotifyArtists (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    followers INT NOT NULL
);

INSERT INTO SpotifyArtists (artist_id, name, followers) VALUES
(1, 'Arijit Singh', 115000000),
(2, 'Taylor Swift', 108000000),
(3, 'Ed Sheeran', 112000000),
(4, 'Badshah', 42000000),
(5, 'The Weeknd', 89000000),
(6, 'Shreya Ghoshal', 48000000),
(7, 'Diljit Dosanjh', 35000000);

-- ---------------------------------------------------------------------
-- Task 2 Table: FlipkartOrders
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS FlipkartOrders;
CREATE TABLE FlipkartOrders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL
);

INSERT INTO FlipkartOrders (order_id, user_id, order_date, total_amount) VALUES
(101, 1, '2023-01-15', 14500.00),
(102, 2, '2023-01-20', 22000.00),
(103, 3, '2023-03-10', 35000.00),
(104, 1, '2023-05-18', 48000.00),
(105, 4, '2023-08-12', 65000.00),
(106, 2, '2023-10-05', 125000.00), -- Big Billion Days festive month
(107, 3, '2023-10-18', 185000.00), -- Big Billion Days festive month
(108, 5, '2023-10-22', 92000.00),  -- Big Billion Days festive month
(109, 1, '2023-11-14', 54000.00),  -- Diwali sales
(110, 4, '2023-12-25', 41000.00);

-- ---------------------------------------------------------------------
-- Task 4 Table: ZomatoRestaurants
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS ZomatoRestaurants;
CREATE TABLE ZomatoRestaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

INSERT INTO ZomatoRestaurants (id, name, city, rating) VALUES
(1, 'Mocha Cafe', 'Ahmedabad', 4.5),
(2, 'Gordhan Thal', 'Ahmedabad', 4.4),
(3, 'Agashiye', 'Ahmedabad', 4.6),
(4, 'Burger Point', 'Kanpur', 3.4),
(5, 'Chai Shai', 'Kanpur', 3.6),
(6, 'Toit Brewpub', 'Bengaluru', 4.8),
(7, 'Truffles', 'Bengaluru', 4.6),
(8, 'MTR', 'Bengaluru', 4.5),
(9, 'Highway Dhaba', 'Panipat', 3.5),
(10, 'Sukhdev Dhaba', 'Panipat', 3.8);

-- ---------------------------------------------------------------------
-- Task 5 Table: IPLMatches (Total Runs Scored in 2023)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS IPLMatches;
CREATE TABLE IPLMatches (
    match_id INT PRIMARY KEY,
    team VARCHAR(50) NOT NULL,
    runs INT NOT NULL,
    match_year INT NOT NULL
);

INSERT INTO IPLMatches (match_id, team, runs, match_year) VALUES
(1, 'CSK', 215, 2023),
(2, 'GT', 214, 2023),
(3, 'MI', 198, 2023),
(4, 'RCB', 182, 2023),
(5, 'CSK', 223, 2023),
(6, 'GT', 227, 2023),
(7, 'MI', 205, 2023),
(8, 'CSK', 212, 2023),
(9, 'GT', 210, 2023),
(10, 'KKR', 175, 2023),
(11, 'DC', 160, 2023),
(12, 'SRH', 155, 2023),
(13, 'CSK', 235, 2023),
(14, 'GT', 218, 2023),
(15, 'CSK', 210, 2023),
(16, 'GT', 215, 2023),
(17, 'CSK', 220, 2023),
(18, 'GT', 212, 2023),
(19, 'CSK', 205, 2023),
(20, 'GT', 208, 2023),
(21, 'CSK', 225, 2023),
(22, 'GT', 230, 2023),
(23, 'CSK', 240, 2023),
(24, 'GT', 220, 2023),
(25, 'CSK', 218, 2023),  -- Pushes CSK to 2403 runs
(26, 'GT', 225, 2023),   -- Pushes GT to 2409 runs
(27, 'MI', 210, 2023),   -- MI total 613 runs
(28, 'RCB', 195, 2023);  -- RCB total 377 runs
