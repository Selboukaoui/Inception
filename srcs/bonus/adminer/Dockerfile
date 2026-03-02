FROM debian:bullseye
RUN apt-get update -y && apt-get install php php-mysql wget -y 
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh
ENTRYPOINT ["/setup.sh"]