import sqlite3
import pandas as pd
import os

def run_session_9():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_9.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Self Join Employees -> Manager": """
            SELECT e.id AS emp_id, e.name AS employee_name, e.department, COALESCE(m.name, 'Top Executive / None') AS manager_name 
            FROM employees e 
            LEFT JOIN employees m ON e.manager_id = m.id;
        """,
        "TASK 1: FULL OUTER JOIN Influencers & Brands (via UNION)": """
            SELECT i.influencer_name, b.brand_name, COALESCE(i.city, b.city) AS city 
            FROM influencers i 
            LEFT JOIN brands b ON i.city = b.city 
            UNION 
            SELECT i.influencer_name, b.brand_name, COALESCE(i.city, b.city) AS city 
            FROM brands b 
            LEFT JOIN influencers i ON b.city = i.city;
        """,
        "TASK 2: SELF JOIN Playlists (Nested Hierarchy)": """
            SELECT p.id AS playlist_id, p.playlist_name, COALESCE(parent.playlist_name, '[Top-Level]') AS parent_playlist_name 
            FROM playlists p 
            LEFT JOIN playlists parent ON p.parent_playlist_id = parent.id;
        """,
        "TASK 3: CROSS JOIN Users x Offers": """
            SELECT u.user_name, o.offer_title, o.discount_pct 
            FROM users u 
            CROSS JOIN offers o 
            ORDER BY u.user_name;
        """,
        "TASK 4A: Employees with Managers": """
            SELECT e.name AS employee_name, m.name AS manager_name 
            FROM employees e 
            INNER JOIN employees m ON e.manager_id = m.id;
        """,
        "TASK 4B: Top-Level Managers (No Manager)": """
            SELECT e.id, e.name, e.department, 'Top-Level Manager' AS role 
            FROM employees e 
            WHERE e.manager_id IS NULL;
        """,
        "TASK 5: Users in Same City (Excluding Self & Duplicates)": """
            SELECT u1.user_name AS user_1, u2.user_name AS user_2, u1.city 
            FROM users u1 
            INNER JOIN users u2 ON u1.city = u2.city AND u1.user_id < u2.user_id 
            ORDER BY u1.city, user_1;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_9()
