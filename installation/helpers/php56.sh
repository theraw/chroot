#!/bin/bash

export CDN="cdn.dope.al/nginx/php"
mkdir -p /var/php/5.6/pools/

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
