.data
	menutext: .asciz "Main Menu\n-------------\n1. Problem 1\n2. Problem 2\n3. Problem 3\nEnter the problem number\n"
	format: .asciz "%d"
	problem1text: .asciz "\n\nEnter pay rate\n"
	problem1text2: .asciz "Enter hours worked\n"
	problem1text3: .asciz "Gross pay $%d\n"
	problem1text4: .asciz "Error, hours cannot be greater than 60\n"
	problem2text: .asciz "Problem 2\n"
	problem3text: .asciz "Enter Fibonacci term to be evaluated\n"
	problem3text2: .asciz "Evaluted number: %d\n"
	testformat: .asciz "you typed %d"
.text

mainmenu:
	str lr, [sp,#-4]!
	ldr r0, address_of_menutext
	bl printf
	ldr lr, [sp], #+4
	bx lr

problem1:
	str lr, [sp,#-4]!
	ldr r0, address_of_problem1text
	bl printf        @ask for payrate
	ldr r0, address_of_format
	sub sp, sp, #4
	mov r1, sp
	bl scanf         @get payrate
	ldr r0, address_of_problem1text2
	bl printf        @ask for hours
	ldr r0, address_of_format
	sub sp, sp, #4
	mov r1, sp
	bl scanf
	
	ldr r0, [sp] @r0 = hours
	add sp, sp, #+4
	ldr r1, [sp]  @r1 = payrate
	add sp, sp, #+4
	CMP r0, #20
	BLE nullovertime
	CMP r0, #40
	BLE doubletime
	CMP r0, #60
	BLE tripletime
	
	@REMEMBER TO GIVE ERROR FOR GREATER THAN 60 HOURS 
	ldr r0, address_of_problem1text4
	BL printf
	BAL badend
nullovertime:
	MUL r1, r0, r1
	BAL prob1end
doubletime:
	MOV r3, #20
	MUL r2, r1, r3
	sub r0, r0, #20
	MOV r1, r1, LSL#1
	MUL r0, r1, r0
	ADD r0, r0, r2
	MOV r1, r0
	BAL prob1end
tripletime:          @r0= hours
    @r1= payrate
	MOV r3, #20
	MUL r2, r1, r3   @r2 normal time
	MOV r3, r1
	str r3, [sp,#-4]!
	MOV r3, #20
	MOV r1, r1, LSL#1 @r1 payrate * 2
	MUL r3, r1, r3    @r3 double time
	ADD r2, r2, r3    @r2 normal time + double time
	MOV r1, r1, LSL#1 @r1 payrate * 2
	LDR r3, [sp]
	add sp, sp, #+4
	sub r1, r1, r3    @r1 payrate * 3
	sub r0, r0, #40   @r0 hours minus 40
	MUL r0, r1, r0    @r0 triplerate * triplehours
	ADD r0, r0, r2    @r0 = normal + double + triple time
	MOV r1, r0
	BAL prob1end
prob1end:
	ldr r0, address_of_problem1text3
	bl printf
	ldr lr, [sp], #+4
	bx lr
badend:
	ldr lr, [sp], #+4
	bx lr
problem2:
	push {lr}
	ldr r0, address_of_problem2text
	bl printf
	ldr lr, [sp], #+4
	bx lr
	
fibonacci:
	push {lr}
	MOV r0, #0  @r0 = first
	MOV r2, #1  @r2 = second
	MOV r3, #0  @r3 = c
	CMP r1, #0  @r1 = n seqence
	BEQ fibend
evalseq:
	CMP r3, r1
	BLT fibgo
fibgo:
	CMP r3, #1
	BGT elsefib
	
elsefib:
	sub r1, #1
	bl fibonacci
fibend:
	ldr lr, [sp], #+4
	bx lr

problem3:
	push {lr}
	ldr r0, address_of_problem3text
	bl printf
	ldr r0, address_of_format
	sub sp, sp, #4
	MOV r1, sp
	bl scanf
	ldr r1, [sp]       @r1 = fib value to evaluate
	add sp, sp, #+4    @scanf value knocked off stack
	bl fibonacci
	
	ldr r0, address_of_problem3text2
	BL printf
	
	ldr lr, [sp], #+4
	bx lr

	

.globl main
main:
	str lr, [sp,#-4]!
	bl mainmenu
	
	sub sp, sp, #4
	ldr r0, address_of_format
	mov r1, sp
	
	bl scanf
	ldr r1, [sp]
	add sp, sp, #+4    /* Discard the integer read by scanf */
	CMP r1, #1
	BLEQ problem1
	CMP r1, #2
	BLEQ problem2
	CMP r1, #3
	BLEQ problem3
	CMP r1, #0
	BEQ end
	BAL main
end:
    ldr lr, [sp], #+4  /* Pop the top of the stack and put it in lr */
	bx lr

address_of_menutext: .word menutext
address_of_format: .word format
address_of_testformat: .word testformat
address_of_problem1text: .word problem1text
address_of_problem1text2: .word problem1text2
address_of_problem1text3: .word problem1text3
address_of_problem1text4: .word problem1text4
address_of_problem2text: .word problem2text
address_of_problem3text: .word problem3text
address_of_problem3text2: .word problem3text2
