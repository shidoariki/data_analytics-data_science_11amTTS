# SESSION 7: GROUP BY & HAVING (Critical Analytics Topic)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 7`

---

## 📌 Executive Summary & Key Concepts

Aggregating metrics across categories and filtering summary outputs represents one of the most critical analytical competencies in SQL.

### 1. The `GROUP BY` Clause
* The `GROUP BY` clause groups rows sharing identical values in specified columns into summary rows:
  ```sql
  SELECT category, COUNT(*), SUM(price)
  FROM products
  GROUP BY category;
  ```
* Every column in the `SELECT` list that is not enclosed within an aggregate function (`SUM`, `AVG`, `COUNT`, `MIN`, `MAX`) **must** be declared in the `GROUP BY` clause.

### 2. The `HAVING` Clause vs. The `WHERE` Clause
A primary architectural distinction in SQL data pipelines is the execution sequence between row-level filtering and group-level filtering:

| Feature | `WHERE` Clause | `HAVING` Clause |
| :--- | :--- | :--- |
| **Execution Timing** | Evaluated **before** rows are grouped (`FROM` $\to$ `WHERE` $\to$ `GROUP BY`) | Evaluated **after** aggregation occurs (`GROUP BY` $\to$ `HAVING`) |
| **Filter Target** | Individual raw rows in the source tables | Aggregated metric values computed by `SUM()`, `AVG()`, `COUNT()`, etc. |
| **Use with Aggregates** | ❌ **Invalid**: Cannot reference aggregate functions (`WHERE SUM(x) > 10` causes syntax error) | ✅ **Valid**: Specifically designed to filter aggregate expressions (`HAVING SUM(x) > 10`) |
| **Performance Impact** | Reduces dataset size early, improving query efficiency | Filters grouped output sets after processing |

---

## 🧪 Demo: Total Revenue per Region (Show Only Regions with Revenue > 1M)

### Business Context:
A retail sales director wants to identify only high-performing regional territories that have generated over 10 Lakh (1 Million) rupees in total sales revenue.

### SQL Query:
```sql
SELECT 
    region,
    SUM(revenue) AS total_revenue
FROM regional_sales
GROUP BY region
HAVING SUM(revenue) > 1000000
ORDER BY total_revenue DESC;
```

### Execution Result Grid:
| region | total_revenue (INR) | Performance Tier |
| :--- | :---: | :--- |
| **South** | **15,50,000.00** | Top Performing Region |
| **West** | **11,70,000.00** | High Revenue Region |
| **North** | **11,00,000.00** | High Revenue Region |

* **Technical Insight:** The East region (Rs. 7,30,000) and Central region (Rs. 2,80,000) were evaluated and automatically excluded from the final output because their aggregated `SUM(revenue)` did not satisfy the `HAVING` condition.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Total Number of Orders Placed by Each User in 'food_orders'
* **Task Statement:** Write an SQL query to display the total number of orders placed by each user in a 'food_orders' table, grouped by `user_id`.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    COUNT(order_id) AS total_orders
FROM food_orders
GROUP BY user_id
ORDER BY total_orders DESC;
```

* **Execution Output:**
| user_id | total_orders | Customer Frequency Segment |
| :---: | :---: | :--- |
| **1** | **4** | High Frequency Diner |
| **2** | **3** | Regular Customer |
| **3** | **2** | Occasional Customer |
| **4** | **1** | New / First-Time User |

* **Query Explanation:**
  `GROUP BY user_id` clusters all food delivery transactions by customer account, and `COUNT(order_id)` determines order frequency per user.

---

### Task 2: Total Amount Spent by Each Payment Method
* **Task Statement:** Using a 'transactions' table with columns (`transaction_id`, `user_id`, `amount`, `payment_method`), write an SQL query to show the total amount spent by each `payment_method`.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    payment_method,
    SUM(amount) AS total_amount_spent
FROM transactions
GROUP BY payment_method
ORDER BY total_amount_spent DESC;
```

* **Execution Output:**
| payment_method | total_amount_spent (INR) | Share of Spending |
| :--- | :---: | :---: |
| **Credit Card** | **27,000.00** | 50.3% |
| **UPI** | **14,700.00** | 27.4% |
| **Debit Card** | **7,500.00** | 14.0% |
| **Net Banking** | **3,200.00** | 6.0% |
| **Cash on Delivery** | **1,300.00** | 2.4% |

* **Query Explanation:**
  The query groups financial transactions by payment gateway / channel and sums transaction amounts, showing that Credit Cards and UPI dominate user payment volume.

---

### Task 3: Genres with Total Box Office Collection Above 10 Crore
* **Task Statement:** Given a 'movies' table with columns (`movie_id`, `genre`, `box_office_collection`), write an SQL query to display each genre and its total `box_office_collection`, but only show genres where the total collection is above 10 crore.
* **Status:** Completed & Executed.
* **Hint Applied:** Use `GROUP BY` and `HAVING` together to filter aggregated results.
* **Note:** 10 Crore = 100,000,000 (100M).
* **SQL Query:**
```sql
SELECT 
    genre,
    SUM(box_office_collection) AS total_box_office_collection
FROM movies
GROUP BY genre
HAVING SUM(box_office_collection) > 100000000
ORDER BY total_box_office_collection DESC;
```

* **Execution Output:**
| genre | total_box_office_collection (INR) | Value in Crores |
| :--- | :---: | :---: |
| **Action** | **3,10,00,00,000.00** | Rs. 310.0 Cr |
| **Comedy-Drama** | **47,00,00,000.00** | Rs. 47.0 Cr |
| **Comedy** | **26,80,00,000.00** | Rs. 26.8 Cr |
| **Biographical** | **13,00,00,000.00** | Rs. 13.0 Cr |

* **Query Explanation:**
  The `Drama` genre generated Rs. 8.45 Crore (`84,500,000`), which is below the 10 Crore threshold. The `HAVING SUM(box_office_collection) > 100000000` clause successfully filtered out Drama, returning only top-grossing movie genres.

---

### Task 4: Users with Combined Playlist Song Duration Over 2 Hours (7200 Seconds)
* **Task Statement:** Suppose you have a 'playlist' table with columns (`playlist_id`, `user_id`, `song_id`, `duration`). Write an SQL query to find users who have created playlists with a combined song duration of more than 2 hours (7200 seconds), showing `user_id` and total duration.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    SUM(duration) AS total_duration_seconds
FROM playlist
GROUP BY user_id
HAVING SUM(duration) > 7200
ORDER BY total_duration_seconds DESC;
```

* **Execution Output:**
| user_id | total_duration_seconds | Equivalent Hours |
| :---: | :---: | :---: |
| **101** | **8,900** | **2.47 Hours** |
| **103** | **7,900** | **2.19 Hours** |

* **Query Explanation:**
  `SUM(duration)` aggregates playback lengths in seconds per listener. `HAVING SUM(duration) > 7200` identifies power listeners whose playlists exceed 120 minutes. Users 102 (5,100s) and 104 (1,900s) were filtered out.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_7_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 4 with commentary. |
| `verify_session_7.py` | Python script verifying execution and output tables. |
| `Session_7_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_7_Assignment_Submission.html` | Polished HTML report ready for submission. |
