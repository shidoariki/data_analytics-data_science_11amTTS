import sqlite3
import os
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(current_dir, "session_22_analytics.db")

conn = sqlite3.connect(db_path)

print("--- Verifying Session 22 Artifacts & Queries ---")

# Check restaurants table
df_rest = pd.read_sql("SELECT COUNT(*) as count FROM restaurants", conn)
print(f"Restaurants table row count: {df_rest['count'].iloc[0]}")

# Check movies table
df_movies = pd.read_sql("SELECT COUNT(*) as count FROM movies WHERE rating > 8.0", conn)
print(f"Movies rated > 8.0 count: {df_movies['count'].iloc[0]}")

# Check orders table
df_orders = pd.read_sql("SELECT COUNT(*) as count FROM orders", conn)
print(f"Orders table row count: {df_orders['count'].iloc[0]}")

# Check matches table
df_matches = pd.read_sql("SELECT COUNT(*) as count FROM matches", conn)
print(f"Matches table row count: {df_matches['count'].iloc[0]}")

# Check chart file existence
chart_file = os.path.join(current_dir, "ipl_matches_per_team.png")
print(f"Chart file exists: {os.path.exists(chart_file)}")

# Check notebook file existence
nb_file = os.path.join(current_dir, "session_22_notebook.ipynb")
print(f"Jupyter Notebook exists: {os.path.exists(nb_file)}")

conn.close()
print("\nSession 22 Verification Successful!")
