APP_NAME=theshop-db
COMPOSE=docker-compose -f docker-compose.yml

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down -v --rmi all

logs:
	$(COMPOSE) logs -f

restart:
	$(MAKE) down
	$(MAKE) up

bash:
	docker exec -it $(APP_NAME) bash
