.global _start

_start:
	ldr x0, =first
	ldr x1, [x0, #2]
	ldr x0, =second
	ldr x2, [x0, #8]
	ldr x0, =third
	ldr x3, [x0, #16]
/*	ldr x0, =fourth
	ldr x4, [x0, #32]*/
	ldr x0, =fifth
	ldr x5, [x0]
exit:
	mov x0, #0
	mov x8, #0x5d
	svc 0

.data
first:
	.align 4
	.byte 0xff, 0x6d, 0xa3
second:
	.align 4
	.short 0xffff, 0x5ae7, 0xa6fd
third:
	.align 4
	.word 0xffffffff, 0x3fe5a67f, 0x5eda2fe4
/*fourth:
	.align 8
	.double 0xffffffffffffffff, 0xfe5a6de19c4a3fc1*/
fifth:
	.align 4
	.octa 0xffffffffffffffffffffffffffffffff
