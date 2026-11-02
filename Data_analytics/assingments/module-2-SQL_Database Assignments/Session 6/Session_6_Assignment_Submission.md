# SESSION 6: Aggregate Functions
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 6`

---

## 📌 Executive Summary & Key Concepts

Aggregate functions are the core computational engines of SQL in data analytics. Rather than processing rows individually, aggregate functions take multiple values across a column or group and reduce them to a single summary metric.

### 1. The Core Standard Aggregate Functions
| Function | Mathematical Operation | Null Value Handling | Primary Business Use Case |
| :--- | :--- | :--- | :--- |
| **`SUM(column)`** | Accumulates the total arithmetic sum $\sum x_i$ | Automatically ignores `NULL`s | Total revenue, gross merchandise value (GMV), total expenditure |
| **`COUNT(expr)`** | Tallies total occurrences; `COUNT(*)` counts rows, `COUNT(col)` counts non-null values | Counts rows regardless of nulls in `*`, ignores `NULL` in `col` | Total orders, active users, playlist items, inventory units |
| **`AVG(column)`** | Computes the arithmetic mean $\frac{\sum x_i}{n}$ | Ignores `NULL`s from both numerator and denominator | Average order value (AOV), average salary, customer rating |
| **`MIN(column)`** | Identifies the minimum scalar value $\min(X)$ | Ignores `NULL`s | Lowest ticket price, minimum transaction, earliest date |
| **`MAX(column)`** | Identifies the maximum scalar value $\max(X)$ | Ignores `NULL`s | Peak surge multiplier, highest spending order, latest login |

### 2. Numerical Precision with `ROUND()`
* In financial and reporting environments, floating-point averages often return unformatted decimals (e.g. `3632.3333333333335`).
* The `ROUND(numeric_expression, decimals)` function restricts precision to business-acceptable decimal places:
  ```sql
  ROUND(AVG(total_price), 2)  -- Formats to 2 decimal places for currency
  ROUND(AVG(rating), 1)       -- Formats to 1 decimal place for star ratings
  ```

---

## 🧪 Demo: Total Revenue, Average Salary, Highest Order Value

### Demo Queries:
```sql
-- 1. Total Revenue across product sales
SELECT SUM(revenue) AS total_revenue 
FROM demo_sales;

-- 2. Average Salary across company departments
SELECT ROUND(AVG(salary), 2) AS average_salary 
FROM demo_employees;

-- 3. Highest Order Value placed by customers
SELECT MAX(order_value) AS highest_order_value 
FROM demo_orders;
```

### Execution Results:
| Metric | SQL Function Applied | Calculated Output (INR) |
| :--- | :--- | :---: |
| **Total Revenue** | `SUM(revenue)` | **Rs. 2,10,500.00** |
| **Average Salary** | `ROUND(AVG(salary), 2)` | **Rs. 75,400.00** |
| **Highest Order Value** | `MAX(order_value)` | **Rs. 62,000.00** |

---

## 📋 Assignment Tasks & Solutions

### Task 1: Total Amount Spent by Users on Food Orders
* **Task Statement:** Write an SQL query using the `SUM()` function to calculate the total amount spent by users on food orders in a table `food_orders` (columns: `order_id`, `user_id`, `amount`) — imagine it's like Zomato's order history.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    SUM(amount) AS total_food_spending
FROM food_orders;
```

* **Execution Output:**
| total_food_spending (INR) |
| :---: |
| **5,400.00** |

* **Query Explanation:**
  The `SUM(amount)` function traverses the `food_orders` table and aggregates all 10 transaction amounts into a single platform-wide total gross spending of Rs. 5,400.00.

---

### Task 2: Count Songs Added to a User's Spotify Playlist
* **Task Statement:** Using the `COUNT()` function, find out how many songs a user has added to their playlist in a table `spotify_playlists` (columns: `playlist_id`, `user_id`, `song_id`).
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    COUNT(song_id) AS total_songs
FROM spotify_playlists
WHERE user_id = 101
GROUP BY user_id;
```

* **Execution Output:**
| user_id | total_songs |
| :---: | :---: |
| **101** | **7** |

* **Query Explanation:**
  The query filters for `user_id = 101` and evaluates `COUNT(song_id)`, determining that user 101 has curated exactly 7 tracks in their playlist.

---

### Task 3: Average Rating Given to a Movie Rounded to 1 Decimal Place
* **Task Statement:** Write an SQL query to get the average rating given to a movie in a table `bookmyshow_reviews` (columns: `review_id`, `movie_id`, `rating`), and round the result to 1 decimal place using the `ROUND()` function.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    movie_id,
    ROUND(AVG(rating), 1) AS average_rating
FROM bookmyshow_reviews
WHERE movie_id = 201
GROUP BY movie_id;
```

* **Execution Output:**
| movie_id | average_rating |
| :---: | :---: |
| **201** | **4.4** |

* **Query Explanation:**
  Movie `201` received 7 user reviews (`4.5, 4.8, 4.2, 4.6, 3.9, 4.7, 4.4`). The raw average evaluates to $31.1 / 7 = 4.4428...$. Wrapping `AVG(rating)` within `ROUND(..., 1)` cleanly trims the output to the standard presentation format of `4.4` stars.

---

### Task 4: Minimum and Maximum Transaction Values for a User (Paytm)
* **Task Statement:** Find the minimum and maximum transaction values for a user from a table `paytm_transactions` (columns: `txn_id`, `user_id`, `amount`) — show both the smallest and largest transaction amounts.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    MIN(amount) AS smallest_amount,
    MAX(amount) AS largest_amount
FROM paytm_transactions
WHERE user_id = 101
GROUP BY user_id;
```

* **Execution Output:**
| user_id | smallest_amount (INR) | largest_amount (INR) |
| :---: | :---: | :---: |
| **101** | **20.00** | **12,000.00** |

* **Query Explanation:**
  User 101 executed multiple micro-transactions (e.g. Rs. 20 for tea, Rs. 45 for snacks) and large transfers (Rs. 12,000 for house rent). `MIN(amount)` and `MAX(amount)` instantly reveal the consumer's lower and upper boundary transaction values.

---

### Task 5: Customer Order Aggregations on Myntra Orders
* **Task Statement:** Given a table `myntra_orders` (columns: `order_id`, `user_id`, `total_price`), write an SQL query to display the total number of orders, the average order value (rounded to 2 decimals), and the highest order value for each `user_id`. (Constraint: Use GROUP BY to get results per user).
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(total_price), 2) AS average_order_value,
    MAX(total_price) AS highest_order_value
FROM myntra_orders
GROUP BY user_id
ORDER BY user_id ASC;
```

* **Execution Output:**
| user_id | total_orders | average_order_value (INR) | highest_order_value (INR) |
| :---: | :---: | :---: | :---: |
| **101** | 3 | 1,799.00 | 2,999.00 |
| **102** | 2 | 5,350.00 | 6,200.00 |
| **103** | 1 | 1,299.00 | 1,299.00 |
| **104** | 3 | 3,632.33 | 5,499.00 |
| **105** | 1 | 799.00 | 799.00 |

* **Query Explanation:**
  The `GROUP BY user_id` partitions the order history table by individual shopper. For each partition, `COUNT(order_id)` computes order frequency, `ROUND(AVG(total_price), 2)` establishes the customer's average basket size (AOV), and `MAX(total_price)` pinpoints their single largest ticket purchase.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_6_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 5 with commentary. |
| `verify_session_6.py` | Python script verifying execution and output tables. |
| `Session_6_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_6_Assignment_Submission.html` | Polished HTML report ready for submission. |
