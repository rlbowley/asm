;
; A simple boot sector that demonstrates the stack
;

	mov ah, 0x0e				;sets scrlling teletype as the BIOS routine used when we 
						;call the interupt

	mov bp, 0x8000				;sets the nase of the stack a little above where the 
	mov sp, bp				;the BIOS will write our boot sector
				
	push 'A'				;push some characters to the stack for later retieval
	push 'B'				;not the stack only works in 16 bits, so the MSB
	push 'C'				;will be padded with a 0

	pop bx					;So we have to pop 16 bits, which is more than we neen
	mov al, bl				;so we'll write bl to al and print
	int 0x10				;screen interupt

	pop bx
	mov al, bl
	int 0x10

	mov al, [0x7ffe]			;this proves the stack grows downward from 0x800
						;because we grab the next value by address

	int 0x10

	jmp $

;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55