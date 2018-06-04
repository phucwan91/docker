FROM httpd:2.4-alpine

COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY httpd-vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

RUN apk --no-cache add shadow \
 && usermod -u 1000 www-data \
 && groupmod -g 1000 www-data \
 && chgrp -R www-data /usr/local/apache2/htdocs \
 && chown -R www-data:www-data /usr/local/apache2/htdocs
