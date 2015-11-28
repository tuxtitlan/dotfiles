#!/usr/bin/env python

from shlex import split
from subprocess import Popen, PIPE
import plistlib
import sys

LAPTOP_DISPLAY = 'Color LCD'


def get_displays():
    displays = []
    cmd = split('system_profiler SPDisplaysDataType -xml')
    _xml = Popen(cmd, stdout=PIPE).stdout.read()
    d = plistlib.readPlistFromString(_xml)[0]['_items'][0]['spdisplays_ndrvs']
    for display in d:
        displays.append(display['_name'])
    return displays


def main():
    displays = get_displays()
    if len(displays) > 1 or LAPTOP_DISPLAY not in displays:
        sys.exit('{} is not the only display'.format(LAPTOP_DISPLAY))
    else:
        sys.exit()


if __name__ == '__main__':
    main()
