FROM httpd:2.4-alpine

ARG UID=1000
ARG GID=1000

COPY httpd-vhosts.conf /usr/local/apache2/conf/sites/httpd-vhosts.conf
COPY modules.conf /usr/local/apache2/conf/sites/modules.conf

RUN apk --no-cache add shadow \
 && usermod -u $UID www-data \
 && groupmod -g $GID www-data \
 && sed -i 's#/usr/local/apache2/htdocs#/var/www/html/site#g' /usr/local/apache2/conf/httpd.conf \
 && echo "Include conf/sites/*.conf" >> /usr/local/apache2/conf/httpd.conf \
 && chown -R $UID:$GID /usr/local/apache2/htdocs
