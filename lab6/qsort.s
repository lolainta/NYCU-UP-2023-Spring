	.p2align 4
qsort:
	push	r14
	mov	r10, rdi
	mov	ecx, 32
	xor	eax, eax
	push	r13
	sub	esi, 1
	push	r12
	push	rbp
	mov	ebp, 1
	push	rbx
	mov	ebx, 1
	sub	rsp, 136
	lea	rdi, -120[rsp]
	rep stosq
	mov	DWORD PTR -116[rsp], esi
	.p2align 4,,10
	.p2align 3
.L26:
	lea	r12d, -1[rbx]
.L16:
	movsx	rax, r12d
	movsx	r8, DWORD PTR -120[rsp+rbp*4]
	movsx	rax, DWORD PTR -120[rsp+rax*4]
	lea	r13, [r10+r8*8]
	mov	r9, r8
	lea	r14d, -1[r8]
	mov	r11, rax
	lea	rsi, [r10+rax*8]
	mov	rdi, QWORD PTR 0[r13]
	mov	rcx, QWORD PTR [rsi]
	mov	rax, rsi
	mov	edx, r11d
	cmp	r8d, r11d
	jg	.L5
	jmp	.L29
	.p2align 4,,10
	.p2align 3
.L8:
	lea	rax, 8[rsi]
	cmp	r9d, edx
	je	.L30
.L5:
	mov	rcx, QWORD PTR [rax]
	mov	rsi, rax
	mov	eax, edx
	lea	edx, 1[rdx]
	cmp	rcx, rdi
	jle	.L8
.L4:
	movsx	r8, r14d
	cmp	r14d, eax
	jg	.L11
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L9:
	sub	r8, 1
	cmp	eax, r8d
	jge	.L31
.L11:
	movsx	rdx, eax
	mov	r14, QWORD PTR [r10+r8*8]
	sal	rdx, 3
	lea	rsi, [r10+rdx]
	cmp	r14, rdi
	jg	.L9
	mov	QWORD PTR [rsi], r14
	lea	rdx, 8[r10+rdx]
	mov	QWORD PTR [r10+r8*8], rcx
	jmp	.L10
	.p2align 4,,10
	.p2align 3
.L32:
	add	rdx, 8
	cmp	rdi, rcx
	jl	.L9
.L10:
	add	eax, 1
	mov	rcx, QWORD PTR [rdx]
	mov	rsi, rdx
	cmp	r9d, eax
	jg	.L32
	sub	r8, 1
	cmp	eax, r8d
	jl	.L11
	.p2align 4,,10
	.p2align 3
.L31:
	mov	rdi, QWORD PTR 0[r13]
.L7:
	lea	edx, -1[rax]
	mov	QWORD PTR [rsi], rdi
	mov	QWORD PTR 0[r13], rcx
	cmp	edx, r11d
	jg	.L12
	add	eax, 1
	sub	ebx, 2
	cmp	eax, r9d
	jl	.L13
	test	ebx, ebx
	js	.L24
	movsx	rbp, ebx
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L12:
	add	eax, 1
	mov	DWORD PTR -120[rsp+rbp*4], edx
	cmp	r9d, eax
	jle	.L16
.L13:
	lea	edx, 1[rbx]
	add	ebx, 2
	movsx	rdx, edx
	movsx	rbp, ebx
	mov	DWORD PTR -120[rsp+rdx*4], eax
	mov	DWORD PTR -120[rsp+rbp*4], r9d
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L30:
	lea	rsi, [r10+r8*8]
	mov	eax, r9d
	mov	rcx, QWORD PTR [rsi]
	jmp	.L4
.L24:
	add	rsp, 136
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L29:
	mov	eax, r11d
	jmp	.L4
