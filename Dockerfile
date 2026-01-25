FROM ubuntu:latest

RUN apt-get update && apt-get install -y apache2 git && apt-get clean

RUN rm -f /var/www/html/index.html

RUN git clone https://github.com/CeciliaMon/CeciliaMon.github.io.git /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]