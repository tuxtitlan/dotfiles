#!/usr/bin/env python

import argparse
import codecs
import getpass
import glob
import os
import string
import subprocess
import tempfile

__VERSION__ = '1.0'


# General utils
###############
class Template(string.Template):
    delimiter = '@'


def call(cmd):
    return subprocess.call(cmd, shell=True)


def open(filename, mode=None, *args, **kwargs):
    if not mode:
        mode = 'r'
    return codecs.open(filename, mode, encoding='utf-8', *args, **kwargs)


# Install files
###############
def install_files(args):
    dstdir = args.directory
    srcdir = os.path.join(MY_PATH, 'scripts')
    prepare(dstdir)
    os.chdir(srcdir)
    for l in glob.iglob('*/*'):
        d, f = l.split('/', 1)
        dst = os.path.join(dstdir, f.replace('.template', ''))
        print('installing %s' % dst)
        process_file(os.path.join(srcdir, l), dst, args)


def process_file(f, dst, args):
    if f.endswith('.template'):
        tmp = tempfile.mkstemp()[1]
        t = Template(open(f, 'rU').read())
        with open(tmp, 'w+') as of:
            while True:
                try:
                    of.write(t.substitute(args.__dict__))
                    break
                except KeyError as e:
                    setattr(args, e.message, raw_input(
                        'Template context "%s"? ' % e.message))
        call('osacompile -x -o %s %s' % (dst, tmp))
        os.remove(tmp)
    else:
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
        '-u', '--admin-user', metavar='ADMIN_USER',
        default=os.environ['USER'],
        help='the admin user compiled into the AppleScripts')
    return parser


# Main
######
def main():
    parser = setup_parser()
    args = parser.parse_args()
    args.admin_password = getpass.getpass('What is the sudo password? ')
    install_files(args)


if __name__ == '__main__':
    MY_PATH = os.path.dirname(os.path.realpath(__file__))
    HOME = os.environ['HOME']
    main()
