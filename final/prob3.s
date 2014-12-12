.data
.balign 4
p3intro: .asciz"Square root\n"
.balign 4
S: .word 0
.balign 4
scan: .asciz"%d"
.balign 4
prompt: .asciz"input a integer between 1 and 10000\n"
output: .asciz"square root is %f\n"
.balign 4
singleX: .float 100
.balign 4
tenX: .float 200
.balign 4
hundredX: .float 300
.balign 4
thousandX: .float 400
.balign 4
tenkX: .float 500
.balign 4
half: .float 2
.balign 4
testM: .asciz"%f\n"
.balign 4
thousand: .word 1000
.balign 4
tenK: .word 10000
.text
	.global prog3
prog3:
	push {r4, lr}
input:
	ldr r0, =p3intro
	bl printf
	ldr r0, addr_prompt
	bl printf
	ldr r0, addr_scan
	ldr r1, addr_S
	bl scanf

	ldr r1, addr_S
	ldr r1, [r1]
	mov r2, r1
	cmp r1, #1
	blt input
	cmp r1, #10
	ldrlt r1, =singleX
	blt setX
	mov r1, r2
	cmp r1, #100
	ldrlt r1, =tenX
	ldr r0, =thousand
	ldr r1, addr_S
	ldr r1, [r1]
	cmp r1, r0
	ldrlt r1, =hundredX
	blt setX
	ldr r0, =tenK
	ldr r1, addr_S
	ldr r1, [r1]
	cmp r1, r0
	ldrlt r0, =thousandX
	ldreq r0, =tenkX
	ble setX
	bgt input
setX:
	vldr s15, [r1]		@s15=Xo
	ldr r1, =half
	vldr s16, [r1]		@s16=0.5
	mov r10, #0		@counter
	ldr r1, addr_S
	ldr r1, [r1]
	vmov s12, r1
	vcvt.f32.s32 s14, s12
	vcvt.f64.f32 d0, s14
	ldr r0, =testM
	vmov r2, r3, d0
	bl printf

calculation:
	vmov s13, s15
	vdiv.f32 s17, s14, s15	@S/Xo
	vcvt.f64.f32 d0, s17
	ldr r0, =testM
	vmov r2, r3, d0
	bl printf
	vadd.f32 s15, s15, s17	@Xo +S/Xo
	vdiv.f32 s15, s15, s16
	vmov r5, s13
	vmov r6, s15
	cmp r5, r6
	bne calculation

	vcvt.f64.f32 d4, s15
	ldr r0, addr_output
	vmov r2, r3, d4
	bl printf


	pop {r4, lr}
	bx lr

addr_scan: .word scan
addr_S: .word S
addr_output: .word output
addr_half: .word half
addr_prompt: .word prompt
