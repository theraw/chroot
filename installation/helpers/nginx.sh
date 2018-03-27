#!/bin/bash

mkdir -p /opt/nginx/source; cd /opt/nginx/source
wget http://nginx.org/download/nginx-1.13.9.tar.gz; tar xf nginx-1.13.9.tar.gz
rm -Rf nginx-1.13.9.tar.gz; mv nginx-1.13.9 nginx; touch nginx/version.txt; echo '1.13.9' > nginx/version.txt

mkdir -p /opt/nginx/mods/; cd /opt/nginx/mods
git clone https://github.com/eustas/ngx_brotli.git
git clone https://github.com/FRiCKLE/ngx_slowfs_cache.git
cd /opt/nginx/mods/ngx_brotli && git submodule update --init && cd /opt/nginx/source/nginx


mkdir -p /opt/nginx/helpers/; cd /opt/nginx/helpers/
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.gz
tar xf pcre-8.42.tar.gz; rm -rf pcre-8.42.tar.gz; mv pcre-8.42 pcre
cd /opt/nginx/helpers/; wget http://zlib.net/zlib-1.2.11.tar.gz; tar xf zlib-1.2.11.tar.gz; rm -Rf zlib-1.2.11.tar.gz; mv zlib-1.2.11/ zlib

apt-get -y install libxml2
apt-get -y install libxml2-dev
apt-get -y install libxslt-dev
apt-get -y install libxslt1-dev
apt-get -y install unzip
apt-get -y install libicu-dev
apt-get -y install libcurl4-gnutls-dev
apt-get -y install libtool
apt-get -y install apt-utils
apt-get -y install libmozjs-24-dev
apt-get -y install libmozjs-24-bin; sudo ln -sf /usr/bin/js24 /usr/bin/js
apt-get -y install openssl
apt-get -y install libssl-dev
apt-get -y install libperl-dev
apt-get -y install libexpat-dev
apt-get -y install mercurial
apt-get -y install meld
apt-get -y install libxslt-dev
apt-get -y install libgd2-xpm
apt-get -y install libgd2-xpm-dev
apt-get -y install libgeoip-dev
apt-get -y install dh-autoreconf

mkdir -p /var/nginx/logs/
mkdir -p /var/nginx/cache/
chown -R nginx:nginx /var/nginx/
chown -R nginx:nginx /var/nginx/*
cd /opt/nginx/source/nginx/; curl -s https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/ngxBuild.sh | bash -s --
