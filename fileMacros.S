#include <asm/unistd.h>

.equ dfd, -100
.equ stdin, 0
.equ readwrite, 0666
.equ execute, 0100
.equ stdout, 1

.macro openat filename, flags, permissions
	ldr x0, =dfd
	ldr x1, =\filename
	mov x2, #\flags
	ldr x3, =stdin
	mov x8, #__NR_openat
	svc 0
.endm

.macro fchmod fd, permissions
	mov x0, \fd
	ldr x1, =\permissions
	mov x8, #__NR_fchmod
	svc 0
.endm

.macro read fd, fillblock, length
	mov x0, \fd
	ldr x1, =\fillblock
	ldr x2, =\length
	mov x8, #__NR_read
	svc 0
.endm

.macro write fd, string, length
	mov x0, \fd
	ldr x1, =\string
	mov x2, #\length
	mov x8, #__NR_write
	svc 0
.endm

.macro fsync fd
	mov x0, \fd
	mov x8, #__NR_fsync
	svc 0
.endm

.macro close fd
	mov x0, \fd
	mov x8, #__NR_close
	svc 0
.endm
