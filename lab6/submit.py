#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import base64
import hashlib
import sys

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
            break;

def main():
    context.arch='amd64'
    context.os='linux'
    teamtoken=None if len(sys.argv)<3 else sys.argv[2]
    payload = None
    if len(sys.argv)>1 and sys.argv[1]!='-':
        with open(sys.argv[1],'rt') as f:
            payload=asm(f.read())
    else:
        payload=asm("""
        ret
        """)
    r=remote('up23.zoolab.org',10950)
    if type(r)!=pwnlib.tubes.process.process:
        solve(r)
    r.sendlineafter(b'Enter to skip: ',b'' if teamtoken==None else teamtoken.encode())
    print(f"!! payload: {len(payload)} bytes to send")
    r.sendlineafter(b'want to send? ',str(len(payload)).encode())
    if 'pause' in sys.argv[3:]:
        pause()
    r.sendafter(b'your code: ',payload);
    r.interactive()

if __name__=='__main__':
    main()
