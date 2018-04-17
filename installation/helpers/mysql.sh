#!/bin/bash

apt-get -y install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.supportex.net/mariadb/repo/10.2/ubuntu trusty main'

apt-get -y update; apt-get -y upgrade
apt-get -y install mariadb-server mariadb-client
