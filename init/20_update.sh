#!/bin/bash
if [ ! -d /opt/headphones/.git ]; then 
	/sbin/setuser abc git clone https://github.com/rembo10/headphones.git /opt/headphones
else
	cd /opt/headphones
	/sbin/setuser abc git pull
fi
chown -R abc:abc /opt/headphones
