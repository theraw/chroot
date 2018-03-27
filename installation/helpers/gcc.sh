#!/bin/bash

sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y

apt-get -y install gcc-snapshot
apt-get -y install gcc-7 gcc-7-base gcc-7-multilib gcc-7-plugin-dev gcc-7-locales cpp-7 g++-7 g++-7-multilib

cd /usr/bin/; rm -Rf gcc g++ cpp
ln -sf /usr/bin/gcc-7 /usr/bin/gcc
ln -sf /usr/bin/g++-7 /usr/bin/g++
ln -sf /usr/bin/cpp-7 /usr/bin/cpp

clear
gcc --version
g++ --version
cpp --version
