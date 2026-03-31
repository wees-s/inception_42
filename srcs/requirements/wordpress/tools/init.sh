#!/bin/bash
set -e

until mysqladmin -h mariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} ping --silent; do
    sleep 2
done

cd /var/www/html

cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php

exec php-fpm8.2 -F