#!/usr/bin/env bash

#chromium-browser --remote-debugging-port=7200 --start-maximized --disable-dev-shm-usage --no-default-browser-check --proxy-server=socks://127.0.0.1:8081
mkdir -p ~/.config/google-chrome
touch ~/.config/google-chrome/"First Run"
google-chrome --remote-debugging-port=7200 --start-maximized --disable-dev-shm-usage --no-default-browser-check --proxy-server=socks://127.0.0.1:8081
