-- =====================================================================
-- SESSION 16: String Functions
-- Setup Script: Database Tables & Sample Data
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Demo Table: dirty_product_codes (Clean Inconsistent Product Codes)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS dirty_product_codes;
CREATE TABLE dirty_product_codes (
    raw_id INT PRIMARY KEY,
    raw_code VARCHAR(100) NOT NULL
);

INSERT INTO dirty_product_codes (raw_id, raw_code) VALUES
(1, '  prd-901-nx  '),
(2, 'PRD-802-NY   '),
(3, '  prd-703-nz'),
(4, 'Prd-604-NW  ');

-- ---------------------------------------------------------------------
-- Task 1 Table: users
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

INSERT INTO users (user_id, first_name, last_name, email) VALUES
(1, 'Aarav', 'Sharma', 'aarav.sharma@example.com'),
(2, 'Priya', 'Verma', 'priya.verma@example.com'),
(3, 'Rohan', 'Patel', 'rohan.patel@example.com'),
(4, 'Ananya', 'Iyer', 'ananya.iyer@example.com'),
(5, 'Kabir', 'Mehta', 'kabir.mehta@example.com');

-- ---------------------------------------------------------------------
-- Task 2 Table: playlists
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists (
    id INT PRIMARY KEY,
    song_title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL
);

INSERT INTO playlists (id, song_title, artist) VALUES
(1, 'kesariya', 'Arijit Singh'),
(2, 'shape of you', 'Ed Sheeran'),
(3, 'blinding lights', 'The Weeknd'),
(4, 'apna bana le', 'Arijit Singh'),
(5, 'stay', 'Justin Bieber');

-- ---------------------------------------------------------------------
-- Task 3 Table: food_items
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS food_items;
CREATE TABLE food_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_code VARCHAR(50) NOT NULL
);

INSERT INTO food_items (item_id, item_name, item_code) VALUES
(1, 'Paneer Butter Masala', '  PBM-101  '),
(2, 'Butter Naan', 'BN-202   '),
(3, 'Chicken Biryani', '   CB-303'),
(4, 'Veg Hakka Noodles', '  VHN-404  '),
(5, 'Gulab Jamun', 'GJ-505 ');

-- ---------------------------------------------------------------------
-- Task 4 Table: movies
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS movies;
CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    imdb_id VARCHAR(20) NOT NULL
);

INSERT INTO movies (movie_id, title, imdb_id) VALUES
(1, 'The Shawshank Redemption', 'tt0111161'),
(2, 'The Godfather', 'tt0068646'),
(3, 'The Dark Knight', 'tt0468569'),
(4, '12 Angry Men', 'tt0050083'),
(5, 'Schindler''s List', 'tt0108052');

-- ---------------------------------------------------------------------
-- Task 5 Table: products
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    sku_code VARCHAR(50) NOT NULL
);

INSERT INTO products (product_id, product_name, sku_code) VALUES
(1, 'OnePlus 12 5G', 'MOB-123-XY'),
(2, 'Sony WH-1000XM5', 'AUD-456-ZZ'),
(3, 'MacBook Air M2', 'LAP-789-QW'),
(4, 'Apple Watch S9', 'WCH-321-AB'),
(5, 'Samsung Smart TV', 'TEL-654-CD');
