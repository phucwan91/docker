.PHONY: docker-start docker-stop docker-restart docker-inside-php docker-inside-nginx docker-inside-node docker-inside-db \

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
	echo 'COMPOSE_FILE=docker/docker-compose.yml:docker/local/docker-compose.yml' >> .env
	@if [ ! -f docker/local/docker-compose.yml ]; then echo "version: '3.0'" > docker/local/docker-compose.yml; fi

docker-start:
	$(generate-env)
	docker-compose up --build -d

docker-stop:
	docker-compose stop

docker-restart:
	$(MAKE) docker-stop
	$(MAKE) docker-start

docker-inside-php:
	docker-compose exec --user www-data php /bin/sh

docker-inside-apache:
	docker-compose exec --user root apache /bin/sh

docker-inside-mysql:
	docker-compose exec mysql /bin/sh
