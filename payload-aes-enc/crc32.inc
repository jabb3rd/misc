; esi - start of block
; edi - size of block
; returns crc32 in eax
Calc_CRC32:
	push ebx
        xor ecx, ecx
        dec ecx
        mov edx, ecx
NextByteCRC:
        xor eax, eax                            ;Ehrm, this is very fast
        xor ebx, ebx                            ;procedure to code CRC32 at
        lodsb                                   ;runtime, no need to use big
        xor al, cl                              ;tables.
        mov cl, ch
        mov ch, dl
        mov dl, dh
        mov dh, 8
NextBitCRC:
        shr bx, 1
        rcr ax, 1
        jnc NoCRC
        xor ax, 08320h
        xor bx, 0edb8h
NoCRC:  dec dh
        jnz NextBitCRC
        xor ecx, eax
        xor edx, ebx
        dec edi
        jne NextByteCRC
        not edx
        not ecx
        pop ebx
        mov eax, edx
        rol eax, 16
        mov ax, cx
        ret
