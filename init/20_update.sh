#!/bin/bash
if [ ! -d /opt/headphones/.git ]; then 
	git clone https://github.com/rembo10/headphones.git /opt/headphones
else
	cd /opt/headphones
	git pull
fi
chown -R abc:abc /opt/headphones

apt-get update -qq
apt-get --only-upgrade install -yqq ffmpeg
