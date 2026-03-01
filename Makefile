all:
	@mkdir -p /home/selbouka/data/wordpress
	@mkdir -p /home/selbouka/data/mariadb
	@docker compose -f srcs/docker-compose.yml up --build

down:
	@docker compose -f srcs/docker-compose.yml down

re: down all

clean: down
	@sudo rm -rf /home/selbouka/data/wordpress/*
	@sudo rm -rf /home/selbouka/data/mariadb/*

fclean: clean
	@docker system prune -af

.PHONY: all down re clean fclean
