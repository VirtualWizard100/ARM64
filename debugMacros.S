.macro printReg reg
	/* Essentially all of the stp instructions are a more efficient way of
	   doing push {x0-x18, lr}, and all of the ldp instructions are a more
	   efficient way of doing pop {x0-x18, lr} */
	/* we offset the stack pointer by -16/16 because all of the words in
	   memory are 64 bit, which means they are 8 bytes long, and so are all
	   of the registers, which means that storing and loading 2 registers
	   at a time would be 128 bits each instruction, which is 16 bytes */
	stp x0, x1, [sp, #-16]!
	stp x2, x3, [sp, #-16]!
	stp x4, x5, [sp, #-16]!
	stp x6, x7, [sp, #-16]!
	stp x8, x9, [sp, #-16]!
	stp x10, x11, [sp, #-16]!
	stp x12, x13, [sp, #-16]!
	stp x14, x15, [sp, #-16]!
	stp x16, x17, [sp, #-16]!
	stp x18, lr, [sp, #-16]!
	mov x2, X\reg
	mov x3, X\reg
	mov x1, #\reg
	add x1, x1, #'0'
	ldr x0, =printFormatString
	bl printf
	ldp x18, lr, [sp], #16
	ldp x16, x17, [sp], #16
	ldp x14, x15, [sp], #16
	ldp x12, x13, [sp], #16
	ldp x10, x11, [sp], #16
	ldp x8, x9, [sp], #16
	ldp x6, x7, [sp], #16
	ldp x4, x5, [sp], #16
	ldp x2, x3, [sp], #16
	ldp x0, x1, [sp], #16
.endm

.macro printstring string
	stp x0, x1, [sp, #-16]!
	stp x2, x3, [sp, #-16]!
	stp x4, x5, [sp, #-16]!
	stp x6, x7, [sp, #-16]!
	stp x8, x9, [sp, #-16]!
	stp x10, x11, [sp, #-16]!
	stp x12, x13, [sp, #-16]!
	stp x14, x15, [sp, #-16]!
	stp x16, x17, [sp, #-16]!
	stp x18, lr, [sp, #-16]!
	ldr x0, =1f
	bl printf
	ldp x18, lr, [sp], #16
	ldp x16, x17, [sp], #16
	ldp x14, x15, [sp], #16
	ldp x12, x13, [sp], #16
	ldp x10, x11, [sp], #16
	ldp x8, x9, [sp], #16
	ldp x6, x7, [sp], #16
	ldp x4, x5, [sp], #16
	ldp x2, x3, [sp], #16
	ldp x0, x1, [sp], #16
	b 2f
1:
	.asciz "\str\n"
2:
.endm
.data
printFormatString:
	.asciz "X%c = %321d, 0x%0161x\n"
	.align 4

