    push   rbp
    mov    rbp,rsp
    sub    rsp,0x30
    mov    QWORD PTR [rbp-0x28],rdi
    mov    rax,QWORD PTR fs:0x28
    mov    QWORD PTR [rbp-0x8],rax
    xor    eax,eax
    mov    rax,0x0a786c25203a
    mov    QWORD PTR [rbp-0x30],rax

    lea    rdi,QWORD PTR [rbp-0x30]
    lea    rsi,QWORD PTR [rbp-0x20]
    add    rsi,0x18
    mov    rsi,QWORD PTR [rsi]
    mov    rdx,QWORD PTR [rbp-0x28]
    call rdx

    lea    rdi,QWORD PTR [rbp-0x30]
    lea    rsi,QWORD PTR [rbp-0x20]
    add    rsi,0x20
    mov    rsi,QWORD PTR [rsi]
    mov    rdx,QWORD PTR [rbp-0x28]
    call rdx

    lea    rdi,QWORD PTR [rbp-0x30]
    lea    rsi,QWORD PTR [rbp-0x20]
    add    rsi,0x28
    mov    rsi,QWORD PTR [rsi]
    add    rsi,0xab
    mov    rdx,QWORD PTR [rbp-0x28]
    call rdx

    leave
    ret
