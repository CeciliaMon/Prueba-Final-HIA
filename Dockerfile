# FROM ubuntu:latest

# RUN apt-get update && apt-get install -y apache2 git && apt-get clean

# # RUN rm -f /var/www/html/index.html

# # RUN git clone https://github.com/CeciliaMon/CeciliaMon.github.io.git /var/www/html/

# # EXPOSE 80

# COPY . /var/www/html/

# EXPOSE 80

# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalamos apache2 Y git (necesario para el clon)
RUN apt-get update && apt-get install -y apache2 git && apt-get clean

# Borramos los archivos por defecto de apache para que no estorben
RUN rm -rf /var/www/html/*

# Clonamos tu repositorio directamente en la carpeta de apache
# CAMBIA EL LINK por tu repo real
RUN git clone https://github.com/CeciliaMon/CeciliaMon.github.io.git /var/www/html/

# Variables de entorno que Apache necesita en Ubuntu para no fallar
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80

# Usamos el script de inicio oficial de apache en Ubuntu
CMD "/usr/sbin/apache2ctl" "-D" "FOREGROUND"