import sqlite3
import pandas as pd
import os

def run_session_12():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_12.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Sales YoY Growth using CTE": """
            WITH SalesCTE AS (
                SELECT s1.sale_year, s1.total_revenue, s2.total_revenue AS prev_year_revenue 
                FROM annual_sales s1 
                LEFT JOIN annual_sales s2 ON s1.sale_year = s2.sale_year + 1
            ) 
            SELECT sale_year, total_revenue, prev_year_revenue, 
                   ROUND(100.0 * (total_revenue - prev_year_revenue) / prev_year_revenue, 2) AS yoy_growth_pct 
            FROM SalesCTE 
            ORDER BY sale_year;
        """,
        "TASK 1: Top 3 Most Followed Artists (TopArtists CTE)": """
            WITH TopArtists AS (
                SELECT artist_id, name, followers 
                FROM SpotifyArtists 
                ORDER BY followers DESC 
                LIMIT 3
            ) 
            SELECT * FROM TopArtists;
        """,
        "TASK 2: Highest Sales Month in 2023 (MonthlyTotals CTE)": """
            WITH MonthlyTotals AS (
                SELECT strftime('%m', order_date) AS order_month, SUM(total_amount) AS total_sales 
                FROM FlipkartOrders 
                WHERE strftime('%Y', order_date) = '2023' 
                GROUP BY strftime('%m', order_date)
            ) 
            SELECT order_month, total_sales 
            FROM MonthlyTotals 
            ORDER BY total_sales DESC 
            LIMIT 1;
        """,
        "TASK 3: Next 7 Calendar Days (Recursive CTE)": """
            WITH RECURSIVE CalendarDays(day_date, day_num) AS (
                SELECT CURRENT_DATE, 1 
                UNION ALL 
                SELECT DATE(day_date, '+1 day'), day_num + 1 
                FROM CalendarDays 
                WHERE day_num < 7
            ) 
            SELECT day_num, day_date FROM CalendarDays;
        """,
        "TASK 4: Restaurants in Cities with Avg Rating > 4.0": """
            WITH CityAvgRatings AS (
                SELECT city, ROUND(AVG(rating), 2) AS city_avg_rating 
                FROM ZomatoRestaurants 
                GROUP BY city 
                HAVING AVG(rating) > 4.0
            ) 
            SELECT r.id, r.name, r.city, r.rating, c.city_avg_rating 
            FROM ZomatoRestaurants r 
            INNER JOIN CityAvgRatings c ON r.city = c.city 
            ORDER BY c.city_avg_rating DESC, r.rating DESC;
        """,
        "TASK 5: IPL 2023 Teams with > 2000 Runs (CTE)": """
            WITH TeamRuns2023 AS (
                SELECT team, SUM(runs) AS total_runs 
                FROM IPLMatches 
                WHERE match_year = 2023 
                GROUP BY team
            ) 
            SELECT team, total_runs 
            FROM TeamRuns2023 
            WHERE total_runs > 2000 
            ORDER BY total_runs DESC;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_12()
