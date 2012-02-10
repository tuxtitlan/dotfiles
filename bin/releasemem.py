#!/usr/bin/env python

import os
import re
import sys

from subprocess import call, Popen, PIPE

INACTIVE_THRESHOLD = 1024  # Number of MBs
FREE_THRESHOLD = INACTIVE_THRESHOLD / 2
RE_INACTIVE = re.compile('Pages inactive:\s+(\d+)')
RE_FREE = re.compile('Pages free:\s+(\d+)')
LOCK_FILE = '/var/tmp/releasemem.lock'


def acquire_lock():
    try:
        os.open(LOCK_FILE, os.O_CREAT | os.O_EXLOCK | os.O_NDELAY)
    except OSError:
        sys.exit('Could not acquire lock.')


def free_inactive():
    vmstat = Popen('vm_stat', shell=True, stdout=PIPE).stdout.read()
    inactive = int(RE_INACTIVE.search(vmstat).group(1)) * 4096 / 1024 ** 2
    free = int(RE_FREE.search(vmstat).group(1)) * 4096 / 1024 ** 2
    return free, inactive


def main():
    acquire_lock()
    free, inactive = free_inactive()
    print("Free: %d < %d?" % (free, FREE_THRESHOLD))
    print("Inactive: %d > %d?" % (inactive, INACTIVE_THRESHOLD))
    if (free < FREE_THRESHOLD) and (inactive > INACTIVE_THRESHOLD):
        print('Purging...')
        call('purge', shell=True)


if __name__ == '__main__':
    main()
