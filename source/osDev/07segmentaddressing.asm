;
; A simple boot sector that demonstrates segment addressing
;

;Note we didn't set [org 0x7c00]

mov ah, 0x0e	;set scrolling teletype

mov al, [the_secret]
int 0x10		;does this print X?

mov bx, 0x7c0		;can't set ds directly so we set bx
mov ds, bx		;then copy it to ds
mov al, [the_secret]	
int 0x10		;Does this print an X?

mov al, [es:the_secret]	;tell the CPU to use the es (not ds) segment
int 0x10		;Does this print an X?

mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10		;Does this print X?

jmp $

the_secret:
	db "X"

;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55