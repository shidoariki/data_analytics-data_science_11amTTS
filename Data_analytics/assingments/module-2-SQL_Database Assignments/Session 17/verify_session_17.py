import sqlite3
import os

db_path = ":memory:"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

current_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()

cursor.executescript(setup_sql)

print("--- DEMO: Customer Value Segmentation ---")
demo_sql = """
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
"""
for row in cursor.execute(demo_sql).fetchall():
    print(row)

print("\n--- TASK 1: Food Order Size Categorization ---")
task1_sql = """
SELECT 
    order_id,
    customer_name,
    total_amount,
    CASE 
        WHEN total_amount < 300 THEN 'Small'
        WHEN total_amount BETWEEN 300 AND 999 THEN 'Medium'
        ELSE 'Large'
    END AS order_size_category
FROM FoodOrders
ORDER BY total_amount DESC;
"""
for row in cursor.execute(task1_sql).fetchall():
    print(row)

print("\n--- TASK 2: Movie Popularity Classification ---")
task2_sql = """
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
"""
for row in cursor.execute(task2_sql).fetchall():
    print(row)

print("\n--- TASK 3: Flipkart Product Price Binning ---")
task3_sql = """
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
"""
for row in cursor.execute(task3_sql).fetchall():
    print(row)

print("\n--- TASK 4: Spotify Track Duration Labeling ---")
task4_sql = """
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
"""
for row in cursor.execute(task4_sql).fetchall():
    print(row)

conn.close()
print("\nSession 17 Verification Successful!")
