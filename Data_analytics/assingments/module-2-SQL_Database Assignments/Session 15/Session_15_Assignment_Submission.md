# Session 15 – Date Functions
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Date Arithmetic, Decomposition, Duration Metrics, and Temporal Filtering  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Concepts Overview

Temporal analytics are fundamental to e-commerce, food delivery, and subscription platforms. Date functions allow analysts to extract granular time dimensions (Year, Quarter, Month, Day), perform date arithmetic (`DATE_ADD`, `DATE_SUB`), compute durations (`DATEDIFF`), and identify dormant user cohorts based on activity thresholds.

### Function Reference & Dialect Mapping

| Objective | MySQL Standard | SQLite Equivalent |
| :--- | :--- | :--- |
| **Current Timestamp** | `NOW()` / `CURRENT_TIMESTAMP` | `datetime('now', 'localtime')` |
| **Date Extraction** | `YEAR(d)`, `MONTH(d)`, `DAY(d)` | `CAST(strftime('%Y', d) AS INT)` |
| **Date Subtraction** | `DATE_SUB(d, INTERVAL 2 DAY)` | `date(d, '-2 day')` |
| **Day Difference** | `DATEDIFF(end_date, start_date)` | `CAST(JULIANDAY(end_date) - JULIANDAY(start_date) AS INT)` |

---

## 2. Assignment Tasks & SQL Solutions

### Demo: Calculate Customer Churn Age (Days Since Last Visit)
```sql
SELECT 
    customer_id,
    customer_name,
    last_visit_date,
    DATEDIFF(CURRENT_DATE(), last_visit_date) AS days_since_last_visit
FROM customer_visits
ORDER BY days_since_last_visit DESC;
```

### Task 1: Display Current Date and Time as 'CurrentDateTime'
```sql
SELECT NOW() AS CurrentDateTime;
```

### Task 2: Extract Year, Month, and Day Components
```sql
SELECT 
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DAY(order_date) AS order_day
FROM Orders;
```

### Task 3: Order Delivery Estimate with `DATE_SUB()` (2 Days Prior)
```sql
SELECT 
    delivery_id,
    order_id,
    delivery_date,
    DATE_SUB(delivery_date, INTERVAL 2 DAY) AS expected_pickup_date
FROM Deliveries;
```

### Task 4: Subscription Duration Using `DATEDIFF()`
```sql
SELECT 
    user_id,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS total_subscription_days
FROM Subscriptions;
```

### Task 5: Identify Inactive Users (> 30 Days Since Last Login)
```sql
SELECT 
    user_id,
    last_login_date
FROM AppLogins
WHERE DATEDIFF(NOW(), last_login_date) > 30;
```

---

## 3. Execution & Verification Output

```text
--- DEMO: Calculate Customer Churn Age (Days Since Last Visit) ---
(4, 'Ananya Iyer', '2023-08-10', 244)
(2, 'Diya Sharma', '2023-11-20', 142)
(5, 'Kabir Mehta', '2024-02-28', 42)
(1, 'Aarav Patel', '2024-03-15', 26)
(3, 'Rohan Verma', '2024-04-01', 9)

--- TASK 1: Current Date & Time Display with NOW() ---
('2026-11-02 22:46:16',)

--- TASK 2: Extract Year, Month, and Day ---
(101, '2023-01-15', 2023, 1, 15)
(102, '2023-06-21', 2023, 6, 21)
(103, '2023-10-31', 2023, 10, 31)
(104, '2024-02-14', 2024, 2, 14)
(105, '2024-04-05', 2024, 4, 5)

--- TASK 3: Order Delivery Estimate (2 Days Before Delivery) ---
(501, 101, '2024-04-10', '2024-04-08')
(502, 102, '2024-04-12', '2024-04-10')
(503, 103, '2024-04-15', '2024-04-13')
(504, 104, '2024-04-18', '2024-04-16')
(505, 105, '2024-04-20', '2024-04-18')

--- TASK 4: Subscription Duration with DATEDIFF(end_date, start_date) ---
(1001, '2024-01-01', '2024-03-31', 90)
(1002, '2023-05-01', '2024-04-30', 365)
(1003, '2024-03-01', '2024-03-31', 30)
(1004, '2023-01-01', '2023-12-31', 364)
(1005, '2023-10-01', '2024-03-29', 180)

--- TASK 5: Users Inactive > 30 Days ---
(202, '2024-01-15')
(203, '2023-12-05')
(205, '2024-02-10')
(206, '2023-09-20')

Session 15 Verification Successful!
```
