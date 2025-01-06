FROM debian:bullseye
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget curl mariadb-client
RUN apt-get install -y lsb-release apt-transport-https ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install -y php8.1 php8.1-fpm php8.1-mysqli php8.1-iconv php8.1-phar
RUN echo "SUCCESS install php8.1"
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN adduser --system --no-create-home --group nginx
RUN mkdir -p /run/php /var/www/html
RUN chmod -R 755 /var/www/html
COPY ./tools/script_w.sh /usr/local/bin/
COPY ./conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/script_w.sh
EXPOSE 9000
CMD ["sh", "/usr/local/bin/script_w.sh"]