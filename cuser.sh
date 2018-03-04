#!/bin/bash

# =======================================================
# add "prisoner" in the jail you created before !!
# USAGE : ./add-user.sh <username> <password> <type>
# Type 1 : sftp jailed user ; Type 2 ssh jailed user
# A password will be auto-generated with pwgen (sudo apt install pwgen)
# =======================================================

# =======================================================
# Set your jail path wherever you want.
JAIL_PATH=/home/userfs/
# =======================================================

# =======================================================
USER=$1
# You can use any password generator you want, or set it manually (e.g PASS=$2)
# PASS=$(pwgen -Bsv 16 1)
PASS=$2
TYPE=$3
# =======================================================

# =======================================================
if [[ "x$USER" == "x" ]]; then
  echo "you have to provide a user name"
  exit;
fi
# =======================================================
if [[ "x$PASS" == "x" ]]; then
  echo "Password is missing"
  exit;
fi
# =======================================================
if [[ $TYPE == 1 ]]; then
  GROUP=sftpjailed;
elif [[ $TYPE == 2 ]]; then
  GROUP=sshjailed;
else
  echo "You have to select jail type"
  echo "1 : sftp jailed user | 2 : ssh jailed user"
  exit;
fi
# =======================================================

# =======================================================
getent passwd $USER > /dev/null
if [ $? -eq 0 ]; then
  echo "user already exists";
  exit;
fi
# =======================================================
# All the steps below will have to be done for all users we want to chroot
# Create new user and add it to the sftp/sshjailed group
# We tell useradd the home directory is /home/$USER because, at login, 
# the user will already be in the jail and this will be the right path at this moment ;)
useradd -G $GROUP -d /home/$USER -s /bin/bash -p $(openssl passwd -1 $PASS) $USER && \
echo "Password : ${PASS}"
# =======================================================

mkdir -p $JAIL_PATH/home/$USER
# =======================================================
# create or update minimal '/etc/passwd' file for our chrooted environment
cat /etc/passwd | grep $USER > $JAIL_PATH/etc/passwd
# =======================================================
