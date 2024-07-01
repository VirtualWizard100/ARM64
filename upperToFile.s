.include "toUpper.s"
.include "fileMacros.s"

.equ create, 0100
.equ readWrite, 0666
.equ stdin, 0

.global _start

_start:
	openat file, readWrite, stdin
	mov x9, x0
	read x9, fillblock, len
        close x9
	toupper fillblock, fillblock2
	mov x10, x0
	openat file2, create+readWrite, stdin
	mov x9, x0
	fchmod x9, create+readWrite
	write x9, fillblock2, x10
	fsync x9
	close x9
	mov x0, #0
	mov x8, #0x5d
	svc 0

.data
file:
	.asciz "string.txt"
file2:
	.asciz "stringUpper.txt"
fillblock:
	.fill 100, 1, 0
len = .-fillblock
fillblock2:
	.fill 100, 1, 0
len2 = .-fillblock2
