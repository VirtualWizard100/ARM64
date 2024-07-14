.equ dfd, -100
.equ stdin, 0
.equ readwrite, 0666
.equ execute, 0100

.macro openat filename, flags, permissions
	ldr x0, =dfd //<--- Where the error is for gpioLed
	ldr x1, =\filename
	mov x2, #\flags
	ldr x3, =stdin
	mov x8, #0x38
	svc 0
.endm

.macro fchmod fd, permissions
	mov x0, \fd
	ldr x1, =\permissions
	mov x8, #0x34
	svc 0
.endm

.macro read fd, fillblock, length
	mov x0, \fd
	ldr x1, =\fillblock
	ldr x2, =\length
	mov x8, #0x3f
	svc 0
.endm

.macro write fd, string, length
	mov x0, \fd
	ldr x1, =\string
	mov x2, #\length
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
