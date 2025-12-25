#!/bin/bash

# Check if wp-config.php doesn't exist (first run)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "WordPress is not installed. Installing..."

    # download wp-cli (command line interface for wordpress)
    # it makes installing and configuring WP much easier/cleaner than editing files manually
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # download wordpress core files
    wp core download --allow-root

    # create the config file using env variables
    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    # install wordpress (creates the admin user and database tables)
    wp core install \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email="admin@student.42.fr" \
        --allow-root

    # create the second user (regular user) as required by subject
    wp user create \
        $WP_USER \
        "user@student.42.fr" \
        --user_pass=$WP_PASSWORD \
        --role=author \
        --allow-root
fi

echo "Starting PHP-FPM..."
# Start PHP-FPM in foreground
exec /usr/sbin/php-fpm7.4 -F
