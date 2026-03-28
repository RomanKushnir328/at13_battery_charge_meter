.include "tn13def.inc"

.org 0x00
    rjmp main

main:
    ldi r16, RAMEND
    out SPL, r16

    sbi DDRB, DDB0
    sbi DDRB, DDB1
    
    ;digital pins
    ldi  r16, (1<<COM0A1)|(1<<COM0B1)|(1<<WGM01)|(1<<WGM00)
    out  TCCR0A, r16

    ldi  r16, (1<<CS01)|(1<<CS00)
    out  TCCR0B, r16
    
    ;analog pins
    cbi  DDRB, DDB2

    ldi  r16, (1<<ADC1D)
    out  DIDR0, r16

    ldi  r16, (1<<MUX0)
    out  ADMUX, r16

    ldi  r16, (1<<ADEN)|(1<<ADPS1)|(1<<ADPS0)
    out  ADCSRA, r16
    
loop:
    rcall adc_read
    out  OCR0A, r24
    out  OCR0B, r25
    rjmp loop

delay_1s:
    ldi r16, 1
outer:
    ldi r17, 10
middle:
    ldi r18, 255
inner:
    dec r18
    brne inner
    dec r17
    brne middle
    dec r16
    brne outer
    ret

read_loop:
    rcall adc_read
    rjmp  read_loop

adc_read:
    in   r16, ADCSRA
    ori  r16, (1<<ADSC)
    out  ADCSRA, r16

wait_adc:
    in   r16, ADCSRA
    sbrc r16, ADSC         
    rjmp wait_adc           

    in   r24, ADCL
    in   r25, ADCH

    ret
