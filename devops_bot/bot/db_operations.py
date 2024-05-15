import psycopg2
import os

DB_USER = os.getenv('DB_USER')
DB_PASSWORD = os.getenv('DB_PASSWORD')
DB_HOST = os.getenv('DB_HOST')
DB_PORT = int(os.getenv('DB_PORT', 5432))
DB_DATABASE = os.getenv('DB_DATABASE')


def connect_db():
    return psycopg2.connect(
        dbname=DB_DATABASE,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
    )

def fetch_emails():
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("SELECT email FROM users;")
        emails = cursor.fetchall()
    conn.close()
    return emails

def fetch_phone_numbers():
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("SELECT phone_number FROM phone_numbers;")
        phone_numbers = cursor.fetchall()
    conn.close()
    return phone_numbers

def insert_email(email):
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("INSERT INTO users (email) VALUES (%s);", (email,))
    conn.commit()
    conn.close()

def insert_phone_number(phone_number):
    conn = connect_db()
    with conn.cursor() as cursor:
        cursor.execute("INSERT INTO phone_numbers (phone_number) VALUES (%s);", (phone_number,))
    conn.commit()
    conn.close()

