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
.L16:
	lea	r13d, -1[rbp]
.L10:
	mov	ebx, DWORD PTR -120[rsp+r12*4]
	movsx	rax, r13d
	mov	r11d, DWORD PTR -120[rsp+rax*4]
	movsx	rax, ebx
	lea	r14, [r10+rax*8]
	lea	ecx, -1[r11]
	mov	rdi, QWORD PTR [r14]
	cmp	ebx, r11d
	jle	.L3
	mov	edx, ebx
	movsx	rsi, r11d
	sub	edx, r11d
	lea	rax, [r10+rsi*8]
	add	rdx, rsi
	lea	r8, [r10+rdx*8]
	.p2align 4,,10
	.p2align 3
.L5:
	mov	rdx, QWORD PTR [rax]
	cmp	rdx, rdi
	jg	.L4
	add	ecx, 1
	movsx	rsi, ecx
	lea	rsi, [r10+rsi*8]
	mov	r9, QWORD PTR [rsi]
	mov	QWORD PTR [rsi], rdx
	mov	QWORD PTR [rax], r9
.L4:
	add	rax, 8
	cmp	r8, rax
	jne	.L5
	mov	rdi, QWORD PTR [r14]
.L3:
	movsx	rax, ecx
	lea	rax, 8[r10+rax*8]
	mov	rdx, QWORD PTR [rax]
	mov	QWORD PTR [rax], rdi
	mov	QWORD PTR [r14], rdx
	cmp	r11d, ecx
	jl	.L6
	add	ecx, 2
	sub	ebp, 2
	cmp	ecx, ebx
	jl	.L7
	test	ebp, ebp
	js	.L14
	movsx	r12, ebp
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L6:
	mov	DWORD PTR -120[rsp+r12*4], ecx
	add	ecx, 2
	cmp	ebx, ecx
	jle	.L10
.L7:
	lea	eax, 1[rbp]
	add	ebp, 2
	cdqe
	movsx	r12, ebp
	mov	DWORD PTR -120[rsp+rax*4], ecx
	mov	DWORD PTR -120[rsp+r12*4], ebx
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L14:
	add	rsp, 136
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
