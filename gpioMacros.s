.include "fileMacros.s"

.equ Write, 0222

.macro nanosleep
	ldr x0, =nanosleeptime
	ldr x1, =nanosleeptime
	mov x8, #0x65
	svc 0
.endm

.macro gpioexport pin
	openat gpioExport, Write, stdin
	mov x9, x0
	write x9, \pin, 2
	fsync x9
	close x9
.endm

.macro gpiodirectionout  pin
	ldr x1, =\pin
	ldr x2, =gpioDirection
	add x2, x2, #20
	ldrb w3, [x1], #1
	strb w3, [x2], #1
	openat gpioDirection, Write, stdin
	mov x9, x0
	write x9, outString, 3
	fsync x9
	close x9
.endm

.macro writevalue pin, value
	ldr x1, =\pin
	ldr x2, =gpioValue
	add x2, x2, #20
	ldrb w3, [x1], #1
	strb w3, [x2], #1
	ldrb w3, [x1], #1
	strb w3, [x2], #1
	openat gpioValue, Write, stdin
	mov x9, x0
	write x9, \value, 1
	fsync x9
	close x9
.endm

.data
nanosleeptime:
	.dword 0
nanosleepremaining:
	.dword 100000000
gpioExport:
	.asciz "/sys/class/gpio/export"
gpioDirection:
	.asciz "/sys/class/gpio/gpioxx/direction"
gpioValue:
	.asciz "/sys/class/gpio/gpioxx/value"
outString:
	.asciz "out"
	.align 4
high:
	.asciz "1"
low:
	.asciz "0"
