FROM debian:bullseye

RUN apt update && apt install -y mariadb-server

# Copy custom config to listen on network (0.0.0.0)
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy initialization script
COPY tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

# MariaDB requires this folder to exist and have correct permissions
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]