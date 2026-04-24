FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    php8.2-fpm php8.2-mysql wget netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html \
    && wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm latest.tar.gz \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /etc/wordpress
COPY wp-config.php /etc/wordpress/wp-config.php
COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

CMD ["/usr/local/bin/entrypoint.sh"]
