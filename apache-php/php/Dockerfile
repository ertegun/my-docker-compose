FROM php:7.4.28-fpm-alpine3.15
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli pdo_mysql
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer