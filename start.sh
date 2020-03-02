#!/usr/bin/env bash

sh generate_certificates.sh


service mysql start

echo "creating database for wordpress"
mysql -e "CREATE DATABASE WordPress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci";

echo "creating user and password for wordpress"
mysql -e "GRANT ALL ON WordPress.* TO WordPressUser @'localhost' IDENTIFIED BY 'admin1234'";

mysql -e "FLUSH PRIVILEGES";

echo "done"



mkdir /var/www/wordpress /var/www/phpmyadmin


nginx -t

cd /etc/nginx/sites-enabled
rm default
ln -s ../sites-available/wordpress.conf .


echo "Installing phpmyadmin"
cd /var/www/phpmyadmin/
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages/* .
rm -rf phpMyAdmin-4.9.0.1-all-languages


echo "copying phpmyadmin config"
cp /config.inc.php /var/www/phpmyadmin

echo "Installing wordpress"
cd /var/www/wordpress/
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
mv wordpress/* .
rm -rf wordpress

echo "copying wp-config.php"
cp /wp-config.php /var/www/wordpress


cd /var/www/wordpress
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

