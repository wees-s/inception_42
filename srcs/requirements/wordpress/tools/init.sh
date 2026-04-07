#!/bin/bash
set -ex

until mysql -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1" >/dev/null 2>&1; do
  echo "Waiting for MariaDB..."
  sleep 2
done

cd /var/www/html

if [ ! -f wp-config.php ]; then
  cp wp-config-sample.php wp-config.php
  sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
  sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
  sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
  sed -i "s/localhost/mariadb/" wp-config.php
fi

if wp core is-installed --allow-root 2>/dev/null; then
  echo "WordPress já instalado"
else
  echo "Instalando WordPress..."
  wp core install \
    --url="$DOMAIN_NAME" \
    --title="Meu Site" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root
fi

exec php-fpm8.2 -F