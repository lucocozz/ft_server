#/bin/sh

echo "Running ft_server..."

# Info
php -v
nginx -v

if (( $(ps -ef | grep -v grep | grep nginx | wc -l) > 0 ))
then
	if [ "$AUTOINDEX" = "off" ]
	then cp /tmp/default_off /etc/nginx/sites-available/default ;
    else cp /tmp/default_on /etc/nginx/sites-available/default ; fi
service nginx reload
else
	if [ "$AUTOINDEX" = "off" ]
	then cp /tmp/default_off /etc/nginx/sites-available/default ;
    else cp /tmp/default_on /etc/nginx/sites-available/default ; fi
fi


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
mv /var/www/html/wp-config.php /var/www/html/wordpress


# PhpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.5/phpMyAdmin-4.9.5-all-languages.tar.gz
mkdir /var/www/html/phpmyadmin
tar -zxvf phpMyAdmin-4.9.5-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
rm phpMyAdmin-4.9.5-all-languages.tar.gz
mv /tmp/config.inc.php /var/www/html/phpmyadmin/


chown -R www-data:www-data /var/www/html/*
chmod -R 755 /var/www/html/*
echo "<?php phpinfo(); ?>" >> /var/www/html/index.php

# Start
service php7.3-fpm start
service nginx restart

service nginx status
service php7.3-fpm status

hostname -I | awk '{print $1}'
echo "ft_server starting."

tail -f /dev/null
