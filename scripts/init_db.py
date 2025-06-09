import os
from db.config import connect

def run_sql_script(filename):
    with open(filename, "r", encoding="utf-8") as file:
        sql_script = file.read()
    
    conn = connect()
    cursor = conn.cursor()
    for statement in sql_script.split(';'):
        if statement.strip():
            cursor.execute(statement)
    conn.commit()
    conn.close()
    print(f"{filename} ejecutado correctamente.")

if __name__ == "__main__":
    run_sql_script("db/create_db.sql")
    run_sql_script("db/insert_sample_data.sql")
