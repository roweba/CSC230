;
; CSc 230 Assignment 1 
; Question 4
; Author: Jason Corless
; Modified: Sudhakar Ganti

.include "m2560def.inc"
; This program should calculate the sum of the integers from 1 to (value)
;
; The result should be stored in (result).
;
; Where:
;
;   (value) refers to the byte stored at memory location value in data memory 
;   (result) refers to the byte stored at memory location result in data memory
;
; The sample code you've been given already contains labels named value and result
;
; In the AVR there is no way to automatically initialize data memory
; with constant values.  This is why I have supplied code that initializes data
; memory from program memory.
;

;--*1 Do not change anything between here and the line starting with *--
;
; You don't need to understand this code, we will get to it later
;
; But, if you are keen -- I am using the Z register as a pointer into
; program memory and X as a pointer into data memory
;
.cseg
	ldi ZH,high(init<<1)		; initialize Z to point to init
	ldi ZL,low(init<<1)
	lpm r0,Z				; get the first byte and increment Z
	sts value,r0				; store into value
;*--1 Do not change anything above this line to the --*

;***
; Your code goes here:
;
.def count = r16 ; define r16 as count 
.def sum = r17 ; define r17 as sum

initialize:
	ldi count,0x00 ; initialize count as 0
	ldi sum,0x00 ; initialize sum as 0
	lds r18,value ; load value into r18

loop:
	cp count,r18 ; compare the values of count and r18
	brne addition ; break to addition if count and r18 are not equal
	rjmp store ; if equal jump to store

addition: 
	add sum,count ; add the value of sum to count
	inc count ; increment the value of count
	rjmp loop ; relative jump to loop
	
store: 
	add sum,count ; add the value of sum and count
	sts result,sum ; store the value of sum into result
	rjmp done ; relative jump to done

;****

;--*2 Do not change anything between here and the line starting with *--
done:	jmp done
;*--2

;--*3 Do not change anything between here and the line starting with *--
; This is the constant to initialize value to
; Program memory must be specified in words (2 bytes) which
; is why there is a 2nd byte (0x00) at the end.
init:	.db 0x08, 0x00
;*--3
;--*4 Do not change anything between here and the line starting with *--
; This is in the data segment (ie. SRAM)
; The first real memory location in SRAM starts at location 0x200 on
; the ATMega 2560 processor.  Locations less than 0x200 are special
; and will be discussed much more later
;
.dseg
.org 0x200
value:	.byte 1
result:	.byte 1
;*--4
