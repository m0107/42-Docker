#!/usr/bin/env bash
service mysql start

echo "creating database for wordpress"
mysql -e "CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci";

echo "creating user and password for wordpress"
mysql -e "GRANT ALL ON WordPress.* TO WordPressUser @'localhost' IDENTIFIED BY 'admin1234'";

mysql -e "FLUSH PRIVILEGES";

echo "done"

echo "starting nginx"

mkdir -p /var/www/html/wordpress/public_html

service nginx start

nginx -t

cd /etc/nginx/sites-enabled
ln -s ../sites-available/wordpress.conf .

systemctl reload nginx


cd /var/www/html/wordpress/public_html
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
mv wordpress/* .
rm -rf wordpress



cd /var/www/html/wordpress/public_html
chown -R www-data:www-data *
chmod -R 755 *

