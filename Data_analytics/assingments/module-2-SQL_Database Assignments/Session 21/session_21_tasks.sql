-- =====================================================================
-- SESSION 21: SQL + Excel Integration (Advanced)
-- Assignment Solutions: Parameterized Queries & Power Query Logic
-- Database: SQL Server / MySQL / SQLite Compatible
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Base Query for Excel Data Connection & Pivot Table
-- ---------------------------------------------------------------------
SELECT 
    name,
    cuisine,
    rating,
    cost_for_two,
    city
FROM Restaurants
ORDER BY rating DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Power Query Initial Load Query
-- Description: Connect Excel workbook to SQL Server using Power Query
-- (Data > Get Data > From Database > From SQL Server Database).
-- ---------------------------------------------------------------------
SELECT 
    restaurant_id,
    name,
    cuisine,
    rating,
    cost_for_two,
    city
FROM Restaurants;


-- ---------------------------------------------------------------------
-- TASK 2: Parameterized SQL Query by Cuisine
-- Description: In Power Query, bind parameter 'CuisineParam' (linked to
-- Excel Cell range 'SelectedCuisine') into the SQL statement.
-- ---------------------------------------------------------------------
-- Parameterized SQL query:
-- SELECT name, cuisine, rating, cost_for_two, city
-- FROM Restaurants
-- WHERE cuisine = ?;  (or @CuisineParam in T-SQL / Power Query Value.NativeQuery)

-- Example evaluation for 'South Indian':
SELECT 
    name,
    cuisine,
    rating,
    cost_for_two,
    city
FROM Restaurants
WHERE cuisine = 'South Indian'
ORDER BY rating DESC;

-- Example evaluation for 'Chinese':
SELECT 
    name,
    cuisine,
    rating,
    cost_for_two,
    city
FROM Restaurants
WHERE cuisine = 'Chinese'
ORDER BY rating DESC;


-- ---------------------------------------------------------------------
-- TASK 3: Dynamic Data Refresh Configuration in Excel
-- Description: How to enable one-click and automatic background refresh:
-- ---------------------------------------------------------------------
-- Steps in Excel UI:
-- 1. Click Data Ribbon > Queries & Connections.
-- 2. Right-click the SQL connection > Properties.
-- 3. Check "Enable background refresh".
-- 4. Check "Refresh data when opening the file".
-- 5. Set "Refresh every X minutes" (e.g. 15 minutes) for live dashboards.
-- 6. Instant Refresh: Click "Refresh All" (Ctrl + Alt + F5) or right-click table > Refresh.


-- ---------------------------------------------------------------------
-- TASK 4: Filter Restaurants with Rating Above 4.0 for Dashboard
-- Description: Modify Power Query connection to return high-rated venues
-- and present as an Excel Table paired with a Bar Chart.
-- ---------------------------------------------------------------------
SELECT 
    name,
    cuisine,
    rating,
    cost_for_two,
    city
FROM Restaurants
WHERE rating > 4.0
ORDER BY rating DESC;


-- ---------------------------------------------------------------------
-- TASK 5: AI-Assisted Dual-Parameterized Query (Rating Range: Min to Max)
-- Description: Parameterized SQL query with MinRating and MaxRating parameters.
-- ---------------------------------------------------------------------
-- Power Query Native SQL with Range:
-- SELECT name, cuisine, rating, cost_for_two, city
-- FROM Restaurants
-- WHERE rating BETWEEN @MinRating AND @MaxRating
-- ORDER BY rating DESC;

-- Test Query with Min = 3.5 and Max = 5.0:
SELECT 
    name,
    cuisine,
    rating,
    cost_for_two,
    city
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 5.0
ORDER BY rating DESC;
