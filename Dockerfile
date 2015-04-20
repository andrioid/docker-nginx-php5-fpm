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


VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]

# TODO: Use supervisord to run both fpm and nginx
# TODO: All logs to stdout and stderr
# TODO: nginx.conf
# TODO: php-fpm.conf
# TODO: php.ini
# TODO: composer dependencies
#COPY apache2/apache2.conf /etc/apache2/apache2.conf
#RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load


