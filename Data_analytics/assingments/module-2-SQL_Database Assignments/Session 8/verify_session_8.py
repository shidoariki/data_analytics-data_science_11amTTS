import sqlite3
import pandas as pd
import os

def run_session_8():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_8.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Orders + Users + CustomerSegments -> Segment Revenue": """
            SELECT cs.segment_name, COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.amount), 0) AS total_revenue 
            FROM CustomerSegments cs 
            LEFT JOIN Users u ON cs.segment_id = u.segment_id 
            LEFT JOIN Orders o ON u.user_id = o.user_id 
            GROUP BY cs.segment_id, cs.segment_name 
            ORDER BY total_revenue DESC;
        """,
        "TASK 1A: Inspect Users Table": "SELECT * FROM Users;",
        "TASK 1B: Inspect Orders Table": "SELECT * FROM Orders;",
        "TASK 2: INNER JOIN (Only Users with Orders)": """
            SELECT u.username, o.product, o.amount 
            FROM Users u 
            INNER JOIN Orders o ON u.user_id = o.user_id;
        """,
        "TASK 3: LEFT JOIN (All Users, NULL if No Order)": """
            SELECT u.username, u.city, o.product, o.amount 
            FROM Users u 
            LEFT JOIN Orders o ON u.user_id = o.user_id;
        """,
        "TASK 4: RIGHT JOIN (All Orders, NULL if User Deleted/Unmatched)": """
            SELECT o.order_id, o.product, o.amount, u.username 
            FROM Users u 
            RIGHT JOIN Orders o ON u.user_id = o.user_id;
        """,
        "TASK 5: Multi-table Join (User + Segment + Total Spend)": """
            SELECT u.username, cs.segment_name, COALESCE(SUM(o.amount), 0.00) AS total_order_amount 
            FROM Users u 
            LEFT JOIN CustomerSegments cs ON u.segment_id = cs.segment_id 
            LEFT JOIN Orders o ON u.user_id = o.user_id 
            GROUP BY u.user_id, u.username, cs.segment_name 
            ORDER BY total_order_amount DESC;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_8()
