import sqlite3
import os
import pandas as pd

current_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(current_dir, "session_20_ipl.db")
csv_path = os.path.join(current_dir, "ipl_matches.csv")
mi_csv_path = os.path.join(current_dir, "mi_matches.csv")
excel_path = os.path.join(current_dir, "ipl_matches_pivot.xlsx")

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# TASK 1: Load sample CSV into SQL table ipl_matches
df_matches = pd.read_csv(csv_path)
df_matches.to_sql("ipl_matches", conn, if_exists="replace", index=False)
print("--- TASK 1: Loaded ipl_matches into SQLite/MySQL ---")
print(f"Total rows loaded: {len(df_matches)}")

# TASK 2: Export Mumbai Indians matches to CSV (mi_matches.csv)
mi_query = """
SELECT * FROM ipl_matches 
WHERE team1 = 'Mumbai Indians' OR team2 = 'Mumbai Indians'
ORDER BY date ASC;
"""
df_mi = pd.read_sql(mi_query, conn)
df_mi.to_csv(mi_csv_path, index=False)
print(f"\n--- TASK 2: Exported {len(df_mi)} matches to mi_matches.csv ---")
print(df_mi[["match_id", "date", "team1", "team2", "winner"]])

# TASK 3: Excel Connection - Total Matches Played Per Team
task3_query = """
WITH AllTeams AS (
    SELECT team1 AS team FROM ipl_matches
    UNION ALL
    SELECT team2 AS team FROM ipl_matches
)
SELECT 
    team,
    COUNT(*) AS total_matches_played
FROM AllTeams
GROUP BY team
ORDER BY total_matches_played DESC;
"""
df_team_matches = pd.read_sql(task3_query, conn)
print("\n--- TASK 3: Total Matches Played Per Team (Excel Table) ---")
print(df_team_matches)

# Export to Excel to simulate Excel workbook connection & Pivot
with pd.ExcelWriter(excel_path) as writer:
    df_matches.to_excel(writer, sheet_name="Raw_IPL_Matches", index=False)
    df_team_matches.to_excel(writer, sheet_name="Matches_Per_Team_Pivot", index=False)
print(f"Created Excel Workbook: {excel_path}")

# TASK 4: Power BI Connection - Wins Per Team
task4_query = """
SELECT 
    winner AS team,
    COUNT(match_id) AS total_wins
FROM ipl_matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY total_wins DESC;
"""
df_wins = pd.read_sql(task4_query, conn)
print("\n--- TASK 4: Total Wins Per Team (Power BI Chart Source) ---")
print(df_wins)

conn.close()

# TASK 5: Run task5_pandas_sqlalchemy.py
print("\n--- Running Task 5 Script ---")
os.system(f'python "{os.path.join(current_dir, "task5_pandas_sqlalchemy.py")}"')

print("\nSession 20 Verification Successful!")
