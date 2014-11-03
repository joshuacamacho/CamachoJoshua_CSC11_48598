@ Joshua Camacho
@ Project 1 
@ 11/2/14
.data
	introtext: .asciz "                            THE DUNGEON OF DESPAIR\n      .                                                      .\n        .n                   .                 .                  n.\n  .   .dP                  dP                   9b                 9b.    .\n 4    qXb         .       dX                     Xb       .        dXp     t\ndX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb\n9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP\n 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP\n  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'\n    `9XXXXXXXXXXXP' `9XX'          `98v8P'          `XXP' `9XXXXXXXXXXXP'\n        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~\n                        )b.  .dbo.dP'`v'`9b.odb.  .dX(\n                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.\n                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb\n                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb\n                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP\n                     `'      9XXXXXX(   )XXXXXXP      `'\n                              XXXX X.`v'.X XXXX\n                              XP^X'`b   d'`X^XX\n                              X. 9  `   '  P )X\n                              `b  `       '  d'\n                               `             '"
	

.text




.globl main

main:
	pop {lr}
	@stuffs
	ldr r0, address_of_introtext
	bl printf


end:
	push {lr}
	bx lr

address_of_introtext: .word introtext