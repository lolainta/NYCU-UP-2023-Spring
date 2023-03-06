from pwn import *

r=remote('up23.zoolab.org',10363);
def main():
    prefix=r.recvline().decode().split('\'')[1]
    for i in range(1000000000000):
        h=hashlib.sha1((prefix+str(i)).encode()).hexdigest();
        if(h[:6]=='000000'):
            ans=str(i).encode()
            break;
    
    print(time.time())
    r.sendlineafter(b'string S: ',base64.b64encode(ans));

if __name__=='__main__':
    main()

    for i in range(8):
        line=r.recvline()
        if i==3:
            q=line.decode().split(' ')[3]
    
    for i in range(int(q)):
        eq=r.recv().decode()
        eq=eq.split(':')[1].split('=')[0][1:]
        ans=eval(eq)
        ans=ans.to_bytes(((ans.bit_length()+7)//8),'little')
        ret=base64.b64encode(ans)
        r.sendline(ret)
    line=r.recvline()
    print(line.decode())
    r.close()

