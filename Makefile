all:
	@mkdir -p /home/selbouka/data/wordpress
	@mkdir -p /home/selbouka/data/mariadb
	@mkdir -p /home/selbouka/data/portainer
	@docker compose -f ./srcs/docker-compose.yml up -d --build
down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

start:
	@docker compose -f ./srcs/docker-compose.yml start

ps:
	@docker compose -f ./srcs/docker-compose.yml ps

re: down all

clean: down
	@sudo rm -rf /home/selbouka/data/wordpress/*
	@sudo rm -rf /home/selbouka/data/mariadb/*
	@sudo rm -rf /home/selbouka/data/portainer/*
