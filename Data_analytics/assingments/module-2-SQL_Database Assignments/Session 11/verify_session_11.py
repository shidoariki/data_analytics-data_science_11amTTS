import sqlite3
import pandas as pd
import os

def run_session_11():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_11.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Employees Earning Above Average Salary": """
            SELECT id, name, department, salary 
            FROM employees 
            WHERE salary > (SELECT AVG(salary) FROM employees) 
            ORDER BY salary DESC;
        """,
        "TASK 1: Restaurants with Rating > Average": """
            SELECT name, rating 
            FROM Restaurants 
            WHERE rating > (SELECT AVG(rating) FROM Restaurants) 
            ORDER BY rating DESC;
        """,
        "TASK 2: Products with Category Average Price (Scalar Subquery in SELECT)": """
            SELECT p.name AS product_name, p.category, p.price, 
                   ROUND((SELECT AVG(p2.price) FROM Products p2 WHERE p2.category = p.category), 2) AS category_avg_price 
            FROM Products p 
            ORDER BY p.category, p.price DESC;
        """,
        "TASK 3: Users with More Playlists than Average (Subquery in FROM & WHERE)": """
            SELECT u.username, user_counts.playlist_count 
            FROM Users u 
            INNER JOIN (
                SELECT user_id, COUNT(playlist_id) AS playlist_count 
                FROM Playlists 
                GROUP BY user_id
            ) user_counts ON u.user_id = user_counts.user_id 
            WHERE user_counts.playlist_count > (
                SELECT AVG(sub.p_count) 
                FROM (SELECT COUNT(playlist_id) AS p_count FROM Playlists GROUP BY user_id) sub
            ) 
            ORDER BY user_counts.playlist_count DESC;
        """,
        "TASK 4: Users with Orders Above Average Amount": """
            SELECT DISTINCT user_id 
            FROM Orders 
            WHERE total_amount > (SELECT AVG(total_amount) FROM Orders) 
            ORDER BY user_id;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_11()
