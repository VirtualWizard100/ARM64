.include "toUpper.s"

.global _start

_start:
	toupper message, fillblock
	mov x2, x0
	mov x0, #1
	ldr x1, =fillblock
	mov x8, #0x40
	svc 0
exit:
	mov x0, #0
	mov x8, #93
	svc 0

.data
message:
	.asciz "Oi lads.\n"
fillblock:
	.fill 255, 4, 0
