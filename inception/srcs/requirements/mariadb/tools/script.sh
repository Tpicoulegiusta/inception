#!/bin/sh

# Lire les secrets
if [ -f "/run/secrets/db_password" ]; then
	. /run/secrets/db_password
fi

if [ -f "/run/secrets/credentials" ]; then
    . /run/secrets/credentials
fi

mysql_install_db --user=root --datadir=/var/lib/mysql

mysqld_safe --user=root --datadir=/var/lib/mysql &

# Wait until the database is pingable
until mysqladmin ping >/dev/null 2>&1; do
	sleep 1
done

# Utiliser les variables des secrets
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"

mysqladmin shutdown

mysqld_safe --user=root --datadir=/var/lib/mysql
