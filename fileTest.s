.include "fileMacros.s"
/*.include "shellMacros.s"*/

.equ create, 0100
.equ readWrite, 0666
.equ stdin, 0

.global _start

_start:
	/*getcwd fillblock, len2
	adds x10, xzr, x0*/
	openat file, create+readWrite, stdin
	adds x9, xzr, x0
	bpl writeFile
	mov x0, #1
	ldr x1, =errMessage
	ldr x2, =len3
	mov x8, #0x40
	svc 0
exit:
	mov x0, #2
	mov x8, #0x5d
	svc 0

writeFile:
	fchmod x9, readWrite
	write x9, message, len
	fsync x9
	close x9
	mov x0, #0
	mov x8, #0x5d
	svc 0

.data
file:
	.asciz "string.txt"
message:
	.asciz "Oi lads.\n"
len = .-message
/*fillblock:
	.fill 30, 1, 0
len2 = .-fillblock*/
errMessage:
	.asciz "failed to create file descriptor\n"
len3 = .-errMessage
