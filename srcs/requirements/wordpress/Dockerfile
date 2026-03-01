FROM debian:bullseye
RUN apt-get update -y && apt-get install mariadb-client php php-fpm php-mysql curl  -y
COPY /tools/setup.sh /
RUN chmod +x /setup.sh

ENTRYPOINT ["/setup.sh"]