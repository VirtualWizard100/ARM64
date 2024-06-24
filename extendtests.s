.global _start

_start:
	mov x0, #0xffffffff
	mov x1, #55
	uxtb w2, w0 /*lsl #4*/
exit:
	mov x0, #0
	mov x8, #93
	svc 0
