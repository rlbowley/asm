;
; A simple boot sector that demonstrates addressing
;
	[org 0x7c00]				;this tells the assembler where to start its offest
						;counting.  With it, attempt 2 and 4 work, without it, 
						;attempt 3 and 4 work (becuase 3 is figuring out the 
						;offset).  1 will never work because the it is copying
						;an address to al, not the contents of the address.  
						;4 will always work because it has hard coded an address
						;that we calculated by looking at a hex editor.  However,
						;4 is not a good solution, since any change in the code
						;would require manually recalculating it. 


	mov ah, 0x0e				;sets scrlling teletype as the BIOS routine used when we 
						;call the interupt

	;First attempt
	mov al, the_secret
	int 0x10				;does this print an x?

	;Second attempt
	mov al, [the_secret]
	int 0x10

	;Third attempt
	mov bx, the_secret
	add bx, 0x7c00
	mov al, [bx]
	int 0x10

	;Fourth attempt
	mov al, [0x7c1d]
	int 0x10

	jmp $					;infinite loop


the_secret:
	db "X"	

;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55