-- =====================================================================
-- SESSION 7: GROUP BY & HAVING (Critical Analytics Topic)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 7
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Total Revenue per Region, Show Only Regions with Revenue > 1M (1,000,000)
-- Concept: GROUP BY partitions the dataset by region, SUM(revenue) aggregates
--          the total, and HAVING filters the aggregated group metric.
--          (WHERE cannot filter on aggregate functions like SUM/COUNT/AVG).
-- ---------------------------------------------------------------------
SELECT 
    region,
    SUM(revenue) AS total_revenue
FROM regional_sales
GROUP BY region
HAVING SUM(revenue) > 1000000;


-- ---------------------------------------------------------------------
-- TASK 1: Total number of orders placed by each user in 'food_orders'
-- Concept: Grouping by user_id and applying COUNT(order_id) to calculate
--          order frequency per customer.
-- ---------------------------------------------------------------------
SELECT 
    user_id,
    COUNT(order_id) AS total_orders
FROM food_orders
GROUP BY user_id
ORDER BY total_orders DESC;


-- ---------------------------------------------------------------------
-- TASK 2: Total amount spent by each payment_method in 'transactions'
-- Concept: Grouping by payment_method and accumulating total volume using SUM(amount).
-- ---------------------------------------------------------------------
SELECT 
    payment_method,
    SUM(amount) AS total_amount_spent
FROM transactions
GROUP BY payment_method
ORDER BY total_amount_spent DESC;


-- ---------------------------------------------------------------------
-- TASK 3: Total box_office_collection per genre, only genres above 10 crore
-- Hint: Use GROUP BY and HAVING together to filter the aggregated results.
-- Note: 10 Crore = 100,000,000 (100M).
-- ---------------------------------------------------------------------
SELECT 
    genre,
    SUM(box_office_collection) AS total_box_office_collection
FROM movies
GROUP BY genre
HAVING SUM(box_office_collection) > 100000000
ORDER BY total_box_office_collection DESC;


-- ---------------------------------------------------------------------
-- TASK 4: Users with combined playlist song duration > 2 hours (7200 seconds)
-- Concept: SUM(duration) calculates total playlist duration in seconds per user.
--          HAVING SUM(duration) > 7200 isolates heavy music listeners.
-- ---------------------------------------------------------------------
SELECT 
    user_id,
    SUM(duration) AS total_duration_seconds
FROM playlist
GROUP BY user_id
HAVING SUM(duration) > 7200
ORDER BY total_duration_seconds DESC;
