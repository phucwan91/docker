FROM php:7.1-fpm-alpine
COPY php.ini /usr/local/etc/php/

COPY www.conf /usr/local/etc/php-fpm.d/www.conf

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apk update \
    && apk add git \
    && apk --no-cache add shadow \
    && docker-php-ext-install pdo pdo_mysql \
    && docker-php-ext-install mysqli \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && chgrp -R www-data /usr/local/etc/php-fpm.d/www.conf
