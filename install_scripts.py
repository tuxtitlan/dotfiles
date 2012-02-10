#!/usr/bin/env python

import argparse
import glob
import os
import subprocess

__VERSION__ = '1.0'


# General utils
###############
def call(cmd):
    return subprocess.call(cmd, shell=True)


# Install files
###############
def install_files(args):
    dstdir = os.path.join(MY_PATH, 'scripts')
    prepare(dstdir)
    os.chdir(dstdir)
    for f in glob.iglob('*.scpt'):
        dst = os.path.join(dstdir, f)
        call('osacompile -x -o %s %s' % (dst, f))


def prepare(a_dir):
    if not os.path.exists(a_dir):
        os.makedirs(a_dir)


# Command-line options
######################
def setup_parser():
    """
    Setup the command line utility.
    """
    desc = 'Installs scripts into home directory'
    parser = argparse.ArgumentParser(
        description=desc,
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument(
        '-v', '--version', action='version', version='%(prog)s ' + __VERSION__)
    parser.add_argument(
        '-d', '--directory', metavar='INSTALL_DIRECTORY',
        default=os.path.join(HOME, '.scripts'),
        help='directory where the scripts should be installed')
    parser.add_argument(
        'admin-password', metavar='ADMIN_PASSWORD',
        help='admin password used for sudo functions')
    return parser


# Main
######
def main():
    parser = setup_parser()
    args = parser.parse_args()
    install_files(args)


if __name__ == '__main__':
    MY_PATH = os.path.dirname(os.path.realpath(__file__))
    HOME = os.environ['HOME']
    main()
