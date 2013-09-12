format	PE CONSOLE 4.0
entry	start

include	'%FASM%\win32ax.inc'
include	'%FASM%\aes\aes.inc'
include 'crc32.inc'

; Size of cleartext (padded to 16-bytes block)
TEXTSIZE	= _padded_size

section	'.text' code readable executable
start:
	; Calculate CRC-32 of the padded payload
	mov	esi,input_file
	; Skip the 1st dword where CRC-32 will be written
	add	esi,4
	mov	edi,(_padded_size-4)
	call	Calc_CRC32

	; Write CRC-32 to memory
	mov	[checksum1],eax

	; Print a message to console
	pushad
	cinvoke	printf,_fmt1,eax
	popad

	; Now encrypt the payload using AES-128 with a simplified key
	stdcall	encAES,TEXTSIZE,input_file,enc_msg,key128
	
	; Again, calculate CRC32 of the encrypted data
	mov	esi,enc_msg
	mov	edi,TEXTSIZE
	call	Calc_CRC32
	
	; Print a message to console
	pushad
	cinvoke	printf,_fmt1,eax
	popad
	

	; Output the ciphertext to encrypted.dat with a checksum prepended to the beginning
        invoke  CreateFile,'encrypted.dat',GENERIC_WRITE,FILE_SHARE_READ,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
        mov     [file_handle],eax
        invoke  WriteFile,eax,enc_msg,TEXTSIZE,bytes_written,0
        invoke  CloseHandle,[file_handle]
	invoke	ExitProcess,0

include	'%FASM%\aes\aes.asm'

section	'.data' data readable writeable
	file_handle	dd	?
	bytes_written	dd	?
	_fmt1		db	'CRC32 = 0x%0x',13,10,0

; Cleartext payload with CRC-32 (dword) checksum prepended
input_file:
	checksum1	dd	?
	file	'exec_calc.bin'
	_input_file_size = $ - input_file
	; Pad the payload to 16-bytes blocks with NOPs
	if	_input_file_size mod BLOCK_SIZE > 0
		_padded_size = ((_input_file_size / BLOCK_SIZE) + 1) * BLOCK_SIZE
		_padding db 0x90 dup (_padded_size - _input_file_size)
	else
		_padded_size = _input_file_size
	end if

enc_msg:
	; A place for a ciphertext
	checksum2 dd ?
	_enc_msg  rb (TEXTSIZE-4)

	; Simplified encryption key (only a few bytes has the meaning, the others are set to 0)
;	key128	db 0x01,0x03,0x00,0x02,0x01,0x01,10 dup(0x00)
	include	'key128.inc'

section	'.idata' import data readable writeable
	library	kernel,'KERNEL32.DLL',\
		msvcrt,'MSVCRT'
	import	kernel,\
		ExitProcess,'ExitProcess',\
		CreateFile,'CreateFileA',\
		WriteFile,'WriteFile',\
		CloseHandle,'CloseHandle'

	import	msvcrt,\
		printf,'printf'
