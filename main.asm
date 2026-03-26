.include "tn13def.inc"

.org 0x00
    rjmp main

main:
    ldi r16, RAMEND
    out SPL, r16

    sbi DDRB, 0

loop:
    sbi PORTB, 0
    rcall delay_1s
    cbi PORTB, 0
    rcall delay_1s
    rjmp loop

delay_1s:
    ldi r16, 8
outer:
    ldi r17, 255
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
