all: up

up:
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker volume prune -fa

fclean: clean
	docker system prune -fa

.PHONY: up down clean fclean all
