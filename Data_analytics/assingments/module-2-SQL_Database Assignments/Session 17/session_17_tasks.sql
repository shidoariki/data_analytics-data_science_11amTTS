-- =====================================================================
-- SESSION 17: CASE WHEN (Conditional Logic)
-- Assignment Solutions
-- Dialect: MySQL / SQLite Compatible (ANSI SQL Standard)
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Customer Value Segmentation
-- Classifies customers into High, Medium, or Low value tiers
-- ---------------------------------------------------------------------
SELECT 
    customer_id,
    customer_name,
    total_spend,
    CASE 
        WHEN total_spend >= 10000 THEN 'High Value'
        WHEN total_spend >= 3000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_tier
FROM customers
ORDER BY total_spend DESC;


-- ---------------------------------------------------------------------
-- TASK 1: Food Order Size Categorization
-- Description: Classify orders in FoodOrders as 'Small' (< 300), 
-- 'Medium' (300 to 999), or 'Large' (>= 1000) based on total_amount.
-- ---------------------------------------------------------------------
SELECT 
    order_id,
    customer_name,
    total_amount,
    order_date,
    CASE 
        WHEN total_amount < 300 THEN 'Small'
        WHEN total_amount BETWEEN 300 AND 999 THEN 'Medium'
        ELSE 'Large'
    END AS order_size_category
FROM FoodOrders
ORDER BY total_amount DESC;


-- ---------------------------------------------------------------------
-- TASK 2: Movie Popularity Classification
-- Description: From Movies, add popularity column showing 'Blockbuster'
-- for ratings >= 8.0, 'Hit' for 5.0 to 7.9, and 'Average' for < 5.0.
-- ---------------------------------------------------------------------
SELECT 
    movie_id,
    movie_title,
    genre,
    rating,
    CASE 
        WHEN rating >= 8.0 THEN 'Blockbuster'
        WHEN rating >= 5.0 THEN 'Hit'
        ELSE 'Average'
    END AS popularity
FROM Movies
ORDER BY rating DESC;


-- ---------------------------------------------------------------------
-- TASK 3: Flipkart Product Price Binning
-- Description: From FlipkartProducts, create price_category column binning
-- prices as 'Budget' (< 500), 'Standard' (500 to 2000), and 'Premium' (> 2000).
-- ---------------------------------------------------------------------
SELECT 
    product_id,
    product_name,
    category,
    price,
    CASE 
        WHEN price < 500 THEN 'Budget'
        WHEN price BETWEEN 500 AND 2000 THEN 'Standard'
        ELSE 'Premium'
    END AS price_category
FROM FlipkartProducts
ORDER BY price DESC;


-- ---------------------------------------------------------------------
-- TASK 4: Spotify Track Duration Labeling
-- Description: From SpotifyTracks, assign duration_label column: 
-- 'Short' (< 180s), 'Medium' (180-300s), and 'Long' (> 300s).
-- ---------------------------------------------------------------------
SELECT 
    track_id,
    track_title,
    artist,
    duration_seconds,
    CASE 
        WHEN duration_seconds < 180 THEN 'Short'
        WHEN duration_seconds BETWEEN 180 AND 300 THEN 'Medium'
        ELSE 'Long'
    END AS duration_label
FROM SpotifyTracks
ORDER BY duration_seconds DESC;
