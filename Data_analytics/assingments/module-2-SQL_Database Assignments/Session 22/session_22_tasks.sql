-- =====================================================================
-- SESSION 22: SQL + Python Integration
-- Assignment Solutions
-- Dialect: MySQL / SQLite Compatible
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Run SQL Query -> Load into Pandas -> Visualize
-- ---------------------------------------------------------------------
SELECT 
    cuisine,
    COUNT(restaurant_id) AS restaurant_count,
    ROUND(AVG(rating), 2) AS avg_rating
FROM restaurants
GROUP BY cuisine
ORDER BY avg_rating DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Load All Restaurants into Pandas DataFrame via read_sql()
-- ---------------------------------------------------------------------
SELECT 
    name,
    cuisine,
    rating
FROM restaurants;


-- ---------------------------------------------------------------------
-- TASK 2: Jupyter Notebook %sql Magic - Movies with Rating > 8.0
-- In Jupyter Notebook:
-- %load_ext sql
-- %sql sqlite:///session_22_analytics.db
-- %%sql
-- ---------------------------------------------------------------------
SELECT 
    movie_id,
    title,
    genre,
    rating
FROM movies
WHERE rating > 8.0
ORDER BY rating DESC;


-- ---------------------------------------------------------------------
-- TASK 3: Load Last 100 Orders from Orders Table
-- In Python: df = pd.read_sql("SELECT * FROM orders ORDER BY order_id DESC LIMIT 100", conn)
-- Then top 3 items: df['item_name'].value_counts().head(3)
-- ---------------------------------------------------------------------
SELECT 
    order_id,
    user_id,
    item_name,
    amount,
    order_date
FROM orders
ORDER BY order_id DESC
LIMIT 100;


-- ---------------------------------------------------------------------
-- TASK 4: IPL Matches Count Query (Combined with Pandas groupby & Matplotlib)
-- ---------------------------------------------------------------------
SELECT 
    match_id,
    season,
    team1,
    team2,
    winner
FROM matches;


-- ---------------------------------------------------------------------
-- TASK 5: AI-Assisted Query - Users Who Have Placed More Than 5 Orders
-- ---------------------------------------------------------------------
SELECT 
    u.user_id,
    u.user_name,
    u.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_spend
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name, u.city
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;
