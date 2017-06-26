;
; A general purpose print_hex function taken from the printhex bootloader
;
	
	mov dx, 0x1fb6		;store the hex value in dx	
	call print_hex		;function
	call print_string
	jmp $

	

	print_hex:
	  ;mov dx, 0x1fb6
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

	  call print_string
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
	;%include "print_string.asm"

	

	HEX_OUT: 
	  db '0x0000', 0
