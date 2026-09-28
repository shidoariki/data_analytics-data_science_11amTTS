"""
SESSION 2: Data & Databases (Structured vs Unstructured)
TASK 2: Parse JSON file of trending movies and print the title of each movie.
Student: Rushikesh
"""

import json
import os

# Define path to the JSON file
current_dir = os.path.dirname(os.path.abspath(__file__))
json_path = os.path.join(current_dir, 'trending_movies.json')

print("=" * 60)
print("TRENDING MOVIES LIST (PARSED FROM JSON)")
print("=" * 60)

# Load and parse the JSON file
with open(json_path, 'r', encoding='utf-8') as f:
    movies_data = json.load(f)

# Iterate through the list of movies and print each title
for idx, movie in enumerate(movies_data, start=1):
    title = movie.get('title')
    year = movie.get('release_year', 'N/A')
    rating = movie.get('rating', 'N/A')
    print(f"{idx:2d}. {title} ({year}) — Rating: {rating}/10")

print("=" * 60)
print(f"Total Movies Processed: {len(movies_data)}")
print("=" * 60)
