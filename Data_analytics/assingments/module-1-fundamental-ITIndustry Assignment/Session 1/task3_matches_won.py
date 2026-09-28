"""
SESSION 1: What is Data Analytics? Overview of Industry Tools
TASK 3: Load IPL_2023_Matches.csv using pandas and display matches won by each team
Student: Rushikesh
"""

import pandas as pd
import os

# Define dataset path
csv_filename = "IPL_2023_Matches.csv"
current_dir = os.path.dirname(os.path.abspath(__file__))
csv_path = os.path.join(current_dir, csv_filename)

print("=" * 65)
print("IPL 2023 - MATCHES WON BY EACH TEAM (PANDAS ANALYSIS)")
print("=" * 65)

# 1. Load the dataset into a pandas DataFrame
df = pd.read_csv(csv_path)
print(f"Successfully loaded dataset with {len(df)} match records.\n")

# 2. Compute the number of matches won by each team
matches_won = df['winner'].value_counts().reset_index()
matches_won.columns = ['Team Name', 'Matches Won']

# 3. Display the formatted results
print(matches_won.to_string(index=False))

print("\n" + "=" * 65)
top_team = matches_won.iloc[0]['Team Name']
top_wins = matches_won.iloc[0]['Matches Won']
print(f"Top Performing Team: {top_team} with {top_wins} victories!")
print("=" * 65)
