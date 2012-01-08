#!/usr/bin/env python

import os
from shlex import split
from subprocess import call, PIPE, Popen

for gem in Popen(split('gem list'),
                 stdout=PIPE).communicate()[0].split(os.linesep):
    if gem.strip():
        gem = gem.split()[0]
        call(split('sudo gem uninstall -aIx %s' % gem))

