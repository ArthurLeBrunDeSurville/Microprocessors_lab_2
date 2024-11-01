.org 00
// Generate a 1kHz PWM signal with 25% width
call initTimer0

start:
    rjmp start
initTimer0:
	// Set OC0A (PB3) and OC0B (PB4) pins as outputs
	ldi	r16, (1 << PB4)|(1<<PB3)
	out	DDRB,r16
	ldi	r16, (1 << COM0B1)|(1 << COM0A1) |  (1 << WGM00)|(1 << WGM01) 
	out    TCCR0A,r16				// setup TCCR0A
	ldi	r16, (1 << CS01)|(1<<CS00)| (1 << WGM02)
	out    TCCR0B,r16				// setup TCCR0B
	ldi	r16, 125
	out	OCR0A,r16				//OCRA = 125
	ldi	r16, 32
	out	OCR0B,r16				//OCRB = 32
	ret
