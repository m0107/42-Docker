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

COPY ./mariaDB.sh .
COPY ./start.sh .
COPY ./wordpress.conf /etc/nginx/sites-available/

RUN apt-get update && apt-get install -y gnupg2

RUN chmod 777 ./start.sh
RUN chmod 777 ./mariaDB.sh
RUN ./mariaDB.sh


#ADD default /etc/nginx/sites-available/default

EXPOSE 80
CMD bash start.sh && tail -f /dev/null