FROM debian:bullseye
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server mariadb-client
COPY ./conf/maria.conf /etc/mysql/my.cnf
COPY ./tools/script.sh ./script.sh
RUN chmod +x ./script.sh
EXPOSE 3306
CMD ["sh", "./script.sh"]
# "/home/tpicoule/Documents/inception/secrets/db_root_password.txt", the following file should be created 
# "/home/tpicoule/Documents/inception/secrets/db_root_password.txt"