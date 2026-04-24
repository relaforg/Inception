#!/bin/sh

# Attendre que MariaDB soit prêt
until nc -z mariadb 3306; do
    sleep 1
done

# Toujours écraser wp-config.php depuis le template hors volume
cp /etc/wordpress/wp-config.php /var/www/html/wp-config.php

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

# Installer et activer le plugin Redis Object Cache
if ! wp plugin is-installed redis-cache --path=/var/www/html --allow-root 2>/dev/null; then
    wp plugin install redis-cache --activate --path=/var/www/html --allow-root
else
    wp plugin activate redis-cache --path=/var/www/html --allow-root 2>/dev/null
fi
wp redis enable --path=/var/www/html --allow-root

# Corriger les permissions après installation (object-cache.php inclus)
chown -R www-data:www-data /var/www/html/wp-content

exec php-fpm8.2 -F
