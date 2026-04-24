#!/bin/sh

# Attendre que MariaDB soit prêt
until nc -z mariadb 3306; do
    sleep 1
done

# Installer WordPress si pas déjà fait
if ! wp core is-installed --path=/var/www/html --allow-root 2>/dev/null; then
    wp core install \
        --path=/var/www/html \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
fi

exec php-fpm8.2 -F
