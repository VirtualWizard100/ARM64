.include "shellMacros.s"
.include "fileMacros.s"

.global _start

_start:
	ldr x9, =fillblock1
	getcwd fillblock1, len
	mov x3, #1
	ldr x10, =len
	write x3, fillblock1, x10
	mov x0, #0
	mov x8, #0x5d
	svc 0
.data
fillblock1:
	.fill 255, 1, 0
len = .-fillblock1
