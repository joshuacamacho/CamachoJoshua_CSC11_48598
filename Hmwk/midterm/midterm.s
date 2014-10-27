.data
	menutext: .asciz "Main Menu\n-------------\n1. Problem 1\n2. Problem 2\n3. Problem 3\nEnter the problem number\n"
	format: .asciz "%d"
	problem1text: .asciz "\n\nEnter pay rate\n"
	problem1text2: .asciz "\n\nEnter hours worked\n"
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
	ldr r0, address_of_problem2text
	
	bl printf        @ask for hours
	ldr r0, address_of_format
	sub sp, sp, #4
	mov r1, sp
	bl scanf
	
	ldr r0, [sp]
	add sp, sp, #+4
	ldr r1, [sp]
	add sp, sp, #+4
	
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
address_of_problem2text: .word problem2text
address_of_problem3text: .word problem3text
