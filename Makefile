all: up

up:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down
