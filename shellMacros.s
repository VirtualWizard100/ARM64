.macro getcwd buffer, len
	ldr x0, =\buffer
	ldr x1, =\len
	mov x8, #0x11
	svc 0
.endm

