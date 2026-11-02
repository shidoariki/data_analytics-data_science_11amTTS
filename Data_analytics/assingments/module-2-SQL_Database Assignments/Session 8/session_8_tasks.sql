-- =====================================================================
-- SESSION 8: JOINS: INNER, LEFT, RIGHT (Foundation Session)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 8
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Join Orders + Customers -> Customer Segment -> Revenue
-- Concept: Multi-table join connecting transactional orders to user profiles
--          and categorical customer segments to compute revenue per segment.
-- ---------------------------------------------------------------------
SELECT 
    cs.segment_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_revenue
FROM CustomerSegments cs
LEFT JOIN Users u ON cs.segment_id = u.segment_id
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY cs.segment_id, cs.segment_name
ORDER BY total_revenue DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Create two tables: Users and Orders. Insert at least 3 users & 5 orders.
-- (Implemented in setup_tables.sql; verified below)
-- ---------------------------------------------------------------------
SELECT * FROM Users;
SELECT * FROM Orders;


-- ---------------------------------------------------------------------
-- TASK 2: INNER JOIN
-- List all usernames and their ordered products, showing ONLY users
-- who have placed at least one order.
-- Concept: Returns rows only when there is a match in BOTH tables.
--          Users without orders (e.g. karan_patel, sneha_rao) are excluded.
-- ---------------------------------------------------------------------
SELECT 
    u.username,
    o.product,
    o.amount
FROM Users u
INNER JOIN Orders o ON u.user_id = o.user_id;


-- ---------------------------------------------------------------------
-- TASK 3: LEFT JOIN
-- Display all usernames along with their ordered products. For users who
-- haven't placed any orders, show NULL for the product.
-- Concept: Preserves ALL records from the left table (Users). If no match
--          exists in Orders, columns from Orders evaluate to NULL.
-- ---------------------------------------------------------------------
SELECT 
    u.username,
    u.city,
    o.product,
    o.amount
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id;


-- ---------------------------------------------------------------------
-- TASK 4: RIGHT JOIN
-- Show all orders and the corresponding username for each order.
-- If an order has a user_id that doesn't exist in the Users table,
-- display NULL for the username.
-- Concept: Preserves ALL records from the right table (Orders). Unmatched
--          orders (e.g. order 106 with user_id 99) display NULL for username.
-- ---------------------------------------------------------------------
SELECT 
    o.order_id,
    o.product,
    o.amount,
    u.username
FROM Users u
RIGHT JOIN Orders o ON u.user_id = o.user_id;


-- ---------------------------------------------------------------------
-- TASK 5: Food Delivery Segmentation Query (Zomato-Style)
-- Show each username, their segment name, and total order amount.
-- Concept: Combines Users with CustomerSegments via INNER/LEFT JOIN and
--          aggregates order spend using LEFT JOIN and GROUP BY.
-- ---------------------------------------------------------------------
SELECT 
    u.username,
    cs.segment_name,
    COALESCE(SUM(o.amount), 0.00) AS total_order_amount
FROM Users u
LEFT JOIN CustomerSegments cs ON u.segment_id = cs.segment_id
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username, cs.segment_name
ORDER BY total_order_amount DESC;
