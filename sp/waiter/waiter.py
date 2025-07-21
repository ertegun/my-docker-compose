#!/usr/bin/env python3
import os
import time
from http.server import BaseHTTPRequestHandler, HTTPServer

import pymysql
import pymongo
import pika

def check_mysql():
    try:
        conn = pymysql.connect(
            host=os.environ.get("MYSQL_HOST", "mysql"),
            port=int(os.environ.get("MYSQL_PORT", 3306)),
            user=os.environ.get("MYSQL_ROOT_USER", "root"),
        )
        with conn.cursor() as cursor:
            cursor.execute("SELECT 1")
        conn.close()
        return True
    except Exception as e:
        print("MySQL error:", e)
        return False

def check_mongodb():
    try:
        client = pymongo.MongoClient(
            host=os.environ.get("MONGODB_HOST", "mongo"),
            port=int(os.environ.get("MONGODB_PORT", 27017)),
            username=os.environ.get("MONGODB_ROOT_USER", "root"),
            password=os.environ.get("MONGODB_ROOT_PASSWORD", ""),
            serverSelectionTimeoutMS=2000
        )
        client.admin.command("ping")
        return True
    except Exception as e:
        print("MongoDB error:", e)
        return False

def check_rabbitmq():
    try:
        credentials = pika.PlainCredentials(
            username=os.environ.get("RABBITMQ_DEFAULT_USER", "guest"),
            password=os.environ.get("RABBITMQ_DEFAULT_PASS", "guest")
        )
        parameters = pika.ConnectionParameters(
            host=os.environ.get("RABBITMQ_HOST", "rabbitmq"),
            port=int(os.environ.get("RABBITMQ_PORT", 5672)),
            credentials=credentials,
            socket_timeout=2
        )
        connection = pika.BlockingConnection(parameters)
        connection.close()
        return True
    except Exception as e:
        print("RabbitMQ error:", e)
        return False

class WaitHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        not_ready = []

        if not check_mysql():
            not_ready.append("mysql")

        if not check_mongodb():
            not_ready.append("mongodb")

        if not check_rabbitmq():
            not_ready.append("rabbitmq")

        if not_ready:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(f"Services not ready: {', '.join(not_ready)}\n".encode())
        else:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"All services are up.\n")

def run():
    port = 8080
    server = HTTPServer(("", port), WaitHandler)
    print(f"Listening on port {port}")
    server.serve_forever()

if __name__ == "__main__":
    run()
