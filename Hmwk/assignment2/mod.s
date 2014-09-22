	.global _start
_start:
	MOV R1,#13
	MOV R2,#5
	MOV R0,#0
	MOV R7,#1
	BAL compare
subtract:
	SUBS R1,R1,R2
compare:
	CMP R1,R2
	BGE subtract
	MOV R0,R1
end:
	SWI 0
