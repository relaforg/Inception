FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl \
    && rm -f /etc/nginx/sites-enabled/default \
    && rm -rf /var/lib/apt/lists/*

COPY init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["/usr/local/bin/init.sh"]
