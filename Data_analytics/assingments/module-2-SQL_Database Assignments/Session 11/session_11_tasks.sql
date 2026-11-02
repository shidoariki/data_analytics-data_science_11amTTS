-- =====================================================================
-- SESSION 11: Subqueries (Scalar, Row, Table)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 11
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Find employees earning above company average salary
-- Concept: Subquery in the WHERE clause returns a single scalar value
--          representing the company-wide average salary.
-- ---------------------------------------------------------------------
SELECT 
    id, 
    name, 
    department, 
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Names and ratings of restaurants with rating > overall average
-- Hint: Use a subquery in the WHERE clause to calculate the average rating.
-- ---------------------------------------------------------------------
SELECT 
    name, 
    rating
FROM Restaurants
WHERE rating > (SELECT AVG(rating) FROM Restaurants)
ORDER BY rating DESC;


-- ---------------------------------------------------------------------
-- TASK 2: Products with Category Average Price as a Scalar Subquery in SELECT
-- Concept: Correlated scalar subquery executes for each candidate row to
--          compute the average price of the matching category.
-- ---------------------------------------------------------------------
SELECT 
    p.name AS product_name,
    p.category,
    p.price,
    ROUND((
        SELECT AVG(p2.price) 
        FROM Products p2 
        WHERE p2.category = p.category
    ), 2) AS category_avg_price
FROM Products p
ORDER BY p.category, p.price DESC;


-- ---------------------------------------------------------------------
-- TASK 3: Users who created more playlists than the average playlists per user
-- Hint: Use a derived table (subquery in FROM) to count playlists per user,
--       then filter with a subquery in WHERE.
-- ---------------------------------------------------------------------
SELECT 
    u.username,
    user_counts.playlist_count
FROM Users u
INNER JOIN (
    -- Derived Table in FROM clause
    SELECT user_id, COUNT(playlist_id) AS playlist_count
    FROM Playlists
    GROUP BY user_id
) user_counts ON u.user_id = user_counts.user_id
WHERE user_counts.playlist_count > (
    -- Subquery in WHERE calculating overall average playlists per active user
    SELECT AVG(sub.p_count)
    FROM (
        SELECT COUNT(playlist_id) AS p_count
        FROM Playlists
        GROUP BY user_id
    ) sub
)
ORDER BY user_counts.playlist_count DESC;


-- ---------------------------------------------------------------------
-- TASK 4: Find user_ids who placed at least one order > average order amount
-- Concept: Subquery in WHERE evaluates overall average order amount.
--          DISTINCT ensures each eligible user_id is listed once.
-- ---------------------------------------------------------------------
SELECT DISTINCT 
    user_id
FROM Orders
WHERE total_amount > (SELECT AVG(total_amount) FROM Orders)
ORDER BY user_id;
