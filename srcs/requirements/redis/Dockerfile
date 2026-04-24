FROM debian:bookworm-slim


RUN apt-get update -y && apt-get install lsb-release curl gpg -y \
&& curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg \
&& chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/redis.list \
&& apt-get update -y \
&& apt-get install redis -y

EXPOSE 6379

CMD ["redis-server", "--protected-mode", "no"]
