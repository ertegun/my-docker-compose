FROM phpdockerio/php74-fpm:latest
WORKDIR /application
COPY . .
# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# Install selected extensions and other stuff
RUN apt-get update \
    && apt-get -y --no-install-recommends install  php7.4-mysql php7.4-xdebug php7.4-bcmath php7.4-bz2 php7.4-dba php7.4-enchant php7.4-gd php7.4-gmp php7.4-igbinary php7.4-imagick php7.4-interbase php7.4-intl php7.4-mongodb php7.4-msgpack php7.4-odbc php7.4-phpdbg php7.4-pspell php7.4-raphf php7.4-ssh2 php7.4-sybase php7.4-tideways php7.4-tidy php7.4-xmlrpc php7.4-xsl php7.4-xhprof php7.4-yaml \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

#RUN cd /application
RUN ls -a

#RUN composer install
#CMD bash -c "composer install"
#RUN cp .env.example .env
#RUN ls -a
#RUN echo 'DEVICE_INFO_REDIRECT_URL = "https://www.enerjitakibi.com/instantValues.php?id="' >> .env
#RUN echo 'APP_URL = "https://www.enerjitakibi.com/instantValues.php?id="' >> .env

RUN chmod -R 777 storage
RUN chmod -R 777 bootstrap/cache
#RUN php artisan key:generate