.data
	menutext: .asciz "Main Menu\n-------------\n1. Problem 1\n2. Problem 2\n3. Problem 3\nEnter the problem number\n"
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
	bx lr

address_of_menutext: .word menutext
	