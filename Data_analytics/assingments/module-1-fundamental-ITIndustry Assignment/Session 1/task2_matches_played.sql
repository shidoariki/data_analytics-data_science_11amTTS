-- =============================================================================
-- SESSION 1: What is Data Analytics? Overview of Industry Tools
-- TASK 2: Total Number of Matches Played by Each Team
-- Database: ipl_analytics_db (MySQL) or matches.db (SQLite)
-- Table: matches
-- Student: Rushikesh
-- =============================================================================

USE ipl_analytics_db;

-- -----------------------------------------------------------------------------
-- SQL Query to find the total number of matches played by each team
-- Explanation:
-- Each match record in the 'matches' table has two teams (team1 and team2).
-- To compute the total games played by each team, we combine the team1 column
-- and the team2 column using UNION ALL, and then aggregate with COUNT(*).
-- -----------------------------------------------------------------------------

SELECT 
    team, 
    COUNT(*) AS total_matches_played
FROM (
    SELECT team1 AS team FROM matches
    UNION ALL
    SELECT team2 AS team FROM matches
) AS all_matches
GROUP BY 
    team
ORDER BY 
    total_matches_played DESC, 
    team ASC;
