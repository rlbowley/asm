;
; A simple boot sector that demonstrates conditional jumps
;

	mov bx, 40		;write a number to bx

	cmp bx, 4		;compare bx to 4 and print A if it is 
	jle print_A		;less than or equal.  Otherwise 
	cmp bx, 40		;compare bx to 40.  if less than then 
	jl print_B		; print B.  Otherwise
	mov al, 'C'		; print C
	jmp the_end
	
print_A:
	mov al, 'A'		;put 'A' in the al register so it can be pri
	jmp the_end		;printed later, then jump to the_end
	
print_B:
	mov al, 'B'		;put 'B' in the al register so it can be
	jmp the_end		;printed later, then jump to the end.

the_end:
	
mov ah, 0x0e			;int=10 BIOS teletype output
int 0x10			; print the character in al

;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55