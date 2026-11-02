import sqlite3
import os

db_path = ":memory:"
conn = sqlite3.connect(db_path)

# Register CONCAT and RIGHT to support MySQL dialect directly
def sql_concat(*args):
    return "".join(str(a) if a is not None else "" for a in args)

def sql_right(string, n):
    if string is None:
        return None
    return str(string)[-int(n):]

conn.create_function("CONCAT", -1, sql_concat)
conn.create_function("RIGHT", 2, sql_right)

cursor = conn.cursor()
current_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()

cursor.executescript(setup_sql)

print("--- DEMO: Clean Inconsistent Product Codes ---")
demo_sql = """
SELECT 
    raw_id,
    raw_code,
    UPPER(TRIM(raw_code)) AS normalized_code,
    REPLACE(UPPER(TRIM(raw_code)), '-', '_') AS cleaned_standard_code
FROM dirty_product_codes;
"""
for row in cursor.execute(demo_sql).fetchall():
    print(row)

print("\n--- TASK 1: CONCAT(first_name, ' ', last_name) ---")
task1_sql = """
SELECT 
    user_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    email
FROM users;
"""
for row in cursor.execute(task1_sql).fetchall():
    print(row)

print("\n--- TASK 2: Song Titles in UPPER() ---")
task2_sql = """
SELECT 
    id,
    song_title,
    UPPER(song_title) AS song_title_upper,
    artist
FROM playlists;
"""
for row in cursor.execute(task2_sql).fetchall():
    print(row)

print("\n--- TASK 3: TRIM(item_code) Whitespace Removal ---")
task3_sql = """
SELECT 
    item_id,
    item_name,
    item_code AS raw_item_code,
    TRIM(item_code) AS cleaned_item_code
FROM food_items;
"""
for row in cursor.execute(task3_sql).fetchall():
    print(f"{row[0]} | {row[1]} | Raw: '{row[2]}' -> Cleaned: '{row[3]}'")

print("\n--- TASK 4: RIGHT(imdb_id, 7) Extract Numeric ID ---")
task4_sql = """
SELECT 
    movie_id,
    title,
    imdb_id,
    RIGHT(imdb_id, 7) AS movie_number
FROM movies;
"""
for row in cursor.execute(task4_sql).fetchall():
    print(row)

print("\n--- TASK 5: REPLACE(sku_code, '-', '_') ---")
task5_sql = """
SELECT 
    product_id,
    product_name,
    sku_code AS original_sku,
    REPLACE(sku_code, '-', '_') AS updated_sku_code
FROM products;
"""
for row in cursor.execute(task5_sql).fetchall():
    print(row)

conn.close()
print("\nSession 16 Verification Successful!")
