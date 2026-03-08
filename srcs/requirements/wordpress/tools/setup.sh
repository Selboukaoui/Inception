#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html
mkdir -p /run/php 

sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf


cd /var/www/html

while ! mysqladmin ping -h${WP_DB_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} --silent; do
    sleep 2
done


if [ ! -f /var/www/html/wp-config.php ]; then

    wp core download --allow-root --version=5.8.1 --locale=en_US

    wp config create --allow-root --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbhost=${WP_DB_HOST} --dbpass=${MYSQL_PASSWORD}

    wp core install --allow-root --url=${URL} --title="Hello from 1337" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL}

    wp user create  --allow-root "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author


    # bonus
    wp plugin install redis-cache --activate --allow-root

    wp config set WP_REDIS_HOST ${WP_REDIS_HOST} --allow-root
    wp config set WP_REDIS_PORT ${WP_REDIS_PORT} --raw --allow-root
    wp config set WP_CACHE true --raw --allow-root

    wp redis enable --allow-root
fi

exec php-fpm8.2 -F
