-- =====================================================================
-- SESSION 15: Date Functions
-- Assignment Solutions
-- Dialect: MySQL (with SQLite equivalents documented)
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Calculate Customer Churn Age (Days Since Last Visit)
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    customer_id,
    customer_name,
    last_visit_date,
    DATEDIFF(CURRENT_DATE(), last_visit_date) AS days_since_last_visit
FROM customer_visits
ORDER BY days_since_last_visit DESC;

-- SQLite Equivalent:
-- SELECT customer_id, customer_name, last_visit_date,
--        CAST(JULIANDAY('now') - JULIANDAY(last_visit_date) AS INT) AS days_since_last_visit
-- FROM customer_visits ORDER BY days_since_last_visit DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Current Date & Time Display
-- Description: Write an SQL query using NOW() to display current date 
-- and time as 'CurrentDateTime'.
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT NOW() AS CurrentDateTime;

-- SQLite Equivalent:
-- SELECT datetime('now', 'localtime') AS CurrentDateTime;


-- ---------------------------------------------------------------------
-- TASK 2: Extract Year, Month, and Day Components
-- Description: From table Orders, display order_date along with year,
-- month, and day as separate columns using YEAR(), MONTH(), and DAY().
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DAY(order_date) AS order_day
FROM Orders;

-- SQLite Equivalent:
-- SELECT order_id, order_date,
--        CAST(strftime('%Y', order_date) AS INT) AS order_year,
--        CAST(strftime('%m', order_date) AS INT) AS order_month,
--        CAST(strftime('%d', order_date) AS INT) AS order_day
-- FROM Orders;


-- ---------------------------------------------------------------------
-- TASK 3: Order Delivery Estimate with DATE_SUB()
-- Description: For table Deliveries, display delivery_date and 
-- expected_pickup_date (2 days prior to delivery_date).
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    delivery_id,
    order_id,
    delivery_date,
    DATE_SUB(delivery_date, INTERVAL 2 DAY) AS expected_pickup_date
FROM Deliveries;

-- SQLite Equivalent:
-- SELECT delivery_id, order_id, delivery_date,
--        date(delivery_date, '-2 day') AS expected_pickup_date
-- FROM Deliveries;


-- ---------------------------------------------------------------------
-- TASK 4: Subscription Duration Calculation using DATEDIFF()
-- Description: From Subscriptions, display user_id, start_date, end_date,
-- and the duration in days using DATEDIFF(end_date, start_date).
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    user_id,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS total_subscription_days
FROM Subscriptions;

-- SQLite Equivalent:
-- SELECT user_id, start_date, end_date,
--        CAST(JULIANDAY(end_date) - JULIANDAY(start_date) AS INT) AS total_subscription_days
-- FROM Subscriptions;


-- ---------------------------------------------------------------------
-- TASK 5: Identifying Dormant App Users (> 30 Days Inactive)
-- Description: From AppLogins, select user_id and last_login_date for 
-- users who haven't logged in for more than 30 days from today.
-- ---------------------------------------------------------------------
-- MySQL Syntax:
SELECT 
    user_id,
    last_login_date
FROM AppLogins
WHERE DATEDIFF(NOW(), last_login_date) > 30;

-- SQLite Equivalent:
-- SELECT user_id, last_login_date
-- FROM AppLogins
-- WHERE CAST(JULIANDAY('now') - JULIANDAY(last_login_date) AS INT) > 30;
