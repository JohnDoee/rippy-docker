#!/usr/bin/env python3
import base64
import json
import subprocess
import tempfile


SCREENSHOT_PATH = '/tmp/screenshot.png'
DISPLAY = ':1'


if __name__ == '__main__':
  subprocess.check_call(['scrot', '-z', SCREENSHOT_PATH], env={'DISPLAY': DISPLAY})
  idletime = int(subprocess.check_output(['xprintidle'], env={'DISPLAY': DISPLAY}).strip())
  with open(SCREENSHOT_PATH, 'rb') as f:
    screenshot = f.read()

  print(json.dumps({'idletime': idletime, 'screenshot': base64.b64encode(screenshot)}))
