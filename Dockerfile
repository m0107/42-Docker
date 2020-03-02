# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mgupta <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/17 17:53:34 by mgupta            #+#    #+#              #
#    Updated: 2020/02/17 17:53:36 by mgupta           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ------------- Notes to run docker using docker machine -------------
#https://docs.docker.com/v17.09/machine/get-started/#use-machine-to-run-docker-containers

#- Install docker-machine, docker desktop requires extra rights :	brew install docker-machine, and docker
#- Create a new VM : 											 	docker-machine create -d virtuabox [name]
#- VM environment variables are there : 							docker-machine env [name]
#- Connect shell to the VM : 									 	eval "$(docker-machine env default)"

# Write the dockerfile, look up LEMP Stack (devOps)

#docker image [options]
#docker container [options]
#docker ps
#docker build .

#Other useful docker commands :

#build       Build an image from a Dockerfile
#kill        Kill one or more running containers
#restart     Restart one or more containers:Wq


FROM debian:buster

RUN apt-get update \
    && apt-get install -y nginx \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	&& echo "daemon off;" >> /etc/nginx/nginx.conf

RUN apt-get update \
	&& apt-get install systemd -y \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
	
RUN apt-get update \
	&& apt-get install wget -y\
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN apt-get update \
	&& apt-get install curl -y\
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


RUN apt-get update \
	&& apt install php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-ldap php-zip php-curl -y\
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 


COPY ./srcs/generate_certificates.sh .
COPY ./srcs/config.inc.php .
COPY ./srcs/wp-config.php .
COPY ./srcs/mariaDB.sh .
COPY ./srcs/start.sh .
COPY ./srcs/wordpress.conf /etc/nginx/sites-available/
COPY ./srcs/mysql_setup.sql /var/

RUN apt-get update && apt-get install -y gnupg2

RUN chmod 777 ./start.sh
RUN chmod 777 ./mariaDB.sh
RUN ./mariaDB.sh


RUN mkdir /var/www/wordpress /var/www/phpmyadmin


RUN nginx -t

WORKDIR /etc/nginx/sites-enabled
RUN rm default
RUN ln -s ../sites-available/wordpress.conf .


RUN echo "Installing phpmyadmin"
WORKDIR /var/www/phpmyadmin/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages/* .
RUN rm -rf phpMyAdmin-4.9.0.1-all-languages


RUN echo "copying phpmyadmin config"
RUN cp /config.inc.php /var/www/phpmyadmin

RUN echo "Installing wordpress"
WORKDIR /var/www/wordpress/
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -zxvf latest.tar.gz
RUN mv wordpress/* .
RUN rm -rf wordpress

RUN echo "copying wp-config.php"
RUN cp /wp-config.php /var/www/wordpress


WORKDIR /var/www/wordpress
RUN chown -R www-data:www-data *
RUN chmod -R 755 *


WORKDIR /

#ADD default /etc/nginx/sites-available/default

EXPOSE 80
EXPOSE 443

CMD bash start.sh && tail -f /dev/null