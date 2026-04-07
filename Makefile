NAME = inceptionLS

COMPOSE = sudo docker compose
ENV_FILE = srcs/.env

include $(ENV_FILE)
export

DATA_PATH = /home/$(USER_42)/data

all: up

up: create_dirs
	$(COMPOSE) -f srcs/docker-compose.yml up --build -d

down:
	$(COMPOSE) -f srcs/docker-compose.yml down

clean: down
	$(COMPOSE) -f srcs/docker-compose.yml down -v

fclean: clean
	sudo rm -rf $(DATA_PATH)

re: fclean up

build:
	$(COMPOSE) -f srcs/docker-compose.yml build

logs:
	$(COMPOSE) -f srcs/docker-compose.yml logs -f

ps:
	$(COMPOSE) -f srcs/docker-compose.yml ps

create_dirs:
	mkdir -p $(USER_PATH)/mariadb
	mkdir -p $(USER_PATH)/wordpress

.PHONY: all up down clean fclean re build logs ps create_dirs