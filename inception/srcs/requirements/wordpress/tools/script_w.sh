#!/bin/sh

# Attendre la disponibilité de la base de données
while ! mariadb -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "show databases;"; do
    echo "Waiting for database connection..."
    sleep 1
done

echo "//CONNECTED TO DATABASE"
pwd
# Télécharger et configurer WordPress
if [ ! -f "/var/www/html/wp-config.php" ]; then
    echo "//avant"
    wp core download --path=$WP_PATH --allow-root
    echo "//apres"

    if [ $? -ne 0 ]; then
        echo "//Error downloading WordPress"
        exit 1
    fi

    chown -R nginx:nginx $WP_PATH
    find $WP_PATH -type d -exec chmod 755 {} \;
    find $WP_PATH -type f -exec chmod 644 {} \;

    cd $WP_PATH

    wp config create --path=$WP_PATH --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --dbprefix="br_" --allow-root
    wp core install --path=$WP_PATH --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_USERADMIN --admin_password=$WP_PASSWORDADMIN --admin_email=$WP_EMAILADMIN --allow-root
    wp user create --path=$WP_PATH $WP_USERDUMMY $WP_EMAILDUMMY --role=editor --user_pass=$WP_PASSWORDDUMMY --allow-root

    chown -R nginx:nginx $WP_PATH
    find $WP_PATH -type d -exec chmod 755 {} \;
    find $WP_PATH -type f -exec chmod 644 {} \;

fi

sleep 2

php-fpm8.1 -F -R