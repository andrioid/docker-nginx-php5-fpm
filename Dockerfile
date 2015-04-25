FROM php:fpm

MAINTAINER Andri Óskarsson "andri80@gmail.com"

RUN apt-get update && \
    apt-get install -y ca-certificates nginx-extras supervisor && \
    apt-get install -y libxml2-dev libmcrypt-dev libpq-dev libpng-dev libjpeg-dev && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/local/bin/docker-php-ext-install mcrypt mysql mysqli simplexml pdo pgsql soap xmlrpc pdo_mysql gd exif pdo_pgsql xml

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

#ADD Docker/nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD php-fpm.conf /usr/local/etc/php-fpm.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD ssl_params /etc/nginx/ssl_params
ADD php.conf /etc/nginx/php.conf
ADD index.php /var/www/html/index.php
ADD default-site.conf /etc/nginx/sites-enabled/99-default

VOLUME ["/var/cache/nginx", "/var/www/html"]

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]


