.data
/* text */
inYear: .asciz"Input the number of years 1-20\n"
inInt: .asciz"Inptut the percentage of the interest rate (5%%-10%%) 5%% input 5\n"
inPrtvle: .asciz"Input the present value $1000-5000\n"
outyear: .asciz"%d year,"
outvle: .asciz" value = $%f\n"
/* format */
scan: .asciz"%d"
/* var */
farr: .skip 128		@result array
year: .word 0		@number of year
intrt: .word 0		@interset value 5%-10%
prtvle: .word 0		@present value

.text
	.global problem2
problem2:
	push {r4, lr}
	ldr r0, =inYear
	bl printf

	ldr r0,=scan
	ldr r1, =year
	bl scanf

	ldr r0, =inInt
	bl printf

	ldr r0, =scan
	ldr r1, =intrt
	bl scanf

	ldr r0, =inPrtvle
	bl printf

	ldr r0, =scan
	ldr r1, =prtvle
	bl scanf

	mov r8, #0		@index counter
	ldr r1, =year
	ldr r9, [r1]		@r9=year

	ldr r1, =intrt
	ldr r1, [r1]		@r1=intrt in percentage
	add r1, r1, #100
	vmov s0, r1		@s0=int  interest rate
	vcvt.f32.s32 s14, s0	@s14=float interest rate in precentage
	mov r1, #100
	vmov s0, r1
	vcvt.f32.s32 s31, s0	@s31=10f
	vdiv.f32 s0, s14, s31	@s0=interest rate

	ldr r4, =farr
	/* calculation */
	ldr r1, =prtvle
	ldr r1, [r1]
	vmov s31, r1
	vcvt.f32.s32 s14, s31
cal:
	vmul.f32 s31, s14, s0	@s31 = value of r8+1 year
	vmov s14, s31
	vmov r1, s14
	str r1, [r4, r8, lsl #2]
	add r8, r8, #1
	cmp r8, r9
	blt cal
	mov r8, #0		@reset index
	mov r7, #1
output:
	ldr r0, =outyear
	mov r1, r7
	bl printf		@output year
	ldr r0, =outvle
	ldr r5, [r4, r8, lsl #2]
	vmov s0, r5
	vcvt.f64.f32 d5, s0
	vmov r2, r3, d5
	bl printf
	add r7, r7, #1
	add r8, r8, #1
	cmp r8, r9
	blt output
p2end:
	pop {r4, lr}
	bx lr
