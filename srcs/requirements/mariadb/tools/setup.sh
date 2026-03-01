#!/bin/bash

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'"
mariadb -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin shutdown

exec mysqld --bind-address=0.0.0.0 --user=mysql

