.global _start

_start:
	mov x0, #0xffffff00
	ldr x1, =0xe000ff
	add x2, x0, x1, uxtb
exit:
	mov x0, #0
	mov x8, #93
	svc 0
