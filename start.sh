#!/usr/bin/env bash
service mysql start

echo "creating database for wordpress"
mysql -e "CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci";

echo "creating user and password for wordpress"
mysql -e "GRANT ALL ON WordPress.* TO WordPressUser @'localhost' IDENTIFIED BY 'admin1234'";

mysql -e "FLUSH PRIVILEGES";

echo "done"



mkdir -p /var/www/html/wordpress/public_html



nginx -t

cd /etc/nginx/sites-enabled
rm default
ln -s ../sites-available/wordpress.conf .



cd /var/www/html/wordpress/public_html
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
mv wordpress/* .
rm -rf wordpress

echo "copying wp-config.php"
cp /wp-config.php /var/www/html/wordpress/public_html/


cd /var/www/html/wordpress/public_html
chown -R www-data:www-data *
chmod -R 755 *


echo "starting php7.3-fpm services"
service php7.3-fpm start 

echo "infinte loop"

while :
do
	echo "Press [CTRL+C] to stop.."
	sleep 10
done

