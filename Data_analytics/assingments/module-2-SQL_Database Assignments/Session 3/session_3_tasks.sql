-- =============================================================================
-- SESSION 3: WHERE Clause & Operators
-- Topics:
--   1. WHERE Clause filtering
--   2. Comparison operators: =, <>, !=, >, <, <=, >=
--   3. Logical operators: AND, OR, NOT
--
-- Student: Rushikesh
-- Target Folder: D:\DA\Data_analytics\assingments\Session 3
-- =============================================================================

USE session_3_db;

-- -----------------------------------------------------------------------------
-- DEMO: Filter employees with salary > 50000 and in "IT" dept.
-- Demonstrates: WHERE clause with comparison operator (>) and logical AND.
-- -----------------------------------------------------------------------------
SELECT * 
FROM employees
WHERE salary > 50000 
  AND department = 'IT';


-- -----------------------------------------------------------------------------
-- TASK 1:
-- Write an SQL query to select all restaurants from a table named 'restaurants' 
-- where the rating is greater than or equal to 4.5.
-- Demonstrates: Greater than or equal to (>=) operator.
-- -----------------------------------------------------------------------------
SELECT * 
FROM restaurants
WHERE rating >= 4.5;


-- -----------------------------------------------------------------------------
-- TASK 2:
-- In a table called 'movies', filter and display only the movies released 
-- after 2020 and with genre 'Action' using the WHERE clause and AND operator.
-- Demonstrates: Combining numerical filter (> 2020) and string equality (= 'Action')
-- using logical AND.
-- -----------------------------------------------------------------------------
SELECT * 
FROM movies
WHERE release_year > 2020 
  AND genre = 'Action';


-- -----------------------------------------------------------------------------
-- TASK 3:
-- Given a table 'products' with columns (id, name, price, category), write a 
-- query to find all products not in the 'Electronics' category or with a 
-- price less than 500.
-- Demonstrates: Combining inequality (<> or NOT) with logical OR.
-- -----------------------------------------------------------------------------

-- Approach A: Using the standard inequality operator (<>)
SELECT id, name, price, category
FROM products
WHERE category <> 'Electronics' 
   OR price < 500;

-- Approach B: Using NOT operator explicitly
SELECT id, name, price, category
FROM products
WHERE NOT (category = 'Electronics') 
   OR price < 500;


-- -----------------------------------------------------------------------------
-- TASK 4:
-- Write an SQL query for a table 'users' to show all users who are NOT from 
-- 'Ahmedabad' and have more than 1000 followers.
-- Hint: Use the NOT operator combined with AND.
-- Demonstrates: Combining NOT condition with logical AND.
-- -----------------------------------------------------------------------------
SELECT user_id, name, city, followers
FROM users
WHERE NOT (city = 'Ahmedabad') 
  AND followers > 1000;
