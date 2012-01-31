#!/usr/bin/env python

import shlex
import subprocess
import sys


def delete_git_branch(branch):
    cmd = ('git co master && git pull && git reset --hard origin/master && '
           'git push origin :%(branch)s && git branch -rd default/%(branch)s '
           '&& git branch -D %(branch)s') % vars()
    subprocess.call(shlex.split(cmd))


def delete_hg_branch(branch):
    cmd = ('hg bookmarks -d %(branch)s' % vars())
    subprocess.call(shlex.split(cmd))


def main():
    branches = sys.argv[1:]
    for branch in branches:
        delete_git_branch(branch)
        delete_hg_branch(branch)


if __name__ == '__main__':
    main()
