#!/bin/bash
ruby random_key.rb > key128.inc
fasm crypt.asm
wine crypt.exe
fasm decrypt.asm
upx -9 decrypt.exe
