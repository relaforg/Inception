FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    mariadb-server

COPY init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

CMD ["/usr/local/bin/init.sh"]
