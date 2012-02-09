#!/usr/bin/env python

import re

from subprocess import call, Popen, PIPE

INACTIVE_THRESHOLD = 1024 * 1.5  # Number of MBs
FREE_THRESHOLD = 512
RE_INACTIVE = re.compile('Pages inactive:\s+(\d+)')
RE_FREE = re.compile('Pages free:\s+(\d+)')


def free_inactive():
    vmstat = Popen('vm_stat', shell=True, stdout=PIPE).stdout.read()
    inactive = int(RE_INACTIVE.search(vmstat).group(1)) * 4096 / 1024 ** 2
    free = int(RE_FREE.search(vmstat).group(1)) * 4096 / 1024 ** 2
    return free, inactive


def main():
    free, inactive = free_inactive()
    if free < FREE_THRESHOLD and inactive > INACTIVE_THRESHOLD:
        call('purge', shell=True)


if __name__ == '__main__':
    main()
