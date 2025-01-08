FROM debian:bullseye
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get install openssl -y
RUN mkdir -p etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/C=FR/L=NI/O=42/OU=student/CN=tpicoule.42.fr"
COPY /conf/nginx.conf /etc/nginx/
RUN adduser --system --no-create-home --group nginx

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]