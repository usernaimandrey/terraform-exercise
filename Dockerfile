FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y

RUN mkdir -p /var/www/public_html

COPY /app/hello.html /var/www/public_html
