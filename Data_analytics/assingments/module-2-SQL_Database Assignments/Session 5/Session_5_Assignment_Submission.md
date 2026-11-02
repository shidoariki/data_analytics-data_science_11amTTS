# SESSION 5: DISTINCT, ORDER BY, LIMIT
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 5`

---

## 📌 Executive Summary & Key Concepts

Data sorting, deduplication, and record limiting are essential techniques for deriving ranking metrics, discovering unique attribute spaces, and implementing pagination in data products.

### 1. The `DISTINCT` Keyword
* The `DISTINCT` clause eliminates duplicate rows from the query output:
  ```sql
  SELECT DISTINCT column_name FROM table_name;
  ```
* Evaluated across all selected columns. When applied to multiple columns, uniqueness is enforced on the tuple combination `(col1, col2)`.
* Crucial for categorical discovery (e.g. finding all payment methods, distinct cities, active subscription tiers).

### 2. The `ORDER BY` Clause (Sorting)
* Arranges the result set in ascending (`ASC`, default) or descending (`DESC`) order based on one or more columns:
  ```sql
  SELECT * FROM table_name ORDER BY col1 DESC, col2 ASC;
  ```
* Supports numeric sorting, alphabetical sorting (lexicographical), and chronological date sorting.

### 3. The `LIMIT` Clause (Row Restriction)
* Constrains the maximum number of rows returned by the query engine:
  ```sql
  SELECT * FROM table_name ORDER BY metrics DESC LIMIT N;
  ```
* In analytics and reporting, `ORDER BY ... DESC LIMIT N` is the standard pattern for **Top-N Analysis** (e.g., top 10 bestselling products, top 5 highest-spending customers).

---

## 🧪 Demo: Top 10 Highest Selling Products

### Business Context:
An e-commerce category manager needs an executive dashboard widget displaying the 10 best-selling products across all catalog categories based on unit volume.

### SQL Query:
```sql
SELECT 
    product_id, 
    product_name, 
    category, 
    units_sold, 
    revenue
FROM products_catalog
ORDER BY units_sold DESC
LIMIT 10;
```

### Execution Result Grid:
| product_id | product_name | category | units_sold | revenue (INR) |
| :---: | :--- | :--- | :---: | :---: |
| **2** | boAt Rockerz 450 Bluetooth Headphone | Audio | 32,000 | 48,000,000.00 |
| **3** | OnePlus Nord CE 3 Lite 5G | Electronics | 28,500 | 57,000,000.00 |
| **8** | Mi Smart Band 8 Active | Wearables | 24,100 | 48,200,000.00 |
| **13** | Amazon Fire TV Stick 4K | Electronics | 22,400 | 89,600,000.00 |
| **12** | Noise Pulse 2 Max Smartwatch | Wearables | 21,500 | 32,250,000.00 |
| **4** | Puma Men Stride Running Shoes | Footwear | 19,800 | 39,600,000.00 |
| **14** | Fastrack Limitless FS1 Smartwatch | Wearables | 18,300 | 27,450,000.00 |
| **9** | Prestige Iris 750W Mixer Grinder | Home Appliances | 17,900 | 53,700,000.00 |
| **6** | Samsung Galaxy S23 5G | Electronics | 16,400 | 114,800,000.00 |
| **10** | Levi's Men 511 Slim Jeans | Fashion | 15,300 | 38,250,000.00 |

* **Technical Insight:** Combining `ORDER BY units_sold DESC` with `LIMIT 10` forces the database engine to sort all candidate rows by unit sales and return only the top 10 rows.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Find All Unique Payment Methods in Food Delivery Orders
* **Task Statement:** Write an SQL query using the `DISTINCT` keyword to find all unique payment methods used in the `orders` table of a food delivery app database.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT DISTINCT 
    payment_method
FROM orders;
```

* **Execution Output:**
| payment_method |
| :--- |
| **UPI** |
| **Credit Card** |
| **Cash on Delivery** |
| **Debit Card** |
| **Net Banking** |
| **Digital Wallet** |

* **Query Explanation:**
  Although the `orders` table contains multiple records with repeated values (e.g. 4 UPI transactions, 2 Credit Card transactions), `SELECT DISTINCT payment_method` eliminates duplicates and produces a clean list of the 6 unique payment channels supported on the platform.

---

### Task 2: List Registered User Cities Alphabetically Without Duplicates
* **Task Statement:** Query the `users` table to list all cities where users have registered, but display each city only once and sort the result in alphabetical order (A-Z).
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT DISTINCT 
    city
FROM users
ORDER BY city ASC;
```

* **Execution Output:**
| city |
| :--- |
| **Ahmedabad** |
| **Bengaluru** |
| **Chandigarh** |
| **Chennai** |
| **Delhi** |
| **Hyderabad** |
| **Jaipur** |
| **Kolkata** |
| **Mumbai** |
| **Pune** |
| **Surat** |
| **Varanasi** |

* **Query Explanation:**
  `DISTINCT city` deduplicates recurring cities (e.g., multiple users from Mumbai, Ahmedabad, and Bengaluru), while `ORDER BY city ASC` sorts the remaining 12 unique city names alphabetically from A to Z.

---

### Task 3: Top 5 Most Recent Movie Bookings Ordered by Booking Date Descending
* **Task Statement:** Write an SQL query to select the top 5 most recent movie bookings from the `bookings` table, ordered by `booking_date` in descending order.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    booking_id, 
    user_id, 
    movie_name, 
    theater_name, 
    tickets_count, 
    booking_date
FROM bookings
ORDER BY booking_date DESC
LIMIT 5;
```

* **Execution Output:**
| booking_id | user_id | movie_name | theater_name | tickets_count | booking_date |
| :---: | :---: | :--- | :--- | :---: | :--- |
| **508** | 120 | Bade Miyan Chote Miyan | PVR PALLADIUM | 5 | 2024-04-01 19:30:00 |
| **507** | 103 | Manjummel Boys | INOX Nexus | 2 | 2024-03-31 15:10:00 |
| **506** | 115 | Shaitaan | PVR Acropolis | 3 | 2024-03-30 21:00:00 |
| **505** | 109 | Godzilla x Kong | Miraj Cinemas | 2 | 2024-03-29 16:20:00 |
| **504** | 102 | Fighter | PVR Icon Gold | 2 | 2024-03-28 20:45:00 |

* **Query Explanation:**
  `ORDER BY booking_date DESC` positions the latest datetime values first, while `LIMIT 5` captures the five most recent transactions.

---

### Task 4: Retrieve the 10 Products with Highest Sold Count
* **Task Statement:** From a products table containing Flipkart-style product data (`id`, `name`, `category`, `sold_count`), write an SQL query to retrieve the 10 products with the highest `sold_count`, displaying only product name and `sold_count`, sorted from highest to lowest.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    name, 
    sold_count
FROM products
ORDER BY sold_count DESC
LIMIT 10;
```

* **Execution Output:**
| name | sold_count |
| :--- | :---: |
| **boAt Airdopes 131** | **85,400** |
| **OnePlus Bullets Wireless Z2** | **81,200** |
| **Boult Audio Z40** | **77,800** |
| **realme C53** | **71,200** |
| **Poco M6 Pro 5G** | **68,400** |
| **Samsung Galaxy M14 5G** | **64,500** |
| **SanDisk 128GB Pen Drive** | **62,300** |
| **Mi Power Bank 3i 20000mAh** | **58,700** |
| **Fire-Boltt Ninja Call Pro** | **54,100** |
| **Noise ColorFit Icon Buzz** | **48,900** |

* **Query Explanation:**
  The projection is strictly restricted to `name` and `sold_count` as required by the specification. The `ORDER BY sold_count DESC LIMIT 10` pattern yields the top 10 bestselling items in descending order.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_5_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 4 with commentary. |
| `verify_session_5.py` | Python script verifying execution and output tables. |
| `Session_5_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_5_Assignment_Submission.html` | Polished HTML report ready for submission. |
