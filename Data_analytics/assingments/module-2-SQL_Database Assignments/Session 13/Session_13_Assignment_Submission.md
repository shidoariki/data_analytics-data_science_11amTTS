# SESSION 13: Window Functions (Part 1: OVER, PARTITION BY)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 13`

---

## 📌 Executive Summary & Key Concepts

**Window Functions** are one of the most powerful and transformative features of modern SQL. Unlike traditional aggregate functions with `GROUP BY`—which collapse multiple rows into a single summary row—window functions compute an aggregate or analytical metric across a specified window of rows **while preserving the identity and granularity of every individual row**.

### 1. Architectural Anatomy of Window Functions
```sql
FUNCTION_NAME(expression) OVER (
    [PARTITION BY partition_column]
    [ORDER BY sort_column]
    [ROWS|RANGE frame_specification]
)
```
* **`OVER()`:** Signals that the function operates as a window calculation rather than a traditional aggregate. An empty `OVER()` defines a window spanning the entire dataset.
* **`PARTITION BY`:** Divides the dataset into independent subsets (partitions). The function executes separately for each partition and resets at partition boundaries.
* **No Row Collapse:** Retains $N$ input rows $\to$ produces $N$ output rows, enabling simultaneous inspection of atomic facts and higher-order cohort benchmarks.

### 2. Window Functions vs. Standard `GROUP BY`
| Dimension | Standard `GROUP BY` | Window Function (`OVER()`) |
| :--- | :--- | :--- |
| **Output Cardinality** | Collapses $N$ rows down to $K$ distinct groups | Exactly $N$ rows preserved |
| **Detail Visibility** | Non-aggregated column detail is discarded | All granular columns (IDs, timestamps, items) remain visible |
| **Comparative Analytics** | Requires complex self-joins to compare row to group | Computes ratios, differences, and benchmarks directly inline |

---

## 🧪 Demo: Find Each Employee's Salary vs. Department Average

### Business Context:
HR and compensation analytics teams must audit internal salary equity by comparing each employee's individual compensation directly against their specific department's average benchmark.

### SQL Query:
```sql
SELECT 
    id,
    name,
    department,
    salary,
    ROUND(AVG(salary) OVER(PARTITION BY department), 2) AS dept_avg_salary,
    ROUND(salary - AVG(salary) OVER(PARTITION BY department), 2) AS diff_from_dept_avg
FROM employees
ORDER BY department, salary DESC;
```

### Execution Result Grid:
| id | name | department | salary (INR) | dept_avg_salary (INR) | diff_from_dept_avg (INR) | Equity Status |
| :---: | :--- | :--- | :---: | :---: | :---: | :--- |
| **4** | Sunita Rao | Analytics | 88,000.00 | 80,000.00 | **+8,000.00** | Above Avg |
| **5** | Vikram Malhotra | Analytics | 72,000.00 | 80,000.00 | **-8,000.00** | Below Avg |
| **1** | Rohan Sharma | Engineering | 95,000.00 | 84,000.00 | **+11,000.00** | Lead Band |
| **3** | Neha Patel | Engineering | 82,000.00 | 84,000.00 | **-2,000.00** | At Par |
| **2** | Amit Verma | Engineering | 75,000.00 | 84,000.00 | **-9,000.00** | Entry Band |
| **6** | Pooja Iyer | Human Resources | 65,000.00 | 60,000.00 | **+5,000.00** | Above Avg |
| **7** | Kavita Joshi | Human Resources | 55,000.00 | 60,000.00 | **-5,000.00** | Below Avg |

* **Technical Insight:** The calculation seamlessly computes the department benchmark and delta inline for each employee without a second query or self-join.

---

## 📋 Assignment Tasks & Solutions

### Task 1: Display Each Order Amount Alongside Grand Total (OVER())
* **Task Statement:** Create a table called `Orders` with columns: `order_id`, `user_id`, `order_amount`, and `app_name` (e.g., 'Zomato', 'Swiggy', 'Flipkart'). Insert at least 10 sample records with different users and apps. Write an SQL query using the `OVER()` function to display each order's amount along with the total order amount for all orders.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    order_id,
    user_id,
    app_name,
    order_amount,
    SUM(order_amount) OVER() AS grand_total_amount
FROM Orders
ORDER BY order_id;
```

* **Execution Output:**
| order_id | user_id | app_name | order_amount (INR) | grand_total_amount (INR) |
| :---: | :---: | :--- | :---: | :---: |
| **101** | 1 | Zomato | 450.00 | 8,900.00 |
| **102** | 1 | Flipkart | 1,200.00 | 8,900.00 |
| **103** | 2 | Swiggy | 320.00 | 8,900.00 |
| **104** | 2 | Zomato | 650.00 | 8,900.00 |
| **105** | 3 | Flipkart | 2,800.00 | 8,900.00 |
| **106** | 1 | Swiggy | 290.00 | 8,900.00 |
| **107** | 3 | Zomato | 420.00 | 8,900.00 |
| **108** | 4 | Flipkart | 1,500.00 | 8,900.00 |
| **109** | 2 | Swiggy | 890.00 | 8,900.00 |
| **110** | 4 | Zomato | 380.00 | 8,900.00 |

* **Query Explanation:**
  The empty `OVER()` clause computes the overall sum of the entire table ($\text{Rs. } 8,900.00$) and projects this global figure onto every individual order row, facilitating ratio and contribution calculations.

---

### Task 2: User Order with User Average (OVER(PARTITION BY user_id))
* **Task Statement:** Using the `Orders` table, write an SQL query to show each user's `order_id`, `order_amount`, and the average `order_amount` for that user using the `OVER(PARTITION BY user_id)` clause.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    order_id,
    app_name,
    order_amount,
    ROUND(AVG(order_amount) OVER(PARTITION BY user_id), 2) AS user_avg_order_amount
FROM Orders
ORDER BY user_id, order_id;
```

* **Execution Output:**
| user_id | order_id | app_name | order_amount (INR) | user_avg_order_amount (INR) |
| :---: | :---: | :--- | :---: | :---: |
| **1** | 101 | Zomato | 450.00 | 646.67 |
| **1** | 102 | Flipkart | 1,200.00 | 646.67 |
| **1** | 106 | Swiggy | 290.00 | 646.67 |
| **2** | 103 | Swiggy | 320.00 | 620.00 |
| **2** | 104 | Zomato | 650.00 | 620.00 |
| **2** | 109 | Swiggy | 890.00 | 620.00 |
| **3** | 105 | Flipkart | 2,800.00 | 1,610.00 |
| **3** | 107 | Zomato | 420.00 | 1,610.00 |
| **4** | 108 | Flipkart | 1,500.00 | 940.00 |
| **4** | 110 | Zomato | 380.00 | 940.00 |

* **Query Explanation:**
  The `PARTITION BY user_id` establishes user-isolated boundaries. User 1's average order value evaluates to $\frac{450+1200+290}{3} = 646.67$, while User 3 evaluates to $\frac{2800+420}{2} = 1610.00$.

---

### Task 3: Song Duration and User Total Duration (SUM() OVER(PARTITION BY user_id))
* **Task Statement:** Suppose you have a table called `Playlist` with columns: `song_id`, `user_id`, and `duration_sec`. Write an SQL query to display each song's duration, and the total duration of songs added by each user using `SUM(duration_sec) OVER(PARTITION BY user_id)`.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    user_id,
    song_id,
    duration_sec,
    SUM(duration_sec) OVER(PARTITION BY user_id) AS total_user_duration_sec
FROM Playlist
ORDER BY user_id, song_id;
```

* **Execution Output:**
| user_id | song_id | duration_sec | total_user_duration_sec |
| :---: | :---: | :---: | :---: |
| **101** | 1 | 240 | **730** |
| **101** | 2 | 180 | **730** |
| **101** | 3 | 310 | **730** |
| **102** | 4 | 210 | **405** |
| **102** | 5 | 195 | **405** |
| **103** | 6 | 360 | **1,055** |
| **103** | 7 | 290 | **1,055** |
| **103** | 8 | 220 | **1,055** |
| **103** | 9 | 185 | **1,055** |

* **Query Explanation:**
  Every individual track's length is presented alongside the curator's cumulative listening investment (e.g. User 103 has accumulated 1,055 total seconds across 4 tracks).

---

### Task 4: Movie Ratings with Movie Average Rating & Differential
* **Task Statement:** Given a table named `MovieRatings` with columns: `rating_id`, `user_id`, `movie_name`, and `rating` (1-5), write an SQL query to show each rating, the average rating per movie, and the difference between the user's rating and the movie's average rating using window functions.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
SELECT 
    rating_id,
    user_id,
    movie_name,
    rating,
    ROUND(AVG(rating) OVER(PARTITION BY movie_name), 2) AS movie_avg_rating,
    ROUND(rating - AVG(rating) OVER(PARTITION BY movie_name), 2) AS rating_diff_from_avg
FROM MovieRatings
ORDER BY movie_name, rating_id;
```

* **Execution Output:**
| rating_id | user_id | movie_name | rating | movie_avg_rating | rating_diff_from_avg | User Sentiment Deviation |
| :---: | :---: | :--- | :---: | :---: | :---: | :--- |
| **9** | 11 | 12th Fail | 5 | 4.67 | **+0.33** | Positive Critic |
| **10** | 13 | 12th Fail | 5 | 4.67 | **+0.33** | Positive Critic |
| **11** | 14 | 12th Fail | 4 | 4.67 | **-0.67** | More Critical |
| **5** | 11 | Animal | 3 | 3.50 | **-0.50** | Slightly Critical |
| **6** | 12 | Animal | 5 | 3.50 | **+1.50** | Strong Fan |
| **7** | 15 | Animal | 2 | 3.50 | **-1.50** | Detractor |
| **8** | 16 | Animal | 4 | 3.50 | **+0.50** | Favorable |
| **1** | 11 | Dune: Part Two | 5 | 4.50 | **+0.50** | Favorable |
| **2** | 12 | Dune: Part Two | 4 | 4.50 | **-0.50** | Slightly Critical |
| **3** | 13 | Dune: Part Two | 5 | 4.50 | **+0.50** | Favorable |
| **4** | 14 | Dune: Part Two | 4 | 4.50 | **-0.50** | Slightly Critical |

* **Query Explanation:**
  The `AVG(rating) OVER(PARTITION BY movie_name)` establishes the movie's consensus score, while subtracting this from the user's score immediately isolates outliers, harsh detractors, and hyper-enthusiasts for audience segmentation.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_13_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 4 with commentary. |
| `verify_session_13.py` | Python script verifying execution and output tables. |
| `Session_13_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_13_Assignment_Submission.html` | Polished HTML report ready for submission. |
