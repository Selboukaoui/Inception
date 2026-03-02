FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y && apt-get install redis-server -y

ENTRYPOINT ["redis-server"]