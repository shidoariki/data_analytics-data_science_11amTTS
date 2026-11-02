# Session 22 – SQL + Python Integration
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Programmatic SQL Integration, Pandas `read_sql()`, Jupyter `%sql` Magic, and Matplotlib EDA Pipelines  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Architecture

The convergence of SQL and Python forms the backbone of contemporary data science. Relational databases handle filtering, grouping, and transactional persistence, while Python provides vector manipulation, statistical modeling, and rich charting libraries.

### Key Workflows Implemented:
1. **Pandas Interoperability**: Direct SQL-to-DataFrame loading via `pd.read_sql()` without intermediate text file serialization.
2. **Jupyter Notebook SQL Magic**: Running native SQL statements inline via `%sql` or `%%sql` blocks for interactive rapid prototyping.
3. **Hybrid Exploratory Data Analysis (EDA)**: Filtering massive order histories down with SQL `LIMIT` and aggregating user preferences via Pandas vector methods.
4. **Data Visualization**: Exporting SQL query summaries directly into Matplotlib bar charts.

---

## 2. Assignment Tasks & Technical Implementations

### Task 1: Load Restaurants Table into DataFrame via `read_sql()`
```python
import sqlite3
import pandas as pd

conn = sqlite3.connect("session_22_analytics.db")
df_restaurants = pd.read_sql("SELECT name, cuisine, rating FROM restaurants", conn)
print(df_restaurants.head())
```
**Output:**
```text
             name       cuisine  rating
0        Truffles   Continental     4.5
1   Meghana Foods       Biryani     4.6
2    Taaza Thindi  South Indian     4.7
3  Mainland China       Chinese     4.2
4    Toit Brewpub   Continental     4.6
```

---

### Task 2: Jupyter Notebook `%sql` Magic – Movies Rated > 8.0
```python
# In Jupyter Notebook:
# %load_ext sql
# %sql sqlite:///session_22_analytics.db
# %%sql
# SELECT movie_id, title, genre, rating FROM movies WHERE rating > 8.0 ORDER BY rating DESC;
```
**Result Set:**
```text
   movie_id                     title      genre  rating
0         1  The Shawshank Redemption      Drama     9.3
1         2             The Godfather      Crime     9.2
2         4                 12th Fail      Drama     9.1
3         3           The Dark Knight     Action     9.0
4         5               Oppenheimer  Biography     8.9
```

---

### Task 3: Load Last 100 Orders & Top 3 Most Ordered Food Items
```python
df_last_100_orders = pd.read_sql(
    "SELECT * FROM orders ORDER BY order_id DESC LIMIT 100", 
    conn
)
top_3_items = df_last_100_orders['item_name'].value_counts().head(3)
print(top_3_items)
```
**Output:**
```text
item_name
Chicken Biryani       27
Veg Whopper Burger    20
Margherita Pizza      18
```

---

### Task 4: IPL Match Data – Matches Played Per Team Bar Chart
```python
df_matches = pd.read_sql("SELECT team1, team2 FROM matches", conn)
all_teams_series = pd.concat([df_matches['team1'], df_matches['team2']])
matches_per_team = all_teams_series.value_counts().reset_index()
matches_per_team.columns = ['Team', 'Matches_Played']

plt.figure(figsize=(10, 6))
plt.bar(matches_per_team['Team'], matches_per_team['Matches_Played'], color='#2563EB', edgecolor='#1E3A8A')
plt.title('IPL 2023: Total Matches Played per Team', fontsize=14, fontweight='bold')
plt.xlabel('Team Name', fontsize=12)
plt.ylabel('Matches Played', fontsize=12)
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.savefig("ipl_matches_per_team.png", dpi=300)
```
- **Generated Graphic**: Saved to `ipl_matches_per_team.png`.

---

### Task 5: AI-Assisted Query – Users with More Than 5 Orders
```python
ai_query = """
SELECT 
    u.user_id,
    u.user_name,
    u.city,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.amount), 2) AS total_spend
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name, u.city
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;
"""
df_active_users = pd.read_sql(ai_query, conn)
print(df_active_users)
```
**Result Table:**
```text
   user_id    user_name       city  total_orders  total_spend
0        1  Aarav Patel  Ahmedabad            29       6131.0
1        5  Kabir Mehta     Mumbai            28       7425.0
2        4  Ananya Iyer    Chennai            24       6310.0
3        2  Diya Sharma  Bangalore            22       5681.0
4        3  Rohan Verma      Delhi            17       4134.0
```

---

## 3. Included Artifacts
- **`session_22_analytics.db`**: Relational database with sample datasets.
- **`session_22_analysis.py`**: Automated end-to-end Python pipeline.
- **`session_22_notebook.ipynb`**: Complete Jupyter Notebook with code, markdown and execution cells.
- **`ipl_matches_per_team.png`**: High-resolution Matplotlib chart.
- **`verify_session_22.py`**: Automated test verification harness.
