-- =====================================================================
-- SESSION 10: UNION & UNION ALL
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 10
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Combine Online + Offline Sales Tables
-- Concept: Set operations combine row sets from multiple SELECT statements.
--          Tables must have identical number of columns with compatible data types.
-- ---------------------------------------------------------------------
SELECT 
    sale_id, 
    customer_name, 
    amount, 
    sale_date, 
    'Online Store' AS channel
FROM online_sales

UNION ALL

SELECT 
    sale_id, 
    customer_name, 
    amount, 
    sale_date, 
    'Retail Outlet' AS channel
FROM offline_sales
ORDER BY sale_date;


-- ---------------------------------------------------------------------
-- TASK 1: Create AppOrders and InStoreOrders tables with sample records
-- (Implemented in setup_tables.sql; verified here)
-- ---------------------------------------------------------------------
SELECT * FROM AppOrders;
SELECT * FROM InStoreOrders;


-- ---------------------------------------------------------------------
-- TASK 2: Combine all UNIQUE customer names using UNION
-- Concept: UNION applies an implicit DISTINCT operation, de-duplicating
--          names appearing in both AppOrders and InStoreOrders.
-- ---------------------------------------------------------------------
SELECT customer_name FROM AppOrders
UNION
SELECT customer_name FROM InStoreOrders
ORDER BY customer_name;


-- ---------------------------------------------------------------------
-- TASK 3: Display EVERY order from both tables using UNION ALL
-- Concept: UNION ALL combines all rows without de-duplication, preserving
--          full transactional volume and executing faster.
-- ---------------------------------------------------------------------
SELECT 
    order_id, 
    customer_name, 
    amount, 
    order_date,
    'App Order' AS order_type
FROM AppOrders

UNION ALL

SELECT 
    order_id, 
    customer_name, 
    amount, 
    order_date,
    'In-Store Dine-in' AS order_type
FROM InStoreOrders
ORDER BY order_date;


-- ---------------------------------------------------------------------
-- TASK 4: Demonstrate the difference between UNION and UNION ALL
-- Step A: Run UNION (removes duplicate customer names)
-- Step B: Run UNION ALL (preserves duplicate customer names)
-- Compare row counts and explain performance implications.
-- ---------------------------------------------------------------------

-- Query 4A: UNION (Unique customers across both channels)
SELECT customer_name FROM AppOrders
UNION
SELECT customer_name FROM InStoreOrders;

-- Query 4B: UNION ALL (All customer occurrences across both channels)
SELECT customer_name FROM AppOrders
UNION ALL
SELECT customer_name FROM InStoreOrders;
