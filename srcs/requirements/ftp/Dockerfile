FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install proftpd -y

COPY init.sh /usr/local/init.sh
COPY proftpd.conf /etc/proftpd/proftpd.conf

CMD ["bash", "/usr/local/init.sh"]
