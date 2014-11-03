@ Joshua Camacho
@ Project 1 
@ 11/2/14
.data
	introtext: .asciz "\n\n\n                            THE DUNGEON OF DESPAIR\n      .                                                      .\n        .n                   .                 .                  n.\n  .   .dP                  dP                   9b                 9b.    .\n 4    qXb         .       dX                     Xb       .        dXp     t\ndX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb\n9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP\n 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP\n  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'\n    `9XXXXXXXXXXXP' `9XX'          `98v8P'          `XXP' `9XXXXXXXXXXXP'\n        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~\n                        )b.  .dbo.dP'`v'`9b.odb.  .dX(\n                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.\n                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb\n                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb\n                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP\n                     `'      9XXXXXX(   )XXXXXXP      `'\n                              XXXX X.`v'.X XXXX\n                              XP^X'`b   d'`X^XX\n                              X. 9  `   '  P )X\n                              `b  `       '  d'\n                               `             '\n                            Press Enter to Continue\n"
	introtext2: .asciz "You awake in a dark dungeon cellar.\nYou have been wrongly banished to a realm of despair.\nYou you must defeat 10 different creatures from the realm of despair to escape.\nPress Enter to Continue\n"
	spacing: .asciz "\033[H\033[2J"
	charformat: .asciz "%c"
	entercontinue: .asciz "Press Enter to Continue\n"
	rattext: .asciz "You encounter a small rat, it is feral but it looks (mostly) harmless"
.text
entertocontinue:
	push {lr}
	ldr r0, address_of_entercontinue
	bl printf
	ldr r0, address_of_charformat
	sub sp, sp, #4
	mov r1, sp
	bl scanf                          @ Ask for enter to be pressed
	add sp, sp, #+4
	pop {lr}
	bx lr
putspacing:
	push {lr}
	ldr r0, address_of_spacing
	bl printf                         @ Put spacing
	pop {lr}
	bx lr
intro:
	push {lr}
	ldr r0, address_of_introtext
	bl printf                         @ Display Intro text
	bl putspacing
	ldr r0, address_of_introtext2
	bl printf                         @ Intro text 2
	bl entertocontinue
	bl putspacing
	pop {lr}
	bx lr
randnum:
	push {lr}
	@r0 is max num r1 is return
	mov r1, #20 @not random yet but return
	pop {lr}
	bx lr
loadmonster:
	push {lr}
	cmp r0, #20
	ble rat
rat:
	ldr r0, address_of_rattext
	mov r1, #20
	mov r2, #1
	bal endload
centipede:

giantspider:

madman:

skeleton:

ogre:

dragon:

endload:
	pop {lr}
	bx lr
.globl main

main:
	push {lr}
	bl intro	
	mov r10, #10 @ counter for battles
	mov r9, #100 @ hitpoints
fightloop:
	cmp r9, #0
	ble died
	ldr r0, #100 @ roll max value for monster
	bl randnum
	mov r0, r1 @set r0 to the rand num
	bl loadmonster
	bl printf
end:
	pop {lr}
	bx lr
died:
	@you died text
	bal end
address_of_introtext: .word introtext
address_of_introtext2: .word introtext2
address_of_spacing: .word spacing
address_of_charformat: .word charformat
address_of_entercontinue: .word entercontinue
address_of_rattext: .word rattext
