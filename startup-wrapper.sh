#!/bin/bash

mkdir -p /home/$USER/.config/chromium

chown -R 1000:1000 /home/$USER/.config/chromium

sed -i 's/href=\//href=/g' /usr/local/lib/web/frontend/index.html
sed -i 's/src=\//src=/g' /usr/local/lib/web/frontend/index.html
sed -i "s|%USER%|$USER|" /etc/supervisor/conf.d/chromium.conf

rm /home/$USER/.config/chromium/SingletonLock || true

exec /startup.sh