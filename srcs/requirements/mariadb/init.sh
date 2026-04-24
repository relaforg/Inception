#!/bin/sh

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    mysqld --user=mysql &
    sleep 3

    mariadb -e "CREATE DATABASE IF NOT EXISTS wordpress;"
    mariadb -e "CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'password';"
    mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';"
    mariadb -e "FLUSH PRIVILEGES;"
    
    kill $(cat /run/mysqld/mysqld.pid)
    sleep 2
fi

exec mysqld --user=mysql --bind-address=0.0.0.0
