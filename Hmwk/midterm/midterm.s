.data
	menutext: .asciz "Main Menu\n-------------\n1. Problem 1\n2. Problem 2\n3. Problem 3\nEnter the problem number\n"
	format: .asciz "%d"
	problem1text: .asciz "Problem 1\n"
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
	CMP r1, #3
	
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
