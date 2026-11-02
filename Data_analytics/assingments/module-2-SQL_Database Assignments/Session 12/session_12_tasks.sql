-- =====================================================================
-- SESSION 12: Common Table Expressions (CTEs)
-- Course: Data Analytics
-- Student: Rushikesh
-- Workspace: D:\DA\Data_analytics\assingments\module-2-SQL_Database Assignments\Session 12
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: WITH SalesCTE AS (...) -> Calculate Year-over-Year (YoY) Growth
-- Concept: CTEs modularize complex analytical pipelines, improving readability
--          and eliminating redundant subquery repetitions.
-- ---------------------------------------------------------------------
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


-- ---------------------------------------------------------------------
-- TASK 1: Top 3 Most-Followed Artists on Spotify using WITH TopArtists AS (...)
-- ---------------------------------------------------------------------
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


-- ---------------------------------------------------------------------
-- TASK 2: MonthlyTotals CTE for FlipkartOrders (Highest Sales Month in 2023)
-- Hint: Use strftime('%m', order_date) in SQLite / EXTRACT(MONTH) in ANSI MySQL.
-- ---------------------------------------------------------------------
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


-- ---------------------------------------------------------------------
-- TASK 3: Recursive CTE for Next 7 Calendar Days Starting from Today
-- Hint: Use UNION ALL inside CTE and limit recursion to 7 levels.
-- ---------------------------------------------------------------------
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


-- ---------------------------------------------------------------------
-- TASK 4: ZomatoRestaurants: CTE finding average rating per city,
--         then selecting all restaurants in cities where average rating > 4.0.
-- ---------------------------------------------------------------------
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


-- ---------------------------------------------------------------------
-- TASK 5: AI-Assisted Query: IPL Matches CTE for 2023 Runs > 2000
-- Prompt / Scenario:
-- Prompt: "Write an SQL query using a CTE to calculate the total runs scored
-- by each team in 2023 from an IPLMatches table, listing only teams with > 2000 runs."
-- AI Improvement / Assistance:
-- The AI helped structure the pipeline into two clean steps: (1) pre-filtering
-- match_year = 2023 inside the CTE with GROUP BY team, and (2) applying the
-- threshold filter (WHERE total_runs > 2000) cleanly in the outer query,
-- separating aggregation logic from presentation filtering.
-- ---------------------------------------------------------------------
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
