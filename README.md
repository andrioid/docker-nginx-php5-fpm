# nginx + php5-fpm

I wanted to combine nginx and php5-fpm. The approach is to base it off of library/php:fpm and then install nginx on top of it. Both servers log to stdout and stderr, running in supervisord. 