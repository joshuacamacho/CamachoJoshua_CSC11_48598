/* ax^2 +bx = ? */
.data
.balign 4
p4intro: .asciz"find ax^2+bx\nPlease input a num between 0 and 255\n"
.balign 4
p4scan: .asciz"%d"
.balign 4
x: .word 0
.balign 4
answer: .asciz" ax^2 +bx = %d\n"
.text
	.global problem4
problem4:
	push {lr}
	ldr r0, =p4intro
	bl printf
	ldr r0, addr_p4scan
	ldr r1, addr_x
	bl scanf

	ldr r1, =0x12b02	@a 	20bit >>20
	ldr r2, =0xe04188	@b 	24bit >>24
	ldr r3, addr_x
	ldr r3, [r3]		@0-255	 8bit
	mul r0, r1, r3		@ax 	28bit >>20
	mov r0, r0, asr #4	@ax	24bit >>16
	mul r0, r3, r0		@ax^2	32bit >>16

	mul r2, r3, r2		@bx	32bit >>24
	mov r2, r2, asr #8	@bx	>>16
	add r0, r0, r2		@ans	>>16
	mov r1, r0, asr #16


	ldr r0, =answer
	bl printf

	pop {lr}
	bx lr

addr_p4scan: .word p4scan
addr_x: .word x
