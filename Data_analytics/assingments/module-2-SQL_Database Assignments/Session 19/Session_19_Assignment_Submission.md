# Session 19 – Indexing & Query Optimization
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Database Indexing, B-Trees, `EXPLAIN PLAN`, Full Table Scan Avoidance, and Execution Optimization  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Optimization Fundamentals

In relational database systems, unindexed queries perform sequential **Full Table Scans ($O(N)$)**, loading every physical page from disk into RAM. 

### Why Queries Become Slow:
1. **Missing Indexes on Predicates**: Columns in `WHERE`, `JOIN`, or `ORDER BY` lack supporting access structures.
2. **High Cardinality Scans**: Scanning millions of records for a handful of matching rows.
3. **Functions on Indexed Columns**: Applying functions like `WHERE YEAR(order_date) = 2024` prevents index seek utilization (SARGability violation).
4. **Unnecessary Column Projections**: Selecting `SELECT *` forces disk I/O for wide columns (TEXT/BLOBs) instead of index-only resolution.

---

## 2. Assignment Tasks & SQL Solutions

### Task 1: Slow Query on Unindexed 15,000+ Row Table
```sql
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount,
    order_status
FROM orders
WHERE user_id = 250;
```

### Task 2: Create Index on `user_id` and Measure Improvement
```sql
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Re-running query with B-Tree Index Seek:
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount,
    order_status
FROM orders
WHERE user_id = 250;
```

### Task 3: `EXPLAIN PLAN` Analysis & Key Differences Observed
```sql
EXPLAIN QUERY PLAN
SELECT * FROM orders WHERE user_id = 250;
```

#### Detailed Comparison Table:
| Metric / Attribute | Before Index Creation | After Index Creation |
| :--- | :--- | :--- |
| **Execution Plan** | `SCAN orders` (Full Table Scan) | `SEARCH orders USING INDEX idx_orders_user_id (user_id=?)` |
| **Complexity** | Linear $O(N)$ | Logarithmic $O(\log N)$ |
| **Pages Inspected** | All 15,000 table rows inspected | Directly traversed B-Tree depth (~3 tree reads + 70 matched row lookups) |
| **Execution Time** | **0.4527 ms** | **0.0620 ms** |
| **Observed Speedup** | Baseline | **7.30x Faster** |

---

### Task 4: Avoiding Full Table Scan on Products Table
```sql
-- Create Index on category
CREATE INDEX idx_products_category ON products(category);

-- Optimized Query:
SELECT 
    product_id,
    product_name,
    category,
    price,
    stock_quantity
FROM products
WHERE category = 'Electronics';

-- Verified Plan:
-- SEARCH products USING INDEX idx_products_category (category=?)
```

---

### Task 5: Advanced Query Optimization Techniques Beyond Basic Indexing
If a `SELECT` query remains slow even after creating an index on `user_id`:

1. **Composite Covering Index (`Index-Only Scan`)**:
   - *Problem:* A secondary index on `user_id` still requires the engine to perform secondary table bookmark lookups for non-indexed columns (`order_date`, `total_amount`).
   - *Solution:* Create a covering index:
     ```sql
     CREATE INDEX idx_orders_covering ON orders(user_id, order_date, total_amount);
     ```
   - *Result:* SQLite produces `SEARCH orders USING COVERING INDEX idx_orders_covering (user_id=?)`, entirely bypassing table disk reads.

2. **Horizontal Table Partitioning (Range Partitioning)**:
   - *Problem:* As tables grow to tens of millions of rows, B-Trees become too large to fit in memory buffer pools.
   - *Solution:* Partition orders horizontally by date (e.g. `PARTITION BY RANGE (YEAR(order_date))`). Queries filtering on `order_date` prune untouched historical years completely.

3. **Keyset (Cursor-based) Pagination over `OFFSET`**:
   - *Problem:* Queries like `LIMIT 10 OFFSET 50000` must scan and discard 50,000 rows.
   - *Solution:* Filter with deterministic monotonic IDs: `WHERE user_id = 250 AND order_id < :last_seen_id ORDER BY order_id DESC LIMIT 10`.

---

## 3. Empirical Verification Benchmark Output

```text
Populating 15,000 rows into orders table...
Orders populated successfully.

--- TASK 1 & TASK 3: Query Execution BEFORE Index & EXPLAIN Plan ---
EXPLAIN QUERY PLAN before index: [(2, 0, 216, 'SCAN orders')]
Rows found for user 250: 70
Average execution time BEFORE index: 0.4527 ms

--- TASK 2 & TASK 3: Create Index & Query Execution AFTER Index ---
EXPLAIN QUERY PLAN after index: [(3, 0, 61, 'SEARCH orders USING INDEX idx_orders_user_id (user_id=?)')]
Average execution time AFTER index: 0.0620 ms
Performance Speedup: 7.30x faster!

--- TASK 4: Index on Products(category) to Avoid Full Table Scan ---
EXPLAIN QUERY PLAN on products: [(3, 0, 62, 'SEARCH products USING INDEX idx_products_category (category=?)')]
(1, 'iPhone 15 Pro', 'Electronics', 134900)
(2, 'Samsung Galaxy S24', 'Electronics', 79999)
(3, 'OnePlus 12', 'Electronics', 64999)

--- TASK 5: Covering Index Demonstration ---
EXPLAIN QUERY PLAN with Covering Index: [(2, 0, 54, 'SEARCH orders USING COVERING INDEX idx_orders_covering (user_id=?)')]

Session 19 Verification Successful!
```
