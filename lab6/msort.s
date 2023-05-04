merge_sort:
	lea	eax, 1[rsi]
	mov	ecx, 2
	push	r12
	mov	r12, rdi
	cdq
	push	rbp
	idiv	ecx
	push	rbx
	mov	ebx, esi
	mov	ebp, eax
	cmp	esi, 2
	jle	.L33
	mov	esi, eax
	call	merge_sort
.L33:
	sub	ebx, ebp
	cmp	ebx, 1
	jle	.L34
	movsx	rax, ebp
	mov	esi, ebx
	lea	rdi, [r12+rax*8]
	call	merge_sort
.L34:
	mov	edx, ebx
	mov	esi, ebp
	pop	rbx
	mov	rdi, r12
	pop	rbp
	xor	eax, eax
	pop	r12
	jmp	merge
merge:
	push	r13
	push	r12
	push	rbp
	mov	ebp, esi
	push	rbx
	push	rcx
.L20:
	movsx	rax, ebp
	lea	rbx, [rdi+rax*8]
	movsx	rax, edx
	lea	r12, [rbx+rax*8]
	test	ebp, ebp
	je	.L1
	test	edx, edx
	je	.L1
	mov	rax, QWORD PTR -8[rbx]
	cmp	QWORD PTR [rbx], rax
	jge	.L1
	mov	eax, 4
	cmp	edx, eax
	cmovle	eax, edx
	cmp	ebp, eax
	jg	.L3
.L25:
	mov	rax, rbx
	cmp	rdi, rbx
	jnb	.L1
	sub	rbx, 8
.L5:
	cmp	rax, r12
	jnb	.L25
	mov	rcx, QWORD PTR [rax]
	mov	rdx, QWORD PTR -8[rax]
	cmp	rcx, rdx
	jge	.L25
	mov	QWORD PTR -8[rax], rcx
	add	rax, 8
	mov	QWORD PTR -8[rax], rdx
	jmp	.L5
.L3:
	cmp	edx, 4
	jle	.L8
	mov	r13, rbx
	mov	rax, rdi
	mov	rdx, rdi
	jmp	.L9
.L29:
	mov	rcx, QWORD PTR [rax]
	mov	rdx, QWORD PTR -8[rax]
	sub	rax, 8
	cmp	rcx, rdx
	jge	.L11
	mov	QWORD PTR 8[rax], rdx
	mov	QWORD PTR [rax], rcx
.L10:
	cmp	rdi, rax
	jb	.L29
.L11:
	add	rbx, 8
.L8:
	cmp	rbx, r12
	jnb	.L1
	mov	rax, rbx
	jmp	.L10
.L30:
	cmp	r13, r12
	jnb	.L21
	mov	rsi, QWORD PTR [rax]
	cmp	QWORD PTR 0[r13], rsi
	jge	.L14
	add	r13, 8
.L15:
	add	rdx, 8
.L9:
	cmp	rdx, rbx
	jb	.L30
	jmp	.L21
.L14:
	add	rax, 8
	jmp	.L15
.L21:
	mov	rcx, rbx
	sub	rcx, rdx
	add	rax, rcx
	mov	rcx, rbx
	mov	rdx, rax
.L18:
	cmp	rdx, rbx
	jnb	.L31
	mov	rsi, QWORD PTR [rdx]
	mov	r8, QWORD PTR [rcx]
	add	rdx, 8
	add	rcx, 8
	mov	QWORD PTR -8[rdx], r8
	mov	QWORD PTR -8[rcx], rsi
	jmp	.L18
.L31:
	mov	rbp, r13
	sub	rax, rdi
	sub	r12, r13
	sar	rax, 3
	sub	rbp, rbx
	sar	r12, 3
	sar	rbp, 3
	mov	rsi, rax
	mov	edx, ebp
	call	merge
	mov	edx, r12d
	mov	rdi, rbx
	jmp	.L20
.L1:
	pop	rax
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
