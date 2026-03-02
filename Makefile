all:
	@mkdir -p /home/selbouka/data/wordpress
	@mkdir -p /home/selbouka/data/mariadb
# 	bonus dir
	@mkdir -p /home/selbouka/data/netdata/lib
	@mkdir -p /home/selbouka/data/netdata/cache
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

start:
	@docker compose -f ./srcs/docker-compose.yml start

re: down all

clean: down
	@sudo rm -rf /home/selbouka/data/wordpress/*
	@sudo rm -rf /home/selbouka/data/mariadb/*
# 	bonus
	@sudo rm -rf /home/selbouka/data/netdata/lib/*
	@sudo rm -rf /home/selbouka/data/netdata/cache/*
