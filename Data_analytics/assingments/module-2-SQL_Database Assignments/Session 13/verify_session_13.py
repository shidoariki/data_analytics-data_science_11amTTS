import sqlite3
import pandas as pd
import os

def run_session_13():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_13.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Employee Salary vs Department Average": """
            SELECT id, name, department, salary, 
                   ROUND(AVG(salary) OVER(PARTITION BY department), 2) AS dept_avg_salary, 
                   ROUND(salary - AVG(salary) OVER(PARTITION BY department), 2) AS diff_from_dept_avg 
            FROM employees 
            ORDER BY department, salary DESC;
        """,
        "TASK 1: Order Amount with Grand Total (OVER())": """
            SELECT order_id, user_id, app_name, order_amount, 
                   SUM(order_amount) OVER() AS grand_total_amount 
            FROM Orders 
            ORDER BY order_id;
        """,
        "TASK 2: User Order with User Average (OVER(PARTITION BY user_id))": """
            SELECT user_id, order_id, app_name, order_amount, 
                   ROUND(AVG(order_amount) OVER(PARTITION BY user_id), 2) AS user_avg_order_amount 
            FROM Orders 
            ORDER BY user_id, order_id;
        """,
        "TASK 3: Song Duration and User Total (SUM() OVER(PARTITION BY user_id))": """
            SELECT user_id, song_id, duration_sec, 
                   SUM(duration_sec) OVER(PARTITION BY user_id) AS total_user_duration_sec 
            FROM Playlist 
            ORDER BY user_id, song_id;
        """,
        "TASK 4: Movie Ratings with Movie Average & Differential": """
            SELECT rating_id, user_id, movie_name, rating, 
                   ROUND(AVG(rating) OVER(PARTITION BY movie_name), 2) AS movie_avg_rating, 
                   ROUND(rating - AVG(rating) OVER(PARTITION BY movie_name), 2) AS rating_diff_from_avg 
            FROM MovieRatings 
            ORDER BY movie_name, rating_id;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_13()
