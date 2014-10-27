.data
	menutext: .asciz "Main Menu\n-------------\n1. Problem 1\n2. Problem 2\n3. Problem 3\nEnter the problem number\n"
	format: .asciz "%d"
	problem1text: .asciz "\n\nEnter pay rate\n"
	problem1text2: .asciz "Enter hours worked\n"
	problem1text3: .asciz "Gross pay $%d\n"
	problem2text: .asciz "Problem 2\n"
	problem3text: .asciz "Problem 3\n"
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
	BEQ nullovertime
	CMP r0, #40
	BLE doubletime
	CMP r0, #60
	BLE tripletime
	
	@REMEMBER TO GIVE ERROR FOR GREATER THAN 60 HOURS 
	BAL end 
nullovertime:
	MUL r1, r0, r1
	BAL prob1end
doubletime:
	MOV r3, #20
	BAL prob1end
tripletime:
	BAL prob1end
prob1end:
	ldr r0, address_of_problem1text3
	bl printf
	ldr lr, [sp], #+4
	bx lr
problem2:
	str lr, [sp,#-4]!
	ldr r0, address_of_problem2text
	bl printf
	ldr lr, [sp], #+4
	bx lr
problem3:
	str lr, [sp,#-4]!
	ldr r0, address_of_problem3text
	bl printf
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
	@ldr r0, address_of_testformat
	@bl printf
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
address_of_problem2text: .word problem2text
address_of_problem3text: .word problem3text
