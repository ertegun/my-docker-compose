FROM erte33/sp-php74-apache:prod
RUN sed -i 's/Listen 80/Listen 4447/' /etc/apache2/ports.conf
RUN sed -i 's/Listen 443/Listen 4433/' /etc/apache2/ports.conf
RUN sed -i 's/*:80/*:4447/' /etc/apache2/conf-enabled/z-custom-apache.conf

#docker build -t docker.io/erte33/sp-php74-apache:podman .