# HW2 Demo

1. Download test cases from [LINK](https://up23.zoolab.org/up23/hw2/hw2_testcases.zip).
2. `unzip hw2_testcases.zip`
3. `apt install strace`

## Example Cases
### Example 1 (10pt)
* Command: `./sdb ./hello`
* Inputs: `cont`

```
** program './hello' loaded. entry point 0x401000
      401000: f3 0f 1e fa                     endbr64   
      401004: 55                              push      rbp
      401005: 48 89 e5                        mov       rbp, rsp
      401008: ba 0e 00 00 00                  mov       edx, 0xe
      40100d: 48 8d 05 ec 0f 00 00            lea       rax, [rip + 0xfec]
(sdb) cont
hello world!
** the target proegram terminated.
```

### Example 2 (10pt)
* Command: `./sdb ./hello`
* Inputs:
```
break 0x401030
break 0x40103b
cont
cont
si
si
```

```
** program './hello' loaded. entry point 0x401000
      401000: f3 0f 1e fa                     endbr64   
      401004: 55                              push      rbp
      401005: 48 89 e5                        mov       rbp, rsp
      401008: ba 0e 00 00 00                  mov       edx, 0xe
      40100d: 48 8d 05 ec 0f 00 00            lea       rax, [rip + 0xfec]
(sdb) break 0x401030
** set a breakpoint at 0x401030
(sdb) break 0x40103b
** set a breakpoint at 0x40103b
(sdb) cont
** hit a breakpoint at 0x401030
      401030: 0f 05                           syscall   
      401032: c3                              ret       
      401033: b8 00 00 00 00                  mov       eax, 0
      401038: 0f 05                           syscall   
      40103a: c3                              ret       
(sdb) cont
hello world!
** hit a breakpoint at 0x40103b
      40103b: b8 3c 00 00 00                  mov       eax, 0x3c
      401040: 0f 05                           syscall   
** the address is out of the range of the text section.
(sdb) si
      401040: 0f 05                           syscall   
** the address is out of the range of the text section.
(sdb) si
** the target program terminated.
```

### Example 3 (10pt)
* Command: `./sdb ./guess`
* Inputs:
```
break 0x4010bf
break 0x40111e
cont
anchor
cont
haha
timetravel
cont
42
cont
```

```
** program './guess' loaded. entry point 0x40108b
      40108b: f3 0f 1e fa                     endbr64   
      40108f: 55                              push      rbp
      401090: 48 89 e5                        mov       rbp, rsp
      401093: 48 83 ec 10                     sub       rsp, 0x10
      401097: ba 12 00 00 00                  mov       edx, 0x12
(sdb) break 0x4010bf
** set a breakpoint at 0x4010bf
(sdb) break 0x40111e
** set a breakpoint at 0x40111e
(sdb) cont
guess a number > ** hit a breakpoint at 0x4010bf
      4010bf: bf 00 00 00 00                  mov       edi, 0
      4010c4: e8 67 00 00 00                  call      0x401130
      4010c9: 48 89 45 f8                     mov       qword ptr [rbp - 8], rax
      4010cd: 48 8d 05 3e 0f 00 00            lea       rax, [rip + 0xf3e]
      4010d4: 48 89 c6                        mov       rsi, rax
(sdb) anchor
** dropped an anchor
(sdb) cont
haha

no no no
** hit a breakpoint at 0x40111e
      40111e: bf 00 00 00 00                  mov       edi, 0
      401123: e8 10 00 00 00                  call      0x401138
      401128: b8 01 00 00 00                  mov       eax, 1
      40112d: 0f 05                           syscall   
      40112f: c3                              ret       
(sdb) timetravel
** go back to the anchor point
      4010bf: bf 00 00 00 00                  mov       edi, 0
      4010c4: e8 67 00 00 00                  call      0x401130
      4010c9: 48 89 45 f8                     mov       qword ptr [rbp - 8], rax
      4010cd: 48 8d 05 3e 0f 00 00            lea       rax, [rip + 0xf3e]
      4010d4: 48 89 c6                        mov       rsi, rax
(sdb) cont
42

yes
** hit a breakpoint at 0x40111e
      40111e: bf 00 00 00 00                  mov       edi, 0
      401123: e8 10 00 00 00                  call      0x401138
      401128: b8 01 00 00 00                  mov       eax, 1
      40112d: 0f 05                           syscall   
      40112f: c3                              ret       
(sdb) cont
** the target program terminated.
```

## Hidden Cases
### Case 1

* Command: `./sdb ./hello`
* Input:
```
break 0x401004
break 0x401005
cont
cont
cont
```

### Case 2

Reverse Order Continuous Breakpoint

* Command: `./sdb ./hello`
* Input:
```
break 0x401005
break 0x401004
cont
cont
cont
```

### Case 3

* Command: `./sdb ./hello`
* Input: 
```
break 0x401004
break 0x401005
si
cont
si
cont
```

### Case 4

* Command: `./sdb ./loop1`
* Input: 
```
break 0x401024
cont
si
break 0x40102e
cont
si
si
si
si
cont
```

### Case 5

* Command: `./sdb ./deep`
* Input:
```
break 0x401034
cont
anchor
break 0x40114a
cont
timetravel
cont
cont
```

### Case 6

* Command: `./sdb ./deep`
* Input:
```
break 0x4010de
cont
anchor
break 0x401159
cont
timetravel
cont
cont
```