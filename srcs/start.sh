#!/usr/bin/env bash

sh generate_certificates.sh



service mysql start
echo "creating database for wordpress"
mysql -e "CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci";

echo "creating user and password for wordpress"
mysql -e "GRANT ALL ON WordPress.* TO WordPressUser @'localhost' IDENTIFIED BY 'admin1234'";

mysql -e "FLUSH PRIVILEGES";

echo "done"

service mysql start && mysql -u root mysql < /var/mysql_setup.sql



echo "starting php7.3-fpm services"
service php7.3-fpm start 
service nginx start 

echo "infinte loop"

read
