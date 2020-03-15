.PHONY: init docker-clean docker-rebuild docker-start docker-stop \
docker-exec-php docker-exec-mysql docker-exec-apache \

UID = $(shell id -u)
GID = $(shell id -g)

ENV ?= dev

PROJECT_DIR = /var/www/html/site

define generate-env
	if [ -f .env ]; then \
		sed -i'' -e 's,UID.*,UID=$(UID),g;s,GID.*,GID=$(GID),g;' .env; \
	fi
endef

define run-in-container
	@if [ ! -z $$(docker-compose ps -q $(2) 2>/dev/null) ]; then \
		docker-compose exec --user $(1) $(2) /bin/sh -c "cd $(PROJECT_DIR) && $(3)"; \
	else \
		$(3); \
	fi
endef

# Used for init the .env file if it's not existed
init:
	echo '\n# *** Used for docker ***' >> .env
	echo 'TIMEZONE=Europe/Paris' >> .env
	echo 'UID=#UID \nGID=#GID' >> .env
	echo 'PROJECT_DIR=$(PROJECT_DIR)' >> .env
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

docker-exec-php:
	docker-compose exec --user www-data php /bin/sh

docker-exec-apache:
	docker-compose exec --user root apache /bin/sh

docker-exec-mysql:
	docker-compose exec --user www-data mysql /bin/sh

docker-import-db:
	docker exec -i docker_mysql_1 mysql -uroot -proot $(DB) < db/$(SQL)

site-install-back:
	$(call run-in-container,www-data,php,php -d memory_limit=-1 /usr/local/bin/composer install)


