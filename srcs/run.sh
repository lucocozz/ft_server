#/bin/sh

echo "Running ft_server..."

# Info
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
php -v
nginx -v


# SSL
mkdir /etc/nginx/ssl
cd /etc/nginx/ssl/
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out localhost.crt -keyout localhost.key -subj "/C=FR/ST=IDF/L=Paris/O=42School/OU=lucocozz/CN=localhost" && cd

nginx -t


# MySQL
service mysql start
service mysql status
mysql -u root < /tmp/database.sql


# Wordpress
wget https://fr.wordpress.org/latest-fr_FR.tar.gz
tar -zxvf latest-fr_FR.tar.gz
rm latest-fr_FR.tar.gz
mv wordpress /var/www/html/wordpress


# PhpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz
mkdir /var/www/html/phpmyadmin
tar -zxvf phpMyAdmin-4.9.5-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
rm phpMyAdmin-4.9.5-all-languages.tar.gz
mv /tmp/config.inc.php /var/www/html/phpmyadmin/


chown -R www-data:www-data /var/www/html/*
chmod -R 755 /var/www/html/*


# Start
service php7.3-fpm start
service nginx restart

service nginx status
service php7.3-fpm status


echo "ft_server starting."

tail -f /dev/null