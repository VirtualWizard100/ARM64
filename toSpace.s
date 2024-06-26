.macro tospace string, buffer
        ldr x3, =\string
        ldr x4, =\buffer
	mov w6, #0x20
1:
        ldrb w5, [x3], #1
        cmp w5, #'z'
        bgt 3f
        cmp w5, #'A'
        blt 3f
        cmp w5, #'Z'
	bgt 2f
	strb w5, [x4], #1
	cmp w5, #0
	bne 1b
2:
        cmp w5, #'a'
        blt 3f
        strb w5, [x4], #1
        cmp w5, #0
        bne 1b

3:
        strb w6, [x4], #1
        cmp w5, #0
        bne 1b
        ldr x3, =\buffer
        sub x0, x4, x3
.endm
