# Session 18 – Views
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Database Views, Reporting Abstraction, View Updatability Limits, and Dashboard Best Practices  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Concepts Overview

A **View** is a stored SQL query that acts as a virtual table. Views do not store physical data themselves; rather, they dynamically execute the underlying `SELECT` query whenever accessed.

### Key Benefits for Analytics & BI Dashboards:
1. **Security & Abstraction**: Restricts user access to sensitive underlying columns (e.g. passwords, payment card tokens).
2. **Standardization & DRY**: Encapsulates multi-table joins and complex KPI business logic in one place.
3. **Simplicity**: BI consumers can query `SELECT * FROM DailyOrdersSummary` without writing convoluted joins or aggregations.

### Updatability Limitations:
Views containing aggregate functions (`AVG`, `SUM`, `COUNT`), `GROUP BY`, `HAVING`, `DISTINCT`, or multi-table joins are **non-updatable**. The database engine cannot translate a modification on an aggregated metric back to individual physical rows.

---

## 2. Assignment Tasks & SQL Solutions

### Demo: Create View for Dashboard Reporting (Daily Sales)
```sql
CREATE VIEW View_DailySalesDashboard AS
SELECT 
    sale_date,
    COUNT(sale_id) AS total_transactions,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_ticket_size
FROM daily_sales
GROUP BY sale_date;
```

### Task 1: Create View `TopRatedRestaurants` (Rating > 4.0)
```sql
CREATE VIEW TopRatedRestaurants AS
SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
INNER JOIN restaurant_reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
HAVING AVG(rv.rating) > 4.0;
```

### Task 2: Update View to Include `city` Column
```sql
CREATE OR REPLACE VIEW TopRatedRestaurants AS
SELECT 
    r.restaurant_name,
    r.city,
    ROUND(AVG(rv.rating), 2) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
INNER JOIN restaurant_reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name, r.city
HAVING AVG(rv.rating) > 4.0;
```

### Task 3: View Updatability Limitation Analysis
**Attempted Query:**
```sql
UPDATE TopRatedRestaurants 
SET avg_rating = 5.0 
WHERE restaurant_name = 'Truffles';
```
**Exact Error Observed:**
- **MySQL:** `ERROR 1288 (HY000): The target table TopRatedRestaurants of the UPDATE is not updatable`
- **SQLite:** `OperationalError: cannot modify TopRatedRestaurants because it is a view`

**Root Cause Explanation:**
Under ANSI SQL standards, a view is updatable only if there exists a strict 1-to-1 correspondence between rows in the view and rows in a single underlying base table. Because `TopRatedRestaurants` uses `AVG(rating)` grouped by restaurant across multiple review records, modifying `avg_rating` is mathematically and logically ambiguous—the database engine cannot infer whether to modify review #1, review #2, or create an offset record.

### Task 4: Create View `DailyOrdersSummary` (Last 30 Days)
```sql
CREATE VIEW DailyOrdersSummary AS
SELECT 
    order_date,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM swiggy_orders
WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
GROUP BY order_date;
```

### Task 5: 3 Best Practices for Analytics Dashboard Views
1. **Pre-filter & Constrain Columns (Avoid `SELECT *`)**:
   * *Flipkart Example:* In `FlipkartDeliveredSalesView`, include `WHERE order_status = 'DELIVERED'` and exclude heavy internal JSON blobs to minimize payload size during dashboard visual rendering.
2. **Standardize Naming and Pre-calculate Business Metrics**:
   * *Flipkart Example:* In `FlipkartDailyRevenueView`, pre-calculate `ROUND(SUM(sale_amount - discount_amount), 2)` as `net_gmv` so all executive reports use an aligned single definition.
3. **Index Underlying Base Tables for Join and Filter Columns**:
   * *Flipkart Example:* Ensure composite index `(order_date, category_id)` exists on the base `orders` table so queries against `CategoryDailySummaryView` execute with fast index seeks instead of full sequential table scans.

---

## 3. Execution & Verification Output

```text
--- DEMO: Create View for Dashboard Reporting (Daily Sales) ---
('2024-04-01', 2, 15700, 7850.0)
('2024-04-02', 2, 23400, 11700.0)
('2024-04-03', 1, 6100, 6100.0)

--- TASK 1: Create View TopRatedRestaurants (avg_rating > 4.0) ---
('Corner House Ice Cream', 4.85, 2)
('Truffles', 4.5, 3)
('Meghana Foods', 4.5, 2)

--- TASK 2: Update View to Include City Column ---
('Corner House Ice Cream', 'Bangalore', 4.85, 2)
('Truffles', 'Bangalore', 4.5, 3)
('Meghana Foods', 'Bangalore', 4.5, 2)

--- TASK 3: Attempting UPDATE on Calculated View Column ---
Captured Expected Error: OperationalError: cannot modify TopRatedRestaurants because it is a view

--- TASK 4: Create View DailyOrdersSummary (Last 30 Days) ---
('2024-04-01', 2, 770)
('2024-04-02', 1, 650)
('2024-04-03', 2, 870)
('2024-04-04', 1, 850)

Session 18 Verification Successful!
```
