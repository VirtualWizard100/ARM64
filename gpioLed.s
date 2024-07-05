.include "gpioLedMacros.s"

.global _start

_start:
	mmapdevmem
	nanosleep
	gpiodirectionout pin17
loop:
	gpioturnon pin17
	nanosleep
	gpioturnoff pin17
	nanosleep
	b loop
.data
pin17:
	.word 4 /* pin offset value in select */
	.align 4
pin22:
	.word 8 /* pin offset value in select */
	.align 4
