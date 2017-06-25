;
; A simple boot sector that demonstrates includes and prints out hex
;
[org 0x7c00]			;Tell the assembler where to start in memory
	
	mov dx, 0x1fb6		;store the hex value in dx	
	call print_hex		;function
	call print_string
	jmp $

	

	print_hex:
	  
	  mov bx, HEX_OUT
	  
	  mov ch, dl	 
	  call shift
	  call convert_ascii
	  mov [bx+4], ch
	  mov [bx+5], cl

	  mov ch, dh
	  call shift
	  call convert_ascii
	  mov [bx+2], ch
	  mov [bx+3], cl 	  

	  ret


	  shift:
	    shr cx, 4
	    shr cl, 4
    	    ret

      	  convert_ascii:
	    cmp cl, 9
	    jg plus_87_low
	    add cl, 48
	    
	    check_next_byte:
	    cmp ch, 9
	    jg plus_87_high
	    add ch, 48
	    jmp end_convert

	    plus_87_low:
		add cl, 87
		jmp check_next_byte
	    
	    plus_87_high:
		add ch, 87	
	  
	 end_convert:
	    ret
	%include "print_string.asm"

	

	HEX_OUT: 
	  db '0x0000', 0
;
;padding and magic number
;

	times 510-($-$$) db 0

	dw 0xAA55