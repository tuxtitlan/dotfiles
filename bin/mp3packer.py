#!/usr/bin/env python

import os
import re
import shlex
import subprocess
import sys

RE_MP3 = re.compile('\.mp3$', re.I)


def filesizeformat(bytes):
    """
    Formats the value like a 'human-readable' file size (i.e. 13 KB, 4.1 MB,
    102 bytes, etc).
    """
    try:
        bytes = float(bytes)
    except (TypeError, ValueError, UnicodeDecodeError):
        return u"0 bytes"

    if bytes < 1024:
        return "%d bytes" % bytes
    if bytes < 1024 * 1024:
        return "%.1f KB" % (bytes / 1024)
    if bytes < 1024 * 1024 * 1024:
        return "%.1f MB" % (bytes / (1024 * 1024))
    return "%.1f GB" % (bytes / (1024 * 1024 * 1024))


def mp3pack(mp3_file):
    if not RE_MP3.search(mp3_file):
        raise ValueError("%(mp3_file)s does not have .mp3 file extension." %
                         vars())
    backup = mp3_file + '.orig'
    raw_input = 'mp3packer -f -z -w -u "%(mp3_file)s" "%(backup)s"' % vars()
    try:
        retcode = subprocess.call(shlex.split(raw_input))
    except KeyboardInterrupt:
        retcode = -1
    if retcode < 0:  # Process failed
        os.remove(mp3_file)
        os.rename(backup, mp3_file)
        print >>sys.stderr
        sys.exit(retcode)
    else:
        old_size = os.path.getsize(backup)
        new_size = os.path.getsize(mp3_file)
        savings = old_size - new_size
        savings_percent = float(savings)/old_size
        msg = "Total savings: %s (%.2f%%)" % (
            filesizeformat(savings), savings_percent
        )
        print >>sys.stdout, msg
        os.remove(backup)


def recursive_mp3pack(root_path):
    for root, dirs, files in os.walk(root_path):
        for f in [f for f in files if RE_MP3.search(f)]:
            mp3pack(os.path.join(root, f))


def main(root_path):
    if os.path.isfile(root_path):
        mp3pack(root_path)
    elif os.path.isdir(root_path):
        recursive_mp3pack(root_path)
    else:
        raise IOError('"%s" is not a valid file or path' % root_path)


if __name__ == '__main__':
    main(sys.argv[1])
