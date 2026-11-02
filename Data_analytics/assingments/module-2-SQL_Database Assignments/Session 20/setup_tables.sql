-- =====================================================================
-- SESSION 20: Import/Export Data (CSV, Excel, Python, Power BI)
-- Setup Script: Database Table DDL & Sample Ingestion
-- Database: analytics_db (MySQL / SQLite Compatible)
-- =====================================================================

-- ---------------------------------------------------------------------
-- Task 1 Table: ipl_matches
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS ipl_matches;
CREATE TABLE ipl_matches (
    match_id INT PRIMARY KEY,
    season INT NOT NULL,
    city VARCHAR(50),
    date DATE NOT NULL,
    team1 VARCHAR(50) NOT NULL,
    team2 VARCHAR(50) NOT NULL,
    toss_winner VARCHAR(50),
    toss_decision VARCHAR(20),
    winner VARCHAR(50),
    result_margin INT
);

-- Note: In MySQL, CSV data can be loaded using:
-- LOAD DATA LOCAL INFILE 'ipl_matches.csv'
-- INTO TABLE ipl_matches
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- Table for Task 5: mi_wins (Created dynamically via Pandas to_sql)
DROP TABLE IF EXISTS mi_wins;
CREATE TABLE mi_wins (
    match_id INT PRIMARY KEY,
    season INT NOT NULL,
    city VARCHAR(50),
    date DATE NOT NULL,
    team1 VARCHAR(50) NOT NULL,
    team2 VARCHAR(50) NOT NULL,
    toss_winner VARCHAR(50),
    toss_decision VARCHAR(20),
    winner VARCHAR(50),
    result_margin INT
);
