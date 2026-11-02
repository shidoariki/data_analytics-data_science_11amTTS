import sqlite3
import pandas as pd
import os

def run_session_10():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    db_path = os.path.join(base_dir, "session_10.db")
    setup_file = os.path.join(base_dir, "setup_tables.sql")

    conn = sqlite3.connect(db_path)
    c = conn.cursor()
    
    with open(setup_file, "r") as f:
        setup_script = f.read()
    c.executescript(setup_script)
    conn.commit()
    print("Setup completed successfully.")

    queries = {
        "DEMO: Online + Offline Sales (UNION ALL)": """
            SELECT sale_id, customer_name, amount, sale_date, 'Online' AS channel FROM online_sales 
            UNION ALL 
            SELECT sale_id, customer_name, amount, sale_date, 'Offline' AS channel FROM offline_sales 
            ORDER BY sale_date;
        """,
        "TASK 1A: AppOrders Records": "SELECT * FROM AppOrders;",
        "TASK 1B: InStoreOrders Records": "SELECT * FROM InStoreOrders;",
        "TASK 2: Unique Customers (UNION)": """
            SELECT customer_name FROM AppOrders 
            UNION 
            SELECT customer_name FROM InStoreOrders 
            ORDER BY customer_name;
        """,
        "TASK 3: All Orders (UNION ALL)": """
            SELECT order_id, customer_name, amount, order_date, 'App Order' AS order_source FROM AppOrders 
            UNION ALL 
            SELECT order_id, customer_name, amount, order_date, 'In-Store' AS order_source FROM InStoreOrders 
            ORDER BY order_date;
        """,
        "TASK 4A: UNION Customer Count": """
            SELECT customer_name FROM AppOrders 
            UNION 
            SELECT customer_name FROM InStoreOrders;
        """,
        "TASK 4B: UNION ALL Customer Count": """
            SELECT customer_name FROM AppOrders 
            UNION ALL 
            SELECT customer_name FROM InStoreOrders;
        """
    }

    for name, sql in queries.items():
        print(f"\n==================== {name} ====================")
        df = pd.read_sql_query(sql, conn)
        print(df.to_markdown(index=False))
        print(f"Total Rows Returned: {len(df)}")

    conn.close()

if __name__ == "__main__":
    run_session_10()
