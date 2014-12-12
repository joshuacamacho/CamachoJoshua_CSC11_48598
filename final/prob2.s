.data
spacing: .asciz "\033[H\033[2J"
yeartext: .asciz "Value at Year #%d: "
valuetext: .asciz "$%.2f\n"
askyeartext: .asciz "Input for number of years from 1-20\n"
askratetext: .asciz "Input for the percentage of interest rate 5%% to 10%% without the %%\nExample: for 5%% type 5\n"
askpresentvaluetext: .asciz "Input for present value $1000-5000\n"
numberformat: .asciz "%d"

@ Variables
resultarray: .skip 128  @ result array
year: .word 0		    @ year number
rate: .word 0		    @ rate percentage
pv: .word 0		        @ present value

.text
putspacing:
	push {lr}
	ldr r0, =spacing
	bl printf                         @ Put spacing
	pop {lr}
	bx lr
	.global problem2
problem2:
	push {r4, lr}
	bl putspacing
	ldr r0, =askyeartext
	bl printf

	ldr r0,=numberformat
	ldr r1, =year
	bl scanf

	ldr r0, =askratetext
	bl printf

	ldr r0, =numberformat
	ldr r1, =rate
	bl scanf

	ldr r0, =askpresentvaluetext
	bl printf

	ldr r0, =numberformat
	ldr r1, =pv
	bl scanf

	mov r8, #0		        @index counter
	ldr r1, =year
	ldr r9, [r1]		    @r9=year

	ldr r1, =rate
	ldr r1, [r1]		    @r1=rate in percentage
	add r1, r1, #100
	vmov s0, r1		        @s0=int  interest rate
	vcvt.f32.s32 s14, s0	@s14=float interest rate in precentage
	mov r1, #100
	vmov s0, r1
	vcvt.f32.s32 s31, s0	@s31=10f
	vdiv.f32 s0, s14, s31	@s0=interest rate

	ldr r4, =resultarray
	@ calculate
	ldr r1, =pv
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
	mov r8, #0		        @reset index
	mov r7, #1
output:
	ldr r0, =yeartext
	mov r1, r7
	bl printf		        @output year
	ldr r0, =valuetext
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
