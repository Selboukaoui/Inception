#!/bin/bash

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inc.key \
    -out /etc/nginx/ssl/inc.crt \
    -subj "/CN=selbouka.42.fr"