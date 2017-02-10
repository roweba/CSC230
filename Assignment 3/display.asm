#define LCD_LIBONLY
.include "lcd.asm"

.cseg

	call lcd_init			; call lcd_init to Initialize the LCD
	call lcd_clr			; clear the lcd
	call init_strings
	call loop_3x
	call flash_asterisk

lp:	jmp lp


init_strings:
	push r16
	; copy strings from program memory to data memory

	ldi r16, high(line1)		; this the destination
	push r16
	ldi r16, low(line1)
	push r16
	ldi r16, high(msg1_p << 1) ; this is the source
	push r16
	ldi r16, low(msg1_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ldi r16, high(line2)		; this the destination
	push r16
	ldi r16, low(line2)
	push r16
	ldi r16, high(msg2_p << 1) ; this is the source
	push r16
	ldi r16, low(msg2_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ldi r16, high(char1)		; this the destination
	push r16
	ldi r16, low(char1)
	push r16
	ldi r16, high(char1_p << 1) ; this is the source
	push r16
	ldi r16, low(char1_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	ldi r16, high(char2)		; this the destination
	push r16
	ldi r16, low(char2)
	push r16
	ldi r16, high(char2_p << 1) ; this is the source
	push r16
	ldi r16, low(char2_p << 1)
	push r16
	call str_init			; copy from program to data
	pop r16					; remove the parameters from the stack
	pop r16
	pop r16
	pop r16

	pop r16
	ret


loop_3x:
	call lcd_clr
	push r16
	push r17
	call lcd_gotoxy
	pop r17
	pop r16
	call display_both
	call delay

	push r16
	ldi r16, 0x03


loop1: 
	call message_order
	dec r16
	brne loop1
	call lcd_clr
	pop r16
	ret

message_order:
	.def row = r16
	.def column = r17
	.def counter = r18
	push row
	push column
	push counter
	ldi counter, 0x02

loop2:
	cpi counter, 0x02
	breq display_1
	cpi counter, 0x01
	breq display_2

display_1_line:

	call lcd_clr
	push row
	push column
	call lcd_gotoxy
	pop column
	pop row
	call display_msg_1
	call delay

	call lcd_clr
	push row
	push column
	call lcd_gotoxy
	pop column
	pop row
	call display_msg_2
	call delay

	dec counter
	brne loop2

	rjmp clear

display_1:
	ldi row,0x00
	ldi column,0x00
	rjmp display_1_line
display_2:
	ldi row,0x01
	ldi column,0x01
	rjmp display_1_line

clear:
	pop counter
	pop column
	pop row
	.undef counter
	.undef column
	.undef row

display_both:
	push r16

	call lcd_clr

	ldi r16, 0x00
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	; Now display msg1 on the first line
	ldi r16, high(line1)
	push r16
	ldi r16, low(line1)
	push r16
	call lcd_puts
	pop r16
	pop r16

	; Now move the cursor to the second line (ie. 0,1)
	ldi r16, 0x01
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	; Now display msg1 on the second line
	ldi r16, high(line2)
	push r16
	ldi r16, low(line2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret


display_msg_1:
	push r16

	ldi r16,high(line1)
	push r16
	ldi r16,low(line1)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret
		
display_msg_2:
	push r16

	ldi r16,high(line2)
	push r16
	ldi r16,low(line2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	pop r16
	ret


flash_asterisk:
	call lcd_clr
	call display_asterisk
	call delay

	call lcd_clr
	call blank
	call delay

	rjmp flash_asterisk

display_asterisk:
	ldi r16, 0x00
	push r16
	ldi r16, 0x06
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
	
	push r16
	ldi r16,high(char1)
	push r16
	ldi r16,low(char1)
	push r16
	call lcd_puts
	pop r16
	pop r16
	pop r16

	ldi r16, 0x01
	push r16
	ldi r16, 0x06
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	push r16
	ldi r16,high(char2)
	push r16
	ldi r16,low(char2)
	push r16
	call lcd_puts
	pop r16
	pop r16
	pop r16

	ret
		
blank:
	call lcd_clr
	ret


delay:	
		push r20
		ldi r20,0x30
		push r21
		push r22
		push r23

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

		pop r23
		pop r22
		pop r21	
		pop r20

		ret

msg1_p:	.db "Rowena Zhu", 0	
msg2_p: .db "CSC 230: Fall 2016", 0
char1_p: .db "****", 0
char2_p: .db "****", 0

.dseg
;
; The program copies the strings from program memory
; into data memory.  These are the strings
; that are actually displayed on the lcd
;

line1: .byte 17
line2: .byte 17
char1: .byte 0
char2: .byte 3
