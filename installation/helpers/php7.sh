#!/bin/bash

export CDN="cdn.dope.al/nginx/php"

# 7.0
apt install -y php7.0 php7.0-fpm
apt install -y php7.0-common php7.0-cgi php7.0-cli php7.0-phpdbg php7.0-dev php7.0-curl 
apt install -y php7.0-enchant php7.0-gd php7.0-gmp php7.0-imap php7.0-interbase 
apt install -y php7.0-intl php7.0-ldap php7.0-mcrypt php7.0-readline php7.0-odbc 
apt install -y php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy 
apt install -y php7.0-xmlrpc php7.0-xsl php7.0-json php7.0-sybase php7.0-sqlite3 
apt install -y php7.0-mysql php7.0-bz2 php7.0-bcmath php7.0-mbstring php7.0-soap 
apt install -y php7.0-xml php7.0-zip php7.0-dba 

service php7.0-fpm restart

curl -s $CDN/7.0/www.conf > /etc/php/7.0/fpm/pool.d/www.conf
ex -sc '%s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g|x' /etc/php/7.0/fpm/php.ini
ex -sc '%s/output_buffering = 4096/output_buffering = Off/g|x' /etc/php/7.0/fpm/php.ini
perl -pi -e 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g' /etc/php/7.0/fpm/php.ini
perl -pi -e 's/;error_log = syslog/error_log = php_error.log/g' /etc/php/7.0/fpm/php.ini
perl -pi -e 's/;date.timezone =/date.timezone = UTC/g' /etc/php/7.0/fpm/php.ini
service php7.0-fpm restart
