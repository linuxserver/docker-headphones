#!/bin/bash
if [ ! -d /opt/headphones/.git ]; then 
	git clone https://github.com/rembo10/headphones.git /opt/headphones
else
	cd /opt/headphones
	git checkout master
fi
chown -R abc:abc /opt/headphones
