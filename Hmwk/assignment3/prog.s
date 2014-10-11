	.global main
main:
	MOV r2, #111
	MOV r3, #5
	MOV r4, #0
	MOV r5, #0
	MOV r6, #0
	MOV r7, #0
	MOV r8, #10
	MOV r9, #0
	MOV r1, r2
divmod:
	CMP r1, r3
	BGT scale
scale:
	MOV r6, #1
	MLA r7, r3, r6
	MLA r9, r7, r8
	CMP r1, r9
	BGT scale2
scale2:
	MLA r6, r6, r8
	MLA r7, r3, r6
	MLA r9, r7, r8
	CMP r1, r9
	BGT scale2
div:
	ADD r0, r0, r6
	SUB r1, r1, r7
	CMP r1, r7
	BGE div
	CMP r6, #1
	BGT scale
	CMP r4, #1
	BEQ last
	BAL end
last
	MOV r5, r0
	MOV r0, r1
	MOV r1, r5
end:
	MOV r7, #1
	SWI 0
