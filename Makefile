COMPOSE_DIRS := homeassistant mysql immich

up:
	@for dir in $(COMPOSE_DIRS); do \
		echo "Levantando $$dir..."; \
		cd $$dir && docker-compose up -d; \
	done

down:
	@for dir in $(COMPOSE_DIRS); do \
		echo "Bajando $$dir..."; \
		cd $$dir && docker-compose down; \
	done

restart:
	@for dir in $(COMPOSE_DIRS); do \
		echo "Reiniciando $$dir..."; \
		cd $$dir && docker-compose restart; \
	done

logs:
	@for dir in $(COMPOSE_DIRS); do \
		echo "Logs de $$dir:"; \
		cd $$dir && docker-compose logs --tail=10; \
	done

status:
	@for dir in $(COMPOSE_DIRS); do \
		echo "Estado de $$dir:"; \
		cd $$dir && docker-compose ps; \
	done
