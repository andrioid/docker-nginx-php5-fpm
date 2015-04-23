FROM php:fpm

MAINTAINER Andri Óskarsson "andri80@gmail.com"

RUN apt-get update && \
    apt-get install -y ca-certificates nginx supervisor && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

#ADD Docker/nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD php-fpm.conf /usr/local/etc/php-fpm.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD php.conf /etc/nginx/php.conf
ADD index.php /var/www/index.php


VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]


