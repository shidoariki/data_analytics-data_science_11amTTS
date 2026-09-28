-- =============================================================================
-- SESSION 2: Basic SELECT & FROM
-- Topics:
--   1. SELECT column1, column2
--   2. SELECT *
--   3. Renaming columns (AS keyword)
--   4. Comments in SQL (-- single line, /* */ multi-line, # MySQL-style)
--
-- Student: Rushikesh
-- Target Folder: D:\DA\Data_analytics\assingments\Session 2
-- =============================================================================

USE session_2_db;

-- -----------------------------------------------------------------------------
-- DEMO: SELECT * FROM employees;
-- Purpose: Retrieves all columns and all rows from the employees table.
-- -----------------------------------------------------------------------------
SELECT * 
FROM employees;


-- -----------------------------------------------------------------------------
-- TASK 1:
-- Open your SQL editor and run a query to select all columns from a table named 
-- restaurants using SELECT * FROM restaurants;.
-- -----------------------------------------------------------------------------
SELECT * 
FROM restaurants;


-- -----------------------------------------------------------------------------
-- TASK 2:
-- Write an SQL query to display only the name and rating columns from the 
-- table zomato_reviews.
-- -----------------------------------------------------------------------------
SELECT name, rating 
FROM zomato_reviews;


-- -----------------------------------------------------------------------------
-- TASK 3:
-- Write an SQL query to select the movie_name and release_year columns from 
-- a table called movies, but rename movie_name as 'Title' and release_year 
-- as 'Year Released' in the output using the AS keyword.
-- -----------------------------------------------------------------------------
SELECT 
    movie_name AS 'Title', 
    release_year AS 'Year Released' 
FROM movies;


-- -----------------------------------------------------------------------------
-- TASK 4:
-- In a table called products, write an SQL query that selects all columns 
-- and add a comment in your SQL code explaining what the query does.
-- Hint: Use -- to write a single-line comment above your query.
-- -----------------------------------------------------------------------------

-- This query retrieves all columns and records from the products inventory table.
SELECT * 
FROM products;
