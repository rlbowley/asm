;
; A simple boot sector that demonstrates includes and prints out hex
;
[org 0x7c00]			;Tell the assembler where to start in memory

	mov dx, 0x1fb6		;store the hex value in dx	
	call print_hex		;function

	jmp $

	print_hex:
	  
	  mov bx, HEX_OUT

	  mov cl, dl	 
	  and cl, 0x0f

	  cmp cl, 9
	  jg alpha_pad_b1
	  add cl, 48
	  jmp end_pad_b1


	  alpha_pad_b1:
	    add cl, 55
	  end_pad_b1:
         
	  mov [bx], cl
	  

	  ;call print_string

	  mov cl, dl
	  shr cl, 4

	  cmp cl, 9
	  jg alpha_pad_b2
	  add cl, 48
	  jmp end_pad_b2

	  alpha_pad_b2:
	    add cl, 55
	  end_pad_b2:

	  shr bx, cl
	  ;mov [bx], cl

	  call print_string

	  ret

	%include "print_string.asm"

	

	HEX_OUT: 
	  db '0x0000', 0
;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55