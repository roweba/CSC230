;
; CSc 230 Assignment 1 
; Question 2
; Author: Jason Corless
 ; Modified: Sudhakar Ganti
 
; This program should calculate:
; R0 = R16 + R17
; if the sum of R16 and R17 is > 255 (ie. there was a carry)
; then R1 = 1, otherwise R1 = 0
;

;--*1 Do not change anything between here and the line starting with *--
.cseg
	ldi	r16, 0xF0
	ldi r17, 0x21
;*--1 Do not change anything above this line to the --*

;***
;---------------------------
;Question: What are we trying to do in this program? What is the
;meaning of if sum > 255 then set R1=1?
;Why did we say that if sum > 255 then there was a carry?
;Answer: We are trying to check if the sum of R16+R17 has a carry(value is greater
;than 255). If sum > 255 set R1=1, it means there was a carry and R1 is updated to
;be true(1). If sum > 255 there was a carry means that the sum of the values is too
;large for the register to store, therefore the bit from the most significant digit
;is added to the LSB.
;---------------------------
; Your code goes here:
;

	add r16,r17 ;add the value of r17 to r16
	mov r0,r16 ;move the value of r16 into r0
	brcs carry ;branch to carry if there was a carry in the addition
	rjmp nocarry ;relative jump to nocarry if there was no carry


carry: 	ldi r20,0x01 ;load the value of 1 into r20
		mov r1,r20 ;move the value of r20 into r1
		rjmp done ;relative jump to done

nocarry:ldi r20,0x00 ;load the value of 0 into r20
		mov r1,r20 ;move the value of r20 into r1
		rjmp done ;relative jump to done

;****
;--*2 Do not change anything between here and the line starting with *--
done:	jmp done
;*--2 Do not change anything above this line to the --*


