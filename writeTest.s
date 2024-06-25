.include "fileMacros.s"

.equ stdout, 1

.global _start

_start:
	mov x3, #1
	write x3, message, len
	mov x0, #0
	mov x8, #0x5d
	svc 0
.data
message:
	.asciz "Oi lads.\n"
len = .-message
