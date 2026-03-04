FROM debian:bookworm
RUN apt-get update -y && apt-get install -y nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/ /var/www/html/
ENTRYPOINT ["nginx", "-g", "daemon off;"]