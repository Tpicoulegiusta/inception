#!/bin/bash

PURPLE			= \033[38;5;141m
GREEN			= \033[38;5;46m
RED				= \033[0;31m
GREY			= \033[38;5;240m
RESET			= \033[0m
BOLD			= \033[1m
CLEAR			= \r\033[K

NAME			= inception
CONTAINERS		= $(shell docker ps -a -q)
VOLUMES			= $(shell docker volume ls -q)

all: start

init:
	@mkdir -p ~/data/wordpress
	@mkdir -p ~/data/mariadb

start: init
	@docker-compose -f ./srcs/docker-compose.yml up -d --build
	@printf "${CLEAR}${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: ${RED}${BOLD}${NAME} ${RESET}has cooked with ${GREEN}success${RESET}.${GREY}\n${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}"

stop:
ifneq ($(CONTAINERS),)
	@docker-compose -f ./srcs/docker-compose.yml down
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Containers ${GREEN}successfully ${RESET}stopped.\n${RESET}"
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to stop.\n${RESET}"
endif

clean: stop
ifneq ($(VOLUMES),)
	@docker volume rm $$(docker volume ls -q) > /dev/null
	@docker system prune -a -f > /dev/null
	@clear
	@printf "${CLEAR}${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: Project cleaned ${GREEN}successfully${RESET}.${GREY}\n${RESET}${GREY}────────────────────────────────────────────────────────────────────────────\n${RESET}"
else
	@printf "${CLEAR}${RESET}${GREEN}»${RESET} [${PURPLE}${BOLD}${NAME}${RESET}]: There's ${RED}nothing ${RESET}to clean.\n${RESET}"
endif

fclean: clean
	@sudo rm -rf ~/data

.PHONE: all start stop clean