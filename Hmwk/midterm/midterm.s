.data
	menutext: .asciz "Main Menu\n-------------\n1. Problem 1\n2. Problem 2\n3. Problem 3\nEnter the problem number\n"
	format: .asciz "%d"
	problem1text: .asciz "Problem 1"
.text

mainmenu:
	str lr, [sp,#-4]!
	ldr r0, address_of_menutext
	bl printf
	ldr lr, [sp], #+4
	bx lr
	


.globl main
main:
	bl mainmenu
	str lr, [sp,#-4]
	sub sp, sp, #4
	mov r1, sp
	ldr r0, 
	bl scanf
	ldr r0, [sp]
	bl printf
	add sp, sp, #+4    /* Discard the integer read by scanf */
    ldr lr, [sp], #+4  /* Pop the top of the stack and put it in lr */
	
	
	bx lr

address_of_menutext: .word menutext
address_of_format: .word format
	