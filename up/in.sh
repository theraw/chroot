#!/bin/bash

cd /etc/ssh/; rm -Rf sshd_config; wget cdn.dope.al/sshd_config
service ssh restart

apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
apt-get install build-essential libssl-dev curl nano wget zip unzip git -y

