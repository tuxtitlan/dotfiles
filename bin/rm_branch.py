#!/usr/bin/env python

import shlex
import subprocess
import sys


def delete_git_branch(branch):
    cmd = [
        'git checkout master',
        'git pull',
        'git reset --hard origin/master',
        'git push origin :%s' % branch,
        'git branch -rd default/%s' % branch,
        'git branch -D %s' % branch,
    ]
    cmd = ' && '.join(cmd)
    print cmd
    subprocess.call(cmd)


def delete_hg_branch(branch):
    cmd = [
        'hg update -C master',
        'hg bookmarks -d %s' % branch,
    ]
    cmd = ' && '.join(cmd)
    print cmd
    subprocess.call(cmd)


def main():
    branches = sys.argv[1:]
    for branch in branches:
        delete_git_branch(branch)
        delete_hg_branch(branch)


if __name__ == '__main__':
    main()
