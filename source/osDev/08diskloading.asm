;Read some sectors from the boot disk using our disk_read function
[org 0x7c00]

  mov [BOOT_DRIVE], dl 		;BIOS stores out boot drive in DL, so it's
				;best to remember this for later

  mov bp, 0x8000		;Setting the stack safely out of the way at 0x8000
  mov sp, bp

  mov bx, 0x9000		;load 5 sectors to 0x0000(ES):0x9000(BX)
  mov dh, 5			;from the boot disk
  mov dl, [BOOT_DRIVE]	

  mov bx, BOOT_MSG
  ;call print_string
  ;call print_hex
  ;mov bx, CRLF
  ;call print_string 

  
  call disk_load
  ;mov bx, FIRST_WORD
  ;call print_string

  mov dx, [0x9000]		;print out the first loaded word, which
  call print_hex		;we expect to be 0xdada, stored
  				;at the address 0x9000

  mov dx, [0x9000 + 512]	;also print the first word from the 
  call print_hex		;2nd loaded sector: should be 0xface

  jmp $

%include "print_string.asm"	;re-use our print string function
%include "print_hex.asm"	;re-use out print hex function
%include "disk_load.asm"	;include our disk load function

;Global variables
BOOT_MSG: db "Booting from disk: ", 0
BOOT_DRIVE: db 0
CRLF: db 10, 13, 0
FIRST_WORD: db "First Loaded Word: ", 0

;bootsector padding
times 510-($-$$) db 0
dw 0xaa55

;We know that BIOS will load only the first 512-byte sector from the disk
;so if we purposely add a few more sectors to our codeby repeating some
;familiar numbers, we can prove to ourselves that we actually loaded those
;additional two sectors from the disk we booted from
times 256 dw 0xdada
times 256 dw 0xface