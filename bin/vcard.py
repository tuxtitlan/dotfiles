#!/usr/bin/env python

import os, codecs

files = ['vCards.vcf']

def vcf_split():
    for vf in files:
        f = codecs.open(vf, 'r', 'utf-8')
        vcard = u''
        for line in f:
            vcard += line
            if line == u'END:VCARD\r\n':
                yield vcard
                vcard = u''

if __name__ == '__main__':
    counter = 1
    for vcard in vcf_split():
        f = codecs.open(os.path.join('vcards', '%d.vcf' %counter), 'w+',
                        'cp1252')
        print >>f, vcard
        f.close()
        counter += 1

