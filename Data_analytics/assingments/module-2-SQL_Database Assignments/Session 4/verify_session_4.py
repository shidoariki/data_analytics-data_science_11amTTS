import sqlite3
import pandas as pd
import os

def run_session_4():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_4.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Customers starting with 'M%'": """
            SELECT customer_id, customer_name, email, city 
            FROM customers 
            WHERE customer_name LIKE 'M%';
        """,
        "TASK 1: Restaurants ending with '%Cafe'": """
            SELECT restaurant_id, name, cuisine, city, rating 
            FROM Restaurants 
            WHERE name LIKE '%Cafe';
        """,
        "TASK 2: Products with price BETWEEN 500 AND 1500": """
            SELECT product_id, product_name, category, price, stock 
            FROM Products 
            WHERE price BETWEEN 500 AND 1500;
        """,
        "TASK 3: Users in ('Ahmedabad', 'Surat', 'Vadodara')": """
            SELECT user_id, username, email, city, signup_date 
            FROM Users 
            WHERE city IN ('Ahmedabad', 'Surat', 'Vadodara');
        """,
        "TASK 4: Songs where artist_name LIKE '%ar%'": """
            SELECT song_id, song_name, artist_name, album, duration_sec 
            FROM Songs 
            WHERE artist_name LIKE '%ar%';
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_4()
