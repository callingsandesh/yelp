
import psycopg2

import os

from dotenv import load_dotenv
from pathlib import Path



load_dotenv()

user=os.getenv("user")
password=os.getenv("password")
host=os.getenv("host")
port=os.getenv("port")
def connect(database_name):
    return psycopg2.connect(user,
                                  password,
                                  host,
                                  port,
                                  database=database_name
                                  )