#!/bin/sh

# Lire les secrets
if [ -f "/run/secrets/db_root_password" ]; then
	. /run/secrets/db_root_password
fi

if [ -f "/run/secrets/credentials" ]; then
    . /run/secrets/credentials
fi

# Attendre la disponibilité de la base de données
while ! mariadb -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "show databases;"; do
    echo "Waiting for database connection..."
    sleep 1
done

# Télécharger et configurer WordPress
if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp core download --path=$WP_PATH --allow-root

    if [ $? -ne 0 ]; then
        echo "//Error downloading WordPress"
        exit 1
    fi

    wp config create --path=$WP_PATH --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --dbprefix="wp_" --allow-root
    wp core install --path=$WP_PATH --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_USERADMIN --admin_password=$WP_PASSWORDADMIN --admin_email=$WP_EMAILADMIN --allow-root
    wp user create --path=$WP_PATH $WP_USERDUMMY $WP_EMAILDUMMY --role=editor --user_pass=$WP_PASSWORDDUMMY --allow-root

fi

sleep 2

php-fpm8.1 -F -R