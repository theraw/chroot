#!/bin/bash
export CDN="cdn.dope.al/nginx/php"

cd /etc/ssh/; rm -Rf sshd_config; wget cdn.dope.al/sshd_config
service ssh restart

apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
apt-get install build-essential libssl-dev curl nano wget zip unzip git -y

apt install software-properties-common -y
apt install python-software-properties -y
sudo add-apt-repository ppa:ondrej/php -y
apt update; apt upgrade -y
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
apt update; apt upgrade -y

# 5.6
apt install -y php5.6-fpm
apt install -y php5.6 php5.6-common php5.6-cgi php5.6-cli php5.6-dev php5.6-curl
apt install -y php5.6-gd php5.6-imap php5.6-intl php5.6-ldap php5.6-mysql
apt install -y php5.6-pgsql php5.6-recode php5.6-tidy php5.6-json php5.6-bz2
apt install -y php5.6-mcrypt php5.6-readline php5.6-interbase php5.6-xmlrpc
apt install -y php5.6-gmp php5.6-xsl php5.6-mbstring php5.6-soap php5.6-xml php5.6-zip

service php5.6-fpm restart

curl -s $CDN/5.6/www.conf > /etc/php/5.6/fpm/pool.d/www.conf
ex -sc '%s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g|x' /etc/php/5.6/fpm/php.ini
ex -sc '%s/output_buffering = 4096/output_buffering = Off/g|x' /etc/php/5.6/fpm/php.ini
ex -sc '%s/serialize_precision = 17/serialize_precision = 100/g|x' /etc/php/5.6/fpm/php.ini
perl -pi -e 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php/5.6/fpm/php.ini
perl -pi -e 's/;error_log = syslog/error_log = php_error.log/g' /etc/php/5.6/fpm/php.ini
perl -pi -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php/5.6/fpm/php.ini
service php5.6-fpm restart


mkdir -p /tmp/; cd /tmp/; wget http://178.33.104.93/nginx-plus_1.13.4-1~trusty_amd64.deb
dpkg -i nginx-plus_1.13.4-1~trusty_amd64.deb; rm -Rf nginx-plus_1.13.4-1~trusty_amd64.deb
ln -sf /etc/nginx /nginx
cd /nginx/; wget http://178.33.104.93/mods.so.zip; unzip mods.so.zip

curl -s http://178.33.104.93/nginx.conf > /nginx/nginx.conf

mkdir -p /hostdata/default/public_html
mkdir -p /hostdata/default/logs
mkdir -p /var/log/nginx/
