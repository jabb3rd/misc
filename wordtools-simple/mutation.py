#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, codecs

sys.stdin = codecs.getreader('utf-8')(sys.stdin)
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

table_lower = u'abcdefghijklmnopqrstuvwxyzабвгдеёжзийклмнопрстуфхцчшщъыьэюя'
table_upper = u'ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'

def trans(str, table_in, table_out):
	result = ''
    	for c in list(str):
        	try:
			result += table_out[table_in.index(c)]
        	except:
        		result += c
    	return result
    
def lowercase(str):
	return trans(str, table_upper, table_lower)

def uppercase(str):
	return trans(str, table_lower, table_upper)

def variation(str):
	result = []
	length = len(str)
	if length < 1:
	        return result
	lowercasestr = lowercase(str)
	result.append(lowercasestr)
	for n in range(1, length - 1):
		for i in range(length - n):
			result.append(lowercasestr[:i] + uppercase(lowercasestr[i: i + n]) + lowercasestr[i + n:])
	result.append(uppercase(str))
	return result

for l in sys.stdin.readlines():
        for v in variation(l):
                sys.stdout.write(v)
