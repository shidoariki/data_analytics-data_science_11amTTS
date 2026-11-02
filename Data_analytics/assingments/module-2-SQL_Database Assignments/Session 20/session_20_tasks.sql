-- =====================================================================
-- SESSION 20: Import/Export Data (CSV, Excel, Python, Power BI)
-- Assignment Solutions
-- Dialect: MySQL / SQLite Compatible
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Connect Excel to SQL -> Run SQL Queries -> Load Pivot
-- Description: From Excel, establish an ODBC/OLEDB connection to MySQL,
-- run a query aggregating matches per city, and load into a Pivot Table.
-- ---------------------------------------------------------------------
SELECT 
    city,
    COUNT(match_id) AS total_matches_hosted
FROM ipl_matches
GROUP BY city
ORDER BY total_matches_hosted DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Load Sample IPL Match Data CSV into ipl_matches Table
-- Description: Using SQL CLI or GUI tool (MySQL Workbench / DBeaver /
-- SQLite CLI), import the dataset into ipl_matches.
-- ---------------------------------------------------------------------
-- MySQL Command:
-- LOAD DATA LOCAL INFILE '/path/to/ipl_matches.csv'
-- INTO TABLE ipl_matches
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Verification of loaded data:
SELECT COUNT(*) AS total_matches_loaded FROM ipl_matches;
SELECT * FROM ipl_matches LIMIT 5;


-- ---------------------------------------------------------------------
-- TASK 2: Export Mumbai Indians Matches to CSV (mi_matches.csv)
-- Description: Select all matches where Mumbai Indians played (as team1 or team2).
-- ---------------------------------------------------------------------
-- In MySQL:
-- SELECT * FROM ipl_matches
-- WHERE team1 = 'Mumbai Indians' OR team2 = 'Mumbai Indians'
-- INTO OUTFILE '/var/lib/mysql-files/mi_matches.csv'
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Standard Query for Tool Export (DBeaver / Workbench / Python CLI):
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


-- ---------------------------------------------------------------------
-- TASK 3: Excel Connection & Total Matches Played Per Team
-- Description: In Excel, data imported via Power Query / SQL Connection.
-- SQL Query to calculate total matches played per team across team1 & team2:
-- ---------------------------------------------------------------------
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


-- ---------------------------------------------------------------------
-- TASK 4: Power BI Desktop Connection & Team Wins Pivot Chart
-- Description: Connect Power BI via MySQL Database connector.
-- SQL View / Query used as DirectQuery or Import Mode source:
-- ---------------------------------------------------------------------
SELECT 
    winner AS team,
    COUNT(match_id) AS total_wins
FROM ipl_matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;


-- ---------------------------------------------------------------------
-- TASK 5: Python (Pandas & SQLAlchemy) Filter and to_sql Insertion
-- Description: Read mi_matches.csv, filter matches where Mumbai Indians won,
-- and insert rows into SQL table mi_wins.
-- (Implemented in task5_pandas_sqlalchemy.py)
-- ---------------------------------------------------------------------
-- Final Verification of mi_wins table:
SELECT 
    match_id,
    date,
    city,
    team1,
    team2,
    winner,
    result_margin
FROM mi_wins
ORDER BY match_id ASC;
