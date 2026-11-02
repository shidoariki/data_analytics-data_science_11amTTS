-- =====================================================================
-- SESSION 18: Views
-- Assignment Solutions
-- Dialect: MySQL (with SQLite equivalents documented)
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Create View for Dashboard Reporting (Daily Sales)
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS View_DailySalesDashboard;

CREATE VIEW View_DailySalesDashboard AS
SELECT 
    sale_date,
    COUNT(sale_id) AS total_transactions,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_ticket_size
FROM daily_sales
GROUP BY sale_date;

-- Query the demo view:
SELECT * FROM View_DailySalesDashboard ORDER BY sale_date ASC;


-- ---------------------------------------------------------------------
-- TASK 1: Create View TopRatedRestaurants
-- Description: Selects restaurant name, average rating, and total reviews
-- from restaurant_reviews, showing only restaurants with avg rating > 4.0.
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS TopRatedRestaurants;

CREATE VIEW TopRatedRestaurants AS
SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
INNER JOIN restaurant_reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
HAVING AVG(rv.rating) > 4.0;

-- Query Task 1 view:
SELECT * FROM TopRatedRestaurants ORDER BY avg_rating DESC;


-- ---------------------------------------------------------------------
-- TASK 2: Update View to Include City Column
-- Description: Re-define TopRatedRestaurants view to include the city column
-- using an INNER JOIN between restaurants and restaurant_reviews.
-- ---------------------------------------------------------------------
-- MySQL Syntax: CREATE OR REPLACE VIEW TopRatedRestaurants AS ...
-- Standard/SQLite Syntax:
DROP VIEW IF EXISTS TopRatedRestaurants;

CREATE VIEW TopRatedRestaurants AS
SELECT 
    r.restaurant_name,
    r.city,
    ROUND(AVG(rv.rating), 2) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
INNER JOIN restaurant_reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name, r.city
HAVING AVG(rv.rating) > 4.0;

-- Query updated view:
SELECT * FROM TopRatedRestaurants ORDER BY avg_rating DESC;


-- ---------------------------------------------------------------------
-- TASK 3: Attempt View Update on Calculated Column (Testing View Limitations)
-- Description: Attempt an UPDATE statement on the aggregate column avg_rating
-- and observe the limitation.
-- ---------------------------------------------------------------------
-- Attempted Update Query:
-- UPDATE TopRatedRestaurants
-- SET avg_rating = 5.0
-- WHERE restaurant_name = 'Truffles';
--
-- Exact Error Observed:
-- MySQL:  ERROR 1288 (HY000): The target table TopRatedRestaurants of the UPDATE is not updatable.
-- SQLite: OperationalError: cannot modify TopRatedRestaurants because it is a view.
--
-- Explanation of SQL View Limitations:
-- A view is strictly non-updatable when its definition contains:
-- 1. Aggregate functions (AVG, SUM, COUNT, MIN, MAX).
-- 2. GROUP BY or HAVING clauses.
-- 3. Multi-table joins where target columns cannot be mapped 1:1 to a single unambiguous base table row.
-- Because avg_rating is a computed summary of 3 distinct review records, the database engine
-- cannot determine how to distribute a change back to the underlying physical rows in restaurant_reviews.


-- ---------------------------------------------------------------------
-- TASK 4: Create View DailyOrdersSummary (Last 30 Days)
-- Description: Aggregates order count and total revenue per date for
-- Swiggy orders placed in the last 30 days using WHERE and GROUP BY.
-- ---------------------------------------------------------------------
DROP VIEW IF EXISTS DailyOrdersSummary;

-- MySQL Syntax:
-- CREATE VIEW DailyOrdersSummary AS
-- SELECT 
--     order_date,
--     COUNT(order_id) AS total_orders,
--     SUM(order_amount) AS total_revenue
-- FROM swiggy_orders
-- WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY)
-- GROUP BY order_date;

-- SQLite Syntax:
CREATE VIEW DailyOrdersSummary AS
SELECT 
    order_date,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM swiggy_orders
WHERE order_date >= date('2024-04-10', '-30 day')
GROUP BY order_date;

-- Query Task 4 view:
SELECT * FROM DailyOrdersSummary ORDER BY order_date ASC;


-- ---------------------------------------------------------------------
-- TASK 5: 3 Best Practices for Analytics Dashboard Views
-- ---------------------------------------------------------------------
-- 1. Pre-filter & Narrow Column Scope (Avoid SELECT *):
--    Example: In FlipkartDeliveredSalesView, include WHERE order_status = 'DELIVERED'
--    and omit internal debugging IDs to avoid unnecessary memory overhead on dashboard renders.
--
-- 2. Standardize Naming and Pre-calculate Business KPIs:
--    Example: In FlipkartDailyGMVView, pre-calculate ROUND(SUM(sale_amount - discount), 2)
--    as net_gmv so all reporting teams use an identical single source of truth.
--
-- 3. Leverage Underlying Table Indexes for Filter and Join Columns:
--    Example: Ensure base tables flipkart_orders(order_date, category_id) are indexed
--    so that queries executing against the view execute with index seeks rather than full scans.
