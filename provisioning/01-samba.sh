#!/bin/bash

# install samba
apt-get install -y samba

# add "vagrant" user with "vagrant" password
(echo "vagrant" && echo "vagrant") | smbpasswd -a vagrant

# replace the samba configuration file
cat > /etc/samba/smb.conf <<EOL
workgroup = Midas
server string = Midas Ubuntu Server

security = user
map to guest = bad user
unix password sync = yes

[root]
    comment = Midas File System
    path = /
    browseable = yes
    guest ok = no
    read only = no
    create mask = 0755
    directory mask = 0755
EOL

# restart services
service smbd restart
service nmbd restart
