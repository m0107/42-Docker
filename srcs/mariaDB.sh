#!/usr/bin/env bash

echo ">>> Installing MariaDB"


MARIADB_VERSION='10.1'

# Import repo key
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

# Add repo for MariaDB
add-apt-repository "deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/$MARIADB_VERSION/ubuntu trusty main"

# Update
apt-get update


# Install MariaDB
# -qq implies -y --force-yes
apt-get install -qq mariadb-server

