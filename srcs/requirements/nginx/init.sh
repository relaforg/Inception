#!/bin/sh

mkdir -p /etc/nginx/ssl
openssl req -x509 -nodes -days 265 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/CN=relaforg.42.fr"

exec nginx -g "daemon off;"
