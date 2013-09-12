#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, codecs

sys.stdin = codecs.getreader('utf-8')(sys.stdin)
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

table_in = u'ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ,ёйцукенгшщзхъфывапролджэячсмитьбю.'
table_out = u'~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>?`qwertyuiop[]asdfghjkl;\'zxcvbnm,./'

def trans(str, table_in, table_out):
    result = ''
    for c in list(str):
	try:
	    result += table_out[table_in.index(c)]
	except:
	    result += c
    return result

for l in sys.stdin.readlines():
	sys.stdout.write(trans(l, table_in, table_out))

