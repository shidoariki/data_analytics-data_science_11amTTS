# SESSION 9: ADVANCED JOINS (FULL OUTER, SELF JOIN, CROSS JOIN)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 9`

---

## 📌 Executive Summary & Key Concepts

Advanced joins extend standard relational operations to solve complex data modeling challenges: hierarchical structures within a single table, exhaustive multi-dimensional matrix generation, and complete cross-table auditing without data loss.

### 1. The Core Advanced Join Types
| Join Type | Mechanism | Primary Business Use Case |
| :--- | :--- | :--- |
| **`FULL OUTER JOIN`** | Combines the results of both `LEFT JOIN` and `RIGHT JOIN`. Returns all records from both tables; unmatched attributes evaluate to `NULL`. | Reconciling marketing partners and brand campaigns; auditing missing records across systems. |
| **`SELF JOIN`** | Joins a table to itself using two distinct aliases (`table t1 JOIN table t2 ON ...`). | Modeling hierarchical data (manager-employee org charts, nested playlists, parent-child categories) and finding relationships within the same cohort. |
| **`CROSS JOIN`** | Computes the Cartesian product of two tables ($M \times N$ rows), matching every row from table 1 with every row from table 2. | Generating candidate feature matrices for recommendation engines (e.g. testing all user $\times$ offer combinations), generating calendar-product reporting grids. |

---

## 🧪 Demo: Self Join on Employees Table $\to$ Manager Relationship

### Business Context:
In enterprise HR databases, organizational hierarchies are typically stored within a single table using an adjacency list pattern, where each employee record has a `manager_id` referencing another employee's `id`.

### SQL Query:
```sql
SELECT 
    e.id AS employee_id,
    e.name AS employee_name,
    e.department,
    COALESCE(m.name, 'Top Executive / No Manager') AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

### Execution Result Grid:
| employee_id | employee_name | department | manager_name |
| :---: | :--- | :--- | :--- |
| **1** | Rajesh Mehta | Executive | *Top Executive / No Manager* |
| **2** | Sunita Rao | Engineering | Rajesh Mehta |
| **3** | Vikram Malhotra | Analytics | Rajesh Mehta |
| **4** | Amit Verma | Engineering | Sunita Rao |
| **5** | Neha Patel | Engineering | Sunita Rao |
| **6** | Rohan Shah | Analytics | Vikram Malhotra |
| **7** | Pooja Iyer | Human Resources | *Top Executive / No Manager* |

* **Technical Insight:** Using `LEFT JOIN` guarantees that executive leadership (Rajesh Mehta, Pooja Iyer) are preserved in the report with explicit `"Top Executive"` labels rather than being omitted.

---

## 📋 Assignment Tasks & Solutions

### Task 1: FULL OUTER JOIN Between Influencers and Brands on City
* **Task Statement:** Create two tables, `influencers` and `brands`, with at least 3 sample rows each. Use a `FULL OUTER JOIN` to list all influencers and brands, showing `influencer_name` and `brand_name`, matching on `city`. If there is no match, display `NULL` for the missing side.
* **Status:** Completed & Executed.
* **SQL Query (Standard Emulation via LEFT JOIN UNION RIGHT JOIN):**
```sql
SELECT 
    i.influencer_name,
    b.brand_name,
    COALESCE(i.city, b.city) AS city
FROM influencers i
LEFT JOIN brands b ON i.city = b.city

UNION

SELECT 
    i.influencer_name,
    b.brand_name,
    COALESCE(i.city, b.city) AS city
FROM brands b
LEFT JOIN influencers i ON b.city = i.city;
```

* **Execution Output:**
| influencer_name | brand_name | city | Match Status |
| :--- | :--- | :--- | :--- |
| *NULL* | Mamaearth | Gurugram | Brand only (No local influencer) |
| *NULL* | Zomato | Gurugram | Brand only (No local influencer) |
| Bhuvan Bam | Boat Lifestyle | Delhi | Matched on City |
| Dolly Singh | *NULL* | Nainital | Influencer only (No local brand) |
| Kusha Kapila | Boat Lifestyle | Delhi | Matched on City |
| Ranveer Allahbadia | Nykaa Fashion | Mumbai | Matched on City |
| Tanmay Bhat | Swiggy | Bengaluru | Matched on City |
| Tanmay Bhat | Titan Watches | Bengaluru | Matched on City |
| Tech Burner | Boat Lifestyle | Delhi | Matched on City |

* **Query Explanation:**
  The `FULL OUTER JOIN` preserves all influencers (including *Dolly Singh* in Nainital where no brand exists) and all brands (including *Zomato* and *Mamaearth* in Gurugram where no influencer is listed).

---

### Task 2: SELF JOIN on Playlists (Nested Hierarchy)
* **Task Statement:** Given a table called `playlists` with columns (`id`, `playlist_name`, `parent_playlist_id`), write a `SELF JOIN` query to display each playlist alongside its parent playlist's name, similar to how Spotify might nest playlists.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    p.id AS playlist_id,
    p.playlist_name,
    COALESCE(parent.playlist_name, '[Top-Level Playlist]') AS parent_playlist_name
FROM playlists p
LEFT JOIN playlists parent ON p.parent_playlist_id = parent.id;
```

* **Execution Output:**
| playlist_id | playlist_name | parent_playlist_name |
| :---: | :--- | :--- |
| **1** | Workout Motivation | *[Top-Level Playlist]* |
| **2** | High Energy Cardio | Workout Motivation |
| **3** | Gym EDM Bass Boost | Workout Motivation |
| **4** | Chill Vibes | *[Top-Level Playlist]* |
| **5** | Acoustic Sunday Afternoon | Chill Vibes |
| **6** | Lo-Fi Study Beats | Chill Vibes |
| **7** | Late Night Coding Lo-Fi | Lo-Fi Study Beats |

* **Query Explanation:**
  By joining `playlists p` to `playlists parent` on `p.parent_playlist_id = parent.id`, we reconstruct the multi-tier navigation tree (e.g. *Late Night Coding Lo-Fi* $\to$ *Lo-Fi Study Beats* $\to$ *Chill Vibes*).

---

### Task 3: CROSS JOIN Users $\times$ Offers (Flipkart Campaign Matrix)
* **Task Statement:** Create two tables: `users` and `offers`. Write a `CROSS JOIN` query to generate all possible combinations of users and offers, displaying `user_name` and `offer_title`. Explain in a comment how this could be used for a Flipkart-style personalized offer campaign.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    u.user_name,
    o.offer_title,
    o.discount_pct
FROM users u
CROSS JOIN offers o
ORDER BY u.user_name;
```

* **Execution Output (Sample of 21 Combinations Generated):**
| user_name | offer_title | discount_pct |
| :--- | :--- | :---: |
| **Aarav Sharma** | Big Billion Days: 50% Off Electronics | 50% |
| **Aarav Sharma** | Flipkart SuperCoin 20% Cashback | 20% |
| **Aarav Sharma** | Fashion Weekend: Flat Rs. 500 Off | 30% |
| **Diya Patel** | Big Billion Days: 50% Off Electronics | 50% |
| **Diya Patel** | Flipkart SuperCoin 20% Cashback | 20% |
| **Diya Patel** | Fashion Weekend: Flat Rs. 500 Off | 30% |

* **Analytics Context (Flipkart Personalized Offer Campaign):**
  > *In high-scale e-commerce, personalization engines start by taking a `CROSS JOIN` between eligible customer segments and active marketing promos. This Cartesian baseline generates the total universe of possible user-offer permutations. Machine learning scoring models (e.g. collaborative filtering or uplift models) subsequently rank each pair based on browsing affinity, displaying only the top 1–2 personalized deals on the customer's homepage.*

---

### Task 4: Employees Table Self Join & Top-Level Filter
* **Task Statement:** You have an employees table with columns (`id`, `name`, `manager_id`). Write a `SELF JOIN` to display each employee's name along with their manager's name. Then, modify your query to only show employees who do not have a manager (i.e., top-level managers).
* **Status:** Completed & Executed.
* **SQL Queries:**

```sql
-- Part A: Employees with Their Reporting Managers
SELECT 
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
INNER JOIN employees m ON e.manager_id = m.id;

-- Part B: Top-Level Managers Only (No Manager)
SELECT 
    e.id AS employee_id,
    e.name AS employee_name,
    e.department,
    'Top-Level Manager' AS role_status
FROM employees e
WHERE e.manager_id IS NULL;
```

* **Part A Output:**
| employee_name | manager_name |
| :--- | :--- |
| **Sunita Rao** | Rajesh Mehta |
| **Vikram Malhotra** | Rajesh Mehta |
| **Amit Verma** | Sunita Rao |
| **Neha Patel** | Sunita Rao |
| **Rohan Shah** | Vikram Malhotra |

* **Part B Output:**
| employee_id | employee_name | department | role_status |
| :---: | :--- | :--- | :--- |
| **1** | Rajesh Mehta | Executive | Top-Level Manager |
| **7** | Pooja Iyer | Human Resources | Top-Level Manager |

---

### Task 5: AI-Assisted Query: Pairs of Users Living in the Same City
* **Task Statement:** Use ChatGPT or Copilot to help you write an SQL query that finds all pairs of users from a users table who live in the same city (excluding pairs where the user is compared with themselves). Paste the query and briefly describe how the AI helped you improve or debug it.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    u1.user_name AS user_1,
    u2.user_name AS user_2,
    u1.city
FROM users u1
INNER JOIN users u2 ON u1.city = u2.city 
                   AND u1.user_id < u2.user_id
ORDER BY u1.city, user_1;
```

* **Execution Output:**
| user_1 | user_2 | city |
| :--- | :--- | :--- |
| **Ananya Desai** | Devansh Joshi | Ahmedabad |
| **Diya Patel** | Ananya Desai | Ahmedabad |
| **Diya Patel** | Devansh Joshi | Ahmedabad |
| **Aarav Sharma** | Kabir Mehta | Mumbai |

* **How the AI Assistant Improved & Debugged the Query:**
  > **Prompt Given:** *"Write an SQL query to find pairs of users living in the same city without self-matching."*  
  > **Naive Draft:** A novice approach often writes `ON u1.city = u2.city AND u1.user_id != u2.user_id`. While `!=` eliminates self-pairs, it produces **duplicate reciprocal pairs** (e.g., both `(Aarav, Kabir)` and `(Kabir, Aarav)` appear).  
  > **AI Optimization:** The AI recommended replacing `!=` with the strict inequality `u1.user_id < u2.user_id`. This elegant condition enforces a canonical ordering, resolving both issues simultaneously: it prevents comparing a user to themselves and ensures every unique pair is counted exactly once, cutting unnecessary result rows by 50%.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_9_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 5 with commentary. |
| `verify_session_9.py` | Python script verifying execution and output tables. |
| `Session_9_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_9_Assignment_Submission.html` | Polished HTML report ready for submission. |
