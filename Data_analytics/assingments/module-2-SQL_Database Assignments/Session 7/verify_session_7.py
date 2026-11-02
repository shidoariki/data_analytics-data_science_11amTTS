import sqlite3
import pandas as pd
import os

def run_session_7():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_7.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Regional Revenue > 1M (HAVING)": """
            SELECT region, SUM(revenue) AS total_revenue 
            FROM regional_sales 
            GROUP BY region 
            HAVING SUM(revenue) > 1000000 
            ORDER BY total_revenue DESC;
        """,
        "TASK 1: Total Orders Placed by Each User": """
            SELECT user_id, COUNT(order_id) AS total_orders 
            FROM food_orders 
            GROUP BY user_id 
            ORDER BY total_orders DESC;
        """,
        "TASK 2: Total Spent by Payment Method": """
            SELECT payment_method, SUM(amount) AS total_amount_spent 
            FROM transactions 
            GROUP BY payment_method 
            ORDER BY total_amount_spent DESC;
        """,
        "TASK 3: Genres with Box Office Collection > 10 Crore": """
            SELECT genre, SUM(box_office_collection) AS total_box_office_collection 
            FROM movies 
            GROUP BY genre 
            HAVING SUM(box_office_collection) > 100000000 
            ORDER BY total_box_office_collection DESC;
        """,
        "TASK 4: Users with Playlist Duration > 2 Hours (7200s)": """
            SELECT user_id, SUM(duration) AS total_duration_seconds 
            FROM playlist 
            GROUP BY user_id 
            HAVING SUM(duration) > 7200 
            ORDER BY total_duration_seconds DESC;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_7()
