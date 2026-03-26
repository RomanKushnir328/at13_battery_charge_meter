avra main.asm

avrdude -p t13 -c usbasp -B 10 -U flash:w:main.hex:i
