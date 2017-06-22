;
; A simple boot sector that demonstrates addressing
;
	print_string:
	  mov ah, 0x0e				;sets scrlling teletype as the BIOS routine used when we 
						;call the interupt	  
	  
	print_loop:
	   
	    mov al, [bx]
            
	    cmp al, 0
            je end

	    int 0x10
	    add bx, 1
	    jmp print_loop

	  end:
	    ;mov al, 10
	    ;int 0x10
	    ;mov al, 13
	    ;int 0x10
	    mov bx, 0
	    ret
