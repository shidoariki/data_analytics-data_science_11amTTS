-- =====================================================================
-- SESSION 19: Indexing & Query Optimization
-- Assignment Solutions
-- Dialect: MySQL / SQLite Compatible
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Slow Query vs Indexed Query Benchmark
-- Measure execution time and EXPLAIN plan before and after adding index
-- ---------------------------------------------------------------------
-- Before Index:
EXPLAIN SELECT * FROM orders WHERE user_id = 42;
SELECT * FROM orders WHERE user_id = 42;

-- Add Index on user_id:
CREATE INDEX idx_user_id ON orders(user_id);

-- After Index:
EXPLAIN SELECT * FROM orders WHERE user_id = 42;
SELECT * FROM orders WHERE user_id = 42;


-- ---------------------------------------------------------------------
-- TASK 1: Slow Query on Unindexed Table (15,000+ Rows)
-- Description: Run a SELECT query on a large orders table to find all 
-- orders for a specific user_id and measure query execution time.
-- ---------------------------------------------------------------------
-- Note: Without an index, the database must execute a Full Table Scan (O(N)),
-- checking every single row across the storage blocks.
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount,
    order_status
FROM orders
WHERE user_id = 250;


-- ---------------------------------------------------------------------
-- TASK 2: Create Index on user_id and Measure Improvement
-- Description: Create an index on user_id and re-run the same query.
-- ---------------------------------------------------------------------
-- DDL to create standard B-Tree index:
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Re-running query with B-Tree Index Seek (O(log N)):
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount,
    order_status
FROM orders
WHERE user_id = 250;


-- ---------------------------------------------------------------------
-- TASK 3: EXPLAIN PLAN Comparative Analysis
-- Description: Analyze how the SELECT query runs before and after index.
-- ---------------------------------------------------------------------
-- 1. Before Index EXPLAIN Output:
--    SQLite: SCAN orders
--    MySQL:  type: ALL, rows: 15000, key: NULL, Extra: Using where
--    Meaning: Full Table Scan. Every disk page containing orders was read into memory.
--
-- 2. After Index EXPLAIN Output:
--    SQLite: SEARCH orders USING INDEX idx_orders_user_id (user_id=?)
--    MySQL:  type: ref, key: idx_orders_user_id, rows: ~15, Extra: Using index condition
--    Meaning: B-Tree Index Seek. The engine jumps directly to pointer leaf nodes in O(log N).

EXPLAIN QUERY PLAN
SELECT order_id, user_id, order_date, total_amount
FROM orders
WHERE user_id = 250;


-- ---------------------------------------------------------------------
-- TASK 4: Avoiding Full Table Scan with Index on Category
-- Description: Write a query for products table using an index on category.
-- ---------------------------------------------------------------------
-- Create index on products(category):
CREATE INDEX idx_products_category ON products(category);

-- Query utilizing index seek to avoid full table scan:
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM products
WHERE category = 'Electronics';

-- Verify with EXPLAIN:
EXPLAIN QUERY PLAN
SELECT product_id, product_name, category, price, stock_quantity
FROM products
WHERE category = 'Electronics';


-- ---------------------------------------------------------------------
-- TASK 5: Advanced Optimization Techniques When Indexing Is Not Enough
-- Description: If SELECT on orders is still slow even after indexing,
-- research and describe additional optimization techniques.
-- ---------------------------------------------------------------------
-- Technique 1: Covering Index (Index-Only Scan)
-- If a query frequently selects (user_id, order_date, total_amount), a normal index
-- on user_id still requires secondary "bookmark lookups" back to the clustered table blocks.
-- Creating a composite covering index allows the engine to satisfy the query entirely from the B-Tree:
-- DDL:
-- CREATE INDEX idx_orders_covering ON orders(user_id, order_date, total_amount);
--
-- Technique 2: Table Partitioning (Horizontal Range Partitioning)
-- For massive multi-million row order tables (like Flipkart or Amazon), partition by order_date:
-- PARTITION BY RANGE (YEAR(order_date)) (
--     PARTITION p2022 VALUES LESS THAN (2023),
--     PARTITION p2023 VALUES LESS THAN (2024),
--     PARTITION p2024 VALUES LESS THAN (2025)
-- );
-- Benefit: Partition Pruning eliminates entire physical storage partitions during query execution.
--
-- Technique 3: Keyset Pagination (Cursor-based) over OFFSET
-- Avoid: SELECT * FROM orders WHERE user_id = 250 LIMIT 10 OFFSET 50000; (scans 50,010 rows)
-- Use:   SELECT * FROM orders WHERE user_id = 250 AND order_id < 45000 ORDER BY order_id DESC LIMIT 10;
