# nginx + php5-fpm

I wanted to combine nginx and php5-fpm. The approach is to base it off of library/php:fpm and then install nginx on top of it. Both servers log to stdout and stderr, running in supervisord.

## Usage

> # On port 80, run in the foreground, files from /data/html
> docker run -ti -p 8080:80 -v /data/html:/var/www/html andrioid/docker-nginx-php-fpm 

It's also possible to use this image as a base, and copy your files into /var/www/html.