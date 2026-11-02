# SESSION 10: UNION & UNION ALL
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 10`

---

## 📌 Executive Summary & Key Concepts

Set operators in SQL allow data practitioners to combine the results of two or more independent `SELECT` queries into a single unified result set vertically (row-stacking), unlike `JOIN` operations which combine datasets horizontally (column-stitching).

### 1. The Core Prerequisites for Set Operations
For any `UNION` or `UNION ALL` query to execute successfully, the queries must satisfy three strict rules:
1. Each `SELECT` statement must have the **exact same number of columns**.
2. The columns in each query must have **compatible data types** in the corresponding positions.
3. The column names of the final result set are determined by the **first `SELECT` query**.

### 2. `UNION` vs. `UNION ALL`: The Architectural Comparison
| Feature | `UNION` | `UNION ALL` |
| :--- | :--- | :--- |
| **Duplicate Elimination** | ✅ **Removes duplicates** (performs implicit `DISTINCT`) | ❌ **Preserves duplicates** (keeps all rows) |
| **Query Engine Overhead** | High — requires sorting / hashing data in temporary memory to identify duplicates | Minimal — directly streams row buffers without sorting or deduplication |
| **Execution Performance** | Slower, especially on large datasets ($> 100\text{K}$ rows) | Significantly faster and more resource-efficient |
| **Typical Use Case** | Building consolidated unique customer lists, distinct geography registries | Consolidating omnichannel transactions, audit log concatenation, ETL ingestion pipelines |

---

## 🧪 Demo: Combine Online + Offline Sales Tables

### Business Context:
A retail analytics manager needs a consolidated ledger of all sales transactions originating from both digital e-commerce storefronts and physical brick-and-mortar outlets.

### SQL Query:
```sql
SELECT 
    sale_id, 
    customer_name, 
    amount, 
    sale_date, 
    'Online Store' AS channel
FROM online_sales

UNION ALL

SELECT 
    sale_id, 
    customer_name, 
    amount, 
    sale_date, 
    'Retail Outlet' AS channel
FROM offline_sales
ORDER BY sale_date;
```

### Execution Result Grid:
| sale_id | customer_name | amount (INR) | sale_date | channel |
| :---: | :--- | :---: | :--- | :--- |
| **1** | Rohan Sharma | 1,450.00 | 2024-02-10 | Online Store |
| **101** | Vikram Malhotra | 1,850.00 | 2024-02-11 | Retail Outlet |
| **2** | Priya Patel | 2,800.00 | 2024-02-12 | Online Store |
| **102** | Priya Patel | 1,200.00 | 2024-02-14 | Retail Outlet |
| **3** | Amit Verma | 390.00 | 2024-02-15 | Online Store |
| **103** | Ananya Sen | 640.00 | 2024-02-16 | Retail Outlet |
| **4** | Neha Gupta | 5,200.00 | 2024-02-18 | Online Store |
| **104** | Siddharth Joshi | 3,100.00 | 2024-02-19 | Retail Outlet |

* **Technical Insight:** Using `'Online Store' AS channel` and `'Retail Outlet' AS channel` adds metadata to differentiate transaction origin while unifying disparate source tables into one clean report.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Table Creation (`AppOrders` & `InStoreOrders`)
* **Task Statement:** Create two tables: `AppOrders` (for orders placed via a food delivery app like Zomato) and `InStoreOrders` (for direct restaurant orders), each with columns: `order_id`, `customer_name`, `amount`, and `order_date`. Insert at least 3 sample records into each table.
* **Status:** Completed & Executed.
* **DDL & DML SQL:**
```sql
CREATE TABLE AppOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

CREATE TABLE InStoreOrders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO AppOrders VALUES
(1, 'Rohan Sharma', 450.00, '2024-03-01'),
(2, 'Priya Mehta', 620.00, '2024-03-02'),
(3, 'Aarav Patel', 310.00, '2024-03-03'),
(4, 'Sneha Rao', 540.00, '2024-03-04');

INSERT INTO InStoreOrders VALUES
(101, 'Karan Joshi', 780.00, '2024-03-01'),
(102, 'Rohan Sharma', 950.00, '2024-03-02'),
(103, 'Neha Verma', 410.00, '2024-03-03'),
(104, 'Priya Mehta', 530.00, '2024-03-05');
```

---

### Task 2: Combine Unique Customer Names Using UNION
* **Task Statement:** Write an SQL query using `UNION` to combine all unique customer names from both `AppOrders` and `InStoreOrders` tables into a single list.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT customer_name FROM AppOrders
UNION
SELECT customer_name FROM InStoreOrders
ORDER BY customer_name;
```

* **Execution Output:**
| customer_name |
| :--- |
| **Aarav Patel** |
| **Karan Joshi** |
| **Neha Verma** |
| **Priya Mehta** |
| **Rohan Sharma** |
| **Sneha Rao** |

* **Query Explanation:**
  Although *Rohan Sharma* and *Priya Mehta* made purchases through both channels (App and In-Store), the `UNION` operation eliminated the duplicate records, returning the 6 unique patrons.

---

### Task 3: Display Every Order Using UNION ALL
* **Task Statement:** Write an SQL query using `UNION ALL` to display every order (including duplicates if any) from both `AppOrders` and `InStoreOrders`, showing `order_id`, `customer_name`, `amount`, and `order_date`.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    order_id, 
    customer_name, 
    amount, 
    order_date,
    'App Order' AS order_type
FROM AppOrders

UNION ALL

SELECT 
    order_id, 
    customer_name, 
    amount, 
    order_date,
    'In-Store Dine-in' AS order_type
FROM InStoreOrders
ORDER BY order_date;
```

* **Execution Output:**
| order_id | customer_name | amount (INR) | order_date | order_type |
| :---: | :--- | :---: | :--- | :--- |
| **1** | Rohan Sharma | 450.00 | 2024-03-01 | App Order |
| **101** | Karan Joshi | 780.00 | 2024-03-01 | In-Store Dine-in |
| **2** | Priya Mehta | 620.00 | 2024-03-02 | App Order |
| **102** | Rohan Sharma | 950.00 | 2024-03-02 | In-Store Dine-in |
| **3** | Aarav Patel | 310.00 | 2024-03-03 | App Order |
| **103** | Neha Verma | 410.00 | 2024-03-03 | In-Store Dine-in |
| **4** | Sneha Rao | 540.00 | 2024-03-04 | App Order |
| **104** | Priya Mehta | 530.00 | 2024-03-05 | In-Store Dine-in |

* **Query Explanation:**
  `UNION ALL` preserves every single commercial transaction, yielding the full 8 records necessary for financial reconciliation and accurate revenue computation.

---

### Task 4: Empirical Demonstration of UNION vs. UNION ALL
* **Task Statement:** Demonstrate the difference between `UNION` and `UNION ALL` by adding a duplicate `customer_name` in both tables, then running both queries and noting the difference in the result count.
* **Status:** Completed & Executed.

#### Comparative Query Run:
```sql
-- Query A: UNION
SELECT customer_name FROM AppOrders
UNION
SELECT customer_name FROM InStoreOrders;

-- Query B: UNION ALL
SELECT customer_name FROM AppOrders
UNION ALL
SELECT customer_name FROM InStoreOrders;
```

#### Comparison Results:
| Operator | Total Rows Returned | Duplicate Handling | Performance Behavior |
| :--- | :---: | :--- | :--- |
| **`UNION`** | **6 Rows** | De-duplicates *Rohan Sharma* and *Priya Mehta* | Performs sort/hash deduplication pass |
| **`UNION ALL`** | **8 Rows** | Retains all 4 app names + all 4 store names | Zero sorting; direct stream union |

* **Key Takeaway for Analytics Engineers:**
  > *Always default to `UNION ALL` unless deduplication is explicitly required by the business logic. `UNION ALL` avoids expensive sorting operations and memory pressure on big data platforms.*

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_10_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 4 with commentary. |
| `verify_session_10.py` | Python script verifying execution and output tables. |
| `Session_10_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_10_Assignment_Submission.html` | Polished HTML report ready for submission. |
