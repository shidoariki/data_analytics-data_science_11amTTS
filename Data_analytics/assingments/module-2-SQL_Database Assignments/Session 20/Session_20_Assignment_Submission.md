# Session 20 – Import/Export Data (CSV, Excel, Python, Power BI)
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Data Interoperability, CSV Ingestion, SQL Exports, Excel/Power BI Connectivity & Pandas/SQLAlchemy Pipelines  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Cross-Tool Interoperability

Modern analytics workflows span diverse client tools and programming languages. Bridging relational databases with Excel, Power BI, and Python allows data analysts to leverage SQL for high-performance extraction and transformation while utilizing BI applications and Python libraries for visualization and machine learning:

1. **Relational Database (SQL)**: High-speed querying, aggregations, and single source of truth storage.
2. **Microsoft Excel (Power Query/ODBC)**: Ad-hoc exploratory slice-and-dice and stakeholder pivot tables.
3. **Power BI Desktop**: Enterprise semantic modeling, interactive visual dashboards, and DAX measures.
4. **Python (`pandas` & `SQLAlchemy`)**: Algorithmic transformations, automated ETL scripts, and programmatic data movement.

---

## 2. Assignment Tasks & Implementations

### Task 1: Load IPL Match Data CSV into `ipl_matches` Table
- **File**: `ipl_matches.csv` (25 matches from IPL 2023 season).
- **SQL / Tool Ingestion**:
  ```sql
  -- MySQL Syntax:
  LOAD DATA LOCAL INFILE 'ipl_matches.csv'
  INTO TABLE ipl_matches
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;
  ```
- **Verification**: Loaded 25 records into `ipl_matches`.

### Task 2: Export Mumbai Indians Matches to CSV (`mi_matches.csv`)
```sql
SELECT 
    match_id,
    season,
    city,
    date,
    team1,
    team2,
    toss_winner,
    toss_decision,
    winner,
    result_margin
FROM ipl_matches
WHERE team1 = 'Mumbai Indians' OR team2 = 'Mumbai Indians'
ORDER BY date ASC;
```
- **Result**: Successfully generated and exported `mi_matches.csv` (6 matches).

### Task 3: Excel Connection & Total Matches Played Per Team
- **SQL Source Query**:
  ```sql
  WITH AllTeams AS (
      SELECT team1 AS team FROM ipl_matches
      UNION ALL
      SELECT team2 AS team FROM ipl_matches
  )
  SELECT 
      team,
      COUNT(*) AS total_matches_played
  FROM AllTeams
  GROUP BY team
  ORDER BY total_matches_played DESC;
  ```
- **Excel Artifact**: Exported to `ipl_matches_pivot.xlsx` featuring sheets `Raw_IPL_Matches` and `Matches_Per_Team_Pivot`.

### Task 4: Power BI Desktop Connection & Team Wins Chart
- **DirectQuery / Import SQL Definition**:
  ```sql
  SELECT 
      winner AS team,
      COUNT(match_id) AS total_wins
  FROM ipl_matches
  WHERE winner IS NOT NULL
  GROUP BY winner
  ORDER BY total_wins DESC;
  ```
- **Power BI Configuration**: Clustered column chart with `team` on the X-axis and `total_wins` on the Y-axis.

### Task 5: Python (Pandas & SQLAlchemy) Pipeline to Create `mi_wins`
- **Script**: `task5_pandas_sqlalchemy.py`
  ```python
  import pandas as pd
  import sqlite3

  # 1. Read CSV using pandas
  df = pd.read_csv("mi_matches.csv")

  # 2. Filter matches where Mumbai Indians won
  mi_wins_df = df[df["winner"] == "Mumbai Indians"]

  # 3. Insert filtered rows into SQL table mi_wins
  conn = sqlite3.connect("session_20_ipl.db")
  mi_wins_df.to_sql("mi_wins", conn, if_exists="replace", index=False)
  conn.close()
  ```
- **Verification Output**: Table `mi_wins` successfully populated with 3 matches (Matches #16, #21, #23).

---

## 3. Execution & Verification Output

```text
--- TASK 1: Loaded ipl_matches into SQLite/MySQL ---
Total rows loaded: 25

--- TASK 2: Exported 6 matches to mi_matches.csv ---
   match_id        date  ...                  team2                       winner
0         5  2023-04-02  ...         Mumbai Indians  Royal Challengers Bangalore
1        12  2023-04-08  ...    Chennai Super Kings          Chennai Super Kings
2        16  2023-04-11  ...         Mumbai Indians               Mumbai Indians
3        21  2023-04-16  ...  Kolkata Knight Riders               Mumbai Indians
4        23  2023-04-18  ...         Mumbai Indians               Mumbai Indians
5        25  2023-04-22  ...           Punjab Kings                 Punjab Kings

--- TASK 3: Total Matches Played Per Team (Excel Table) ---
                          team  total_matches_played
0                 Punjab Kings                     6
1               Mumbai Indians                     6
2          Sunrisers Hyderabad                     5
3  Royal Challengers Bangalore                     5
4             Rajasthan Royals                     5
5        Kolkata Knight Riders                     5
6               Gujarat Titans                     5
7               Delhi Capitals                     5
8         Lucknow Super Giants                     4
9          Chennai Super Kings                     4

--- TASK 4: Total Wins Per Team (Power BI Chart Source) ---
                          team  total_wins
0             Rajasthan Royals           4
1  Royal Challengers Bangalore           3
2                 Punjab Kings           3
3               Mumbai Indians           3
4         Lucknow Super Giants           3
5               Gujarat Titans           3
6          Sunrisers Hyderabad           2
7        Kolkata Knight Riders           2
8          Chennai Super Kings           2

--- TASK 5: Python Pipeline Results ---
Loaded 6 Mumbai Indians matches from mi_matches.csv
Filtered 3 matches won by Mumbai Indians:
   match_id        date  ...          winner result_margin
0        16  2023-04-11  ...  Mumbai Indians             6
1        21  2023-04-16  ...  Mumbai Indians             5
2        23  2023-04-18  ...  Mumbai Indians            14

Session 20 Verification Successful!
```
