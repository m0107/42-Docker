# 42-Docker
Ft_server Project for 42.

It builds a docker images with wordpress installed on NGINX server with phpmyadmin amd SQL.

#To build this Docker image run :
docker build -thello:latest .   

#To run this image on docker:
docker run -p80:80 -p443:443 hello:latest 

#To go inside the running container:
docker exec -it "container id" /bin/bash

eg: docker exec -it a6aab /bin/bash
