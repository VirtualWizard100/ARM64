.macro toupper string, buffer
        ldr x3, =\string
        ldr x4, =\buffer
1:
        ldrb w5, [x3], #1
        cmp w5, #'a'
        blt 2f
        cmp w5, #'z'
        bgt 2f
        sub x5, x5, #('a'-'A')
2:
        strb w5, [x4], #1
        cmp w5, #0
        bne 1b
        ldr x3, =\buffer
        sub x0, x4, x3
.endm
