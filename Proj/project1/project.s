@ Joshua Camacho
@ Project 1 
@ 11/2/14
.data
	introtext: .asciz "\n\n\n                            THE DUNGEON OF DESPAIR\n      .                                                      .\n        .n                   .                 .                  n.\n  .   .dP                  dP                   9b                 9b.    .\n 4    qXb         .       dX                     Xb       .        dXp     t\ndX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb\n9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP\n 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP\n  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'\n    `9XXXXXXXXXXXP' `9XX'          `98v8P'          `XXP' `9XXXXXXXXXXXP'\n        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~\n                        )b.  .dbo.dP'`v'`9b.odb.  .dX(\n                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.\n                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb\n                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb\n                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP\n                     `'      9XXXXXX(   )XXXXXXP      `'\n                              XXXX X.`v'.X XXXX\n                              XP^X'`b   d'`X^XX\n                              X. 9  `   '  P )X\n                              `b  `       '  d'\n                               `             '\n                            "
	introtext2: .asciz "You awake in a dark dungeon cellar.\nYou have been wrongly banished to a realm of despair.\nYou you must defeat 10 different creatures from the realm of despair to escape.\n"
	spacing: .asciz "\033[H\033[2J"
	charformat: .asciz "%c"
	entercontinue: .asciz "Press Enter to Continue\n"
	rattext: .asciz "You encounter a small rat, it is feral but it looks (mostly) harmless\n"
	centipedetext: .asciz "A Large Centipede blocks your path.\n"
	giantspidertext: .asciz "A Giant Spider creeps out from the dark.\n"
	madmantext: .asciz "You come across a Mad Lunatic, a once criminal who lost his mind in the dungeon.\n"
	skeletontext: .asciz "An animated Skeleton lets loose a high pitch cackle as he readys his exposed bone arm to take a swing at you.\n"
	ogretext: .asciz "A large door slams to the ground in front of you and an Ogre brute walks through the doorway. Saliva is drooling from his fanged mouth as he's hungry for fresh meat.\n"
	dragontext: .asciz "You have found the lair of Eredran, the Frozen Dragon of the North. He's already noticed you, but it's not too late to run.\n"
	fightruntext: .asciz "Yourlife (%d) Monster strength (%d) will you (f)ight or (r)un?\n"
	fightbadinput: .asciz "What? do you want to (f)ight or (r)un?\n"

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
	bl entertocontinue
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
	mov r1, #100 @not random yet but return
	pop {lr}
	bx lr
loadmonster:
	push {lr}
	mov r2, #1
	cmp r0, #40
	ble rat
	cmp r0, #50
	ble centipede
	cmp r0, #60
	ble giantspider
	cmp r0, #70
	ble madman
	cmp r0, #80
	ble skeleton
	cmp r0, #90
	ble ogre
	cmp r0, #100
	ble dragon
rat:
	ldr r0, address_of_rattext
	mov r1, #20
	bal endload
centipede:
	ldr r0, address_of_centipedetext
	mov r1, #30
	bal endload
giantspider:
	ldr r0, address_of_giantspidertext
	mov r1, #40
	bal endload
madman:
	ldr r0, address_of_madmantext
	mov r1, #50
	bal endload
skeleton:
	ldr r0, address_of_skeletontext
	mov r1, #60
	bal endload
ogre:
	ldr r0, address_of_ogretext
	mov r1, #70
	bal endload
dragon:
	ldr r0, address_of_dragontext
	mov r1, #80
	bal endload
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
	mov r0, #100 @ roll max value for monster
	bl randnum
	mov r0, r1 @set r0 to the rand num
	bl loadmonster
	mov r8, r1 @ r8 = monster str 
	mov r7, r0 @ r7 = monster text
	mov r6, r2 @ r6 = monster alive
fightrunloop:
	mov r0, r7
	bl printf
	mov r1, r9
	mov r2, r8
	ldr r0, address_of_fightruntext
	bl printf
askloop:
	ldr r0, address_of_charformat
	sub sp, sp, #4
	mov r1, sp
	bl scanf
	ldr r1, [sp]
	add sp, sp, #+4
	cmp r1, #102 @did user type 'f'?
	beq rollfight
	cmp r1, #114 @did user type 'r'?
	beq rollrun
	ldr r0, address_of_fightbadinput
	bl printf
	bal askloop
rollfight:
	@roll against str
rollrun:
	@roll against runchance
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
address_of_centipedetext: .word centipedetext
address_of_giantspidertext: .word giantspidertext
address_of_madmantext: .word madmantext
address_of_skeletontext: .word skeletontext
address_of_ogretext: .word ogretext
address_of_dragontext: .word dragontext
address_of_fightruntext: .word fightruntext
address_of_fightbadinput: .word fightbadinput
