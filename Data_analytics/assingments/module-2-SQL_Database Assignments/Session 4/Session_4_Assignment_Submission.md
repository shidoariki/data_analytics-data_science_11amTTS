# SESSION 4: Wildcards & Pattern Matching (LIKE, BETWEEN, IN)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 4`

---

## 📌 Executive Summary & Key Concepts

Pattern matching and range filtering are foundational to exploratory data analysis (EDA) and business intelligence querying. Real-world datasets rarely match exact strings or isolated numbers; analysts must query fuzzy text, bounding intervals, and discrete category subsets.

### 1. The `LIKE` Operator & Wildcards
The `LIKE` operator performs pattern matching against string expressions using special wildcard characters:
* **`%` (Percent Wildcard):** Matches zero, one, or multiple characters.
  * `'M%'`: Strings beginning with 'M' (e.g., *Manish*, *Meera*, *Mumbai*).
  * `'%Cafe'`: Strings ending with 'Cafe' (e.g., *Mocha Cafe*, *Hard Rock Cafe*).
  * `'%ar%'`: Strings containing the substring 'ar' anywhere (e.g., *Arijit Singh*, *Qaran*).
* **`_` (Underscore Wildcard):** Matches exactly one single character.
  * `'C_t'`: Matches *Cat*, *Cot*, *Cut*.

### 2. The `BETWEEN` Operator (Inclusive Range Evaluation)
The `BETWEEN` operator filters data within a specified continuous range:
$$\text{expression} \ge \text{lower\_bound} \quad \text{AND} \quad \text{expression} \le \text{upper\_bound}$$
* Both endpoints are **inclusive**.
* Works across numeric types (`price BETWEEN 500 AND 1500`), dates (`order_date BETWEEN '2024-01-01' AND '2024-03-31'`), and lexicographical strings.

### 3. The `IN` Operator (Set Membership)
The `IN` operator checks whether an attribute value matches any value within a comma-separated list of literals or subquery results:
$$\text{column} \in \{v_1, v_2, \dots, v_n\}$$
* Functionally equivalent to chained `OR` clauses (`city = 'Ahmedabad' OR city = 'Surat' OR city = 'Vadodara'`), but significantly more concise, readable, and index-optimized.

---

## 🧪 Demo: Find All Customers Whose Names Start With 'M'

### Business Context:
A marketing team launching an alphabet-targeted promo campaign needs to identify all registered customer accounts whose legal or display name starts with the capital letter 'M'.

### SQL Query:
```sql
SELECT 
    customer_id, 
    customer_name, 
    email, 
    city
FROM customers
WHERE customer_name LIKE 'M%';
```

### Execution Result Grid:
| customer_id | customer_name | email | city |
| :---: | :--- | :--- | :--- |
| **1** | Manish Sharma | manish.s@example.com | Mumbai |
| **2** | Meera Iyer | meera.i@example.com | Bengaluru |
| **4** | Mohit Patel | mohit.p@example.com | Ahmedabad |
| **6** | Madhav Joshi | madhav.j@example.com | Pune |
| **8** | Mukesh Ambani | mukesh.a@example.com | Mumbai |

* **Technical Insight:** The wildcard `'M%'` filters out names like *Rohan Verma* or *Ananya Roy*, ensuring only records with an initial 'M' are returned regardless of total string length.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Find All Restaurants Whose Names End with 'Cafe'
* **Task Statement:** Write an SQL query to find all restaurants in a table called `Restaurants` whose names end with 'Cafe' using the `LIKE` operator.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    restaurant_id, 
    name, 
    cuisine, 
    city, 
    rating
FROM Restaurants
WHERE name LIKE '%Cafe';
```

* **Execution Output:**
| restaurant_id | name | cuisine | city | rating |
| :---: | :--- | :--- | :--- | :---: |
| **1** | Mocha Cafe | Continental & Coffee | Ahmedabad | 4.5 |
| **2** | Hard Rock Cafe | American & Bar | Mumbai | 4.6 |
| **4** | The Chocolate Room Cafe | Desserts & Beverages | Surat | 4.2 |
| **6** | Zen Garden Cafe | Asian & Cafe | Pune | 4.7 |

* **Query Explanation:** 
  The `%` placed before `Cafe` matches any sequence of preceding characters, ensuring only venues that terminate specifically with the word `Cafe` are selected. Restaurants like *Cafe Coffee Day* are properly excluded because `Cafe` is at the beginning rather than the end.

---

### Task 2: Filter Products Priced Between 500 and 1500 Rupees
* **Task Statement:** In a Flipkart-style `Products` table, use the `BETWEEN` operator to select all products with a price between 500 and 1500 rupees.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    product_id, 
    product_name, 
    category, 
    price, 
    stock
FROM Products
WHERE price BETWEEN 500 AND 1500;
```

* **Execution Output:**
| product_id | product_name | category | price (INR) | stock |
| :---: | :--- | :--- | :---: | :---: |
| **102** | Puma Men Running T-Shirt | Fashion | 699.00 | 80 |
| **103** | SanDisk 64GB Ultra microSD Card | Storage | 549.00 | 200 |
| **104** | Portronics Toad Wireless Mouse | Accessories | 899.00 | 95 |
| **105** | Wildcraft Casual 30L Backpack | Bags | 1299.00 | 60 |
| **106** | Fastrack Casual Analog Watch | Fashion | 1450.00 | 45 |
| **108** | Noise ColorFit Pulse Smartwatch | Wearables | 1499.00 | 110 |
| **110** | Mi 10000mAh Power Bank 3i | Accessories | 1199.00 | 120 |

* **Query Explanation:**
  The `BETWEEN 500 AND 1500` clause evaluates inclusively. Low-cost items like *boAt Bassheads (399.00)* and premium hardware like *JBL Flip 6 (8999.00)* are excluded, leaving the mid-range promotional price tier.

---

### Task 3: Display Users from Ahmedabad, Surat, or Vadodara
* **Task Statement:** Write an SQL query to display all users from a `Users` table whose city is either 'Ahmedabad', 'Surat', or 'Vadodara' using the `IN` operator.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id, 
    username, 
    email, 
    city, 
    signup_date
FROM Users
WHERE city IN ('Ahmedabad', 'Surat', 'Vadodara');
```

* **Execution Output:**
| user_id | username | email | city | signup_date |
| :---: | :--- | :--- | :--- | :---: |
| **1** | aarav_shah | aarav.shah@gmail.com | Ahmedabad | 2024-01-15 |
| **2** | priya_mehta | priya.m@yahoo.com | Surat | 2024-02-10 |
| **3** | karan_patel | karan.p@outlook.com | Vadodara | 2024-02-28 |
| **5** | dev_pandya | dev.p@rediffmail.com | Ahmedabad | 2024-03-18 |
| **6** | anjali_desai | anjali.d@gmail.com | Surat | 2024-04-02 |
| **8** | bhavin_gandhi | bhavin.g@gmail.com | Vadodara | 2024-05-01 |

* **Query Explanation:**
  Instead of verbose multiple boolean clauses (`city = 'Ahmedabad' OR city = 'Surat' OR city = 'Vadodara'`), `IN ('Ahmedabad', 'Surat', 'Vadodara')` performs set containment evaluation cleanly and allows the database query planner to leverage index seeks. Users from *Mumbai*, *Jaipur*, and *Bengaluru* are filtered out.

---

### Task 4: Find Songs Where Artist Name Contains 'ar' Anywhere
* **Task Statement:** Given a table called `Songs` with columns `song_name` and `artist_name`, find all songs where the `artist_name` contains the letter sequence 'ar' anywhere in the name using the `LIKE` operator.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    song_id, 
    song_name, 
    artist_name, 
    album, 
    duration_sec
FROM Songs
WHERE artist_name LIKE '%ar%';
```

* **Execution Output:**
| song_id | song_name | artist_name | album | duration_sec |
| :---: | :--- | :--- | :--- | :---: |
| **201** | Kesariya | Arijit Singh | Brahmastra | 268 |
| **202** | Tum Hi Ho | Arijit Singh | Aashiqui 2 | 262 |
| **208** | Channa Mereya | Arijit Singh | Ae Dil Hai Mushkil | 289 |
| **210** | Tareefan | Qaran ft. Badshah | Veere Di Wedding | 185 |

* **Query Explanation:**
  Surrounding the pattern with `%` on both sides (`'%ar%'`) matches any string containing the contiguous letters 'ar' regardless of whether they appear at the start, middle, or end of the artist name (e.g. *Arijit Singh* has 'ari', *Qaran* has 'ar').

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_4_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 4 with commentary. |
| `verify_session_4.py` | Python script verifying execution and output tables. |
| `Session_4_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_4_Assignment_Submission.html` | Polished HTML report ready for submission. |
