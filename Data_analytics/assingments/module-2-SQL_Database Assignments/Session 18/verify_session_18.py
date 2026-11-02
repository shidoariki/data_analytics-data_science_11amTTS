import sqlite3
import os

db_path = ":memory:"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

current_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()

cursor.executescript(setup_sql)

print("--- DEMO: Create View for Dashboard Reporting (Daily Sales) ---")
demo_view_sql = """
DROP VIEW IF EXISTS View_DailySalesDashboard;
CREATE VIEW View_DailySalesDashboard AS
SELECT 
    sale_date,
    COUNT(sale_id) AS total_transactions,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_ticket_size
FROM daily_sales
GROUP BY sale_date;
"""
cursor.executescript(demo_view_sql)
for row in cursor.execute("SELECT * FROM View_DailySalesDashboard ORDER BY sale_date ASC;").fetchall():
    print(row)

print("\n--- TASK 1: Create View TopRatedRestaurants (avg_rating > 4.0) ---")
task1_view_sql = """
DROP VIEW IF EXISTS TopRatedRestaurants;
CREATE VIEW TopRatedRestaurants AS
SELECT 
    r.restaurant_name,
    ROUND(AVG(rv.rating), 2) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
INNER JOIN restaurant_reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
HAVING AVG(rv.rating) > 4.0;
"""
cursor.executescript(task1_view_sql)
for row in cursor.execute("SELECT * FROM TopRatedRestaurants ORDER BY avg_rating DESC;").fetchall():
    print(row)

print("\n--- TASK 2: Update View to Include City Column ---")
task2_view_sql = """
DROP VIEW IF EXISTS TopRatedRestaurants;
CREATE VIEW TopRatedRestaurants AS
SELECT 
    r.restaurant_name,
    r.city,
    ROUND(AVG(rv.rating), 2) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
INNER JOIN restaurant_reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name, r.city
HAVING AVG(rv.rating) > 4.0;
"""
cursor.executescript(task2_view_sql)
for row in cursor.execute("SELECT * FROM TopRatedRestaurants ORDER BY avg_rating DESC;").fetchall():
    print(row)

print("\n--- TASK 3: Attempting UPDATE on Calculated View Column ---")
try:
    cursor.execute("UPDATE TopRatedRestaurants SET avg_rating = 5.0 WHERE restaurant_name = 'Truffles';")
except Exception as e:
    print(f"Captured Expected Error: {type(e).__name__}: {e}")

print("\n--- TASK 4: Create View DailyOrdersSummary (Last 30 Days) ---")
task4_view_sql = """
DROP VIEW IF EXISTS DailyOrdersSummary;
CREATE VIEW DailyOrdersSummary AS
SELECT 
    order_date,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM swiggy_orders
WHERE order_date >= date('2024-04-10', '-30 day')
GROUP BY order_date;
"""
cursor.executescript(task4_view_sql)
for row in cursor.execute("SELECT * FROM DailyOrdersSummary ORDER BY order_date ASC;").fetchall():
    print(row)

conn.close()
print("\nSession 18 Verification Successful!")
