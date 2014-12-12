.data
introtext: .asciz "I have a number between 1 and 1000\nCan you guess my number?\nYou will be given a maximum of 10 guesses."
youwintext: .asciz "1. You guessed my number, you win!\n"
toolowtext: .asciz "2. Too low.  Try again.\n"
toohightext: .asciz "3. Too High. Try again.\n"
youlosetext: .asciz "4. Too many tries, you lose.\n"
trytext: .asciz "\nTry #%d .\n"
qYN: .asciz"Would you like to play again (y)es or (n)o?\n"
inv: .asciz"Invalid input\n"
/* scan format */
.align 4
scan: .asciz"%d"
.align 4
scanYN: .asciz"%s"
/* var */
.align 4
in: .word 0
.align 4
ansYN: .word 0
.align 4
y: .asciz "y"
.align 4
n: .asciz "n"

.text
	.global problem1
problem1:
	push {r4, lr}
p1start:
	mov r7, #1			@try counter
	mov r0, #0
	bl time
	bl srand			@set seed
	bl rand				@r0=rand number
	mov r1, r0, asr #1		@cfm positive
	ldr r2, =1000			@r2=1000
	bl divMod			@rand()%1000, r1=ans
	mov r5, r1			@r5=ans
/*	ldr r0, =scan
	bl printf*/
	ldr r0, =introtext
	bl printf			@output intro
p1loop:
	ldr r0, =trytext
	mov r1, r7
	bl printf			@output try counter
	ldr r0, =scan
	ldr r1, =in
	bl scanf			@input in
	ldr r1, =in
	ldr r1, [r1]		@r1=in
	mov r3, r1			@r3=in
	cmp r7, #10
	ldreq r0, =youlosetext
	bleq printf
	beq Question
	mov r2, r5
	cmp r1, r2
	blt low
	beq bingo
	bgt high
low:
	ldr r0, =toolowtext
	bl printf
	b p1count
high:
	ldr r0, =toohightext
	bl printf
	b p1count
p1count:
	add r7, r7, #1
	cmp r7, #11
	ble p1loop
bingo:
	ldr r0, =youwintext
	bl printf
Question:
	ldr r0, =qYN
	bl printf
	ldr r0, =scanYN
	ldr r1, =ansYN
	bl scanf
	ldr r0, =ansYN
	ldr r1, =y
	bl strcmp
	beq p1start
	ldr r0, =ansYN
	ldr r1, =n
	bl strcmp
	beq p1end
	ldrne r0, =inv
	blne printf
	bne Question
p1end:
	pop {r4, lr}
	bx lr

.global time
.global srand
.global rand
.global strcmp
