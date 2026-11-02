import sqlite3
import pandas as pd
import os

def run_session_5():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_5.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Top 10 Highest Selling Products": """
            SELECT product_id, product_name, category, units_sold, revenue 
            FROM products_catalog 
            ORDER BY units_sold DESC 
            LIMIT 10;
        """,
        "TASK 1: Unique Payment Methods (DISTINCT)": """
            SELECT DISTINCT payment_method 
            FROM orders;
        """,
        "TASK 2: Unique Cities Sorted Alphabetically (A-Z)": """
            SELECT DISTINCT city 
            FROM users 
            ORDER BY city ASC;
        """,
        "TASK 3: Top 5 Most Recent Movie Bookings": """
            SELECT booking_id, user_id, movie_name, theater_name, tickets_count, booking_date 
            FROM bookings 
            ORDER BY booking_date DESC 
            LIMIT 5;
        """,
        "TASK 4: Top 10 Products by sold_count": """
            SELECT name, sold_count 
            FROM products 
            ORDER BY sold_count DESC 
            LIMIT 10;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_5()
