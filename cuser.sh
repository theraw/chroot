#!/bin/bash
# =====================================
export ssh_group=sshjails
export sftp_group=sftpjails
export JAIL_PATH=/home/userfs
export USER_BIN=/bin/bash # If you want to allow user to login in ssh
#export USER_BIN=/bin/false # If you won't to allow user to login in ssh
# =====================================

# =======================================================
# add "prisoner" in the jail you created before !!
# USAGE : ./add-user.sh <username> <password> <type>
# Type 1 : sftp jailed user ; Type 2 ssh jailed user
# A password will be auto-generated with pwgen (sudo apt install pwgen)
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
  GROUP=$sftp_group;
elif [[ $TYPE == 2 ]]; then
  GROUP=$ssh_group;
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
useradd -G $GROUP -d /home/$USER -s $USER_BIN -p $(openssl passwd -1 $PASS) $USER && \
echo "Password : ${PASS}"
# =======================================================

mkdir -p $JAIL_PATH/home/$USER
chown -R $USER:$USER $JAIL_PATH/home/$USER
# =======================================================
# create or update minimal '/etc/passwd' file for our chrooted environment
cat /etc/passwd | grep $USER > $JAIL_PATH/etc/passwd
# =======================================================
