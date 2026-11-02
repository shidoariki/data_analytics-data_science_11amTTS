-- =====================================================================
-- SESSION 6: Aggregate Functions
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 6
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Aggregate Functions (Total Revenue, Average Salary, Highest Order Value)
-- Concept: Aggregate functions process a collection of row values and return
--          a single summarizing scalar value.
-- ---------------------------------------------------------------------

-- Demo 1: Total Revenue using SUM()
SELECT 
    SUM(revenue) AS total_revenue
FROM demo_sales;

-- Demo 2: Average Salary using AVG()
SELECT 
    AVG(salary) AS average_salary
FROM demo_employees;

-- Demo 3: Highest Order Value using MAX()
SELECT 
    MAX(order_value) AS highest_order_value
FROM demo_orders;


-- ---------------------------------------------------------------------
-- TASK 1: Calculate total amount spent by users on food orders
-- Concept: SUM(amount) accumulates all transaction values in food_orders.
-- ---------------------------------------------------------------------
SELECT 
    SUM(amount) AS total_food_spending
FROM food_orders;


-- ---------------------------------------------------------------------
-- TASK 2: Count how many songs a user has added to their playlist
-- Concept: COUNT(song_id) or COUNT(*) counts total matching records.
--          Filter for a specific user (e.g. user_id = 101).
-- ---------------------------------------------------------------------
SELECT 
    COUNT(song_id) AS total_songs_in_playlist
FROM spotify_playlists
WHERE user_id = 101;


-- ---------------------------------------------------------------------
-- TASK 3: Average rating for a movie rounded to 1 decimal place
-- Concept: AVG(rating) calculates arithmetic mean, and ROUND(..., 1)
--          formats the result to 1 decimal place.
-- ---------------------------------------------------------------------
SELECT 
    movie_id,
    ROUND(AVG(rating), 1) AS average_rating
FROM bookmyshow_reviews
WHERE movie_id = 201
GROUP BY movie_id;


-- ---------------------------------------------------------------------
-- TASK 4: Minimum and maximum transaction values for a user
-- Concept: MIN(amount) and MAX(amount) retrieve the boundary transactions.
-- ---------------------------------------------------------------------
SELECT 
    user_id,
    MIN(amount) AS smallest_transaction_amount,
    MAX(amount) AS largest_transaction_amount
FROM paytm_transactions
WHERE user_id = 101
GROUP BY user_id;


-- ---------------------------------------------------------------------
-- TASK 5: Total orders, average order value (rounded to 2 decimals),
--         and highest order value for each user_id.
-- Constraint: Use GROUP BY to get results per user.
-- ---------------------------------------------------------------------
SELECT 
    user_id,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(total_price), 2) AS average_order_value,
    MAX(total_price) AS highest_order_value
FROM myntra_orders
GROUP BY user_id
ORDER BY user_id ASC;
