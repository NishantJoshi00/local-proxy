PORT = 0

# add a hidden command validate-port to be used as a dependency

__validate_port:
	@if [ "$(PORT)" -eq 0 ]; then \
		echo "Invalid port number"; \
		exit 1; \
	fi

proxy:
	@echo "Usage: make proxy [start|logs|stop]"
	@echo -e "\t\e[32m\e[1mstart-proxy\e[0m\e[32m: start the proxy\e[0m"
	@echo -e "\t\e[33m\e[1mlogs-proxy\e[0m\e[33m: view the logs of the proxy\e[0m"
	@echo -e "\t\e[31m\e[1mstop-proxy\e[0m\e[31m: stop the proxy server\e[0m"

start-proxy:
	@echo "Starting the proxy"
	@bash scripts/start-proxy.sh

logs-proxy:
	@echo "Viewing the logs of the proxy"
	@bash scripts/view-container.sh

stop-proxy:
	@read -p "Are you sure you want to stop the proxy? [y/N] " confirm; \
	if [ "$$confirm" = "y" ]; then \
		bash scripts/stop-proxy.sh; \
	fi

server:
	@echo "Usage: make server [add|remove|list]"
	@echo -e "\t\e[32m\e[1madd-server PORT={PORT}\e[0m\e[32m: add a server\e[0m"
	@echo -e "\t\e[33m\e[1mlist-server\e[0m\e[33m: list the currently running servers\e[0m"
	@echo -e "\t\e[31m\e[1mremove-server PORT={PORT}\e[0m\e[31m: remove a server\e[0m"

add-server: __validate_port
	@read -p "Are you sure you want to add $(PORT)? [y/N] " confirm; \
		if [ "$$confirm" = "y" ]; then \
			bash scripts/add-server.sh $(PORT); \
		fi

remove-server: __validate_port
	@read -p "Are you sure you want to add $(PORT)? [y/N] " confirm; \
		if [ "$$confirm" = "y" ]; then \
			bash scripts/remove-server.sh $(PORT); \
		fi

list-server:
	@wc conf.d/upstream.conf -l
	@cat conf.d/upstream.conf
