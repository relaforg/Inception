FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    nginx php-fpm php-mysqli wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php \
    -O /var/www/html/adminer.php

COPY adminer.conf /etc/nginx/sites-available/default

EXPOSE 8081

CMD ["sh", "-c", "php-fpm8.2 && nginx -g 'daemon off;'"]
