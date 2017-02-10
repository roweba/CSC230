#include <avr/io.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <avr/interrupt.h>
#include "main.h"
#include "lcd_drv.h"
#include <util/delay.h>

int sub_sec = 0;
int seconds = 0;
int minutes = 0;
int hours = 0;
unsigned int count = 0;

// timer1 overflow
ISR(TIMER1_OVF_vect)
{

}

// timer0 overflow
ISR(TIMER0_OVF_vect)
{
	if(minutes>59){
		sub_sec= 0 ;
		seconds= 0 ;
		minutes= 0 ;
		hours++;
	}
	if(seconds>59){
		sub_sec = 0;
		seconds = 0;
		minutes++;
	}
	if(sub_sec>59){
		sub_sec = 0;
		seconds++;
	}
	sub_sec++;
}

int init_timers(void){
	TIMSK0 |=(1<<TOIE0);
 	TIMSK1 |=(1<<TOIE1);
	
	TCNT0=0x00;
	TCNT1=0x00;

	TCCR0B = (1<<CS02) | (1<<CS00);
	TCCR1B = (1 << CS10) | (1 << CS12);

	sei(); 
}

void init_buttons(void){
	DDRL = 0xFF;
	DDRB = 0xFF;
	ADCSRA = 0x87;
	ADMUX = 0x40;
}


void button_pressed(void){

	ADCSRA |= 0x40;
	
	while (ADCSRA & 0x40)
		;
	unsigned int val = ADCL;
	unsigned int val2 = ADCH;

	val += (val2 << 8);

	
	if (val > 1000){
		count = 0;
	}
	if (val < 790){
		if(count==1){
			count=0;
		}else{
			count = 1;
		}
	}		 

}

void reset(void){

	ADCSRA |= 0x40;
	
	while (ADCSRA & 0x40)
		;
	unsigned int val = ADCL;
	unsigned int val2 = ADCH;

	val += (val2 << 8);

	
	if (val > 1000){
		count = 1;
	}
	if (val < 790){
		if(count==0){
			count=1;
		}else{
			count = 0;
		}
	}		 

}

void line1(){
	char timer[10];
	lcd_xy( 0, 0 );
	sprintf(timer, "%02i:%02i:%02i:%02i", hours ,minutes, seconds, sub_sec);
	lcd_puts(timer);
}

void line2(){
	char timer[10];
	lcd_xy( 0, 1 );
	sprintf(timer, "%02i:%02i:%02i:%02i", hours ,minutes, seconds, sub_sec);
	lcd_puts(timer);
}

int main( void )
{
	init_buttons();
	init_timers();
	lcd_init();

	for (;;){
		line1();
		while(count==0){
			line1();
			button_pressed();
			line2();
		}
		_delay_ms(100);

	}
}
