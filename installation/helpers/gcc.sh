#!/bin/bash

sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y
