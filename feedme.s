.include "toUpper.s"
.global _start

_start:
	ldr x3, =0x002e656d2064656566
	ldr x4, =fillblock
	ldr x5, =lowercase
	str x3, [x5]
	toupper lowercase, fillblock
	orr x5, xzr, x0
	mov x0, #1
	ldr x1, =fillblock
	sub x2, x4, x5
	mov x8, #0x40
	svc 0
exit:
	mov x0, #0
	mov x8, #0x5d
	svc 0
.data
lowercase:
	.fill 30, 4, 0
fillblock:
	.fill 30, 4, 0
