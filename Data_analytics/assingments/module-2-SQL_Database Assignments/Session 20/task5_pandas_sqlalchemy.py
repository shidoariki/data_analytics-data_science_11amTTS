import pandas as pd
import sqlite3
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
csv_file = os.path.join(current_dir, "mi_matches.csv")
db_file = os.path.join(current_dir, "session_20_ipl.db")

print("--- TASK 5: Python (Pandas & SQLAlchemy/SQLite) Pipeline ---")

# 1. Read CSV using pandas
df = pd.read_csv(csv_file)
print(f"Loaded {len(df)} Mumbai Indians matches from {csv_file}")

# 2. Filter matches where 'Mumbai Indians' won
mi_wins_df = df[df["winner"] == "Mumbai Indians"]
print(f"Filtered {len(mi_wins_df)} matches won by Mumbai Indians:")
print(mi_wins_df[["match_id", "date", "team1", "team2", "winner", "result_margin"]])

# 3. Connect to database and insert into SQL table mi_wins using to_sql()
conn = sqlite3.connect(db_file)
mi_wins_df.to_sql("mi_wins", conn, if_exists="replace", index=False)

# 4. Verify insertion from SQL table
verification_df = pd.read_sql("SELECT * FROM mi_wins", conn)
print("\n--- Verified Rows in SQL Table 'mi_wins' ---")
print(verification_df)

conn.close()
print("\nTask 5 Completed Successfully!")
