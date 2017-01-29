;
; CSc 230 Assignment 1 
; Question 1
; Author: Jason Corless
; Modified: Sudhakar Ganti

; This program should calculate:
; R0 = R16 + R17 + R18
;
;--*1 Do not change anything between here and the line starting with *--
.cseg
	ldi	r16, 0x20
	ldi r17, 0x21
	ldi r18, 0x22
;*--1 Do not change anything above this line to the --*

;***
;-------------------------
; Question: Why did we use r16 to r18? Can we use r0 to 15?
; Answer: Certain opcodes are only supported in the upper register values, such as
; ldi, which only is able to load into registers 16-31. This is due to the limited opcode size
; of 16bit.
;-------------------------
; Your code goes here:
;
	mov r0,r16 ;move the value of r16 to r0
	add r0,r17 ;add the value of r17 to r0
	add r0,r18 ;add the value of r18 to r0

;****

;--*2 Do not change anything between here and the line starting with *--
done:	jmp done
;*--2 Do not change anything above this line to the --*


