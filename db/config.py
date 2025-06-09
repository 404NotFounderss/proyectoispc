import os
from dotenv import load_dotenv
import mysql.connector

load_dotenv() 

def connect():
    db_config = {
        'host': os.getenv('DB_HOST'),
        'user': os.getenv('DB_USER'),
        'password': os.getenv('DB_PASSWORD'),
        
    }
    return mysql.connector.connect(**db_config)
