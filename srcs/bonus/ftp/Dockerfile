FROM debian:bookworm
RUN apt-get update -y && apt-get install vsftpd  -y
COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh 
ENTRYPOINT ["/setup.sh"]