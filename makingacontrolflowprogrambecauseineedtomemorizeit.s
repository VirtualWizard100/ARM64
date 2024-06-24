.global _start

_start:
	mov x5, #1
loop:
	cmp x5, #2
	blt firstMessage
	beq secondMessage
	bgt thirdMessage
firstMessage:
	mov x0, #1
	ldr x1, =message1
	ldr x2, =len
	mov x8, #0x40
	svc 0
	add x5, x5, #1
	b loop
secondMessage:
	mov x0, #1
	ldr x1, =message2
	ldr x2, =len2
	mov x8, 0x40
	svc 0
	add x5, x5, #1
	b loop
thirdMessage:
	mov x0, #1
	ldr x1, =message3
	ldr x2, =len3
	mov x8, #0x40
	svc 0
	add x5, x5, #1
	cmp x5, #3
	bne exit
exit:
	mov x0, #1
	ldr x1, =exitMessage
	ldr x2, =len4
	mov x8, #0x40
	svc 0
	mov x0, #0
	mov x8, #0x5d
	svc 0
.data
message1:
	.asciz "This will come first.\n"
len = .-message1
message2:
	.asciz "This will come second.\n"
len2 = .-message2
message3:
	.asciz "This will come third.\n"
len3 = .-message3
exitMessage:
	.asciz "finally, it will exit.\n"
len4 = .-exitMessage
