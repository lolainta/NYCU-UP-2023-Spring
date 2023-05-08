	.p2align 4
qsort:
	push	r14
	mov	r10, rdi
	mov	ecx, 32
	xor	eax, eax
	push	r13
	sub	esi, 1
	push	r12
	mov	r12d, 1
	push	rbp
	mov	ebp, 1
	push	rbx
	sub	rsp, 136
	lea	rdi, -120[rsp]
	rep stosq
	mov	DWORD PTR -116[rsp], esi
	.p2align 4,,10
	.p2align 3
.L15:
	lea	r13d, -1[rbp]
.L10:
	movsx	rax, r13d
	mov	ebx, DWORD PTR -120[rsp+r12*4]
	movsx	rcx, DWORD PTR -120[rsp+rax*4]
	movsx	rax, ebx
	lea	r14, [r10+rax*8]
	lea	rax, [r10+rcx*8]
	mov	r11, rcx
	mov	rdi, QWORD PTR [r14]
	mov	rdx, QWORD PTR [rax]
	cmp	ebx, ecx
	jle	.L3
	mov	edx, ebx
	sub	edx, ecx
	add	rdx, rcx
	lea	r8, [r10+rdx*8]
	.p2align 4,,10
	.p2align 3
.L5:
	mov	rdx, QWORD PTR [rax]
	cmp	rdx, rdi
	jg	.L4
	movsx	rsi, ecx
	add	ecx, 1
	lea	rsi, [r10+rsi*8]
	mov	r9, QWORD PTR [rsi]
	mov	QWORD PTR [rsi], rdx
	mov	QWORD PTR [rax], r9
.L4:
	add	rax, 8
	cmp	r8, rax
	jne	.L5
	movsx	rax, ecx
	mov	rsi, QWORD PTR [r14]
	lea	rax, [r10+rax*8]
	mov	rdx, QWORD PTR [rax]
	mov	QWORD PTR [rax], rsi
	lea	eax, -1[rcx]
	mov	QWORD PTR [r14], rdx
	cmp	eax, r11d
	jle	.L6
	add	ecx, 1
	mov	DWORD PTR -120[rsp+r12*4], eax
	cmp	ebx, ecx
	jle	.L10
.L7:
	lea	eax, 1[rbp]
	add	ebp, 2
	cdqe
	movsx	r12, ebp
	mov	DWORD PTR -120[rsp+rax*4], ecx
	mov	DWORD PTR -120[rsp+r12*4], ebx
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L3:
	mov	QWORD PTR [rax], rdi
	mov	QWORD PTR [r14], rdx
.L6:
	add	ecx, 1
	sub	ebp, 2
	cmp	ecx, ebx
	jl	.L7
	test	ebp, ebp
	js	.L13
	movsx	r12, ebp
	jmp	.L15
	.p2align 4,,10
	.p2align 3
.L13:
	add	rsp, 136
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
