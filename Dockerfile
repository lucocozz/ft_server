FROM debian:buster
#MAINTAINER lucocozz <lucocozz@student.42.fr>

# Setup
RUN	apt-get update && apt-get upgrade -y
RUN	apt-get install -y nginx
RUN	apt-get install -y mariadb-server
RUN	apt-get install -y wget
RUN	apt-get install -y php-mysql php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cli php-fpm php-cgi

ADD srcs/run.sh /tmp/run.sh
ADD srcs/default /etc/nginx/sites-available/default
ADD srcs/wp-config.php /var/www/html/wp-config.php
ADD srcs/database.sql /tmp/database.sql
ADD srcs/config.inc.php /tmp/config.inc.php

EXPOSE 80
EXPOSE 443

CMD ["sh", "/tmp/run.sh"]