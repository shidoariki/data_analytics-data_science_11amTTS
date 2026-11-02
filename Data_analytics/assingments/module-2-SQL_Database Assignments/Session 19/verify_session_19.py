import sqlite3
import os
import time
import random
from datetime import datetime, timedelta

db_path = ":memory:"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

current_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()

cursor.executescript(setup_sql)

# Populate 15,000 orders
print("Populating 15,000 rows into orders table...")
base_date = datetime(2023, 1, 1)
statuses = ['DELIVERED', 'SHIPPED', 'CANCELLED', 'RETURNED']
data = []
target_user = 250

for i in range(1, 15001):
    # distribute users across 1..1000, with user 250 having several orders
    uid = target_user if (i % 300 == 0) else random.randint(1, 1000)
    dt = (base_date + timedelta(days=random.randint(0, 450))).strftime('%Y-%m-%d')
    amt = round(random.uniform(100.0, 5000.0), 2)
    st = random.choice(statuses)
    data.append((i, uid, dt, amt, st))

cursor.executemany("INSERT INTO orders VALUES (?, ?, ?, ?, ?)", data)
conn.commit()
print("Orders populated successfully.")

print("\n--- TASK 1 & TASK 3: Query Execution BEFORE Index & EXPLAIN Plan ---")
explain_before = cursor.execute(f"EXPLAIN QUERY PLAN SELECT * FROM orders WHERE user_id = {target_user};").fetchall()
print(f"EXPLAIN QUERY PLAN before index: {explain_before}")

# Timing before index (repeat 200 times for accurate microsecond benchmarking)
start_time = time.perf_counter()
for _ in range(200):
    res_before = cursor.execute(f"SELECT * FROM orders WHERE user_id = {target_user};").fetchall()
elapsed_before = (time.perf_counter() - start_time) / 200

print(f"Rows found for user {target_user}: {len(res_before)}")
print(f"Average execution time BEFORE index: {elapsed_before * 1000:.4f} ms")

print("\n--- TASK 2 & TASK 3: Create Index & Query Execution AFTER Index ---")
cursor.execute("CREATE INDEX idx_orders_user_id ON orders(user_id);")
conn.commit()

explain_after = cursor.execute(f"EXPLAIN QUERY PLAN SELECT * FROM orders WHERE user_id = {target_user};").fetchall()
print(f"EXPLAIN QUERY PLAN after index: {explain_after}")

start_time = time.perf_counter()
for _ in range(200):
    res_after = cursor.execute(f"SELECT * FROM orders WHERE user_id = {target_user};").fetchall()
elapsed_after = (time.perf_counter() - start_time) / 200

print(f"Average execution time AFTER index: {elapsed_after * 1000:.4f} ms")
speedup = elapsed_before / elapsed_after if elapsed_after > 0 else 1.0
print(f"Performance Speedup: {speedup:.2f}x faster!")

print("\n--- TASK 4: Index on Products(category) to Avoid Full Table Scan ---")
cursor.execute("CREATE INDEX idx_products_category ON products(category);")
conn.commit()

explain_prod = cursor.execute("EXPLAIN QUERY PLAN SELECT * FROM products WHERE category = 'Electronics';").fetchall()
print(f"EXPLAIN QUERY PLAN on products: {explain_prod}")
prod_res = cursor.execute("SELECT product_id, product_name, category, price FROM products WHERE category = 'Electronics';").fetchall()
for p in prod_res:
    print(p)

print("\n--- TASK 5: Covering Index Demonstration ---")
cursor.execute("CREATE INDEX idx_orders_covering ON orders(user_id, order_date, total_amount);")
conn.commit()
explain_covering = cursor.execute(f"EXPLAIN QUERY PLAN SELECT order_date, total_amount FROM orders WHERE user_id = {target_user};").fetchall()
print(f"EXPLAIN QUERY PLAN with Covering Index: {explain_covering}")

conn.close()
print("\nSession 19 Verification Successful!")
