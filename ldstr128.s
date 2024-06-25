.global _start

_start:
	ldr x1, =quad
	ldp x2, x3, [x1]
	stp x2, x3, [x1]
exit:
	mov x0, #0
	mov x8, #0x5d
	svc 0
.data
quad:
	.octa 0xffffffffffffffffffffffffffffffff
