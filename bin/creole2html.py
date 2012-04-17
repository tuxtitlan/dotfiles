#!/usr/local/bin/python

import sys
from creole import creole2html

sys.stdout.write(creole2html(sys.stdin.read().decode('utf-8')))
