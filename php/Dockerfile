FROM php:7.1-fpm-alpine

ARG TIMEZONE
ARG UID=1000
ARG GID=1000

COPY php.ini /usr/local/etc/php/
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini
RUN "date"

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && apk update \
    && apk add git \
    && apk add libzip-dev \
    && apk --no-cache add shadow \
    && docker-php-ext-install pdo pdo_mysql mysqli zip\
    && usermod -u $UID www-data \
    && groupmod -g $GID www-data \
    && chgrp -R www-data /usr/local/etc/php-fpm.d/www.conf
