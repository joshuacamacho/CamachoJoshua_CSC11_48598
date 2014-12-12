.data
spacing: .asciz "\033[H\033[2J"
.balign 4
introtextshifting: .asciz "Calculating ax^2+bx with shifting\n\Input a num between 0 and 255 to be used for x\n"
.balign 4
numberformat: .asciz "%d"
.balign 4
x: .word 0
.balign 4
answertext: .asciz " ax^2 +bx = %d\n"
.text
putspacing:
	push {lr}
	ldr r0, =spacing
	bl printf                         @ Put spacing
	pop {lr}
	bx lr
	.global problem4
problem4:
	push {lr}
	bl putspacing
	ldr r0, =introtextshifting
	bl printf                         @ intro
	ldr r0, address_of_numberformat
	ldr r1, adress_of_x
	bl scanf            @ input x
	ldr r1, =0x12b02	@a 	20bit >>20
	ldr r2, =0xe04188	@b 	24bit >>24
	ldr r3, adress_of_x
	ldr r3, [r3]		@0-255	 8bit
	mul r0, r1, r3		@ax 	28bit >>20
	mov r0, r0, asr #4	@ax	24bit >>16
	mul r0, r3, r0		@ax^2	32bit >>16

	mul r2, r3, r2		@bx	32bit >>24
	mov r2, r2, asr #8	@bx	>>16
	add r0, r0, r2		@ans	>>16
	mov r1, r0, asr #16


	ldr r0, =answertext
	bl printf           @ print answer

	pop {lr}
	bx lr

address_of_numberformat: .word numberformat
adress_of_x: .word x
