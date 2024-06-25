.macro write fd, string, length
	mov x0, \fd
	ldr x1, =\string
	mov x2, \length
	mov x8, #0x40
	svc 0
.endm

.macro fsync fd
	mov x0, \fd
	mov x8, #0x52
	svc 0
.endm

.macro close fd
	mov x0, \fd
	mov x8, #0x39
	svc 0
.endm
