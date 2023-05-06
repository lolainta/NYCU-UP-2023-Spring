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
	cmp	rdi, rdx
	jl	.L4
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
	.p2align 4
partition:
	movsx	rax, edx
	mov	r9, rdi
	lea	r11, [rdi+rax*8]
	lea	edi, -1[rsi]
	mov	r8, QWORD PTR [r11]
	cmp	edx, esi
	jle	.L22
	movsx	rax, esi
	sub	edx, esi
	add	rdx, rax
	lea	rcx, [r9+rax*8]
	lea	rsi, [r9+rdx*8]
	.p2align 4,,10
	.p2align 3
.L21:
	mov	rax, QWORD PTR [rcx]
	cmp	rax, r8
	jg	.L20
	add	edi, 1
	movsx	rdx, edi
	lea	rdx, [r9+rdx*8]
	mov	r10, QWORD PTR [rdx]
	mov	QWORD PTR [rdx], rax
	mov	QWORD PTR [rcx], r10
.L20:
	add	rcx, 8
	cmp	rsi, rcx
	jne	.L21
	mov	r8, QWORD PTR [r11]
	lea	eax, 1[rdi]
.L19:
	movsx	rdi, edi
	lea	rdx, 8[r9+rdi*8]
	mov	rcx, QWORD PTR [rdx]
	mov	QWORD PTR [rdx], r8
	mov	QWORD PTR [r11], rcx
	ret
	.p2align 4,,10
	.p2align 3
.L22:
	mov	eax, esi
	jmp	.L19
