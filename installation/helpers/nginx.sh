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
apt-get -y install libgeoip-dev
apt-get -y install libpcre3
apt-get -y install libpcre3-dev
sudo add-apt-repository ppa:maxmind/ppa -y
apt-get install aptitude -y
aptitude update -y
aptitude upgrade -y
aptitude install libmaxminddb0 libmaxminddb-dev mmdb-bin -y

cd /opt/nginx/helpers/
git clone http://luajit.org/git/luajit-2.0.git
cd luajit-2.0/
make -j`nproc`
sudo make install
ldconfig

cd /opt/nginx/helpers/
git clone https://github.com/SpiderLabs/ModSecurity
cd /opt/nginx/helpers/ModSecurity/
git checkout -b v3/master origin/v3/master
sh build.sh
git submodule init
git submodule update
./configure
make -j`nproc`
make install
cd ~

mkdir -p /var/nginx/logs/
touch  /var/nginx/logs/error.log
mkdir -p /var/nginx/cache/
useradd nginx
chown -R nginx:nginx /var/nginx/
chown -R nginx:nginx /var/nginx/*
cd /opt/nginx/source/nginx/; curl -s https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/ngxBuild.sh | bash -s --
cd /opt/nginx/source/nginx/; make -j`nproc`
cd /opt/nginx/source/nginx/; make install
cd ~
clear

cd /nginx/; rm -Rf *.default
rm -Rf /etc/init.d/nginx
cd /etc/init.d/; wget https://raw.githubusercontent.com/systemroot/my-nginx/master/nginx-as-firewall/static/nginx; chmod +x nginx
cd /nginx/; rm -Rf html/; mkdir -p /nginx/conf.d; rm -Rf nginx.conf; rm -Rf nginx.conf*
wget https://raw.githubusercontent.com/theraw/chroot/master/installation/helpers/nginx.conf
mkdir -p /nginx/live/
cd /nginx/live/
wget https://raw.githubusercontent.com/systemroot/my-nginx/master/nginx-as-firewall/static/default

mkdir -p /hostdata/default/public_html
mkdir -p /hostdata/default/logs
mkdir -p /hostdata/default/cache
cd /hostdata/default/public_html/
wget https://raw.githubusercontent.com/systemroot/my-nginx/master/hostdata/default/index.html
sudo update-rc.d nginx defaults


