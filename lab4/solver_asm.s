    push   rbp
    mov    rbp,rsp
    sub    rsp,0x30
    mov    QWORD PTR [rbp-0x28],rdi
    mov    rax,QWORD PTR fs:0x28
    mov    QWORD PTR [rbp-0x8],rax
    mov    rax,0x0a786c25203a
    mov    QWORD PTR [rbp-0x30],rax

    mov    rax,0x18
LOOP:
    mov    QWORD PTR [rbp-0x18],rax

    lea    rdi,QWORD PTR [rbp-0x30]
    lea    rsi,QWORD PTR [rbp-0x20]
    add    rsi,rax
    mov    rsi,QWORD PTR [rsi]

    cmp    rax,0x28
    jne    NRA
    add    rsi,0xab
NRA:
    mov    rdx,QWORD PTR [rbp-0x28]
    call   rdx

    mov    rax,QWORD PTR [rbp-0x18]
    add    rax,0x08
    cmp    rax,0x30
    jne    LOOP

    leave
    ret
