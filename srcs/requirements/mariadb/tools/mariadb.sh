#!/bin/bash

service mariadb start 

sleep 5

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then

    echo "Setting up MariaDB..."

    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
    
    # Secure installation (remove anonymous users, disable root login remotely)
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    
    mysql -e "FLUSH PRIVILEGES;"
    
    # Shut down the temporary server so we can restart it in the foreground for Docker
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
fi

# Run MariaDB safely in the foreground
exec mysqld_safe
