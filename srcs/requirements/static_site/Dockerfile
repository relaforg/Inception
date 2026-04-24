FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y nginx \
    && rm -rf /var/lib/apt/lists/*

COPY html/ /var/www/html/

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
