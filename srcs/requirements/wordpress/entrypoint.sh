#!/bin/sh

# Attendre que MariaDB soit prêt
until nc -z mariadb 3306; do
    sleep 1
done

# Installer WordPress si pas déjà fait
if ! wp core is-installed --path=/var/www/html --allow-root 2>/dev/null; then
    wp core install \
        --path=/var/www/html \
        --url="https://relaforg.42.fr" \
        --title="Inception" \
        --admin_user="relaforg" \
        --admin_password="password" \
        --admin_email="relaforg@42.fr" \
        --allow-root
fi

exec php-fpm8.2 -F
