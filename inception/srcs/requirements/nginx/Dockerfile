FROM debian:bullseye
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get install openssl -y
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/L=NI/O=42/OU=student/CN=[tpicoule.42.fr]"
COPY /conf/nginx.conf /etc/nginx/

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]