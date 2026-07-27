import sqlite3 
import os

def get_connection():
    try:
        conn = sqlite3.connect('data/ecommerce.db')
        conn.row_factory = sqlite3.Row
        conn.execute("PRAGMA foreign_keys = ON;")
        return conn
    except sqlite3.Error as e:
        print(f"Error connecting to database: {e}")
        return None
    
def setup_database():
    CORE_TABLES = ["customers", "products", "orders", "order_items"]
    conn = get_connection()
    if conn:
        if os.path.exists('data/ecommerce.db'):
            os.remove('data/ecommerce.db')
            conn = get_connection()

        with open('data/ecommerce_setup.sql', 'r') as f: 
            sql=f.read()
            try:
                conn.executescript(sql)
                print("Database setup completed successfully.")
                conn.commit()
                try:
                    conn.execute("""alter table order_items add column revenue float""")
                except:
                    pass
                conn.execute("""update order_items set revenue = quantity * unit_price * (1-discount_pct/100.0)""")
                conn.commit()
            except sqlite3.Error as e:
                print(f"Error setting up database: {e}")
            finally:
                cursor = conn.cursor()
                for table in CORE_TABLES:
                    cursor.execute(f"SELECT count(*) FROM {table}")
                    count = cursor.fetchone()[0]
                    print(f"{table}: {count} rows")
                conn.close()
    
    

if __name__ == "__main__":
    get_connection()
    setup_database()
    

