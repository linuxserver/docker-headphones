#!/bin/bash


if [ ! -f /config/config.ini ]; then
	cp /defaults/config.ini /config/config.ini
	chown abc:abc /config/config.ini
fi

