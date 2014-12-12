@ Joshua Camacho
@ CSC-11 Final
@ 12/12/14

.data
@ Main Menu 
.balign 4
introtext: .asciz "Main Menu\n"
.balign 4
prob1: .asciz "1. Problem 1\n"
.balign 4
prob2: .asciz "2. Problem 2\n"
.balign 4
prob3: .asciz "3. Problem 3\n"
.balign 4
prob4: .asciz "4. Problem 4\n"
.balign 4
probexit: .asciz "0. Exit\n"
.balign 4
scanMenu: .asciz "%d"
.balign 4
inputchoice: .word 0
.balign 4
repeat: .asciz "You typed %d\n"
.balign 4
exit: .asciz "Press %d to exit\n"


.text
	.global main
main:
	push {r4, lr}
menu:
	ldr r0, =introtext
	bl printf
	ldr r0, =prob1
	bl printf
	ldr r0, =prob2
	bl printf
	ldr r0, =prob3
	bl printf
	ldr r0, =prob4
	bl printf		@ show menu
	ldr r0, =probexit
	bl printf

	ldr r0, =scanMenu
	ldr r1, =inputchoice
	bl scanf		@ User choose problem
	ldr r0, =repeat
	ldr r1, =inputchoice
	ldr r1, [r1]
	mov r5, r1
	bl printf

	mov r1, r5		 
	cmp r1, #1
	bleq problem1  @ Branch to Problem 1
	beq menu

	mov r1, r5		
	cmp r1, #2
	bleq problem2  @ Branch to Problem 2
	beq menu

	mov r1, r5		
	cmp r1, #3
	bleq problem3  @ Branch to Problem 3
	beq menu

	mov r1, r5		
	cmp r1, #4
	bleq problem4  @ Branch to Problem 4
	

end:
	
	pop {r4, lr}
	bx lr

/* external */
.global printf
.global scanf
.global strcmp
