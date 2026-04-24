#!/bin/bash

id -u ${FTP_USER} &>/dev/null || useradd -m -d /var/www/html/wordpress ${FTP_USER}
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

chown -R ${FTP_USER}:${FTP_USER} /var/www/html/wordpress

exec proftpd --nodaemon
