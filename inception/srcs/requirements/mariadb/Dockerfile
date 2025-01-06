FROM debian:bullseye
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y mariadb-server mariadb-client
COPY ./conf/maria.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh ./script.sh
RUN chmod +x ./script.sh
EXPOSE 3306
CMD ["sh", "./script.sh"]
# ENTRYPOINT [] <<----- command pour build obligatoirement sinon pas marcher