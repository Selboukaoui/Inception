#!/bin/bash

useradd -m -d /var/www/html -g www-data $FTP_USER
echo "$FTP_USER:$FTP_PASS" | chpasswd

chown -R $FTP_USER:www-data /var/www/html


mkdir -p /var/run/vsftpd/empty

cat <<EOF > /etc/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=YES
pasv_min_port=11110
pasv_max_port=11111
secure_chroot_dir=/var/run/vsftpd/empty
EOF

exec vsftpd /etc/vsftpd.conf