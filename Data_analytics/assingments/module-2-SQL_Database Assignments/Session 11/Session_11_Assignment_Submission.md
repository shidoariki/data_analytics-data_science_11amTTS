# SESSION 11: Subqueries (Scalar, Row, Table)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 11`

---

## 📌 Executive Summary & Key Concepts

A **subquery** (also termed an inner query or nested query) is an SQL query nested inside a larger outer `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. Subqueries enable dynamic computation, comparing individual records against population-level aggregates without hard-coding static threshold constants.

### 1. Classification by Return Structure
* **Scalar Subquery:** Returns exactly **one single value** (one row, one column). Can be used anywhere a literal constant or expression is permitted (e.g. `SELECT`, `WHERE`, `HAVING`).
* **Row Subquery:** Returns a single row of multiple column values, typically evaluated using tuple comparison: `(col1, col2) = (SELECT a, b FROM ...)`.
* **Table Subquery (Derived Table):** Returns multiple rows and columns. Placed in the `FROM` clause and must always be assigned an explicit alias: `FROM (SELECT ...) AS derived_alias`.

### 2. Subquery Placement in the SQL Processing Pipeline
| Location | Architectural Purpose | Example |
| :--- | :--- | :--- |
| **`WHERE` Clause** | Dynamic threshold filtering against calculated aggregates. | `WHERE rating > (SELECT AVG(rating) FROM ...)` |
| **`SELECT` Clause** | Row-level benchmark comparison (correlated or uncorrelated scalar values). | `SELECT name, price, (SELECT AVG(price) ...) AS avg_price FROM ...` |
| **`FROM` Clause** | Multi-stage aggregation; treats the inner query as a temporary in-memory table. | `FROM (SELECT user_id, COUNT(*) AS c FROM ...) AS user_counts` |

---

## 🧪 Demo: Find Employees Earning Above Company Average Salary

### Business Context:
Compensation benchmarking requires identifying staff whose annual compensation exceeds the organization's overall arithmetic mean salary.

### SQL Query:
```sql
SELECT 
    id, 
    name, 
    department, 
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;
```

### Execution Result Grid:
| id | name | department | salary (INR) | Benchmark Differential |
| :---: | :--- | :--- | :---: | :---: |
| **1** | Rajesh Mehta | Executive | 1,25,000.00 | +Rs. 49,000.00 |
| **2** | Sunita Rao | Engineering | 92,000.00 | +Rs. 16,000.00 |
| **3** | Vikram Malhotra | Analytics | 78,000.00 | +Rs. 2,000.00 |

* **Technical Insight:** The inner subquery `(SELECT AVG(salary) FROM employees)` computes the company-wide average ($\text{Rs. } 76,000.00$) in a single execution pass. The outer query dynamically filters candidates against this computed benchmark.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Restaurants with Rating Higher Than Overall Average
* **Task Statement:** Write an SQL query to display the names and ratings of restaurants (from a table named `Restaurants`) where the rating is higher than the average rating of all restaurants in the table.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    name, 
    rating
FROM Restaurants
WHERE rating > (SELECT AVG(rating) FROM Restaurants)
ORDER BY rating DESC;
```

* **Execution Output:**
| name | rating |
| :--- | :---: |
| **Indian Accent** | **4.9** |
| **Toit Brewpub** | **4.8** |
| **Barbeque Nation** | **4.6** |
| **Mocha Cafe** | **4.5** |

* **Query Explanation:**
  The platform average rating across all 8 restaurants is **4.39**. Restaurants with ratings $\le 4.39$ (*Haldirams: 4.1*, *Burger King: 3.9*, *Subway Express: 3.8*, *Pizza Hut: 3.7*) are filtered out by the `WHERE` subquery.

---

### Task 2: Products with Category Average Price (Scalar Subquery in SELECT)
* **Task Statement:** In a Flipkart-style `Products` table (columns: `product_id`, `name`, `price`, `category`), write an SQL query to list each product name along with the average price of its category as an additional column using a scalar subquery in the `SELECT` statement.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    p.name AS product_name,
    p.category,
    p.price,
    ROUND((
        SELECT AVG(p2.price) 
        FROM Products p2 
        WHERE p2.category = p.category
    ), 2) AS category_avg_price
FROM Products p
ORDER BY p.category, p.price DESC;
```

* **Execution Output:**
| product_name | category | price (INR) | category_avg_price (INR) | Pricing Index |
| :--- | :--- | :---: | :---: | :--- |
| **Sony WH-1000XM5** | Audio | 29,990.00 | 13,829.33 | Premium Tier |
| **OnePlus Buds Pro 2** | Audio | 9,999.00 | 13,829.33 | Value Tier |
| **boAt Rockerz 450** | Audio | 1,499.00 | 13,829.33 | Entry Tier |
| **Nike Air Zoom Pegasus** | Footwear | 9,995.00 | 6,247.00 | Premium Tier |
| **Puma Smash v2** | Footwear | 2,499.00 | 6,247.00 | Entry Tier |
| **iPhone 15** | Mobiles | 79,900.00 | 55,632.67 | Flagship Tier |
| **Samsung Galaxy S23** | Mobiles | 74,999.00 | 55,632.67 | Flagship Tier |
| **Redmi 12 5G** | Mobiles | 11,999.00 | 55,632.67 | Budget Tier |

* **Query Explanation:**
  The correlated scalar subquery runs for every row, matching `p2.category = p.category`. This appends the category benchmark directly alongside the individual SKU price, enabling margin and discount optimization analysis.

---

### Task 3: Users Creating More Playlists Than Average (Subquery in FROM & WHERE)
* **Task Statement:** Given a `Playlists` table (`playlist_id`, `user_id`, `playlist_name`) and a `Users` table (`user_id`, `username`), write a SQL query using a subquery in the `FROM` clause to show each username and the number of playlists they have created, displaying only users who have created more playlists than the average number of playlists per user.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    u.username,
    user_counts.playlist_count
FROM Users u
INNER JOIN (
    -- Subquery in FROM: Derived table counting playlists per user
    SELECT user_id, COUNT(playlist_id) AS playlist_count
    FROM Playlists
    GROUP BY user_id
) user_counts ON u.user_id = user_counts.user_id
WHERE user_counts.playlist_count > (
    -- Subquery in WHERE: Computes average playlists per active curator
    SELECT AVG(sub.p_count)
    FROM (
        SELECT COUNT(playlist_id) AS p_count
        FROM Playlists
        GROUP BY user_id
    ) sub
)
ORDER BY user_counts.playlist_count DESC;
```

* **Execution Output:**
| username | playlist_count |
| :--- | :---: |
| **arjun_kapoor** | **4** |
| **sneha_nair** | **3** |

* **Query Explanation:**
  The derived table `user_counts` pre-aggregates total playlists per user (Arjun: 4, Sneha: 3, Zara: 2, Rohan: 1). The average across these curators is $\frac{10}{4} = 2.5$. The outer `WHERE` subquery filters out users with $\le 2.5$ playlists, leaving power curators Arjun and Sneha.

---

### Task 4: Users with Orders Greater Than Average Order Amount
* **Task Statement:** Suppose you have an `Orders` table (`order_id`, `user_id`, `total_amount`) for a food delivery app. Write a query to find all `user_ids` who have placed at least one order with a `total_amount` greater than the average order amount, using a subquery in the `WHERE` clause.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT DISTINCT 
    user_id
FROM Orders
WHERE total_amount > (SELECT AVG(total_amount) FROM Orders)
ORDER BY user_id;
```

* **Execution Output:**
| user_id | Qualifying High-Value Orders |
| :---: | :--- |
| **102** | Order #507 (Rs. 690.00) |
| **103** | Order #503 (Rs. 850.00) |
| **104** | Order #505 (Rs. 1,250.00) |
| **106** | Order #509 (Rs. 1,500.00) |

* **Query Explanation:**
  The mean basket size across all orders is $\text{Rs. } 606.00$. Customers 102, 103, 104, and 106 placed orders exceeding Rs. 606.00. Using `DISTINCT` ensures users who placed multiple high-value orders (e.g. user 102) are not listed redundantly.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_11_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 4 with commentary. |
| `verify_session_11.py` | Python script verifying execution and output tables. |
| `Session_11_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_11_Assignment_Submission.html` | Polished HTML report ready for submission. |
