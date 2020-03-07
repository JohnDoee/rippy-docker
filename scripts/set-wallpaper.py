#!/usr/bin/env python3

import argparse
import os
import subprocess

WALLPAPER_PATH = '/tmp/'
DISPLAY = ':1.0'

if __name__ == '__main__':
    parser = argparse.ArgumentParser('Set the wallpaper')
    parser.add_argument('url', help='URL to wallpaper')

    args = parser.parse_args()

    filename = args.url.split('?')[0].split('/')[-1] or 'unknown.jpg'
    path = os.path.join(WALLPAPER_PATH, filename)

    subprocess.check_call(['/usr/bin/curl', '-o', path, args.url])
    subprocess.check_call(['/usr/bin/pcmanfm', '--wallpaper-mode=crop', '--set-wallpaper=%s' % (path, )], env={'DISPLAY': DISPLAY})
