"""
SESSION 4: Data Analytics Workflow
TASK 4: Transform raw Zomato order data into user spend summary table
Student: Rushikesh
"""

import pandas as pd

# Raw input order tuples
raw_orders = [
    {"user": "A", "item": "Pizza", "price": 300},
    {"user": "B", "item": "Burger", "price": 150},
    {"user": "A", "item": "Burger", "price": 150}
]

df_raw = pd.DataFrame(raw_orders)

print("=" * 65)
print("TASK 4: ZOMATO ORDER DATA TRANSFORMATION")
print("=" * 65)
print("\n[INPUT] Raw Order Transactions:")
print(df_raw.to_string(index=False))

# Transformation: Group by user and aggregate total spend, order count, and item list
summary_table = df_raw.groupby('user').agg(
    total_spend=('price', 'sum'),
    order_count=('item', 'count'),
    items_ordered=('item', lambda x: ', '.join(x))
).reset_index()

summary_table.columns = ['User', 'Total Spend (INR)', 'Total Orders', 'Items Ordered']

print("\n" + "-" * 65)
print("[OUTPUT] Transformed User Spend Summary Table:")
print(summary_table.to_string(index=False))
print("=" * 65)
