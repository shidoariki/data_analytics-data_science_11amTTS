import sqlite3
import pandas as pd
import os

def run_session_6():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_6.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO 1: Total Revenue (SUM)": "SELECT SUM(revenue) AS total_revenue FROM demo_sales;",
        "DEMO 2: Average Salary (AVG)": "SELECT ROUND(AVG(salary), 2) AS average_salary FROM demo_employees;",
        "DEMO 3: Highest Order Value (MAX)": "SELECT MAX(order_value) AS highest_order_value FROM demo_orders;",
        "TASK 1: Total Food Spending (SUM)": "SELECT SUM(amount) AS total_food_spending FROM food_orders;",
        "TASK 2: User Playlist Song Count (COUNT)": "SELECT user_id, COUNT(song_id) AS total_songs FROM spotify_playlists WHERE user_id = 101 GROUP BY user_id;",
        "TASK 3: Movie Avg Rating Rounded (AVG + ROUND)": "SELECT movie_id, ROUND(AVG(rating), 1) AS average_rating FROM bookmyshow_reviews WHERE movie_id = 201 GROUP BY movie_id;",
        "TASK 4: Min and Max Transaction Values (MIN + MAX)": "SELECT user_id, MIN(amount) AS smallest_amount, MAX(amount) AS largest_amount FROM paytm_transactions WHERE user_id = 101 GROUP BY user_id;",
        "TASK 5: Myntra User Order Aggregations (GROUP BY)": """
            SELECT user_id, COUNT(order_id) AS total_orders, ROUND(AVG(total_price), 2) AS average_order_value, MAX(total_price) AS highest_order_value 
            FROM myntra_orders 
            GROUP BY user_id 
            ORDER BY user_id ASC;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_6()
