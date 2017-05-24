;
; A simple boot sector that prints a message to the sceen using BIOS routine
;

	mov ah, 0x0e				;sets scrlling teletype as the BIOS routine used when we 
						;call the interupt

	mov al, 'H'				;write a character to al and trigger the interupt
	int 0x10

	mov al, 'e'
	int 0x10

	mov al, 'l'
	int 0x10

	mov al, 'l'
	int 0x10

	mov al, 'o'
	int 0x10

	jmp $					;infinite loop

;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55