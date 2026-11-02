# SESSION 8: JOINS: INNER, LEFT, RIGHT (Foundation Session)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 8`

---

## 📌 Executive Summary & Key Concepts

Relational database systems achieve normalization by decomposing data across specialized entity tables (e.g. `Users`, `Orders`, `CustomerSegments`). **SQL JOINS** are the fundamental mechanism for reconstructing dimensional models and combining records across tables using relational keys.

### 1. Primary Keys vs. Foreign Keys
* **Primary Key (PK):** A column or set of columns uniquely identifying every row in a table (e.g. `user_id` in `Users`). Must be unique and non-null.
* **Foreign Key (FK):** A column in a child table that references the primary key of a parent table (e.g. `user_id` in `Orders`, `segment_id` in `Users`), enforcing referential integrity.

### 2. Core SQL Join Types
| Join Type | Mathematical Set Concept | Unmatched Left Table Rows | Unmatched Right Table Rows |
| :--- | :--- | :--- | :--- |
| **`INNER JOIN`** | Intersection ($A \cap B$) | **Excluded** | **Excluded** |
| **`LEFT JOIN`** | Left Set ($A$) | **Preserved** (Right cols = `NULL`) | **Excluded** |
| **`RIGHT JOIN`** | Right Set ($B$) | **Excluded** | **Preserved** (Left cols = `NULL`) |
| **`FULL OUTER JOIN`** | Union ($A \cup B$) | **Preserved** | **Preserved** |

---

## 🧪 Demo: Join Orders + Customers $\to$ Customer Segment $\to$ Revenue

### Business Context:
A food delivery enterprise needs to evaluate revenue generation across marketing customer tiers (`Premium Gold`, `Regular Diner`, `Occasional Saver`, `New Customer`).

### SQL Query:
```sql
SELECT 
    cs.segment_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0.00) AS total_revenue
FROM CustomerSegments cs
LEFT JOIN Users u ON cs.segment_id = u.segment_id
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY cs.segment_id, cs.segment_name
ORDER BY total_revenue DESC;
```

### Execution Result Grid:
| segment_name | total_orders | total_revenue (INR) |
| :--- | :---: | :---: |
| **Premium Gold** | 3 | **610.00** |
| **Regular Diner** | 2 | **540.00** |
| **Occasional Saver** | 0 | **0.00** |
| **New Customer** | 0 | **0.00** |

* **Technical Insight:** Multi-table `LEFT JOIN` guarantees that inactive customer tiers (`Occasional Saver`, `New Customer`) are preserved in executive reporting with 0 revenue rather than disappearing from the scorecard.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Create Tables (`Users` & `Orders`) with Sample Data
* **Task Statement:** Create two tables in your SQL database: `Users` (`user_id`, `username`, `city`) and `Orders` (`order_id`, `user_id`, `product`, `amount`). Insert at least 3 users and 5 orders, making sure some users have no orders.
* **Status:** Completed & Executed.
* **DDL & DML SQL:**
```sql
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    segment_id INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Users (user_id, username, city, segment_id) VALUES
(1, 'rohan_sharma', 'Mumbai', 1),
(2, 'priya_mehta', 'Bengaluru', 2),
(3, 'karan_patel', 'Ahmedabad', 3),
(4, 'sneha_rao', 'Pune', 4);

INSERT INTO Orders (order_id, user_id, product, amount) VALUES
(101, 1, 'Margherita Pizza', 350.00),
(102, 1, 'Garlic Breadsticks', 150.00),
(103, 2, 'Paneer Butter Masala', 420.00),
(104, 2, 'Butter Naan (Pack of 3)', 120.00),
(105, 1, 'Choco Lava Cake', 110.00),
(106, 99, 'Chicken Biryani', 380.00);
```

---

### Task 2: INNER JOIN (List Only Users with Orders)
* **Task Statement:** Write an SQL query using `INNER JOIN` to list all usernames and their ordered products, showing only users who have placed at least one order.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    u.username,
    o.product,
    o.amount
FROM Users u
INNER JOIN Orders o ON u.user_id = o.user_id;
```

* **Execution Output:**
| username | product | amount (INR) |
| :--- | :--- | :---: |
| **rohan_sharma** | Margherita Pizza | 350.00 |
| **rohan_sharma** | Garlic Breadsticks | 150.00 |
| **priya_mehta** | Paneer Butter Masala | 420.00 |
| **priya_mehta** | Butter Naan (Pack of 3) | 120.00 |
| **rohan_sharma** | Choco Lava Cake | 110.00 |

* **Query Explanation:**
  Only rows with matching `user_id` values in both tables are returned. Users *karan_patel* and *sneha_rao* (no orders placed) as well as Order 106 (user 99, unmatched) are excluded.

---

### Task 3: LEFT JOIN (Display All Users, NULL if No Orders)
* **Task Statement:** Write an SQL query using `LEFT JOIN` to display all usernames along with their ordered products. For users who haven't placed any orders, show `NULL` for the product.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    u.username,
    u.city,
    o.product,
    o.amount
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.user_id;
```

* **Execution Output:**
| username | city | product | amount (INR) |
| :--- | :--- | :--- | :---: |
| **rohan_sharma** | Mumbai | Choco Lava Cake | 110.00 |
| **rohan_sharma** | Mumbai | Garlic Breadsticks | 150.00 |
| **rohan_sharma** | Mumbai | Margherita Pizza | 350.00 |
| **priya_mehta** | Bengaluru | Butter Naan (Pack of 3) | 120.00 |
| **priya_mehta** | Bengaluru | Paneer Butter Masala | 420.00 |
| **karan_patel** | Ahmedabad | *NULL* | *NULL* |
| **sneha_rao** | Pune | *NULL* | *NULL* |

* **Query Explanation:**
  The `LEFT JOIN` keeps all 4 users in the output. Because *karan_patel* and *sneha_rao* have no matching records in `Orders`, their `product` and `amount` columns evaluate cleanly to `NULL`.

---

### Task 4: RIGHT JOIN (Display All Orders, NULL for Unmatched Users)
* **Task Statement:** Write an SQL query using `RIGHT JOIN` to show all orders and the corresponding username for each order. If an order has a `user_id` that doesn't exist in the `Users` table, display `NULL` for the username.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    o.order_id,
    o.product,
    o.amount,
    u.username
FROM Users u
RIGHT JOIN Orders o ON u.user_id = o.user_id;
```

* **Execution Output:**
| order_id | product | amount (INR) | username |
| :---: | :--- | :---: | :--- |
| **101** | Margherita Pizza | 350.00 | rohan_sharma |
| **102** | Garlic Breadsticks | 150.00 | rohan_sharma |
| **105** | Choco Lava Cake | 110.00 | rohan_sharma |
| **103** | Paneer Butter Masala | 420.00 | priya_mehta |
| **104** | Butter Naan (Pack of 3) | 120.00 | priya_mehta |
| **106** | Chicken Biryani | 380.00 | *NULL* |

* **Query Explanation:**
  All records from the right table (`Orders`) are preserved. Order 106 was placed with `user_id = 99` (simulating a deleted user or guest checkout), so its `username` attribute evaluates to `NULL`.

---

### Task 5: Zomato Customer Segmentation Query
* **Task Statement:** Suppose you want to analyze food delivery data like Zomato. Create a `CustomerSegments` table (`segment_id`, `segment_name`), and link it to `Users` with a foreign key. Write an SQL query to show each username, their segment name, and total order amount (use JOINs as needed).
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    u.username,
    cs.segment_name,
    COALESCE(SUM(o.amount), 0.00) AS total_order_amount
FROM Users u
LEFT JOIN CustomerSegments cs ON u.segment_id = cs.segment_id
LEFT JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username, cs.segment_name
ORDER BY total_order_amount DESC;
```

* **Execution Output:**
| username | segment_name | total_order_amount (INR) |
| :--- | :--- | :---: |
| **rohan_sharma** | Premium Gold | **610.00** |
| **priya_mehta** | Regular Diner | **540.00** |
| **karan_patel** | Occasional Saver | **0.00** |
| **sneha_rao** | New Customer | **0.00** |

* **Query Explanation:**
  The query joins `Users` with `CustomerSegments` to resolve membership tier, and left-joins `Orders` to aggregate historical order expenditure per customer. `COALESCE(SUM(o.amount), 0.00)` replaces `NULL` sums with `0.00` for users without orders.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_8_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 5 with commentary. |
| `verify_session_8.py` | Python script verifying execution and output tables. |
| `Session_8_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_8_Assignment_Submission.html` | Polished HTML report ready for submission. |
