.data
	menutext: .asciz "
	Main Menu"
.text

.globl main
main:
	str lr, [sp,#-4]!
	ldr r0, address_of_menutext
	bl printf
	ldr lr, [sp], #+4
	bx lr

address_of_menutext: .word menutext
	