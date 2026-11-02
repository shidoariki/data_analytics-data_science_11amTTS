-- =====================================================================
-- SESSION 4: Wildcards & Pattern Matching (LIKE, BETWEEN, IN)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 4
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Find all customers whose names start with 'M'
-- Concept: The LIKE operator with prefix wildcard 'M%' matches any string
--          beginning with the letter 'M' followed by zero or more characters.
-- ---------------------------------------------------------------------
SELECT 
    customer_id, 
    customer_name, 
    email, 
    city
FROM customers
WHERE customer_name LIKE 'M%';


-- ---------------------------------------------------------------------
-- TASK 1: Find all restaurants in 'Restaurants' whose names end with 'Cafe'
-- Concept: The LIKE operator with suffix wildcard '%Cafe' matches any string
--          ending with 'Cafe' preceded by any character sequence.
-- ---------------------------------------------------------------------
SELECT 
    restaurant_id, 
    name, 
    cuisine, 
    city, 
    rating
FROM Restaurants
WHERE name LIKE '%Cafe';


-- ---------------------------------------------------------------------
-- TASK 2: Select all products with a price between 500 and 1500 rupees
-- Concept: The BETWEEN operator tests whether a value falls within an inclusive
--          range (value >= min AND value <= max).
-- ---------------------------------------------------------------------
SELECT 
    product_id, 
    product_name, 
    category, 
    price, 
    stock
FROM Products
WHERE price BETWEEN 500 AND 1500;


-- ---------------------------------------------------------------------
-- TASK 3: Display all users whose city is either 'Ahmedabad', 'Surat', or 'Vadodara'
-- Concept: The IN operator replaces multiple OR conditions, testing membership
--          in a discrete set of literal values.
-- ---------------------------------------------------------------------
SELECT 
    user_id, 
    username, 
    email, 
    city, 
    signup_date
FROM Users
WHERE city IN ('Ahmedabad', 'Surat', 'Vadodara');


-- ---------------------------------------------------------------------
-- TASK 4: Find all songs where artist_name contains letter sequence 'ar' anywhere
-- Hint: Use wildcards on both sides of the pattern ('%ar%').
-- Concept: Substring pattern matching with wildcards on both sides matches any
--          occurrence of 'ar' (case-insensitive in standard collation).
-- ---------------------------------------------------------------------
SELECT 
    song_id, 
    song_name, 
    artist_name, 
    album, 
    duration_sec
FROM Songs
WHERE artist_name LIKE '%ar%';
