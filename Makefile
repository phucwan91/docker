.PHONY: docker-clean docker- docker-rebuild docker-start docker-stop docker-restart \
 docker-inside-php docker-inside-nginx docker-inside-node docker-inside-db \

UID = $(shell id -u)
GID = $(shell id -g)

define generate-env
	if [ -f .env ]; then \
		sed -i 's,UID.*,UID=$(UID),g;s,GID.*,GID=$(GID),g;' .env; \
	fi
endef

# Only run one time
init:
	echo '\n# *** Used for docker ***' >> .env
	echo 'TIMEZONE=Europe/Paris' >> .env
	echo 'UID=#UID \nGID=#GID' >> .env
	echo 'COMPOSE_FILE=$(INFRA_DIR)/docker-compose.yml:$(INFRA_DIR)/docker/docker-compose.yml' >> .env
	@if [ ! -f $(INFRA_DIR)/docker-compose.yml ]; then echo "version: '3.0'" > $(INFRA_DIR)/docker-compose.yml; fi

docker-clean:
	docker-compose down --rmi all

docker-rebuild:
	make docker-clean
	make docker-start

docker-start:
	$(generate-env)
	docker-compose up --build -d

docker-stop:
	docker-compose stop

docker-restart:
	$(MAKE) docker-stop
	$(MAKE) docker-start

docker-inside-php:
	docker exec -it --user www-data php /bin/sh

docker-inside-apache:
	docker exec -it --user root apache /bin/sh

docker-inside-mysql:
	docker exec -it mysql /bin/sh
