FROM debian:bullseye
RUN apt-get update -y && apt-get install mariadb-client php php-fpm php-mysql curl  -y
# RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf
COPY /tools/setup.sh /
RUN chmod +x /setup.sh
COPY index.html /var/www/html/index.html
ENTRYPOINT ["/setup.sh"]