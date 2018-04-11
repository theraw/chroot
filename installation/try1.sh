#!/bin/bash
export USR=raw
export PASSWD=raw
export WW=2
export DOMAIN=test.com
CLR=$(echo "$DOMAIN" | sed 's/\./-/g')
export CDN="cdn.dope.al/clients/default/php"

export CF=/home/kvm

chr $USR $PASSWD $WW

mkdir -p $CF/home/$USR/$DOMAIN/public_html
mkdir -p $CF/home/$USR/$DOMAIN/logs
mkdir -p $CF/home/$USR/$DOMAIN/.ssl
mkdir -p $CF/home/$USR/$DOMAIN/.cache
mkdir -p $CF/home/$USR/$DOMAIN/.backups
mkdir -p $CF/home/$USR/$DOMAIN/.mails

chmod -R 0755 $CF/home/$USR/$DOMAIN/
chmod -R 0755 $CF/home/$USR/$DOMAIN/*

chown -R $USR:$USR $CF/home/$USR/$DOMAIN/
chown -R $USR:$USR $CF/home/$USR/$DOMAIN/*

curl -s $CDN/56.conf > /etc/php/5.6/fpm/pool.d/$USR-$CLR.conf
