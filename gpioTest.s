.include "gpioMacros.s"

.global _start


_start:
	gpioexport Pin17
	nanosleep
	gpiodirectionout Pin17
loop:
	cmp x5, #10
	beq exit
	writevalue Pin17, high
	nanosleep
	writevalue Pin17, low
	nanosleep
	add x5, x5, #1
	b loop
exit:
	mov x0, #0
	mov x8, #0x5d
	svc 0

.data
Pin17:
	.asciz "17"
Pin22:
	.asciz "22"
/*high:
	.asciz "1"
low:
	.asciz "0"
*/
