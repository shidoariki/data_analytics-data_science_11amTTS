-- =====================================================================
-- SESSION 22: SQL + Python Integration
-- Setup Script: Database Tables & Sample Data
-- Database: session_22_analytics.db (SQLite / MySQL Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Task 1 Table: restaurants
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating DECIMAL(2,1) NOT NULL
);

INSERT INTO restaurants (restaurant_id, name, cuisine, rating) VALUES
(1, 'Truffles', 'Continental', 4.5),
(2, 'Meghana Foods', 'Biryani', 4.6),
(3, 'Taaza Thindi', 'South Indian', 4.7),
(4, 'Mainland China', 'Chinese', 4.2),
(5, 'Toit Brewpub', 'Continental', 4.6),
(6, 'Vidyarthi Bhavan', 'South Indian', 4.5),
(7, 'Corner House Ice Cream', 'Desserts', 4.8),
(8, 'Empire Restaurant', 'North Indian', 3.9);

-- ---------------------------------------------------------------------
-- Task 2 Table: movies
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    rating DECIMAL(3,1) NOT NULL
);

INSERT INTO movies (movie_id, title, genre, rating) VALUES
(1, 'The Shawshank Redemption', 'Drama', 9.3),
(2, 'The Godfather', 'Crime', 9.2),
(3, 'The Dark Knight', 'Action', 9.0),
(4, '12th Fail', 'Drama', 9.1),
(5, 'Oppenheimer', 'Biography', 8.9),
(6, 'Fast X', 'Action', 5.8),
(7, 'Brahmastra', 'Fantasy', 5.6),
(8, 'Housefull 4', 'Comedy', 3.5);

-- ---------------------------------------------------------------------
-- Task 3 & 5 Table: orders (Populated with 120+ orders across users & items)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

-- Note: Populated dynamically with realistic items (Biryani, Burger, Pizza, etc.) via python script

-- ---------------------------------------------------------------------
-- Task 4 Table: matches
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    season INT NOT NULL,
    team1 VARCHAR(50) NOT NULL,
    team2 VARCHAR(50) NOT NULL,
    winner VARCHAR(50) NOT NULL
);

INSERT INTO matches (match_id, season, team1, team2, winner) VALUES
(1, 2023, 'Gujarat Titans', 'Chennai Super Kings', 'Gujarat Titans'),
(2, 2023, 'Punjab Kings', 'Kolkata Knight Riders', 'Punjab Kings'),
(3, 2023, 'Lucknow Super Giants', 'Delhi Capitals', 'Lucknow Super Giants'),
(4, 2023, 'Sunrisers Hyderabad', 'Rajasthan Royals', 'Rajasthan Royals'),
(5, 2023, 'Royal Challengers Bangalore', 'Mumbai Indians', 'Royal Challengers Bangalore'),
(6, 2023, 'Chennai Super Kings', 'Lucknow Super Giants', 'Chennai Super Kings'),
(7, 2023, 'Delhi Capitals', 'Gujarat Titans', 'Gujarat Titans'),
(8, 2023, 'Rajasthan Royals', 'Punjab Kings', 'Punjab Kings'),
(9, 2023, 'Kolkata Knight Riders', 'Royal Challengers Bangalore', 'Kolkata Knight Riders'),
(10, 2023, 'Lucknow Super Giants', 'Sunrisers Hyderabad', 'Lucknow Super Giants'),
(11, 2023, 'Rajasthan Royals', 'Delhi Capitals', 'Rajasthan Royals'),
(12, 2023, 'Mumbai Indians', 'Chennai Super Kings', 'Chennai Super Kings'),
(13, 2023, 'Gujarat Titans', 'Kolkata Knight Riders', 'Kolkata Knight Riders'),
(14, 2023, 'Sunrisers Hyderabad', 'Punjab Kings', 'Sunrisers Hyderabad'),
(15, 2023, 'Royal Challengers Bangalore', 'Lucknow Super Giants', 'Lucknow Super Giants');

-- ---------------------------------------------------------------------
-- Task 5 Table: users
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO users (user_id, user_name, city) VALUES
(1, 'Aarav Patel', 'Ahmedabad'),
(2, 'Diya Sharma', 'Bangalore'),
(3, 'Rohan Verma', 'Delhi'),
(4, 'Ananya Iyer', 'Chennai'),
(5, 'Kabir Mehta', 'Mumbai');
