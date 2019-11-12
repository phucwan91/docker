.PHONY: docker-clean docker- docker-rebuild docker-start docker-stop docker-restart \
 docker-inside-php docker-inside-nginx docker-inside-node docker-inside-db \

UID = $(shell id -u)
GID = $(shell id -g)

PROJECT_DIR  = /var/www/html
PROJECT_NAME = tree
INFRA_DIR := $(or $(INFRA_DIR), '.')


define generate-env
	if [ -f .env ]; then \
		sed -i 's,UID.*,UID=$(UID),g;s,GID.*,GID=$(GID),g;' .env; \
	fi
endef

# Only run one time
init:
	echo '\n# *** Used for docker ***' >> .env
	echo 'TIMEZONE=Asia/Ho_Chi_Minh' >> .env
	echo 'UID=#UID \nGID=#GID' >> .env
	echo 'PROJECT_DIR=$(PROJECT_DIR)' >> .env
	echo 'COMPOSE_PROJECT_NAME=$(PROJECT_NAME)' >> .env
	echo 'COMPOSE_FILE=$(INFRA_DIR)/docker-compose.yml:$(INFRA_DIR)/docker-compose.local.yml' >> .env
	@if [ ! -f $(INFRA_DIR)/docker-compose.local.yml ]; then echo "version: '3.0'" > $(INFRA_DIR)/docker-compose.local.yml; fi
	$(generate-env)

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

docker-inside-php:
	docker-compose exec --user www-data php /bin/sh

