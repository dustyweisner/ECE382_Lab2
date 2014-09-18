;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;Lab2 - Subroutines - "Cryptography"
;Dusty Weisner 14 September 14
;ECE 382, DFEC, USAF Academy, CO
;Documentation:
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
	 	        	.text            ; Assemble into program memory
;-------------------------------------------------------------------------------
;Required Functionality
;myMessage			.byte			0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f
;-------------------------------------------------------------------------------
;B-functionailty
myMessage       	.byte			0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50,0x8f
;-------------------------------------------------------------------------------
endMCode			.byte			0x11, 0x22, 0x33
;-------------------------------------------------------------------------------
;Required Functionality
;myKey				.byte			0xac
;------------------------------------------------------------------------------
;B-functionality
myKey				.byte			0xac, 0xdf, 0x23
;------------------------------------------------------------------------------
endKCode			.byte			0x11, 0x22, 0x33
	            	.retain                   		    ; Override ELF conditional linking
	                                            		; and retain current section
	            	.retainrefs                 	    ; Additionally retain any sections
	                                            		; that have references to current
	                                            		; section
enderOne			.equ			0x11
enderTwo			.equ			0x22
enderThree			.equ			0x33

					.data
myDecryption:		.space	    	100

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
;Message Size (r6) is amount of characters
			   		mov.w	#myMessage, r5
	                mov.b	#0x00, r6
MessageSize:	    mov.b	@r5, r7
					cmp		#enderOne, r7
	                jne		IncrementOne
	                inc		r5
	                mov.b	@r5, r7
	                cmp     #enderTwo, r7
	                jne		IncrementTwo
	                inc		r5
	                mov.b	@r5, r7
	                cmp     #enderThree, r7
	                jne		IncrementThree
	                jmp		KeyCode
IncrementOne:		inc		r6
					jmp		NextByte
IncrementTwo:		incd	r6
					jmp		NextByte
IncrementThree:     incd	r6
					inc		r6
NextByte:			inc		r5
					jmp		MessageSize

;-------------------------------------------------------------------------------
KeyCode:			mov.w	#myKey, r5
	                mov.b	#0x00, r7
KeySize:	    	mov.b	@r5, r8
					cmp		#enderOne, r8
	                jne		IncOne
	                inc		r5
	                mov.b	@r5, r8
	                cmp     #enderTwo, r8
	                jne		IncTwo
	                inc		r5
	                mov.b	@r5, r8
	                cmp     #enderThree, r8
	                jne		IncThree
	                jmp		Decryption
IncOne:				inc		r7
					jmp		NewByte
IncTwo:				incd	r7
					jmp		NewByte
IncThree:     		incd	r7
					inc		r7
NewByte:			inc		r5
					jmp		KeySize

;-------------------------------------------------------------------------------

Decryption:			mov.w	#myMessage, r8       		; load registers with necessary info for decryptMessage here
					mov.w	#myKey, r9
					mov.w	#myDecryption, r10

           			call    #decryptMessage

forever:    		jmp     forever

;-------------------------------------------------------------------------------
                                            ; Subroutines
;-------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
;Subroutine Name: decryptMessage
;Author:
;Function: Decrypts a string of bytes and stores the result in memory.  Accepts
;           the address of the encrypted message, address of the key, and address
;           of the decrypted message (pass-by-reference).  Accepts the length of
;           the message by value.  Uses the decryptCharacter subroutine to decrypt
;           each byte of the message.  Stores the results to the decrypted message
;           location.
;Inputs: r6 (MessageSize), r7 (KeySize), myMessage (r8), myKey (r9), myDecryption (r10)
;Outputs:
;Registers destroyed: r6
;-------------------------------------------------------------------------------

decryptMessage:		push.w	r7

cycleKey:			push.w	r8
					call	#decryptCharacter
					mov.b	r8, 0(r10)
					pop.w	r8
					inc.w	r8
					inc.w	r9
					inc.w	r10
					dec.w	r6
					dec.w	r7
					cmp		#0x00, r6
					jeq		skip
					cmp		#0x00, r7
					jne		cycleKey
					mov.w	#myKey, r9

skip:				pop.b	r7
					cmp		#0x00, r6
					jeq		finish
					jmp		decryptMessage
finish:
					ret

;-------------------------------------------------------------------------------
;Subroutine Name: decryptCharacter
;Author:
;Function: Decrypts a byte of data by XORing it with a key byte.  Returns the
;           decrypted byte in the same register the encrypted byte was passed in.
;           Expects both the encrypted data and key to be passed by value.
;Inputs: r8, r9
;Outputs: r8
;Registers destroyed: r8
;-------------------------------------------------------------------------------

decryptCharacter:	mov.b	@r8, r8
					xor.b	@r9, r8

            		ret

;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect    .stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
