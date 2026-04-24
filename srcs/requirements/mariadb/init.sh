#!/bin/sh

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld --user=mysql &

    mariadb -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mariadb -e "FLUSH PRIVILEGES;"
    
    kill $(cat /run/mysqld/mysqld.pid)
fi

exec mysqld --user=mysql --bind-address=0.0.0.0
