FROM debian:bullseye

RUN apt update && apt install -y wget php7.4 php-fpm php-mysql mariadb-client

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/create_wordpress.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/create_wordpress.sh

RUN mkdir -p /run/php

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]