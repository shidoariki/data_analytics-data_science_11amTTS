import sqlite3
import os

db_path = ":memory:"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

current_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()

cursor.executescript(setup_sql)

print("--- DEMO: Top 3 Selling Products Per Region ---")
demo_sql = """
WITH RankedProducts AS (
    SELECT 
        product_id,
        product_name,
        region,
        units_sold,
        DENSE_RANK() OVER (PARTITION BY region ORDER BY units_sold DESC) AS rank_in_region
    FROM regional_product_sales
)
SELECT product_id, product_name, region, units_sold, rank_in_region
FROM RankedProducts
WHERE rank_in_region <= 3
ORDER BY region ASC, rank_in_region ASC;
"""
for row in cursor.execute(demo_sql).fetchall():
    print(row)

print("\n--- TASK 1: ROW_NUMBER() by order_date DESC per user ---")
task1_sql = """
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
"""
for row in cursor.execute(task1_sql).fetchall():
    print(row)

print("\n--- TASK 2: RANK() Songs by Streams per Artist (With Ties & Gaps) ---")
task2_sql = """
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
"""
for row in cursor.execute(task2_sql).fetchall():
    print(row)

print("\n--- TASK 3: DENSE_RANK() Movies by Rating per Genre (No Gaps) ---")
task3_sql = """
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
"""
for row in cursor.execute(task3_sql).fetchall():
    print(row)

print("\n--- TASK 4: Top 3 Influencers per Platform using ROW_NUMBER() CTE ---")
task4_sql = """
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
"""
for row in cursor.execute(task4_sql).fetchall():
    print(row)

conn.close()
print("\nSession 14 Verification Successful!")
