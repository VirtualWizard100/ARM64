.global _start

.equ RDWR, 00000002
.equ SYNC, 00010000
.equ RESOLVE_IN_ROOT, 0x08
.equ MAP_SHARED, 0x01
.equ PROT_READ, 0x1
.equ PROT_WRITE, 0x2
.equ PAGELEN, 4096
.equ offset17, 21
.equ GPFSEL1, 0x04
.equ GPSET0, 0x1c
.equ GPCLR0, 0x28

_start:
	ldr x0, =RESOLVE_IN_ROOT /* Means you want to access another directory starting from root */
	ldr x1, =devmem		 /* The pathname for devmem as a zero placed string */
	mov x2, #(RDWR+SYNC)	 /* Read, and Write flags plus Sync to enable i/o operations of the returned file descriptor */
	mov x8, #0x38
	svc 0
	adds x4, xzr, x0	 /* The returned file descriptor */
	bpl Mmap
	mov x0, #1
	ldr x1, =errmessage
	ldr x2, =len
	mov x8, #0x40
	svc 0
	b exit
Mmap:
	ldr x0, =gpioBaseAddress /* The base address for the gpio pins */
	mov x1, #PAGELEN	 /* Page length, which is 4096 */
	mov x2, #(PROT_READ + PROT_WRITE) /* Pages may be Read, and Written */
	mov x3, #MAP_SHARED		  /* Updates to the mapping are visible to the other processes mapping the same region */
	/* adds x4, xzr, x0 from the openat function, so the returned file descriptor from opening dev/gpiomem */
	orr x5, x5, xzr 		  /* We dont need this parameter, so just put 0 */
	mov x8, #0xde
	svc 0
	adds x9, xzr, x0		  /* The returned file descriptor of the virtual page of memory created at the mapped address of 0xfe200000 */
	bpl Select
	mov x0, #1
	ldr x1, =errmessage
	mov x2, #len
	mov x8, #0x40
	svc 0
Select:
	mov x1, #0b001
	lsl x1, x1, #offset17
	str w1, [x9, #GPFSEL1]		 /* Each instruction interacting with the gpio pins has to be 32 bit, or else you will recieve a bus error, store the 3 bit value in x1 in the gpfsel1 offset address to set pin17 as an output */

loop:
	mov x1, #1
	str w1, [x9, #GPSET0]
	str w1, [x9, #GPCLR0]
	b loop

exit:
	mov x0, #0
	mov x8, #0x5d
	svc 0
.data
devmem:
	.asciz "/dev/gpiomem"
errmessage:
	.asciz "couldn't obtain file descriptor"
len = .-errmessage
gpioBaseAddress:
	.word 0xfe200000
