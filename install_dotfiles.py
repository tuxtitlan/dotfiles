#!/usr/bin/env python

import argparse
import codecs
import filecmp
import glob
import json
import os
import string
import subprocess
import sys

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
    replace_all = False
    os.chdir(MY_PATH)
    for f in glob.iglob('*'):
        if f in args.ignore:
            continue
        dst = os.path.join(args.directory, '.%s' % f.replace('.template', ''))
        if os.path.exists(dst):
            if identical(f, dst):
                print('identical %s' % dst)
            elif replace_all:
                replace_file(f, dst, args)
            else:
                r = raw_input('overwrite %s? [ynaq] ' % dst)
                if r == 'a':
                    replace_all = True
                    replace_file(f, dst, args)
                elif r == 'y':
                    replace_file(f, dst, args)
                elif r == 'q':
                    sys.exit()
                else:
                    print('skipping %s' % dst)
        else:
            link_file(f, dst, args)


def identical(f, dst):
    if os.path.isdir(dst):
        dircmp = filecmp.dircmp(f, dst)
        if not (len(dircmp.left_only) or len(dircmp.right_only) or 
                len(dircmp.diff_files)):
            return True
    return filecmp.cmp(f, dst)


def replace_file(f, dst, args):
    call('rm -rf "%s"' % dst)
    link_file(f, dst, args)


def link_file(f, dst, args):
    f = os.path.join(MY_PATH, f)
    if f.endswith('.template'):
        print('generating %s' % dst)
        t = Template(open(f, 'rU').read())
        with open(dst, 'w+') as of:
            while True:
                try:
                    of.write(t.substitute(args.template_context))
                    break
                except KeyError as e:
                    args.template_context[e.message] = raw_input(
                        'Template context "%s"? ' % e.message)
    else:
        print('linking %s' % dst)
        call('ln -s "%s" "%s"' % (f, dst))


# Command-line options
######################
def is_file(string):
    """
    Type checking utility for ArgumentParser.
    """
    if not os.path.isfile(string):
        msg = '%s is not a file' % string
        raise argparse.ArgumentTypeError(msg)
    return string


def setup_parser():
    """
    Setup the command line utility.
    """
    desc = 'Installs dotfiles into home directory'
    parser = argparse.ArgumentParser(
        description=desc,
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument(
        '-v', '--version', action='version', version='%(prog)s ' + __VERSION__)
    parser.add_argument(
        '-c', '--config', metavar='CONFIG_FILE', type=is_file,
        help='location of the configuration file')
    parser.add_argument(
        '-d', '--directory', metavar='INSTALL_DIRECTORY', default=HOME,
        help='directory where the dotfiles should be installed')
    return parser


def update_args_with_config(args):
    """
    Update args with what's in config, take care to not override what's already
    specified.
    """
    d = json.load(open(args.config))
    for k, v in d.iteritems():
        if not getattr(args, k, None):
            setattr(args, k, v)


def default_args(args):
    """
    Fill args with required defaults if they are missing.
    """
    defaults = {
        'ignore': [],
        'template_context': {}
    }
    for k, v in defaults.iteritems():
        setattr(args, k, getattr(args, k, v))


# Main
######
def main():
    parser = setup_parser()
    args = parser.parse_args()
    if args.config:
        update_args_with_config(args)
    default_args(args)
    install_files(args)


if __name__ == '__main__':
    MY_PATH = os.path.dirname(os.path.realpath(__file__))
    HOME = os.environ['HOME']
    main()
