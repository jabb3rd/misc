#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, codecs

sys.stdin = codecs.getreader('utf-8')(sys.stdin)
sys.stdout = codecs.getwriter('utf-8')(sys.stdout)

conversion = {
	u'а': 'a',
	u'б': 'b',
	u'в': 'v',
	u'г': 'g',
	u'д': 'd',
	u'е': 'e',
	u'ё': 'e',
	u'ж': 'zh',
	u'з': 'z',
	u'и': 'i',
	u'й': 'y',
	u'к': 'k',
	u'л': 'l',
	u'м': 'm',
	u'н': 'n',
	u'о': 'o',
	u'п': 'p',
	u'р': 'r',
	u'с': 's',
	u'т': 't',
	u'у': 'u',
	u'ф': 'f',
	u'х': 'h',
	u'ц': 'c',
	u'ч': 'ch',
	u'ш': 'sh',
	u'щ': 'sch',
	u'ъ': '\'',
	u'ы': 'y',
	u'ь': '\'',
	u'э': 'e',
	u'ю': 'yu',
	u'я': 'ya',
	u'А': 'A',
	u'Б': 'B',
	u'В': 'V',
	u'Г': 'G',
	u'Д': 'D',
	u'Е': 'E',
	u'Ё': 'E',
	u'Ж': 'Zh',
	u'З': 'Z',
	u'И': 'I',
	u'Й': 'Y',
	u'К': 'K',
	u'Л': 'L',
	u'М': 'M',
	u'Н': 'N',
	u'О': 'O',
	u'П': 'P',
	u'Р': 'R',
	u'С': 'S',
	u'Т': 'T',
	u'У': 'U',
	u'Ф': 'F',
	u'Х': 'H',
	u'Ц': 'C',
	u'Ч': 'Ch',
	u'Ш': 'Sh',
	u'Щ': 'Sch',
	u'Ъ': '\'',
	u'Ы': 'Y',
	u'Ь': '\'',
	u'Э': 'E',
	u'Ю': 'Yu',
	u'Я': 'Ya'
}

def transliterate(str):
	result = ''
	for c in str:
		try:
			c = conversion[c]
		except KeyError:
			pass
		result += c
        return result

for l in sys.stdin.readlines():
            sys.stdout.write(transliterate(l))
