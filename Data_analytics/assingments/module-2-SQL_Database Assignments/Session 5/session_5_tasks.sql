-- =====================================================================
-- SESSION 5: DISTINCT, ORDER BY, LIMIT
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 5
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Top 10 Highest Selling Products
-- Concept: ORDER BY units_sold DESC sorts records from highest volume to lowest,
--          and LIMIT 10 restricts the result set to the top 10 items.
-- ---------------------------------------------------------------------
SELECT 
    product_id, 
    product_name, 
    category, 
    units_sold, 
    revenue
FROM products_catalog
ORDER BY units_sold DESC
LIMIT 10;


-- ---------------------------------------------------------------------
-- TASK 1: Find all unique payment methods used in the orders table
-- Concept: The DISTINCT keyword eliminates duplicate values in the result set,
--          returning each distinct payment method exactly once.
-- ---------------------------------------------------------------------
SELECT DISTINCT 
    payment_method
FROM orders;


-- ---------------------------------------------------------------------
-- TASK 2: List all registered user cities once, sorted alphabetically (A-Z)
-- Concept: DISTINCT eliminates duplicate city names, while ORDER BY city ASC
--          sorts the distinct values in ascending alphabetical order.
-- ---------------------------------------------------------------------
SELECT DISTINCT 
    city
FROM users
ORDER BY city ASC;


-- ---------------------------------------------------------------------
-- TASK 3: Top 5 most recent movie bookings ordered by booking_date descending
-- Concept: ORDER BY booking_date DESC sorts chronologically from newest to oldest,
--          and LIMIT 5 restricts the output to the 5 most recent bookings.
-- ---------------------------------------------------------------------
SELECT 
    booking_id, 
    user_id, 
    movie_name, 
    theater_name, 
    tickets_count, 
    booking_date
FROM bookings
ORDER BY booking_date DESC
LIMIT 5;


-- ---------------------------------------------------------------------
-- TASK 4: Retrieve the 10 products with the highest sold_count from products table
-- Hint: Use ORDER BY and LIMIT together to achieve this.
-- Constraint: Display only product name (name) and sold_count, sorted highest to lowest.
-- ---------------------------------------------------------------------
SELECT 
    name, 
    sold_count
FROM products
ORDER BY sold_count DESC
LIMIT 10;
