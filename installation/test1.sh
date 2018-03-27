#!/bin/bash

hostname server1.dope.al
echo "`curl -s api.ipify.org` server1.dope.al" >> /etc/hosts
rm -Rf /etc/apt/sources.list~
curl -s 'https://raw.githubusercontent.com/theraw/raws/master/usr/local/raws/ubuntu/eu-repo' > /etc/apt/sources.list
echo 'nameserver 8.8.8.8' > /etc/resolv.conf
echo 'nameserver 8.8.4.4' >> /etc/resolv.conf
apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
apt-get -y install build-essential libssl-dev curl nano wget zip unzip git iftop htop

clear

curl -s https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/gcc.sh | bash -s --

clear

curl -s https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/nginx.sh | bash -s --

clear

curl -s https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/php56.sh | bash -s --

clear

curl -s https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/php7.sh | bash -s --
