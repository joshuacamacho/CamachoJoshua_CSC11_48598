	.global _start
_start:
	MOV r2, #111
	MOV r3, #5
	MOV r4, #0
	MOV r5, #0
	MOV r6, #0
	MOV r7, #0
	MOV r8, #10
	MOV r9, #0
	MOV r1, r2
	CMP r1, r3
	BLT _swap
_divmod:
	MOV r6, #1
	MLA r7, r3, r6 @ r0 = r1 * r2
	MLA r9, r7, r8
	CMP r1, r9
	BGT _scale
_scale:
	ADD r6, r6, #10
	MLA r7, r3, r6
	MLA r9, r7, r8
	CMP r1, r9
	BGT _scale
_div:
	ADD r0, r0, r6
	SUB r1, r1, r7
	CMP r1, r7
	BGE _divmod
end:
	MOV r7, #1
	SWI 0






