#!/usr/bin/env bash
service mysql start

echo "creating database for wordpress"
mysql -e "CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci";

echo "creating user and password for wordpress"
mysql -e "GRANT ALL ON WordPress.* TO WordPressUser @'localhost' IDENTIFIED BY 'your password'";

mysql -e "FLUSH PRIVILEGES";

echo "done"

echo "starting nginx"
nginx