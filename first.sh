# =====================================
export ssh_group=sshjails
export sftp_group=sftpjails
export JAIL_PATH=/home/kvm
# =====================================

# =====================================
if [[ $1 == "debug" ]]; then
  echo "Entering debugging mode (set -x)"
  set -x
fi
# =====================================

# =====================================
# =====================================
APPS="bash cat clear cp touch grep ls mkdir ping ps rm sed tar env find git htop nano php rsync scp sftp top unzip vi whoami zip"
# =====================================

# =====================================
# FS
mkdir $JAIL_PATH
mkdir -p $JAIL_PATH/{bin,dev,lib,mnt,proc,run,srv,sys,usr/bin,usr/share,etc,lib64,opt,sbin,tmp,var}
# =====================================

# =====================================
# Create null device node
mknod -m 666 $JAIL_PATH/dev/null c 1 3
# =====================================

# =====================================
# Copy minimum files
cp /etc/ld.so.{cache,conf} $JAIL_PATH/etc/
cp /etc/nsswitch.conf $JAIL_PATH/etc/
cp /etc/hosts $JAIL_PATH/etc/
# =====================================

# =====================================
# here we just want 'ls' and 'bash' in our chrooted environment
for ii in $APPS; do which $ii && cp $(which $ii) $JAIL_PATH$(which $ii); done
# =====================================

# =====================================
# FHS requires that /bin/sh exists
pushd $JAIL_PATH/bin/
ln -s bash sh
popd
# =====================================

# =====================================
# copy library dependencies for the binaries we just copied
# to find out what we need, 'ldd' can be used
# ex: ldd $(which bash)
#	linux-vdso.so.1 =>  (0x00007ffd4c735000)
#	libtinfo.so.5 => /lib/x86_64-linux-gnu/libtinfo.so.5 (0x00007fe0cce9c000)
#	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fe0ccc98000)
#	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fe0cc8d3000)
#	/lib64/ld-linux-x86-64.so.2 (0x00007fe0cd0c5000)
# =====================================

# =====================================
curl -s http://www.cyberciti.biz/files/lighttpd/l2chroot.txt > /usr/local/sbin/l2chroot
#cp ./l2chroot /usr/local/sbin/
chmod 744 /usr/local/sbin/l2chroot
sed -i "s@/webroot@${JAIL_PATH}@" /usr/local/sbin/l2chroot
# =====================================

# =====================================
# copy library dependencies (with l2chroot)
for ii in $APPS; do which $ii && l2chroot $(which $ii); done
# =====================================

# =====================================
# Additional dependencies for displaying the name of our user in its prompt
mkdir -p $JAIL_PATH/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libnsl.so.1 $JAIL_PATH/lib/x86_64-linux-gnu/
cp /lib/x86_64-linux-gnu/libnss_* $JAIL_PATH/lib/x86_64-linux-gnu/
# =====================================

# =====================================
sed -i 's/Subsystem sftp \/usr\/lib\/openssh\/sftp-server/Subsystem sftp internal-sftp/g' /etc/ssh/sshd_config 
cat <<- EOF >> /etc/ssh/sshd_config
Match group ${ssh_group}
  ChrootDirectory ${JAIL_PATH}/
  X11Forwarding no
  AllowTcpForwarding no
Match group ${sftp_group}
  ChrootDirectory ${JAIL_PATH}/home/%u
  X11Forwarding no
  AllowTcpForwarding no
  ForceCommand internal-sftp
EOF
# =====================================

# =====================================
service ssh restart
groupadd $ssh_group
groupadd $sftp_group
# =====================================
