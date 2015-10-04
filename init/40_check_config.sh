#!/bin/bash


if [ ! -f /config/config.ini ]; then
	/sbin/setuser abc cp -v /defaults/config.ini /config/config.ini

fi
