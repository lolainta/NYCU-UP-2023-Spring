	.p2align 4
qsort:
	push	r14
	mov	r8, rdi
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
.L20:
	lea	r13d, -1[rbp]
.L13:
	movsx	rax, r13d
	mov	ebx, DWORD PTR -120[rsp+r12*4]
	mov	r11d, DWORD PTR -120[rsp+rax*4]
	lea	edx, [rbx+r11]
	mov	eax, edx
	shr	eax, 31
	add	eax, edx
	sar	eax
	cdqe
	lea	rcx, [r8+rax*8]
	movsx	rax, ebx
	lea	r14, [r8+rax*8]
	mov	rdx, QWORD PTR [rcx]
	mov	rsi, QWORD PTR [r14]
	cmp	rdx, rsi
	jle	.L3
	mov	QWORD PTR [rcx], rsi
	mov	rsi, rdx
	mov	QWORD PTR [r14], rdx
	mov	rdx, QWORD PTR [rcx]
.L3:
	movsx	r9, r11d
	lea	rax, [r8+r9*8]
	mov	rdi, QWORD PTR [rax]
	cmp	rdi, rdx
	jle	.L4
	mov	QWORD PTR [rax], rdx
	mov	rdx, rdi
	mov	QWORD PTR [rcx], rdi
	mov	rsi, QWORD PTR [r14]
.L4:
	cmp	rdx, rsi
	jge	.L5
	mov	QWORD PTR [rcx], rsi
	mov	rsi, rdx
	mov	QWORD PTR [r14], rdx
.L5:
	cmp	ebx, r11d
	jle	.L14
	mov	edx, ebx
	mov	ecx, r11d
	sub	edx, r11d
	add	rdx, r9
	lea	r9, [r8+rdx*8]
	.p2align 4,,10
	.p2align 3
.L8:
	mov	rdx, QWORD PTR [rax]
	cmp	rdx, rsi
	jg	.L7
	movsx	rdi, ecx
	add	ecx, 1
	lea	rdi, [r8+rdi*8]
	mov	r10, QWORD PTR [rdi]
	mov	QWORD PTR [rdi], rdx
	mov	QWORD PTR [rax], r10
.L7:
	add	rax, 8
	cmp	rax, r9
	jne	.L8
	movsx	rax, ecx
	mov	rsi, QWORD PTR [r14]
	lea	rax, [r8+rax*8]
.L6:
	mov	rdx, QWORD PTR [rax]
	mov	QWORD PTR [rax], rsi
	lea	eax, -1[rcx]
	mov	QWORD PTR [r14], rdx
	cmp	eax, r11d
	jg	.L9
	add	ecx, 1
	sub	ebp, 2
	cmp	ecx, ebx
	jl	.L10
	test	ebp, ebp
	js	.L18
	movsx	r12, ebp
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L9:
	add	ecx, 1
	mov	DWORD PTR -120[rsp+r12*4], eax
	cmp	ebx, ecx
	jle	.L13
.L10:
	lea	eax, 1[rbp]
	add	ebp, 2
	cdqe
	movsx	r12, ebp
	mov	DWORD PTR -120[rsp+rax*4], ecx
	mov	DWORD PTR -120[rsp+r12*4], ebx
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L14:
	mov	ecx, r11d
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L18:
	add	rsp, 136
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
