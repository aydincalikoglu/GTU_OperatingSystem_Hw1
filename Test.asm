        ; 8080 assembler code
        .hexfile Test.hex
        .binfile Test.com
        ; try "hex" for downloading in hex format
        .download bin  
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

	; OS call list
PRINT_B		equ 1
PRINT_MEM	equ 2
READ_B		equ 3
READ_MEM	equ 4
PRINT_STR	equ 5
READ_STR	equ 6
GET_RND		equ 7

	; Position for stack pointer
stack   equ 0F000h

	org 000H
	jmp begin

	; Start of our Operating System
GTU_OS:	PUSH D
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop D
	ret
	; ---------------------------------------------------------------
	; YOU SHOULD NOT CHANGE ANYTHING ABOVE THIS LINE        

	;This program prints a null terminated string to the screen

READ_B_PRINT_B_TEST:	dw '  READ_B_TEST and PRINT_B_TEST',00AH,00AH,00H ; null terminated string


READ_MEM_PRINT_MEM_TEST:	dw '  READ_MEM_TEST and PRINT_MEM_TEST',00AH,00AH,00H ; null terminated string


READ__PRINT_STR:	dw '  READ_STR_TEST and PRINT_STR_TEST',00AH,00AH,00H ; null terminated string


getRND_TEST:	dw 'getRND_TEST',00AH,00H ; null terminated string



memNumber ds 1
testSTR ds 100

begin:
	LXI SP,stack 	; always initialize the stack pointer


Main:
	LXI B,READ_B_PRINT_B_TEST
	MVI A, PRINT_STR
	call GTU_OS	; call the OS

	; TEST READ_B
	MVI A, READ_B
	call GTU_OS	; call the OS

	; TEST PRINT_B
	MVI A, PRINT_B	; store the OS call code to A
	call GTU_OS	; call the OS


	LXI B,READ_MEM_PRINT_MEM_TEST
	MVI A, PRINT_STR
	call GTU_OS	; call the OS

	; TEST READ_MEM
	LXI B,memNumber
	MVI A, READ_MEM	; store the OS call code to A
	call GTU_OS	; call the OS


	; TEST PRINT_MEM
	LXI B,memNumber
	MVI A, PRINT_MEM	; store the OS call code to A
	call GTU_OS	; call the OS



	LXI B,READ__PRINT_STR
	MVI A, PRINT_STR
	call GTU_OS	; call the OS

	; TEST READ STR
	LXI B, testSTR	; put the address of string in registers B and C
	MVI A, READ_STR	; store the OS call code to A
	call GTU_OS	; call the OS
	
	; TEST PRINT_STR
	LXI B, testSTR	; put the address of string in registers B and C
	MVI A, PRINT_STR	; store the OS call code to A
	call GTU_OS	; call the OS
	

	LXI B,getRND_TEST
	MVI A, PRINT_STR
	call GTU_OS	; call the OS


	; TEST GET_RND
	MVI A, GET_RND
	call GTU_OS	; call the OS

	;  PRINT_B
	MVI A, PRINT_B	; store the OS call code to A
	call GTU_OS	; call the OS



	hlt		; end program
