PORT = 0

# add a hidden command validate-port to be used as a dependency

__validate_port:
	@if [ "$(PORT)" -eq 0 ]; then \
		echo "Invalid port number"; \
		exit 1; \
	fi

proxy:
	@echo "Usage: make proxy [start|logs|stop]"
	@echo -e "\tstart-proxy: start the proxy"
	@echo -e "\tlogs-proxy: view the logs of the proxy"
	@echo -e "\tstop-proxy: stop the proxy server"

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
	@echo -e "\tadd-server PORT={PORT}: add a server"
	@echo -e "\tlist-server: list the currently running servers"
	@echo -e "\tremove-server PORT={PORT}: remove a server"

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
