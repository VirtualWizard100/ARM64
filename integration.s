.global _start

_start:
	ldr w0, =0xffffffff
	and w1, w0, #0xff
	and w2, w0, #0xff00
	and w3, w0, #0xff0000
	and w4, w0, #0xff000000
	eor w0, w0, w0
exit:
	mov w0, #0
	mov w8, #0x5d
	svc 0
