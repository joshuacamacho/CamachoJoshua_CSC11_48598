.data
spacing: .asciz "\033[H\033[2J"
invalidtext: .asciz "Invalid input\n"
introtext: .asciz "I have a number between 1 and 1000\nCan you guess my number?\nYou will be given a maximum of 10 guesses."
toolowtext: .asciz "Too low.  Try again.\n"
toohightext: .asciz "Too High. Try again.\n"
youlosetext: .asciz "Too many tries, you lose.\n"
youwintext: .asciz "1. You guessed my number, you win!\n"
trytext: .asciz "\nTry #%d .\n"
playagaintext: .asciz "Would you like to play again (y)es or (n)o?\n"
.align 4
numformat: .asciz "%d"
.align 4
charformat: .asciz "%s"

@ Variables
.align 4
inputguess: .word 0
.align 4
inputyesno: .word 0
.align 4
y: .asciz "y"
.align 4
n: .asciz "n"

.text
putspacing:
	push {lr}
	ldr r0, =spacing
	bl printf                         @ Put spacing
	pop {lr}
	bx lr
	.global problem1
problem1:
	push {r4, lr}
	bl putspacing
p1start:
	mov r7, #1			@ Counter for Num Trys
	mov r0, #0
	bl time
	bl srand			@ Set the Seed
	bl rand				@ r0 is the random number
	mov r1, r0, asr #1		
	ldr r2, =1000			
	bl divMod			@ rand()%1000, 
	mov r5, r1			
	ldr r0, =introtext
	bl printf			@ Display Intro text
p1loop:
	ldr r0, =trytext
	mov r1, r7
	bl printf			@ Display number of tries
	ldr r0, =numformat
	ldr r1, =inputguess
	bl scanf			@ Get input
	ldr r1, =inputguess
	ldr r1, [r1]		 
	mov r3, r1			
	cmp r7, #10
	ldreq r0, =youlosetext
	bleq printf
	beq playagainstate
	mov r2, r5
	cmp r1, r2
	blt low
	beq winstate
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
winstate:
	ldr r0, =youwintext
	bl printf	
playagainstate:
	ldr r0, =playagaintext
	bl printf
	ldr r0, =charformat
	ldr r1, =inputyesno
	bl scanf
	ldr r0, =inputyesno
	ldr r1, =y
	bl strcmp
	beq p1start
	ldr r0, =inputyesno
	ldr r1, =n
	bl strcmp
	beq p1end
	ldrne r0, =invalidtext
	blne printf
	bne playagainstate
p1end:
	pop {r4, lr}
	bx lr

.global time
.global srand
.global rand
.global strcmp
