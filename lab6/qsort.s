qsort:
	push	r12
	lea	r12d, -1[rsi]
	push	rbp
	push	rbx
	test	r12d, r12d
	jle	.L22
	movsx	rax, r12d
	mov	r11, rdi
	lea	ebx, -2[rsi]
	xor	r9d, r9d
	lea	rbp, [rdi+rax*8]
.L27:
	mov	rsi, QWORD PTR 0[rbp]
	lea	r10d, -1[r9]
	cmp	r12d, r9d
	jle	.L24
	mov	edx, ebx
	movsx	rcx, r9d
	sub	edx, r9d
	lea	rax, [r11+rcx*8]
	add	rdx, rcx
	lea	rdi, 8[r11+rdx*8]
.L26:
	mov	rdx, QWORD PTR [rax]
	cmp	rsi, rdx
	jl	.L25
	add	r10d, 1
	movsx	rcx, r10d
	lea	rcx, [r11+rcx*8]
	mov	r8, QWORD PTR [rcx]
	mov	QWORD PTR [rcx], rdx
	mov	QWORD PTR [rax], r8
.L25:
	add	rax, 8
	cmp	rdi, rax
	jne	.L26
	mov	rsi, QWORD PTR 0[rbp]
.L24:
	movsx	rax, r10d
	mov	rdi, r11
	lea	rax, 8[r11+rax*8]
	mov	rdx, QWORD PTR [rax]
	mov	QWORD PTR [rax], rsi
	mov	esi, r9d
	mov	QWORD PTR 0[rbp], rdx
	mov	edx, r10d
	call	quickSort
	lea	r9d, 2[r10]
	cmp	r12d, r9d
	jg	.L27
.L22:
	pop	rbx
	pop	rbp
	pop	r12
	ret
swap:
	mov	rax, QWORD PTR [rdi]
	mov	rdx, QWORD PTR [rsi]
	mov	QWORD PTR [rdi], rdx
	mov	QWORD PTR [rsi], rax
	ret
partition:
	movsx	rax, edx
	mov	r9, rdi
	lea	r11, [rdi+rax*8]
	lea	edi, -1[rsi]
	mov	r8, QWORD PTR [r11]
	cmp	edx, esi
	jle	.L7
	movsx	rax, esi
	sub	edx, esi
	add	rdx, rax
	lea	rcx, [r9+rax*8]
	lea	rsi, [r9+rdx*8]
.L6:
	mov	rax, QWORD PTR [rcx]
	cmp	rax, r8
	jg	.L5
	add	edi, 1
	movsx	rdx, edi
	lea	rdx, [r9+rdx*8]
	mov	r10, QWORD PTR [rdx]
	mov	QWORD PTR [rdx], rax
	mov	QWORD PTR [rcx], r10
.L5:
	add	rcx, 8
	cmp	rsi, rcx
	jne	.L6
	mov	r8, QWORD PTR [r11]
	lea	eax, 1[rdi]
.L4:
	movsx	rdi, edi
	lea	rdx, 8[r9+rdi*8]
	mov	rcx, QWORD PTR [rdx]
	mov	QWORD PTR [rdx], r8
	mov	QWORD PTR [r11], rcx
	ret
.L7:
	mov	eax, esi
	jmp	.L4
quickSort:
	cmp	edx, esi
	jle	.L19
	push	r13
	movsx	rax, edx
	mov	r9d, esi
	push	r12
	lea	r13, [rdi+rax*8]
	mov	r12d, edx
	push	rbp
	mov	rbp, rdi
	push	rbx
	sub	rsp, 8
.L14:
	mov	rsi, QWORD PTR 0[r13]
	lea	ebx, -1[r9]
	cmp	r12d, r9d
	jle	.L11
	mov	edx, r12d
	movsx	rcx, r9d
	sub	edx, r9d
	lea	rax, 0[rbp+rcx*8]
	add	rdx, rcx
	lea	rdi, 0[rbp+rdx*8]
.L13:
	mov	rdx, QWORD PTR [rax]
	cmp	rsi, rdx
	jl	.L12
	add	ebx, 1
	movsx	rcx, ebx
	lea	rcx, 0[rbp+rcx*8]
	mov	r8, QWORD PTR [rcx]
	mov	QWORD PTR [rcx], rdx
	mov	QWORD PTR [rax], r8
.L12:
	add	rax, 8
	cmp	rdi, rax
	jne	.L13
	mov	rsi, QWORD PTR 0[r13]
.L11:
	movsx	rax, ebx
	mov	rdi, rbp
	lea	rax, 8[rbp+rax*8]
	mov	rdx, QWORD PTR [rax]
	mov	QWORD PTR [rax], rsi
	mov	esi, r9d
	mov	QWORD PTR 0[r13], rdx
	mov	edx, ebx
	call	quickSort
	lea	r9d, 2[rbx]
	cmp	r9d, r12d
	jl	.L14
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
.L19:
	ret
