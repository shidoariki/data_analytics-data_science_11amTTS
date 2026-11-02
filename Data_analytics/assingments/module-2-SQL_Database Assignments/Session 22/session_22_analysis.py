import sqlite3
import os
import pandas as pd
import matplotlib.pyplot as plt
import random

current_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(current_dir, "session_22_analytics.db")

# 1. Initialize SQLite Database from setup_tables.sql
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()
cursor.executescript(setup_sql)

# Populate 120 orders with realistic items and dates
items = [
    ("Chicken Biryani", 320.0),
    ("Veg Whopper Burger", 180.0),
    ("Paneer Butter Masala", 280.0),
    ("Margherita Pizza", 399.0),
    ("Butter Naan", 45.0),
    ("Cold Coffee", 120.0),
    ("Gulab Jamun", 90.0)
]
orders_data = []
for i in range(1, 121):
    u_id = random.randint(1, 5)
    item, price = random.choices(items, weights=[30, 25, 15, 20, 10, 8, 5])[0]
    dt = f"2024-04-{(i % 28) + 1:02d}"
    orders_data.append((i, u_id, item, price, dt))

cursor.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?)", orders_data)
conn.commit()
print("Initialized session_22_analytics.db with 120 orders.\n")

# TASK 1: pandas read_sql() to load restaurants table & display first 5 rows
print("--- TASK 1: Load restaurants into DataFrame & display first 5 rows ---")
df_restaurants = pd.read_sql("SELECT name, cuisine, rating FROM restaurants", conn)
print(df_restaurants.head())

# TASK 2: Movies with rating above 8
print("\n--- TASK 2: Movies with rating > 8.0 (Demonstrating %sql / Query Result) ---")
df_top_movies = pd.read_sql("SELECT movie_id, title, genre, rating FROM movies WHERE rating > 8.0 ORDER BY rating DESC", conn)
print(df_top_movies)

# TASK 3: Combine SQL and Python - Last 100 orders & Top 3 most ordered items
print("\n--- TASK 3: Last 100 Orders & Top 3 Most Ordered Food Items ---")
df_last_100_orders = pd.read_sql("SELECT * FROM orders ORDER BY order_id DESC LIMIT 100", conn)
print(f"Loaded {len(df_last_100_orders)} orders into pandas.")
top_3_items = df_last_100_orders['item_name'].value_counts().head(3)
print("\nTop 3 Most Ordered Food Items (via DataFrame value_counts):")
print(top_3_items)

# TASK 4: IPL Match Data - Bar Chart of matches played per team
print("\n--- TASK 4: Matches Played Per Team Bar Chart via pandas & matplotlib ---")
df_matches = pd.read_sql("SELECT * FROM matches", conn)
all_teams_series = pd.concat([df_matches['team1'], df_matches['team2']])
matches_per_team = all_teams_series.value_counts().reset_index()
matches_per_team.columns = ['Team', 'Matches_Played']
print(matches_per_team)

plt.figure(figsize=(10, 6))
plt.bar(matches_per_team['Team'], matches_per_team['Matches_Played'], color='#2563EB', edgecolor='#1E3A8A')
plt.title('IPL 2023: Total Matches Played per Team', fontsize=14, fontweight='bold')
plt.xlabel('Team Name', fontsize=12)
plt.ylabel('Matches Played', fontsize=12)
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
chart_path = os.path.join(current_dir, "ipl_matches_per_team.png")
plt.savefig(chart_path, dpi=300)
plt.close()
print(f"Saved chart to: {chart_path}")

# TASK 5: AI-Assisted Query - Users who have placed more than 5 orders
print("\n--- TASK 5: Users with More Than 5 Orders (via pandas & SQL join) ---")
ai_query = """
SELECT 
    u.user_id,
    u.user_name,
    u.city,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.amount), 2) AS total_spend
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name, u.city
HAVING COUNT(o.order_id) > 5
ORDER BY total_orders DESC;
"""
df_active_users = pd.read_sql(ai_query, conn)
print(df_active_users)

conn.close()
print("\nSession 22 Analysis Completed Successfully!")
