.include "fileMacros.s"

/*.equ baseGpioAddress, 0x7e200000*/
.equ prot_read, 1
.equ prot_write, 2
.equ map_shared, 1
/*.equ execute, 0200*/
.equ pageLength, 4096
.equ setregoffset, 28
.equ clrregoffset, 40

/* mmap creates a virtual page of memory in a specified, or non specified
   directory, with a varible page size/length for the page created, then returns
   a virtual address for the virtual page created */
.macro mmapdevmem
	openat devmem, execute+readwrite, stdin
	adds x4, xzr, x0 /* mov devmem file descriptor into x4 */
	/* Error handling code */
	bpl 1f
	mov x1, #1
	ldr x2, =devmemerrmessage
	ldr w2, [x2]
	mov x8, #0x40
	svc 0
	mov x0, #2
	mov x8, #0x5d
	svc 0
1:
	ldr x5, =baseGpioAddress/* Load the base gpio address into x5 */
	ldr x5, [x5]		/* Load the value from the base gpio address */
	mov x0, #0		/* move 0 into x0 for stdin */
	mov x1, #pageLength	/* move 4096 which is the page length into x1 */
	mov x2, #(prot_read + prot_write) /* move protect read, and protect write permissions into x2 */
	mov x3, #map_shared	/* move the map shared value into x3, which is 1 */
	mov x8, #0xde		/* load the value for the mmap syscall into x8 */
	svc 0			/* call mmap */
	adds x9, xzr, x0	/* Obtain file descriptor returned from mmap */
	bpl 2f
	mov x1, #1
	write x1, errmessage, len
2:
	/* x0 = 0
	   x1 = 4096
	   x2 = 3
	   x3 = 1
           x4 = fd for /dev/mem
	   x5 = value in baseGpioAddress
	   x8 = 0xde / mmap
	   x9 = mmap returned file descriptor */
.endm

.macro nanosleep
	ldr x0, =timeamount
	ldr x1, =timeamount
	mov x8, #0x65
	svc 0
.endm

.macro gpiodirectionout pin
	ldr x2, =\pin	/* Load the pin number into x2 */
	ldr w2, [x2]	/* Load the value of that pin number into x2 */
	ldr w1, [x9, x2]/* Load into x1 the value of the file descriptor of mmap offset by the value of the pin that you're trying to set */
	ldr x3, =\pin	/* Load the pin number into x3 */
	add x3, x3, #4	/* add the amount to shift to the pin number */
	ldr x3, [x3]	/* Load the value of the shift amount of the pin into x3 */
	mov x0, #0b111	/* Load 3 1 bits (which is the clear value) into x0 */
	lsl x0, x0, x3	/* Shift the 3 1 bits by the pin shift amount */
	bic x1, x1, x0	/* Use the 3 bits to clear the mmap offset file descriptor value */
	mov x0, #1	/* Move 1 into x0 for the out value */
	lsl x0, x0, x3	/* Shift the out bit by the pin shift amount */
	orr x1, x1, x0	/* orr the out bit with the mmap file descriptor pin offset value */
	str w1, [x9, x2]/* store the out bit into the mmap file descriptor pin offset */
.endm

.macro gpioturnon pin
	mov x2, x9
	add x2, x2, #setregoffset
	mov x0, #1
	ldr x3, =\pin
	add x3, x3, #8
	ldr x3, [x3]
	lsl x0, x0, x3
	str w0, [x2]
.endm

.macro gpioturnoff pin
	mov x2, x9
	add x2, x2, #clrregoffset
	mov x0, #1
	ldr x3, =\pin
	add x3, x3, #8
	ldr w3, [x3]
	lsl x0, x0, x3
	str w0, [x2]
.endm

.data
devmem:
	.asciz "/dev/mem"
timeamount:
	.align 4
	.dword 0
timeremaining:
	.align 4
	.dword 10000000
gpioBaseAddress:
	.align 4
	.dword fe200000
errmessage:
	.asciz "Couldn't obtain file descriptor for /dev/mem\n"
len = .-errmessage
devmemerrmessage:
	.asciz "Couldn't obtain devmem file descriptor\n"
len2 = .-devmemerrmessage
