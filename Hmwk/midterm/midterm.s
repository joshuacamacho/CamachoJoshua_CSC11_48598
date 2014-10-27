.data
	menutext: asciz "222222"
.text

.globl main
main:
	str lr, [sp,#-4]!
	ldr r0 adress_of_menutext
	bl printf
	ldr lr, [sp], #+4
	bx lr

adress_of_menutext: .word menutext
	