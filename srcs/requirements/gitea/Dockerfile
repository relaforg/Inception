FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y wget git \
    && rm -rf /var/lib/apt/lists/*

RUN wget -q https://dl.gitea.com/gitea/1.22.3/gitea-1.22.3-linux-amd64 \
    -O /usr/local/bin/gitea \
    && chmod +x /usr/local/bin/gitea

RUN useradd -m -s /bin/bash git \
    && mkdir -p /home/git/gitea/{data,log,custom/conf} \
    && mkdir -p /home/git/gitea/data/repositories \
    && chown -R git:git /home/git/gitea

COPY app.ini /home/git/gitea/custom/conf/app.ini
RUN chown -R git:git /home/git/gitea/custom

EXPOSE 3000

USER git

CMD ["/usr/local/bin/gitea", "web", "--config", "/home/git/gitea/custom/conf/app.ini"]
