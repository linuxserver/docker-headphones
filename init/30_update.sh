#!/bin/bash

[[ ! -d /app/headphones/.git ]] && (git clone https://github.com/rembo10/headphones.git /app/headphones && \
chown -R abc:abc /app)


# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

cd /app/headphones
git pull
chown -R abc:abc /app

