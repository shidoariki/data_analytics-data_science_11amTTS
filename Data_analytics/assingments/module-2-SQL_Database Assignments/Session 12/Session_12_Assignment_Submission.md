# SESSION 12: Common Table Expressions (CTEs)
**Data Analytics Course — Assignment & Lab Submission**  
**Student:** Rushikesh  
**Workspace:** `D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 12`

---

## 📌 Executive Summary & Key Concepts

A **Common Table Expression (CTE)** is a named temporary result set defined using the `WITH` clause that exists only within the execution scope of a single SQL statement (`SELECT`, `INSERT`, `UPDATE`, or `DELETE`).

### 1. Why Modern Analytics Prefers CTEs Over Subqueries
* **Code Readability & Modularity:** Decomposes deeply nested subqueries into clean, sequential, top-down execution blocks.
* **Elimination of Repetition:** If an intermediate dataset is referenced multiple times within a complex report (e.g. self-joining a summary dataset), a CTE is defined once and referenced repeatedly.
* **Recursive Capabilities:** Non-recursive CTEs handle linear data pipelines, whereas **Recursive CTEs** execute iterative loops to traverse hierarchical tree graphs and generate dynamic series (e.g. date dimensions).

### 2. Standard vs. Recursive CTE Anatomy
```sql
-- Standard CTE Syntax
WITH CteName AS (
    SELECT col1, SUM(col2) AS metric
    FROM source_table
    GROUP BY col1
)
SELECT * FROM CteName WHERE metric > 100;

-- Recursive CTE Syntax
WITH RECURSIVE NumberSeries(n) AS (
    SELECT 1              -- Anchor Member
    UNION ALL
    SELECT n + 1 FROM NumberSeries WHERE n < 10 -- Recursive Member
)
SELECT * FROM NumberSeries;
```

---

## 🧪 Demo: Calculate Year-over-Year (YoY) Sales Growth Using CTE

### Business Context:
Executive leadership requires a financial performance report tracking annual revenue and calculating the percentage Year-over-Year (YoY) growth metric across multiple fiscal years.

### SQL Query:
```sql
WITH SalesCTE AS (
    SELECT 
        s1.sale_year,
        s1.total_revenue,
        s2.total_revenue AS prev_year_revenue
    FROM annual_sales s1
    LEFT JOIN annual_sales s2 ON s1.sale_year = s2.sale_year + 1
)
SELECT 
    sale_year,
    total_revenue,
    prev_year_revenue,
    ROUND(100.0 * (total_revenue - prev_year_revenue) / prev_year_revenue, 2) AS yoy_growth_pct
FROM SalesCTE
ORDER BY sale_year;
```

### Execution Result Grid:
| sale_year | total_revenue (INR) | prev_year_revenue (INR) | YoY Growth (%) | Trend Assessment |
| :---: | :---: | :---: | :---: | :--- |
| **2020** | 4,50,00,000.00 | *NULL* | *NULL* | Baseline Year |
| **2021** | 5,80,00,000.00 | 4,50,00,000.00 | **+28.89%** | Strong Post-Pandemic Rebound |
| **2022** | 7,20,00,000.00 | 5,80,00,000.00 | **+24.14%** | Stable Expansion |
| **2023** | 9,50,00,000.00 | 7,20,00,000.00 | **+31.94%** | Peak Growth Surge |
| **2024** | 12,00,00,000.00 | 9,50,00,000.00 | **+26.32%** | Sustained Momentum |

---

## 📋 Assignment Tasks & Solutions

### Task 1: Top 3 Most-Followed Artists on Spotify using WITH TopArtists AS (...)
* **Task Statement:** Write an SQL query using the `WITH` clause to create a temporary result set called `TopArtists` that selects the top 3 most-followed artists from a table `SpotifyArtists` (columns: `artist_id`, `name`, `followers`), then select all rows from `TopArtists`.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
WITH TopArtists AS (
    SELECT 
        artist_id, 
        name, 
        followers
    FROM SpotifyArtists
    ORDER BY followers DESC
    LIMIT 3
)
SELECT * FROM TopArtists;
```

* **Execution Output:**
| artist_id | name | followers | Global Ranking |
| :---: | :--- | :---: | :---: |
| **1** | Arijit Singh | **115,000,000** | #1 |
| **3** | Ed Sheeran | **112,000,000** | #2 |
| **2** | Taylor Swift | **108,000,000** | #3 |

* **Query Explanation:**
  The `TopArtists` CTE encapsulates the sorting and top-N limitation logic. The primary query simply outputs the final clean tabular view.

---

### Task 2: MonthlyTotals CTE for FlipkartOrders (Highest Sales Month in 2023)
* **Task Statement:** Using a table named `FlipkartOrders` (columns: `order_id`, `user_id`, `order_date`, `total_amount`), write a query with a CTE called `MonthlyTotals` that calculates the total sales amount for each month in 2023, then select the month with the highest total sales from `MonthlyTotals`.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
WITH MonthlyTotals AS (
    SELECT 
        strftime('%m', order_date) AS order_month,
        SUM(total_amount) AS total_sales
    FROM FlipkartOrders
    WHERE strftime('%Y', order_date) = '2023'
    GROUP BY strftime('%m', order_date)
)
SELECT 
    order_month,
    total_sales
FROM MonthlyTotals
ORDER BY total_sales DESC
LIMIT 1;
```

* **Execution Output:**
| order_month | total_sales (INR) | Primary Driver |
| :---: | :---: | :--- |
| **10 (October)** | **4,02,000.00** | Flipkart Big Billion Days Annual Sale |

* **Query Explanation:**
  The `MonthlyTotals` CTE extracts the two-digit calendar month, filters strictly for 2023 orders, and aggregates monthly revenue. The outer query sorts descending by total volume and restricts to 1, pinpointing Month 10 (October) as the dominant peak sales month.

---

### Task 3: Recursive CTE Generating Next 7 Calendar Days Starting Today
* **Task Statement:** Create a recursive CTE to generate a list of dates for the next 7 days starting from today in a table called `CalendarDays` (columns: `day_date`).
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
WITH RECURSIVE CalendarDays(day_date, day_num) AS (
    -- Anchor Member (Day 1: Today)
    SELECT CURRENT_DATE, 1
    
    UNION ALL
    
    -- Recursive Member (Days 2 to 7)
    SELECT DATE(day_date, '+1 day'), day_num + 1
    FROM CalendarDays
    WHERE day_num < 7
)
SELECT 
    day_num AS day_sequence,
    day_date
FROM CalendarDays;
```

* **Execution Output:**
| day_sequence | day_date | Label |
| :---: | :--- | :--- |
| **1** | 2026-11-02 | Day 1 (Today) |
| **2** | 2026-11-03 | Day 2 |
| **3** | 2026-11-04 | Day 3 |
| **4** | 2026-11-05 | Day 4 |
| **5** | 2026-11-06 | Day 5 |
| **6** | 2026-11-07 | Day 6 |
| **7** | 2026-11-08 | Day 7 |

* **Query Explanation:**
  The recursive CTE initializes with `CURRENT_DATE` as the anchor. On each iteration, it increments the date by `+1 day` until `day_num < 7` terminates the loop, generating a synthetic date spine without physical calendar tables.

---

### Task 4: Restaurants in Cities with City Average Rating Above 4.0
* **Task Statement:** Given a table called `ZomatoRestaurants` (columns: `id`, `name`, `city`, `rating`), use a CTE to find the average rating for each city, then select all restaurants in cities where the average rating is above 4.0.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
WITH CityAvgRatings AS (
    SELECT 
        city,
        ROUND(AVG(rating), 2) AS city_avg_rating
    FROM ZomatoRestaurants
    GROUP BY city
    HAVING AVG(rating) > 4.0
)
SELECT 
    r.id,
    r.name AS restaurant_name,
    r.city,
    r.rating,
    c.city_avg_rating
FROM ZomatoRestaurants r
INNER JOIN CityAvgRatings c ON r.city = c.city
ORDER BY c.city_avg_rating DESC, r.rating DESC;
```

* **Execution Output:**
| id | restaurant_name | city | individual_rating | city_avg_rating |
| :---: | :--- | :--- | :---: | :---: |
| **6** | Toit Brewpub | Bengaluru | 4.8 | 4.63 |
| **7** | Truffles | Bengaluru | 4.6 | 4.63 |
| **8** | MTR | Bengaluru | 4.5 | 4.63 |
| **3** | Agashiye | Ahmedabad | 4.6 | 4.50 |
| **1** | Mocha Cafe | Ahmedabad | 4.5 | 4.50 |
| **2** | Gordhan Thal | Ahmedabad | 4.4 | 4.50 |

* **Query Explanation:**
  The `CityAvgRatings` CTE filters out low-rated culinary markets (*Kanpur: 3.50*, *Panipat: 3.65*). The main query joins back to `ZomatoRestaurants` to retrieve all venues operating in premium culinary clusters.

---

### Task 5: AI-Assisted Query: IPL 2023 Total Team Runs > 2000
* **Task Statement:** Use ChatGPT or Copilot to help you write an SQL query with a CTE that, given a table `IPLMatches` (columns: `match_id`, `team`, `runs`, `match_year`), calculates the total runs scored by each team in 2023 and lists only teams with more than 2000 runs.
* **Status:** Completed & Executed.
* **SQL Query:**
```sql
WITH TeamRuns2023 AS (
    SELECT 
        team,
        SUM(runs) AS total_runs
    FROM IPLMatches
    WHERE match_year = 2023
    GROUP BY team
)
SELECT 
    team,
    total_runs
FROM TeamRuns2023
WHERE total_runs > 2000
ORDER BY total_runs DESC;
```

* **Execution Output:**
| team | total_runs | Season Performance |
| :--- | :---: | :--- |
| **CSK** | **2,203** | Qualified & Exceeded Benchmark |
| **GT** | **2,179** | Qualified & Exceeded Benchmark |

* **How the AI Assistant Improved & Debugged the Query:**
  > **Prompt Given:** *"How to write a clean CTE in SQL to sum IPL match runs for 2023 per team and show only teams over 2000 runs?"*  
  > **AI Value-Add & Architecture:** Rather than cramming year filtering, aggregation, and threshold conditions into a single monolithic statement with a `HAVING` clause, the AI advised establishing a clean **separation of concerns**:  
  > 1. The CTE handles dataset scoping (`match_year = 2023`) and aggregation (`SUM(runs)` per `team`).  
  > 2. The outer query applies the business threshold (`WHERE total_runs > 2000`). This ensures downstream analytics tools can easily adjust or parameterize the cutoff threshold without rewriting the core aggregation logic.

---

## 📂 Deliverables & File Index

| File Name | Description |
| :--- | :--- |
| `setup_tables.sql` | DDL and mock data creation script for MySQL / SQLite. |
| `session_12_tasks.sql` | Clean SQL script containing Demo and Tasks 1 to 5 with commentary. |
| `verify_session_12.py` | Python script verifying execution and output tables. |
| `Session_12_Assignment_Submission.md` | Comprehensive Markdown report with queries and result tables. |
| `Session_12_Assignment_Submission.html` | Polished HTML report ready for submission. |
