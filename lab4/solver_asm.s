    push   rbp
    mov    rbp,rsp
    sub    rsp,0x30
    mov    QWORD PTR [rbp-0x28],rdi
    mov    rax,QWORD PTR fs:0x28
    mov    QWORD PTR [rbp-0x8],rax
    mov    rax,0x0a786c25203a
    mov    QWORD PTR [rbp-0x30],rax
    mov    QWORD PTR [rbp-0x18],0x18
LOOP:
    lea    rdi,QWORD PTR [rbp-0x30]
    lea    rsi,QWORD PTR [rbp-0x20]
    add    rsi,QWORD PTR [rbp-0x18]
    mov    rsi,QWORD PTR [rsi]
    call   QWORD PTR [rbp-0x28]
    add    QWORD PTR [rbp-0x18],0x08
    cmp    QWORD PTR [rbp-0x18],0x30
    jne    LOOP
    leave
    ret
