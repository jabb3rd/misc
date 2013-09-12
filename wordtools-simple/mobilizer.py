#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys, codecs

sys.stdin = codecs.getreader('utf-8')(sys.stdin)
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

while 1:
	c = sys.stdin.read(1)
	if not c: break
	if c in u'abcABCабвгАБВГ':
		nc = '2'
        elif c in u'defDEFдеёжзДЕЁЖЗ':
		nc = '3'
        elif c in u'ghiGHIийклИЙКЛ':
		nc = '4'
        elif c in u'jklJKLмнопМНОП':
		nc = '5'
	elif c in u'mnoMNOрстуРСТУ':
		nc = '6'
        elif c in u'pqrsPQRSфхцчФХЦЧ':
	        nc = '7'
        elif c in u'tuvTUVшщъыШЩЪЫ':
		nc = '8'
        elif c in u'wxyzWXYZьэюяЬЭЮЯ':
		nc = '9'
        else:
		nc = c
        sys.stdout.write(nc)
