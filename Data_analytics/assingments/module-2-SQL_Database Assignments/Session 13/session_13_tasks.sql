-- =====================================================================
-- SESSION 13: Window Functions (Part 1: OVER, PARTITION BY)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 13
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Find each employee's salary vs department average
-- Concept: Window functions perform aggregate calculations across a set of
--          table rows related to the current row, WITHOUT collapsing rows
--          (unlike standard GROUP BY which collapses rows).
-- ---------------------------------------------------------------------
SELECT 
    id,
    name,
    department,
    salary,
    ROUND(AVG(salary) OVER(PARTITION BY department), 2) AS dept_avg_salary,
    ROUND(salary - AVG(salary) OVER(PARTITION BY department), 2) AS diff_from_dept_avg
FROM employees
ORDER BY department, salary DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Display each order amount along with the total order amount
--         for all orders using OVER()
-- Concept: An empty OVER() clause defines a window spanning the entire
--          result set, broadcasting the overall grand total onto each row.
-- ---------------------------------------------------------------------
SELECT 
    order_id,
    user_id,
    app_name,
    order_amount,
    SUM(order_amount) OVER() AS total_order_amount_all_orders
FROM Orders
ORDER BY order_id;


-- ---------------------------------------------------------------------
-- TASK 2: Each user's order_id, order_amount, and average order_amount
--         for that user using OVER(PARTITION BY user_id)
-- ---------------------------------------------------------------------
SELECT 
    user_id,
    order_id,
    app_name,
    order_amount,
    ROUND(AVG(order_amount) OVER(PARTITION BY user_id), 2) AS user_avg_order_amount
FROM Orders
ORDER BY user_id, order_id;


-- ---------------------------------------------------------------------
-- TASK 3: Display each song's duration and the total duration of songs
--         added by each user using SUM(duration_sec) OVER(PARTITION BY user_id)
-- ---------------------------------------------------------------------
SELECT 
    user_id,
    song_id,
    duration_sec,
    SUM(duration_sec) OVER(PARTITION BY user_id) AS total_user_duration_sec
FROM Playlist
ORDER BY user_id, song_id;


-- ---------------------------------------------------------------------
-- TASK 4: Show each rating, the average rating per movie, and the difference
--         between the user's rating and the movie's average rating
-- Hint: Use AVG(rating) OVER(PARTITION BY movie_name) and subtract from user's rating.
-- ---------------------------------------------------------------------
SELECT 
    rating_id,
    user_id,
    movie_name,
    rating,
    ROUND(AVG(rating) OVER(PARTITION BY movie_name), 2) AS movie_avg_rating,
    ROUND(rating - AVG(rating) OVER(PARTITION BY movie_name), 2) AS rating_diff_from_avg
FROM MovieRatings
ORDER BY movie_name, rating_id;
