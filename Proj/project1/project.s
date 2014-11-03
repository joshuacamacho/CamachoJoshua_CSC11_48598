@ Joshua Camacho
@ Project 1 
@ 11/2/14
.data
	introtext: .asciz "\n\n\n                            THE DUNGEON OF DESPAIR\n      .                                                      .\n        .n                   .                 .                  n.\n  .   .dP                  dP                   9b                 9b.    .\n 4    qXb         .       dX                     Xb       .        dXp     t\ndX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb\n9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP\n 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP\n  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'\n    `9XXXXXXXXXXXP' `9XX'          `98v8P'          `XXP' `9XXXXXXXXXXXP'\n        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~\n                        )b.  .dbo.dP'`v'`9b.odb.  .dX(\n                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.\n                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb\n                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb\n                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP\n                     `'      9XXXXXX(   )XXXXXXP      `'\n                              XXXX X.`v'.X XXXX\n                              XP^X'`b   d'`X^XX\n                              X. 9  `   '  P )X\n                              `b  `       '  d'\n                               `             '\n                            Press Enter to Continue\n"
	introtext2: .asciz "You awake in a dark dungeon cellar.\nYou have been wrongly banished to a realm of despair.\nYou you must defeat 10 different creatures from the realm of despair to escape.\n Press Enter to Continue\n"
	spacing: .asciz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	charformat: .asciz "%c"

.text




.globl main

main:
	push {lr}
	ldr r0, address_of_introtext
	bl printf                         @ Display Intro text
	ldr r0, address_of_charformat
	sub sp, sp, #4
	mov r1, sp
	bl scanf                          @ Ask for enter to be pressed
	add sp, sp, #+4
	ldr r0, address_of_spacing
	bl printf                         @ Put spacing
	ldr r0, address_of_introtext2
	bl printf                         @ Intro text 2
	sub sp, sp, #4
	mov r1, sp
	bl scanf                          @ Ask for enter to be pressed
	add sp, sp, #+4

end:
	pop {lr}
	bx lr

address_of_introtext: .word introtext
address_of_introtext2: .word introtext2
address_of_spacing: .word spacing
address_of_charformat: .word charformat
