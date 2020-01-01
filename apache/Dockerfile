FROM httpd:2.4-alpine

ARG UID=1000

COPY vhost /usr/local/apache2/conf/sites/vhost
COPY modules.conf /usr/local/apache2/conf/sites/common/modules.conf

RUN apk --no-cache add shadow \
 && usermod -u $UID www-data \
 && sed -i 's#/usr/local/apache2/htdocs#/var/www/html#g' /usr/local/apache2/conf/httpd.conf \
 && echo "Include conf/sites/*/*.conf" >> /usr/local/apache2/conf/httpd.conf \
 && echo "Listen 1510" >> /usr/local/apache2/conf/httpd.conf \
 && chown -R $UID /usr/local/apache2/htdocs