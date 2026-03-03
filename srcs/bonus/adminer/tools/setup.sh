#!/bin/bash

mkdir -p /var/www/html
wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer.php
exec php -S 0.0.0.0:8080 -t /var/www/html
