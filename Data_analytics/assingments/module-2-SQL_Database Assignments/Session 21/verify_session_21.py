import sqlite3
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(current_dir, "session_21_restaurants.db")

# First run generator to create DB and Excel
os.system(f'python "{os.path.join(current_dir, "generate_excel_dashboard.py")}"')

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

print("\n--- TASK 1: Power Query Initial Load ---")
t1_rows = cursor.execute("SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants LIMIT 5").fetchall()
for r in t1_rows:
    print(r)

print("\n--- TASK 2: Parameterized Filter by Cuisine ('South Indian') ---")
cuisine_param = 'South Indian'
t2_rows = cursor.execute("SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants WHERE cuisine = ? ORDER BY rating DESC", (cuisine_param,)).fetchall()
for r in t2_rows:
    print(r)

print("\n--- TASK 2: Parameterized Filter by Cuisine ('Chinese') ---")
cuisine_param = 'Chinese'
t2_chinese = cursor.execute("SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants WHERE cuisine = ? ORDER BY rating DESC", (cuisine_param,)).fetchall()
for r in t2_chinese:
    print(r)

print("\n--- TASK 3: Dynamic Refresh Simulation (Inserting New Record & Re-querying) ---")
cursor.execute("INSERT INTO Restaurants VALUES (16, 'New Paradise Biryani', 'Biryani', 4.7, 500, 'Bangalore')")
conn.commit()
refreshed_count = cursor.execute("SELECT COUNT(*) FROM Restaurants").fetchone()[0]
print(f"Total restaurants after live insertion: {refreshed_count}")

print("\n--- TASK 4: High Rated Restaurants (Rating > 4.0) ---")
t4_rows = cursor.execute("SELECT name, cuisine, rating FROM Restaurants WHERE rating > 4.0 ORDER BY rating DESC").fetchall()
for r in t4_rows:
    print(r)

print("\n--- TASK 5: AI-Assisted Parameterized Range (Rating BETWEEN 3.5 AND 5.0) ---")
min_r, max_r = 3.5, 5.0
t5_rows = cursor.execute("SELECT name, cuisine, rating FROM Restaurants WHERE rating BETWEEN ? AND ? ORDER BY rating DESC", (min_r, max_r)).fetchall()
for r in t5_rows:
    print(r)

conn.close()
print("\nSession 21 Verification Successful!")
