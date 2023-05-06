	.p2align 4
qsort:
	lea	edx, -1[rsi]
	xor	eax, eax
	xor	esi, esi
	jmp	quickSort
quickSort:
	movsx	rax, edx
	push	r13
	mov	r8d, esi
	push	r12
	lea	r13, [rdi+rax*8]
	push	rbp
	mov	rbp, rax
	push	rbx
	mov	eax, ebp
	mov	rbx, rdi
	sub	eax, r8d
	sub	rsp, 8
	cmp	eax, 10
	jle	.L21
.L2:
	cmp	ebp, r8d
	jle	.L1
.L19:
	movsx	r10, r8d
.L7:
	mov	edx, ebp
	mov	rdi, QWORD PTR 0[r13]
	lea	r12d, -1[r8]
	lea	rax, [rbx+r10*8]
	sub	edx, r8d
	add	rdx, r10
	lea	rsi, [rbx+rdx*8]
	.p2align 4,,10
	.p2align 3
.L12:
	mov	rdx, QWORD PTR [rax]
	cmp	rdi, rdx
	jl	.L11
	add	r12d, 1
	movsx	rcx, r12d
	lea	rcx, [rbx+rcx*8]
	mov	r9, QWORD PTR [rcx]
	mov	QWORD PTR [rcx], rdx
	mov	QWORD PTR [rax], r9
.L11:
	add	rax, 8
	cmp	rax, rsi
	jne	.L12
	movsx	rax, r12d
	mov	rcx, QWORD PTR 0[r13]
	mov	esi, r8d
	mov	rdi, rbx
	lea	rax, 8[rbx+rax*8]
	mov	rdx, QWORD PTR [rax]
	mov	QWORD PTR [rax], rcx
	mov	QWORD PTR 0[r13], rdx
	mov	edx, r12d
	call	quickSort
	lea	r8d, 2[r12]
	mov	eax, ebp
	sub	eax, r8d
	cmp	eax, 10
	jg	.L2
.L21:
	cmp	ebp, r8d
	jle	.L1
	lea	edi, 1[r8]
	cmp	ebp, edi
	jle	.L19
	movsx	r10, r8d
	movsx	r9, edi
	lea	rsi, [rbx+r10*8]
	.p2align 4,,10
	.p2align 3
.L6:
	mov	rax, r9
	.p2align 4,,10
	.p2align 3
.L9:
	mov	rdx, QWORD PTR [rsi]
	mov	rcx, QWORD PTR [rbx+rax*8]
	cmp	rdx, rcx
	jle	.L8
	mov	QWORD PTR [rsi], rcx
	mov	QWORD PTR [rbx+rax*8], rdx
.L8:
	add	rax, 1
	cmp	ebp, eax
	jg	.L9
	add	edi, 1
	add	r9, 1
	add	rsi, 8
	cmp	ebp, edi
	jne	.L6
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L1:
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4
