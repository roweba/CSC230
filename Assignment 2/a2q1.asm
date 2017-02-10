;
; a2q1.asm
;
; Write a program that displays the binary value in r16
; on the LEDs.
;
; See the assignment PDF for details on the pin numbers and ports.
;
;
;
; These definitions allow you to communicate with
; PORTB and PORTL using the LDS and STS instructions
;
.equ DDRB=0x24
.equ PORTB=0x25
.equ DDRL=0x10A
.equ PORTL=0x10B



		ldi r16, 0xFF
		sts DDRB, r16		; PORTB all output
		sts DDRL, r16		; PORTL all output

		ldi r16, 0x33		; display the value
		mov r0, r16			; in r0 on the LEDs
		ldi r20,0x00
		ldi r21,0x00
; Your code here
check1:
		mov r20,r0
		andi r20, 0x01
		cpi r20, 0x01
		brne check2
		ori r21, 0b10000000

check2: 
		mov r20,r0
		andi r20, 0x02
		cpi r20,0x02
		brne check3
		ori r21, 0b00100000
check3:
		mov r20, r0
		andi r20,0x04
		cpi r20,0x04
		brne check4
		ori r21, 0b00001000
check4:
		mov r20, r0
		andi r20,0x08
		cpi r20,0x08
		brne l
		ori r21, 0b00000010

l:		sts PORTL, r21	

check5:
		mov r20, r0
		andi r20,0x10
		cpi r20,0x10
		brne check6
		ori r30, 0b00001000
	
check6:
		mov r20, r0
		andi r20,0x20
		cpi r20,0x20
		brne b
		ori r30, 0b00000010

b:		sts PORTB, r30
;
; Don't change anything below here
;
done:	jmp done
