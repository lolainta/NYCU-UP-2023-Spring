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

if len(sys.argv)<2:
    print("usage: {} solver-program".format(sys.argv[0]));
    sys.exit(-1);

r=remote('up23.zoolab.org',10081)
solve(r);
upload(sys.argv[1]);
r.interactive();
r.close();

