make initialize:
	test -f ../Makefile || echo '' > ../Makefile && \
	sed -i -e '1i-include docker/Makefile \' ../Makefile
	sed -i -e '2i################################\' ../Makefile

	cp docker-compose.yml.dist ../docker-compose.yml

	test -f ../.gitignore || echo '' > ../.gitignore && \
	echo '/docker/*' >> ../.gitignore
	echo 'docker-compose.yml' >> ../.gitignore

make docker-build:
	docker-compose build --no-cache

docker-up:
	docker-compose up -d --build; \
	docker-compose ps

docker-stop:
	docker-compose stop

ssh-php:
	docker exec -it php7.1  sh -c "cd /usr/local/apache2/htdocs/shoppy && /bin/sh"

ssh-apache:
	docker exec -it apache2.4 /bin/sh

