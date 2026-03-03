FROM debian:bullseye
RUN apt-get update && apt-get install mariadb-server -y
COPY tools/setup.sh /
RUN chmod +x /setup.sh
ENTRYPOINT ["/setup.sh"]
