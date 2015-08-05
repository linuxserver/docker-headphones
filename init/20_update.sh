#!/bin/bash
/sbin/setuser abc mkdir -p /app

if [ ! -d /app/headphones/.git ]; then 
	/sbin/setuser abc git clone https://github.com/rembo10/headphones.git /app/headphones
else
	cd /app/headphones
	/sbin/setuser abc git pull
fi
