-- =====================================================================
-- SESSION 14: Window Functions (Part 2: ROW_NUMBER, RANK, DENSE_RANK)
-- Assignment Solutions
-- Dialect: MySQL / SQLite compatible
-- =====================================================================

-- ---------------------------------------------------------------------
-- DEMO: Top 3 Selling Products Per Region
-- Uses ROW_NUMBER() or DENSE_RANK() with a Common Table Expression (CTE)
-- ---------------------------------------------------------------------
WITH RankedProducts AS (
    SELECT 
        product_id,
        product_name,
        region,
        units_sold,
        DENSE_RANK() OVER (PARTITION BY region ORDER BY units_sold DESC) AS rank_in_region
    FROM regional_product_sales
)
SELECT 
    product_id,
    product_name,
    region,
    units_sold,
    rank_in_region
FROM RankedProducts
WHERE rank_in_region <= 3
ORDER BY region ASC, rank_in_region ASC;

-- ---------------------------------------------------------------------
-- TASK 1: Sequential Order Numbering Per User
-- Description: Assign a unique sequential number to each order per user,
-- ordered by order_date descending using ROW_NUMBER().
-- ---------------------------------------------------------------------
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (
        PARTITION BY user_id 
        ORDER BY order_date DESC
    ) AS order_sequence_desc
FROM Orders
ORDER BY user_id ASC, order_sequence_desc ASC;

-- ---------------------------------------------------------------------
-- TASK 2: Song Stream Rankings with RANK() (Demonstrating Gaps)
-- Description: Rank songs based on streams within each artist using RANK().
-- Notice how tied stream counts receive identical rank, with subsequent
-- ranks skipped (e.g. 1, 2, 2, 4).
-- ---------------------------------------------------------------------
SELECT 
    song_id,
    song_title,
    artist,
    streams,
    RANK() OVER (
        PARTITION BY artist 
        ORDER BY streams DESC
    ) AS stream_rank
FROM Songs
ORDER BY artist ASC, stream_rank ASC;

-- ---------------------------------------------------------------------
-- TASK 3: Movie Rating Rankings with DENSE_RANK() (No Gaps)
-- Description: Rank movies within genre based on rating descending using
-- DENSE_RANK(), where highest rating receives rank 1 with contiguous ranks.
-- ---------------------------------------------------------------------
SELECT 
    movie_id,
    movie_name,
    genre,
    rating,
    DENSE_RANK() OVER (
        PARTITION BY genre 
        ORDER BY rating DESC
    ) AS rating_dense_rank
FROM Movies
ORDER BY genre ASC, rating_dense_rank ASC;

-- ---------------------------------------------------------------------
-- TASK 4: Top 3 Influencers Per Platform
-- Description: Display top 3 influencers per platform using ROW_NUMBER()
-- within a CTE / Subquery, showing id, platform, followers, and row number.
-- ---------------------------------------------------------------------
WITH RankedInfluencers AS (
    SELECT 
        id,
        influencer_name,
        platform,
        followers,
        ROW_NUMBER() OVER (
            PARTITION BY platform 
            ORDER BY followers DESC
        ) AS rank_num
    FROM Influencers
)
SELECT 
    id,
    influencer_name,
    platform,
    followers,
    rank_num
FROM RankedInfluencers
WHERE rank_num <= 3
ORDER BY platform ASC, rank_num ASC;
