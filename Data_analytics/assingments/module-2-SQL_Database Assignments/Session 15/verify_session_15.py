import sqlite3
import os
from datetime import datetime, timedelta

db_path = ":memory:"
conn = sqlite3.connect(db_path)

# Register custom functions to allow standard MySQL syntax to run directly on SQLite
def sql_year(val):
    return int(val[:4])

def sql_month(val):
    return int(val[5:7])

def sql_day(val):
    return int(val[8:10])

def sql_now():
    return datetime.now().strftime('%Y-%m-%d %H:%M:%S')

def sql_datediff(d1, d2):
    dt1 = datetime.strptime(str(d1)[:10], '%Y-%m-%d')
    dt2 = datetime.strptime(str(d2)[:10], '%Y-%m-%d')
    return (dt1 - dt2).days

def sql_date_sub_2days(val):
    dt = datetime.strptime(str(val)[:10], '%Y-%m-%d')
    return (dt - timedelta(days=2)).strftime('%Y-%m-%d')

conn.create_function("YEAR", 1, sql_year)
conn.create_function("MONTH", 1, sql_month)
conn.create_function("DAY", 1, sql_day)
conn.create_function("NOW", 0, sql_now)
conn.create_function("CURRENT_DATE", 0, lambda: datetime.now().strftime('%Y-%m-%d'))
conn.create_function("DATEDIFF", 2, sql_datediff)
conn.create_function("DATE_SUB_2", 1, sql_date_sub_2days)

cursor = conn.cursor()
current_dir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()

cursor.executescript(setup_sql)

print("--- DEMO: Calculate Customer Churn Age (Days Since Last Visit) ---")
demo_sql = """
SELECT 
    customer_id,
    customer_name,
    last_visit_date,
    DATEDIFF('2024-04-10', last_visit_date) AS days_since_last_visit
FROM customer_visits
ORDER BY days_since_last_visit DESC;
"""
for row in cursor.execute(demo_sql).fetchall():
    print(row)

print("\n--- TASK 1: Current Date & Time Display with NOW() ---")
task1_sql = "SELECT NOW() AS CurrentDateTime;"
print(cursor.execute(task1_sql).fetchone())

print("\n--- TASK 2: Extract Year, Month, and Day ---")
task2_sql = """
SELECT 
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DAY(order_date) AS order_day
FROM Orders;
"""
for row in cursor.execute(task2_sql).fetchall():
    print(row)

print("\n--- TASK 3: Order Delivery Estimate (2 Days Before Delivery) ---")
task3_sqlite_native = """
SELECT 
    delivery_id,
    order_id,
    delivery_date,
    date(delivery_date, '-2 day') AS expected_pickup_date
FROM Deliveries;
"""
for row in cursor.execute(task3_sqlite_native).fetchall():
    print(row)

print("\n--- TASK 4: Subscription Duration with DATEDIFF(end_date, start_date) ---")
task4_sql = """
SELECT 
    user_id,
    start_date,
    end_date,
    DATEDIFF(end_date, start_date) AS total_subscription_days
FROM Subscriptions;
"""
for row in cursor.execute(task4_sql).fetchall():
    print(row)

print("\n--- TASK 5: Users Inactive > 30 Days (Relative to Benchmark '2024-04-10') ---")
task5_sql = """
SELECT 
    user_id,
    last_login_date
FROM AppLogins
WHERE DATEDIFF('2024-04-10', last_login_date) > 30;
"""
for row in cursor.execute(task5_sql).fetchall():
    print(row)

conn.close()
print("\nSession 15 Verification Successful!")
