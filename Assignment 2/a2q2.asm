;
; a2q2.asm
;
;
; Turn the code you wrote in a2q1.asm into a subroutine
; and then use that subroutine with the delay subroutine
; to have the LEDs count up in binary.
;
;
; These definitions allow you to communicate with
; PORTB and PORTL using the LDS and STS instructions
;
.equ DDRB=0x24
.equ PORTB=0x25
.equ DDRL=0x10A
.equ PORTL=0x10B


; Your code here
		ldi r16, 0xFF
		sts DDRB, r16		; PORTB all output
		sts DDRL, r16		; PORTL all output
		ldi r20, 0x08
		ldi r28,0x00
		mov r0,r28

loop:
		call display
		inc r0
		call delay
		rjmp loop
; Be sure that your code is an infite loop


done:		jmp done	; if you get here, you're doing it wrong

;
; display
; 
; display the value in r0 on the 6 bit LED strip
;
; registers used:
;	r0 - value to display
;
display:
check1:
		mov r30,r0
		andi r30, 0x01
		cpi r30, 0x01
		brne check2
		ori r31, 0b10000000

check2: 
		mov r30,r0
		andi r30, 0x02
		cpi r30,0x02
		brne check3
		ori r31, 0b00100000
check3:
		mov r30, r0
		andi r30,0x04
		cpi r30,0x04
		brne check4
		ori r31, 0b00001000
check4:
		mov r30, r0
		andi r30,0x08
		cpi r30,0x08
		brne l
		ori r31, 0b00000010

l:		sts PORTL, r31	

check5:
		mov r30, r0
		andi r30,0x10
		cpi r30,0x10
		brne check6
		ori r25, 0b00001000
	
check6:
		mov r30, r0
		andi r30,0x20
		cpi r30,0x20
		brne b
		ori r25, 0b00000010

b:		sts PORTB, r25
		ret
;
; delay
;
; set r20 before calling this function
; r20 = 0x40 is approximately 1 second delay
;
; registers used:
;	r20
;	r21
;	r22
;

delay:	
del1:	nop
		ldi r21,0xFF
del2:	nop
		ldi r22, 0xFF
del3:	nop
		dec r22
		brne del3
		dec r21
		brne del2
		dec r20
		brne del1	
		ret
