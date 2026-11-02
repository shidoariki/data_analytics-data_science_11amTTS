# Session 14 – Window Functions (Part 2: ROW_NUMBER, RANK, DENSE_RANK)
**Module 2: SQL & Relational Database Assignments**  
**Student Name:** Rushikesh  
**Topic:** Window Ranking Functions (`ROW_NUMBER`, `RANK`, `DENSE_RANK`), Tie Handling, and Regional Top-N Analytics  
**Status:** Completed & Fully Verified

---

## 1. Executive Summary & Concepts Overview

Window ranking functions allow analysts to assign ordinal ranks or sequential numbering across rows within specific partitions without collapsing the result set into aggregated summaries.

### Comparative Distinction Table

| Function | Tie Handling Behavior | Subsequent Numbering | Primary Use Case |
| :--- | :--- | :--- | :--- |
| **`ROW_NUMBER()`** | Assigns distinct integer sequentially even if values are identical | Continuous ($1, 2, 3, 4, \dots$) | Pagination, deduplication, fetching exact top-N rows per group |
| **`RANK()`** | Assigns identical rank to ties | Leaves gaps equal to tied count ($1, 2, 2, 4$) | Leaderboards, athletic podiums, competition rankings |
| **`DENSE_RANK()`** | Assigns identical rank to ties | Contiguous, never skips numbers ($1, 2, 2, 3$) | Tier classifications, price brackets, rating groups |

---

## 2. Table Schemas & Sample Data

The environment is set up in `setup_tables.sql` with tables covering regional sales, user orders, artist streaming numbers, movie critic ratings, and social media influencers.

---

## 3. Assignment Tasks & SQL Solutions

### Demo: Top 3 Selling Products Per Region
```sql
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
```

### Task 1: Sequential Order Numbering Per User (`ROW_NUMBER`)
```sql
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
```

### Task 2: Song Stream Rankings with `RANK()` (Ties with Gaps)
```sql
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
```

### Task 3: Movie Rating Rankings with `DENSE_RANK()` (Ties without Gaps)
```sql
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
```

### Task 4: Top 3 Influencers Per Platform
```sql
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
```

---

## 4. Execution & Verification Output

```text
--- DEMO: Top 3 Selling Products Per Region ---
(1, 'iPhone 15', 'North', 15400, 1)
(3, 'Redmi Note 13', 'North', 14200, 2)
(2, 'OnePlus Nord', 'North', 12100, 3)
(5, 'iPhone 15', 'South', 18200, 1)
(6, 'Samsung S23', 'South', 16500, 2)
(7, 'OnePlus Nord', 'South', 11900, 3)
(9, 'boAt Rockerz', 'West', 24000, 1)
(11, 'JBL Flip 6', 'West', 18500, 2)
(12, 'Noise Smartwatch', 'West', 16200, 3)

--- TASK 1: ROW_NUMBER() by order_date DESC per user ---
(103, 1, '2024-03-01', 890, 1)
(102, 1, '2024-02-14', 1200, 2)
(101, 1, '2024-01-10', 450, 3)
(106, 2, '2024-03-15', 310, 1)
(105, 2, '2024-02-20', 1450, 2)
(104, 2, '2024-01-05', 620, 3)
(110, 3, '2024-04-05', 3200, 1)
(109, 3, '2024-03-22', 950, 2)
(108, 3, '2024-02-28', 1750, 3)
(107, 3, '2024-01-18', 2100, 4)

--- TASK 2: RANK() Songs by Streams per Artist (With Ties & Gaps) ---
(201, 'Kesariya', 'Arijit Singh', 450000000, 1)
(202, 'Tum Hi Ho', 'Arijit Singh', 380000000, 2)
(203, 'Channa Mereya', 'Arijit Singh', 380000000, 2)
(204, 'Apna Bana Le', 'Arijit Singh', 290000000, 4)
(205, 'Shape of You', 'Ed Sheeran', 920000000, 1)
(206, 'Perfect', 'Ed Sheeran', 850000000, 2)
(207, 'Bad Habits', 'Ed Sheeran', 850000000, 2)
(208, 'Shivers', 'Ed Sheeran', 610000000, 4)

--- TASK 3: DENSE_RANK() Movies by Rating per Genre (No Gaps) ---
(303, 'The Dark Knight', 'Action', 9, 1)
(302, 'Top Gun: Maverick', 'Action', 8.4, 2)
(301, 'John Wick: Chapter 4', 'Action', 8.2, 3)
(304, 'The Batman', 'Action', 8.2, 3)
(305, 'Mission Impossible 7', 'Action', 7.9, 4)
(307, '12th Fail', 'Drama', 9.1, 1)
(306, 'Oppenheimer', 'Drama', 8.9, 2)
(308, 'The Whale', 'Drama', 8.5, 3)
(309, 'Killers of the Flower Moon', 'Drama', 8.5, 3)

--- TASK 4: Top 3 Influencers per Platform using ROW_NUMBER() CTE ---
(6, 'Virat Kohli', 'Instagram', 270000000, 1)
(7, 'Priyanka Chopra', 'Instagram', 91000000, 2)
(8, 'Shraddha Kapoor', 'Instagram', 88000000, 3)
(10, 'Narendra Modi', 'X/Twitter', 98000000, 1)
(11, 'Amitabh Bachchan', 'X/Twitter', 48000000, 2)
(13, 'Salman Khan', 'X/Twitter', 45000000, 3)
(1, 'CarryMinati', 'YouTube', 42000000, 1)
(2, 'Total Gaming', 'YouTube', 38000000, 2)
(3, 'Ashish Chanchlani', 'YouTube', 30000000, 3)

Session 14 Verification Successful!
```
