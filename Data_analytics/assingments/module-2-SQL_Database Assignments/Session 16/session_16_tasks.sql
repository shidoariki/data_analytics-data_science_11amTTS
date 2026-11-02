-- =====================================================================
-- SESSION 16: String Functions
-- Assignment Solutions
-- Dialect: MySQL (with SQLite equivalents documented)
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Clean Inconsistent Product Codes
-- Removes padding, standardizes casing to UPPER, and normalizes separators
-- ---------------------------------------------------------------------
SELECT 
    raw_id,
    raw_code,
    UPPER(TRIM(raw_code)) AS normalized_code,
    REPLACE(UPPER(TRIM(raw_code)), '-', '_') AS cleaned_standard_code
FROM dirty_product_codes;


-- ---------------------------------------------------------------------
-- TASK 1: Concatenate First and Last Names
-- Description: Combine first_name and last_name from users into a single
-- full_name column using CONCAT().
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    user_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM users;

-- SQLite Equivalent:
-- SELECT user_id, first_name || ' ' || last_name AS full_name, email FROM users;


-- ---------------------------------------------------------------------
-- TASK 2: Song Titles in Uppercase
-- Description: Display all song titles in uppercase using UPPER().
-- ---------------------------------------------------------------------
SELECT 
    id,
    song_title,
    UPPER(song_title) AS song_title_upper,
    artist
FROM playlists;


-- ---------------------------------------------------------------------
-- TASK 3: Trim Whitespace from Item Codes
-- Description: Select item_code values after removing leading and 
-- trailing spaces using TRIM().
-- ---------------------------------------------------------------------
SELECT 
    item_id,
    item_name,
    item_code AS raw_item_code,
    TRIM(item_code) AS cleaned_item_code
FROM food_items;


-- ---------------------------------------------------------------------
-- TASK 4: Extract Numeric Portion of IMDb IDs with RIGHT()
-- Description: Extract just the numeric part (last 7 characters) from
-- imdb_id like 'tt1234567' using RIGHT() and display as movie_number.
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    movie_id,
    title,
    imdb_id,
    RIGHT(imdb_id, 7) AS movie_number
FROM movies;

-- SQLite Equivalent:
-- SELECT movie_id, title, imdb_id, SUBSTR(imdb_id, -7) AS movie_number FROM movies;


-- ---------------------------------------------------------------------
-- TASK 5: Replace Delimiters with REPLACE()
-- Description: Replace all dashes '-' with underscores '_' in sku_code 
-- using REPLACE() and display the updated codes.
-- ---------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    sku_code AS original_sku,
    REPLACE(sku_code, '-', '_') AS updated_sku_code
FROM products;
