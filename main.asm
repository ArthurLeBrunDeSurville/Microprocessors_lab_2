.ORG 0

       SBI DDRA,0
       CBI PORTA, 0
       sbi ddrb,3
       rjmp ex2

ex1:

       SBI PORTA,0
       CALL DELAY_1MS
       CBI PORTA,0
       CALL DELAY_1MS
       RJMP ex1

DELAY_1MS:

       LDI R17,37

TT:

       LDI R16,-200
       OUT TCNT0,R16
       LDI R16,$00
       OUT TCCR0A,R16
       LDI R16,$01
       OUT TCCR0B,R16

LOOP:

       SBIS TIFR0,TOV0
       RJMP LOOP
       SBI TIFR0,TOV0
       LDI R16,$00
       OUT TCCR0B,R16
       DEC R17
       CPI R17,0
       BRNE TT
	   ret

Ex2:

       SBI PORTB,3
       CALL DELAY32US
       CBI PORTB,3
       CALL DELAY32US
       RJMP ex2

/*DELAY32US_:         // Normal Mode

       LDI R16,0
       OUT TCNT0,R16
       LDI R16,$02
       OUT TCCR0A,R16
       LDI R16,$03
       OUT TCCR0B,R16
*/

LOOP1:

       SBIS TIFR0,TOV0
       RJMP LOOP1
       SBI TIFR0,TOV0
       LDI R16,$00
       OUT TCCR0B,R16
	   RET 
 
 DELAY32US:          // CTC MODE
       LDI R16,$00
       STS TCNT1H,R16
       LDI R16,$00
       STS TCNT1L,R16
       LDI R16,HIGH(3)
       STS OCR1AH,R16
       LDI R16,LOW(3)

       STS OCR1AL,R16
       LDI R16,$00
       STS TCCR1A,R16
       LDI R16,$0B
       STS TCCR1B,R16

LOOP2:

       SBIS TIFR1,OCF1A
       RJMP LOOP2
       SBI TIFR1,OCF1A
       LDI R16,$00
       STS TCCR1B,R16
       RET