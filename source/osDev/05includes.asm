;
; A simple boot sector that demonstrates includes
;
[org 0x7c00]			;Tell the assembler where to start in memory

	
	mov bx, HELLO_MSG	;Use bx as a parameter for our print_String 
	call print_string	;function

	mov bx, GOODBYE_MSG	
	call print_string

	jmp $			;hang

	%include "print_string.asm"

	; Data
	HELLO_MSG:
	  db 'hello, World!', 0	;zero terminated hello message


	GOODBYE_MSG:
	  db 'Goodbye!', 0	;zero terminate goodby message

;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55