#!/bin/bash

mkdir -p /home/$USER/.config/chromium

chown -R 1000:1000 /home/$USER/.config/chromium

sed -i 's/href=\//href=/g' /usr/local/lib/web/frontend/index.html
sed -i 's/src=\//src=/g' /usr/local/lib/web/frontend/index.html
sed -i 's/path=websockify/path="+window.location.pathname.substring\(1\)+"websockify/g' /usr/local/lib/web/frontend/static/js/app.*.js
sed -i "s/<title>.*<\/title>/<title>$TITLE<\/title>/g" /usr/local/lib/web/frontend/index.html
sed -i "s|%USER%|$USER|" /etc/supervisor/conf.d/chromium.conf

rm /home/$USER/.config/chromium/SingletonLock || true
rm /home/$USER/.config/google-chrome/SingletonLock || true

/reload-dante.py $HTTP_PROXY

exec /startup.sh
