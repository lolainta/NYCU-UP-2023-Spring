
solver:     file format elf64-x86-64


Disassembly of section .interp:

0000000000000318 <.interp>:
 318:	2f                   	(bad)
 319:	6c                   	ins    BYTE PTR es:[rdi],dx
 31a:	69 62 36 34 2f 6c 64 	imul   esp,DWORD PTR [rdx+0x36],0x646c2f34
 321:	2d 6c 69 6e 75       	sub    eax,0x756e696c
 326:	78 2d                	js     355 <_init-0xcab>
 328:	78 38                	js     362 <_init-0xc9e>
 32a:	36 2d 36 34 2e 73    	ss sub eax,0x732e3436
 330:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 331:	2e 32 00             	cs xor al,BYTE PTR [rax]

Disassembly of section .note.gnu.property:

0000000000000338 <.note.gnu.property>:
 338:	04 00                	add    al,0x0
 33a:	00 00                	add    BYTE PTR [rax],al
 33c:	30 00                	xor    BYTE PTR [rax],al
 33e:	00 00                	add    BYTE PTR [rax],al
 340:	05 00 00 00 47       	add    eax,0x47000000
 345:	4e 55                	rex.WRX push rbp
 347:	00 02                	add    BYTE PTR [rdx],al
 349:	80 00 c0             	add    BYTE PTR [rax],0xc0
 34c:	04 00                	add    al,0x0
 34e:	00 00                	add    BYTE PTR [rax],al
 350:	01 00                	add    DWORD PTR [rax],eax
 352:	00 00                	add    BYTE PTR [rax],al
 354:	00 00                	add    BYTE PTR [rax],al
 356:	00 00                	add    BYTE PTR [rax],al
 358:	01 00                	add    DWORD PTR [rax],eax
 35a:	01 c0                	add    eax,eax
 35c:	04 00                	add    al,0x0
 35e:	00 00                	add    BYTE PTR [rax],al
 360:	01 00                	add    DWORD PTR [rax],eax
 362:	00 00                	add    BYTE PTR [rax],al
 364:	00 00                	add    BYTE PTR [rax],al
 366:	00 00                	add    BYTE PTR [rax],al
 368:	02 00                	add    al,BYTE PTR [rax]
 36a:	01 c0                	add    eax,eax
 36c:	04 00                	add    al,0x0
	...

Disassembly of section .note.gnu.build-id:

0000000000000378 <.note.gnu.build-id>:
 378:	04 00                	add    al,0x0
 37a:	00 00                	add    BYTE PTR [rax],al
 37c:	14 00                	adc    al,0x0
 37e:	00 00                	add    BYTE PTR [rax],al
 380:	03 00                	add    eax,DWORD PTR [rax]
 382:	00 00                	add    BYTE PTR [rax],al
 384:	47                   	rex.RXB
 385:	4e 55                	rex.WRX push rbp
 387:	00 36                	add    BYTE PTR [rsi],dh
 389:	9c                   	pushf
 38a:	04 66                	add    al,0x66
 38c:	ce                   	(bad)
 38d:	af                   	scas   eax,DWORD PTR es:[rdi]
 38e:	7f c1                	jg     351 <_init-0xcaf>
 390:	f5                   	cmc
 391:	da 74 f7 35          	fidiv  DWORD PTR [rdi+rsi*8+0x35]
 395:	e7 44                	out    0x44,eax
 397:	87 58 f1             	xchg   DWORD PTR [rax-0xf],ebx
 39a:	2e                   	cs
 39b:	88                   	.byte 0x88

Disassembly of section .note.ABI-tag:

000000000000039c <.note.ABI-tag>:
 39c:	04 00                	add    al,0x0
 39e:	00 00                	add    BYTE PTR [rax],al
 3a0:	10 00                	adc    BYTE PTR [rax],al
 3a2:	00 00                	add    BYTE PTR [rax],al
 3a4:	01 00                	add    DWORD PTR [rax],eax
 3a6:	00 00                	add    BYTE PTR [rax],al
 3a8:	47                   	rex.RXB
 3a9:	4e 55                	rex.WRX push rbp
 3ab:	00 00                	add    BYTE PTR [rax],al
 3ad:	00 00                	add    BYTE PTR [rax],al
 3af:	00 04 00             	add    BYTE PTR [rax+rax*1],al
 3b2:	00 00                	add    BYTE PTR [rax],al
 3b4:	04 00                	add    al,0x0
 3b6:	00 00                	add    BYTE PTR [rax],al
 3b8:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .gnu.hash:

00000000000003c0 <.gnu.hash>:
 3c0:	02 00                	add    al,BYTE PTR [rax]
 3c2:	00 00                	add    BYTE PTR [rax],al
 3c4:	07                   	(bad)
 3c5:	00 00                	add    BYTE PTR [rax],al
 3c7:	00 01                	add    BYTE PTR [rcx],al
 3c9:	00 00                	add    BYTE PTR [rax],al
 3cb:	00 06                	add    BYTE PTR [rsi],al
	...
 3d5:	40 00 01             	rex add BYTE PTR [rcx],al
 3d8:	07                   	(bad)
 3d9:	00 00                	add    BYTE PTR [rax],al
 3db:	00 00                	add    BYTE PTR [rax],al
 3dd:	00 00                	add    BYTE PTR [rax],al
 3df:	00                   	.byte 0x0
 3e0:	b9                   	.byte 0xb9
 3e1:	2b 6b 15             	sub    ebp,DWORD PTR [rbx+0x15]

Disassembly of section .dynsym:

00000000000003e8 <.dynsym>:
	...
 400:	12 00                	adc    al,BYTE PTR [rax]
 402:	00 00                	add    BYTE PTR [rax],al
 404:	12 00                	adc    al,BYTE PTR [rax]
	...
 416:	00 00                	add    BYTE PTR [rax],al
 418:	65 00 00             	add    BYTE PTR gs:[rax],al
 41b:	00 20                	add    BYTE PTR [rax],ah
	...
 42d:	00 00                	add    BYTE PTR [rax],al
 42f:	00 01                	add    BYTE PTR [rcx],al
 431:	00 00                	add    BYTE PTR [rax],al
 433:	00 12                	add    BYTE PTR [rdx],dl
	...
 445:	00 00                	add    BYTE PTR [rax],al
 447:	00 81 00 00 00 20    	add    BYTE PTR [rcx+0x20000000],al
	...
 45d:	00 00                	add    BYTE PTR [rax],al
 45f:	00 90 00 00 00 20    	add    BYTE PTR [rax+0x20000000],dl
	...
 475:	00 00                	add    BYTE PTR [rax],al
 477:	00 24 00             	add    BYTE PTR [rax+rax*1],ah
 47a:	00 00                	add    BYTE PTR [rax],al
 47c:	22 00                	and    al,BYTE PTR [rax]
	...
 48e:	00 00                	add    BYTE PTR [rax],al
 490:	33 00                	xor    eax,DWORD PTR [rax]
 492:	00 00                	add    BYTE PTR [rax],al
 494:	12 00                	adc    al,BYTE PTR [rax]
	...

Disassembly of section .dynstr:

00000000000004a8 <.dynstr>:
 4a8:	00 5f 5f             	add    BYTE PTR [rdi+0x5f],bl
 4ab:	73 74                	jae    521 <_init-0xadf>
 4ad:	61                   	(bad)
 4ae:	63 6b 5f             	movsxd ebp,DWORD PTR [rbx+0x5f]
 4b1:	63 68 6b             	movsxd ebp,DWORD PTR [rax+0x6b]
 4b4:	5f                   	pop    rdi
 4b5:	66 61                	data16 (bad)
 4b7:	69 6c 00 5f 5f 6c 69 	imul   ebp,DWORD PTR [rax+rax*1+0x5f],0x62696c5f
 4be:	62 
 4bf:	63 5f 73             	movsxd ebx,DWORD PTR [rdi+0x73]
 4c2:	74 61                	je     525 <_init-0xadb>
 4c4:	72 74                	jb     53a <_init-0xac6>
 4c6:	5f                   	pop    rdi
 4c7:	6d                   	ins    DWORD PTR es:[rdi],dx
 4c8:	61                   	(bad)
 4c9:	69 6e 00 5f 5f 63 78 	imul   ebp,DWORD PTR [rsi+0x0],0x78635f5f
 4d0:	61                   	(bad)
 4d1:	5f                   	pop    rdi
 4d2:	66 69 6e 61 6c 69    	imul   bp,WORD PTR [rsi+0x61],0x696c
 4d8:	7a 65                	jp     53f <_init-0xac1>
 4da:	00 70 72             	add    BYTE PTR [rax+0x72],dh
 4dd:	69 6e 74 66 00 6c 69 	imul   ebp,DWORD PTR [rsi+0x74],0x696c0066
 4e4:	62 63 2e 73 6f       	(bad)
 4e9:	2e 36 00 47 4c       	cs ss add BYTE PTR [rdi+0x4c],al
 4ee:	49                   	rex.WB
 4ef:	42                   	rex.X
 4f0:	43 5f                	rex.XB pop r15
 4f2:	32 2e                	xor    ch,BYTE PTR [rsi]
 4f4:	32 2e                	xor    ch,BYTE PTR [rsi]
 4f6:	35 00 47 4c 49       	xor    eax,0x494c4700
 4fb:	42                   	rex.X
 4fc:	43 5f                	rex.XB pop r15
 4fe:	32 2e                	xor    ch,BYTE PTR [rsi]
 500:	34 00                	xor    al,0x0
 502:	47                   	rex.RXB
 503:	4c                   	rex.WR
 504:	49                   	rex.WB
 505:	42                   	rex.X
 506:	43 5f                	rex.XB pop r15
 508:	32 2e                	xor    ch,BYTE PTR [rsi]
 50a:	33 34 00             	xor    esi,DWORD PTR [rax+rax*1]
 50d:	5f                   	pop    rdi
 50e:	49 54                	rex.WB push r12
 510:	4d 5f                	rex.WRB pop r15
 512:	64 65 72 65          	fs gs jb 57b <_init-0xa85>
 516:	67 69 73 74 65 72 54 	imul   esi,DWORD PTR [ebx+0x74],0x4d547265
 51d:	4d 
 51e:	43 6c                	rex.XB ins BYTE PTR es:[rdi],dx
 520:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 521:	6e                   	outs   dx,BYTE PTR ds:[rsi]
 522:	65 54                	gs push rsp
 524:	61                   	(bad)
 525:	62                   	(bad)
 526:	6c                   	ins    BYTE PTR es:[rdi],dx
 527:	65 00 5f 5f          	add    BYTE PTR gs:[rdi+0x5f],bl
 52b:	67 6d                	ins    DWORD PTR es:[edi],dx
 52d:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 52e:	6e                   	outs   dx,BYTE PTR ds:[rsi]
 52f:	5f                   	pop    rdi
 530:	73 74                	jae    5a6 <_init-0xa5a>
 532:	61                   	(bad)
 533:	72 74                	jb     5a9 <_init-0xa57>
 535:	5f                   	pop    rdi
 536:	5f                   	pop    rdi
 537:	00 5f 49             	add    BYTE PTR [rdi+0x49],bl
 53a:	54                   	push   rsp
 53b:	4d 5f                	rex.WRB pop r15
 53d:	72 65                	jb     5a4 <_init-0xa5c>
 53f:	67 69 73 74 65 72 54 	imul   esi,DWORD PTR [ebx+0x74],0x4d547265
 546:	4d 
 547:	43 6c                	rex.XB ins BYTE PTR es:[rdi],dx
 549:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 54a:	6e                   	outs   dx,BYTE PTR ds:[rsi]
 54b:	65 54                	gs push rsp
 54d:	61                   	(bad)
 54e:	62                   	.byte 0x62
 54f:	6c                   	ins    BYTE PTR es:[rdi],dx
 550:	65                   	gs
	...

Disassembly of section .gnu.version:

0000000000000552 <.gnu.version>:
 552:	00 00                	add    BYTE PTR [rax],al
 554:	02 00                	add    al,BYTE PTR [rax]
 556:	01 00                	add    DWORD PTR [rax],eax
 558:	03 00                	add    eax,DWORD PTR [rax]
 55a:	01 00                	add    DWORD PTR [rax],eax
 55c:	01 00                	add    DWORD PTR [rax],eax
 55e:	04 00                	add    al,0x0
 560:	04 00                	add    al,0x0

Disassembly of section .gnu.version_r:

0000000000000568 <.gnu.version_r>:
 568:	01 00                	add    DWORD PTR [rax],eax
 56a:	03 00                	add    eax,DWORD PTR [rax]
 56c:	3a 00                	cmp    al,BYTE PTR [rax]
 56e:	00 00                	add    BYTE PTR [rax],al
 570:	10 00                	adc    BYTE PTR [rax],al
 572:	00 00                	add    BYTE PTR [rax],al
 574:	00 00                	add    BYTE PTR [rax],al
 576:	00 00                	add    BYTE PTR [rax],al
 578:	75 1a                	jne    594 <_init-0xa6c>
 57a:	69 09 00 00 04 00    	imul   ecx,DWORD PTR [rcx],0x40000
 580:	44 00 00             	add    BYTE PTR [rax],r8b
 583:	00 10                	add    BYTE PTR [rax],dl
 585:	00 00                	add    BYTE PTR [rax],al
 587:	00 14 69             	add    BYTE PTR [rcx+rbp*2],dl
 58a:	69 0d 00 00 03 00 50 	imul   ecx,DWORD PTR [rip+0x30000],0x50        # 30594 <_end+0x2c574>
 591:	00 00 00 
 594:	10 00                	adc    BYTE PTR [rax],al
 596:	00 00                	add    BYTE PTR [rax],al
 598:	b4 91                	mov    ah,0x91
 59a:	96                   	xchg   esi,eax
 59b:	06                   	(bad)
 59c:	00 00                	add    BYTE PTR [rax],al
 59e:	02 00                	add    al,BYTE PTR [rax]
 5a0:	5a                   	pop    rdx
 5a1:	00 00                	add    BYTE PTR [rax],al
 5a3:	00 00                	add    BYTE PTR [rax],al
 5a5:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .rela.dyn:

00000000000005a8 <.rela.dyn>:
 5a8:	c8 3d 00 00          	enter  0x3d,0x0
 5ac:	00 00                	add    BYTE PTR [rax],al
 5ae:	00 00                	add    BYTE PTR [rax],al
 5b0:	08 00                	or     BYTE PTR [rax],al
 5b2:	00 00                	add    BYTE PTR [rax],al
 5b4:	00 00                	add    BYTE PTR [rax],al
 5b6:	00 00                	add    BYTE PTR [rax],al
 5b8:	40 11 00             	rex adc DWORD PTR [rax],eax
 5bb:	00 00                	add    BYTE PTR [rax],al
 5bd:	00 00                	add    BYTE PTR [rax],al
 5bf:	00 d0                	add    al,dl
 5c1:	3d 00 00 00 00       	cmp    eax,0x0
 5c6:	00 00                	add    BYTE PTR [rax],al
 5c8:	08 00                	or     BYTE PTR [rax],al
 5ca:	00 00                	add    BYTE PTR [rax],al
 5cc:	00 00                	add    BYTE PTR [rax],al
 5ce:	00 00                	add    BYTE PTR [rax],al
 5d0:	f0 10 00             	lock adc BYTE PTR [rax],al
 5d3:	00 00                	add    BYTE PTR [rax],al
 5d5:	00 00                	add    BYTE PTR [rax],al
 5d7:	00 10                	add    BYTE PTR [rax],dl
 5d9:	40 00 00             	rex add BYTE PTR [rax],al
 5dc:	00 00                	add    BYTE PTR [rax],al
 5de:	00 00                	add    BYTE PTR [rax],al
 5e0:	08 00                	or     BYTE PTR [rax],al
 5e2:	00 00                	add    BYTE PTR [rax],al
 5e4:	00 00                	add    BYTE PTR [rax],al
 5e6:	00 00                	add    BYTE PTR [rax],al
 5e8:	10 40 00             	adc    BYTE PTR [rax+0x0],al
 5eb:	00 00                	add    BYTE PTR [rax],al
 5ed:	00 00                	add    BYTE PTR [rax],al
 5ef:	00 b8 3f 00 00 00    	add    BYTE PTR [rax+0x3f],bh
 5f5:	00 00                	add    BYTE PTR [rax],al
 5f7:	00 06                	add    BYTE PTR [rsi],al
 5f9:	00 00                	add    BYTE PTR [rax],al
 5fb:	00 01                	add    BYTE PTR [rcx],al
	...
 605:	00 00                	add    BYTE PTR [rax],al
 607:	00 c0                	add    al,al
 609:	3f                   	(bad)
 60a:	00 00                	add    BYTE PTR [rax],al
 60c:	00 00                	add    BYTE PTR [rax],al
 60e:	00 00                	add    BYTE PTR [rax],al
 610:	06                   	(bad)
 611:	00 00                	add    BYTE PTR [rax],al
 613:	00 02                	add    BYTE PTR [rdx],al
	...
 61d:	00 00                	add    BYTE PTR [rax],al
 61f:	00 c8                	add    al,cl
 621:	3f                   	(bad)
 622:	00 00                	add    BYTE PTR [rax],al
 624:	00 00                	add    BYTE PTR [rax],al
 626:	00 00                	add    BYTE PTR [rax],al
 628:	06                   	(bad)
 629:	00 00                	add    BYTE PTR [rax],al
 62b:	00 07                	add    BYTE PTR [rdi],al
	...
 635:	00 00                	add    BYTE PTR [rax],al
 637:	00 d0                	add    al,dl
 639:	3f                   	(bad)
 63a:	00 00                	add    BYTE PTR [rax],al
 63c:	00 00                	add    BYTE PTR [rax],al
 63e:	00 00                	add    BYTE PTR [rax],al
 640:	06                   	(bad)
 641:	00 00                	add    BYTE PTR [rax],al
 643:	00 04 00             	add    BYTE PTR [rax+rax*1],al
	...
 64e:	00 00                	add    BYTE PTR [rax],al
 650:	d8 3f                	fdivr  DWORD PTR [rdi]
 652:	00 00                	add    BYTE PTR [rax],al
 654:	00 00                	add    BYTE PTR [rax],al
 656:	00 00                	add    BYTE PTR [rax],al
 658:	06                   	(bad)
 659:	00 00                	add    BYTE PTR [rax],al
 65b:	00 05 00 00 00 00    	add    BYTE PTR [rip+0x0],al        # 661 <_init-0x99f>
 661:	00 00                	add    BYTE PTR [rax],al
 663:	00 00                	add    BYTE PTR [rax],al
 665:	00 00                	add    BYTE PTR [rax],al
 667:	00 e0                	add    al,ah
 669:	3f                   	(bad)
 66a:	00 00                	add    BYTE PTR [rax],al
 66c:	00 00                	add    BYTE PTR [rax],al
 66e:	00 00                	add    BYTE PTR [rax],al
 670:	06                   	(bad)
 671:	00 00                	add    BYTE PTR [rax],al
 673:	00 06                	add    BYTE PTR [rsi],al
	...

Disassembly of section .rela.plt:

0000000000000680 <.rela.plt>:
 680:	00 40 00             	add    BYTE PTR [rax+0x0],al
 683:	00 00                	add    BYTE PTR [rax],al
 685:	00 00                	add    BYTE PTR [rax],al
 687:	00 07                	add    BYTE PTR [rdi],al
 689:	00 00                	add    BYTE PTR [rax],al
 68b:	00 03                	add    BYTE PTR [rbx],al
	...

Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    rsp,0x8
    1008:	48 8b 05 c1 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fc1]        # 3fd0 <__gmon_start__@Base>
    100f:	48 85 c0             	test   rax,rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   rax
    1016:	48 83 c4 08          	add    rsp,0x8
    101a:	c3                   	ret

Disassembly of section .plt:

0000000000001020 <__stack_chk_fail@plt-0x10>:
    1020:	ff 35 ca 2f 00 00    	push   QWORD PTR [rip+0x2fca]        # 3ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 cc 2f 00 00    	jmp    QWORD PTR [rip+0x2fcc]        # 3ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]

0000000000001030 <__stack_chk_fail@plt>:
    1030:	ff 25 ca 2f 00 00    	jmp    QWORD PTR [rip+0x2fca]        # 4000 <__stack_chk_fail@GLIBC_2.4>
    1036:	68 00 00 00 00       	push   0x0
    103b:	e9 e0 ff ff ff       	jmp    1020 <_init+0x20>

Disassembly of section .plt.got:

0000000000001040 <printf@plt>:
    1040:	ff 25 82 2f 00 00    	jmp    QWORD PTR [rip+0x2f82]        # 3fc8 <printf@GLIBC_2.2.5>
    1046:	66 90                	xchg   ax,ax

Disassembly of section .text:

0000000000001050 <_start>:
    1050:	f3 0f 1e fa          	endbr64
    1054:	31 ed                	xor    ebp,ebp
    1056:	49 89 d1             	mov    r9,rdx
    1059:	5e                   	pop    rsi
    105a:	48 89 e2             	mov    rdx,rsp
    105d:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
    1061:	50                   	push   rax
    1062:	54                   	push   rsp
    1063:	45 31 c0             	xor    r8d,r8d
    1066:	31 c9                	xor    ecx,ecx
    1068:	48 8d 3d 7b 01 00 00 	lea    rdi,[rip+0x17b]        # 11ea <main>
    106f:	ff 15 43 2f 00 00    	call   QWORD PTR [rip+0x2f43]        # 3fb8 <__libc_start_main@GLIBC_2.34>
    1075:	f4                   	hlt
    1076:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    107d:	00 00 00 
    1080:	48 8d 3d 91 2f 00 00 	lea    rdi,[rip+0x2f91]        # 4018 <__TMC_END__>
    1087:	48 8d 05 8a 2f 00 00 	lea    rax,[rip+0x2f8a]        # 4018 <__TMC_END__>
    108e:	48 39 f8             	cmp    rax,rdi
    1091:	74 15                	je     10a8 <_start+0x58>
    1093:	48 8b 05 26 2f 00 00 	mov    rax,QWORD PTR [rip+0x2f26]        # 3fc0 <_ITM_deregisterTMCloneTable@Base>
    109a:	48 85 c0             	test   rax,rax
    109d:	74 09                	je     10a8 <_start+0x58>
    109f:	ff e0                	jmp    rax
    10a1:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    10a8:	c3                   	ret
    10a9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    10b0:	48 8d 3d 61 2f 00 00 	lea    rdi,[rip+0x2f61]        # 4018 <__TMC_END__>
    10b7:	48 8d 35 5a 2f 00 00 	lea    rsi,[rip+0x2f5a]        # 4018 <__TMC_END__>
    10be:	48 29 fe             	sub    rsi,rdi
    10c1:	48 89 f0             	mov    rax,rsi
    10c4:	48 c1 ee 3f          	shr    rsi,0x3f
    10c8:	48 c1 f8 03          	sar    rax,0x3
    10cc:	48 01 c6             	add    rsi,rax
    10cf:	48 d1 fe             	sar    rsi,1
    10d2:	74 14                	je     10e8 <_start+0x98>
    10d4:	48 8b 05 fd 2e 00 00 	mov    rax,QWORD PTR [rip+0x2efd]        # 3fd8 <_ITM_registerTMCloneTable@Base>
    10db:	48 85 c0             	test   rax,rax
    10de:	74 08                	je     10e8 <_start+0x98>
    10e0:	ff e0                	jmp    rax
    10e2:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    10e8:	c3                   	ret
    10e9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    10f0:	f3 0f 1e fa          	endbr64
    10f4:	80 3d 1d 2f 00 00 00 	cmp    BYTE PTR [rip+0x2f1d],0x0        # 4018 <__TMC_END__>
    10fb:	75 33                	jne    1130 <_start+0xe0>
    10fd:	55                   	push   rbp
    10fe:	48 83 3d da 2e 00 00 	cmp    QWORD PTR [rip+0x2eda],0x0        # 3fe0 <__cxa_finalize@GLIBC_2.2.5>
    1105:	00 
    1106:	48 89 e5             	mov    rbp,rsp
    1109:	74 0d                	je     1118 <_start+0xc8>
    110b:	48 8b 3d fe 2e 00 00 	mov    rdi,QWORD PTR [rip+0x2efe]        # 4010 <__dso_handle>
    1112:	ff 15 c8 2e 00 00    	call   QWORD PTR [rip+0x2ec8]        # 3fe0 <__cxa_finalize@GLIBC_2.2.5>
    1118:	e8 63 ff ff ff       	call   1080 <_start+0x30>
    111d:	c6 05 f4 2e 00 00 01 	mov    BYTE PTR [rip+0x2ef4],0x1        # 4018 <__TMC_END__>
    1124:	5d                   	pop    rbp
    1125:	c3                   	ret
    1126:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    112d:	00 00 00 
    1130:	c3                   	ret
    1131:	66 66 2e 0f 1f 84 00 	data16 cs nop WORD PTR [rax+rax*1+0x0]
    1138:	00 00 00 00 
    113c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1140:	f3 0f 1e fa          	endbr64
    1144:	e9 67 ff ff ff       	jmp    10b0 <_start+0x60>

0000000000001149 <solver>:
    1149:	55                   	push   rbp
    114a:	48 89 e5             	mov    rbp,rsp
    114d:	48 83 ec 30          	sub    rsp,0x30
    1151:	48 89 7d d8          	mov    QWORD PTR [rbp-0x28],rdi
    1155:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    115c:	00 00 
    115e:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1162:	31 c0                	xor    eax,eax
    1164:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    1168:	48 83 c0 18          	add    rax,0x18
    116c:	48 8b 00             	mov    rax,QWORD PTR [rax]
    116f:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1173:	48 89 c6             	mov    rsi,rax
    1176:	48 8d 05 87 0e 00 00 	lea    rax,[rip+0xe87]        # 2004 <_IO_stdin_used+0x4>
    117d:	48 89 c7             	mov    rdi,rax
    1180:	b8 00 00 00 00       	mov    eax,0x0
    1185:	ff d2                	call   rdx
    1187:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    118b:	48 83 c0 20          	add    rax,0x20
    118f:	48 8b 00             	mov    rax,QWORD PTR [rax]
    1192:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    1196:	48 89 c6             	mov    rsi,rax
    1199:	48 8d 05 64 0e 00 00 	lea    rax,[rip+0xe64]        # 2004 <_IO_stdin_used+0x4>
    11a0:	48 89 c7             	mov    rdi,rax
    11a3:	b8 00 00 00 00       	mov    eax,0x0
    11a8:	ff d2                	call   rdx
    11aa:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    11ae:	48 83 c0 28          	add    rax,0x28
    11b2:	48 8b 00             	mov    rax,QWORD PTR [rax]
    11b5:	48 05 ab 00 00 00    	add    rax,0xab
    11bb:	48 8b 55 d8          	mov    rdx,QWORD PTR [rbp-0x28]
    11bf:	48 89 c6             	mov    rsi,rax
    11c2:	48 8d 05 3b 0e 00 00 	lea    rax,[rip+0xe3b]        # 2004 <_IO_stdin_used+0x4>
    11c9:	48 89 c7             	mov    rdi,rax
    11cc:	b8 00 00 00 00       	mov    eax,0x0
    11d1:	ff d2                	call   rdx
    11d3:	90                   	nop
    11d4:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11d8:	64 48 2b 04 25 28 00 	sub    rax,QWORD PTR fs:0x28
    11df:	00 00 
    11e1:	74 05                	je     11e8 <solver+0x9f>
    11e3:	e8 48 fe ff ff       	call   1030 <__stack_chk_fail@plt>
    11e8:	c9                   	leave
    11e9:	c3                   	ret

00000000000011ea <main>:
    11ea:	55                   	push   rbp
    11eb:	48 89 e5             	mov    rbp,rsp
    11ee:	48 83 ec 20          	sub    rsp,0x20
    11f2:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    11f9:	00 00 
    11fb:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    11ff:	31 c0                	xor    eax,eax
    1201:	48 b8 2a 2a 20 6d 61 	movabs rax,0x206e69616d202a2a
    1208:	69 6e 20 
    120b:	48 ba 3d 20 25 70 0a 	movabs rdx,0xa7025203d
    1212:	00 00 00 
    1215:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1219:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    121d:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    1221:	48 8d 15 c2 ff ff ff 	lea    rdx,[rip+0xffffffffffffffc2]        # 11ea <main>
    1228:	48 89 d6             	mov    rsi,rdx
    122b:	48 89 c7             	mov    rdi,rax
    122e:	b8 00 00 00 00       	mov    eax,0x0
    1233:	e8 08 fe ff ff       	call   1040 <printf@plt>
    1238:	48 8b 05 89 2d 00 00 	mov    rax,QWORD PTR [rip+0x2d89]        # 3fc8 <printf@GLIBC_2.2.5>
    123f:	48 89 c7             	mov    rdi,rax
    1242:	e8 02 ff ff ff       	call   1149 <solver>
    1247:	b8 00 00 00 00       	mov    eax,0x0
    124c:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    1250:	64 48 2b 14 25 28 00 	sub    rdx,QWORD PTR fs:0x28
    1257:	00 00 
    1259:	74 05                	je     1260 <main+0x76>
    125b:	e8 d0 fd ff ff       	call   1030 <__stack_chk_fail@plt>
    1260:	c9                   	leave
    1261:	c3                   	ret

Disassembly of section .fini:

0000000000001264 <_fini>:
    1264:	f3 0f 1e fa          	endbr64
    1268:	48 83 ec 08          	sub    rsp,0x8
    126c:	48 83 c4 08          	add    rsp,0x8
    1270:	c3                   	ret

Disassembly of section .rodata:

0000000000002000 <_IO_stdin_used>:
    2000:	01 00                	add    DWORD PTR [rax],eax
    2002:	02 00                	add    al,BYTE PTR [rax]
    2004:	3a 20                	cmp    ah,BYTE PTR [rax]
    2006:	25 30 31 36 6c       	and    eax,0x6c363130
    200b:	78 0a                	js     2017 <__GNU_EH_FRAME_HDR+0x7>
	...

Disassembly of section .eh_frame_hdr:

0000000000002010 <__GNU_EH_FRAME_HDR>:
    2010:	01 1b                	add    DWORD PTR [rbx],ebx
    2012:	03 3b                	add    edi,DWORD PTR [rbx]
    2014:	34 00                	xor    al,0x0
    2016:	00 00                	add    BYTE PTR [rax],al
    2018:	05 00 00 00 10       	add    eax,0x10000000
    201d:	f0 ff                	lock (bad)
    201f:	ff 68 00             	jmp    FWORD PTR [rax+0x0]
    2022:	00 00                	add    BYTE PTR [rax],al
    2024:	30 f0                	xor    al,dh
    2026:	ff                   	(bad)
    2027:	ff 90 00 00 00 40    	call   QWORD PTR [rax+0x40000000]
    202d:	f0 ff                	lock (bad)
    202f:	ff 50 00             	call   QWORD PTR [rax+0x0]
    2032:	00 00                	add    BYTE PTR [rax],al
    2034:	39 f1                	cmp    ecx,esi
    2036:	ff                   	(bad)
    2037:	ff a8 00 00 00 da    	jmp    FWORD PTR [rax-0x26000000]
    203d:	f1                   	int1
    203e:	ff                   	(bad)
    203f:	ff c8                	dec    eax
    2041:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .eh_frame:

0000000000002048 <.eh_frame>:
    2048:	14 00                	adc    al,0x0
    204a:	00 00                	add    BYTE PTR [rax],al
    204c:	00 00                	add    BYTE PTR [rax],al
    204e:	00 00                	add    BYTE PTR [rax],al
    2050:	01 7a 52             	add    DWORD PTR [rdx+0x52],edi
    2053:	00 01                	add    BYTE PTR [rcx],al
    2055:	78 10                	js     2067 <__GNU_EH_FRAME_HDR+0x57>
    2057:	01 1b                	add    DWORD PTR [rbx],ebx
    2059:	0c 07                	or     al,0x7
    205b:	08 90 01 00 00 14    	or     BYTE PTR [rax+0x14000001],dl
    2061:	00 00                	add    BYTE PTR [rax],al
    2063:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
    2066:	00 00                	add    BYTE PTR [rax],al
    2068:	e8 ef ff ff 26       	call   2700205c <_end+0x26ffe03c>
    206d:	00 00                	add    BYTE PTR [rax],al
    206f:	00 00                	add    BYTE PTR [rax],al
    2071:	44 07                	rex.R (bad)
    2073:	10 00                	adc    BYTE PTR [rax],al
    2075:	00 00                	add    BYTE PTR [rax],al
    2077:	00 24 00             	add    BYTE PTR [rax+rax*1],ah
    207a:	00 00                	add    BYTE PTR [rax],al
    207c:	34 00                	xor    al,0x0
    207e:	00 00                	add    BYTE PTR [rax],al
    2080:	a0 ef ff ff 20 00 00 	movabs al,ds:0x20ffffef
    2087:	00 00 
    2089:	0e                   	(bad)
    208a:	10 46 0e             	adc    BYTE PTR [rsi+0xe],al
    208d:	18 4a 0f             	sbb    BYTE PTR [rdx+0xf],cl
    2090:	0b 77 08             	or     esi,DWORD PTR [rdi+0x8]
    2093:	80 00 3f             	add    BYTE PTR [rax],0x3f
    2096:	1a 3b                	sbb    bh,BYTE PTR [rbx]
    2098:	2a 33                	sub    dh,BYTE PTR [rbx]
    209a:	24 22                	and    al,0x22
    209c:	00 00                	add    BYTE PTR [rax],al
    209e:	00 00                	add    BYTE PTR [rax],al
    20a0:	14 00                	adc    al,0x0
    20a2:	00 00                	add    BYTE PTR [rax],al
    20a4:	5c                   	pop    rsp
    20a5:	00 00                	add    BYTE PTR [rax],al
    20a7:	00 98 ef ff ff 08    	add    BYTE PTR [rax+0x8ffffef],bl
	...
    20b5:	00 00                	add    BYTE PTR [rax],al
    20b7:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
    20ba:	00 00                	add    BYTE PTR [rax],al
    20bc:	74 00                	je     20be <__GNU_EH_FRAME_HDR+0xae>
    20be:	00 00                	add    BYTE PTR [rax],al
    20c0:	89 f0                	mov    eax,esi
    20c2:	ff                   	(bad)
    20c3:	ff a1 00 00 00 00    	jmp    QWORD PTR [rcx+0x0]
    20c9:	41 0e                	rex.B (bad)
    20cb:	10 86 02 43 0d 06    	adc    BYTE PTR [rsi+0x60d4302],al
    20d1:	02 9c 0c 07 08 00 00 	add    bl,BYTE PTR [rsp+rcx*1+0x807]
    20d8:	1c 00                	sbb    al,0x0
    20da:	00 00                	add    BYTE PTR [rax],al
    20dc:	94                   	xchg   esp,eax
    20dd:	00 00                	add    BYTE PTR [rax],al
    20df:	00 0a                	add    BYTE PTR [rdx],cl
    20e1:	f1                   	int1
    20e2:	ff                   	(bad)
    20e3:	ff                   	(bad)
    20e4:	78 00                	js     20e6 <__GNU_EH_FRAME_HDR+0xd6>
    20e6:	00 00                	add    BYTE PTR [rax],al
    20e8:	00 41 0e             	add    BYTE PTR [rcx+0xe],al
    20eb:	10 86 02 43 0d 06    	adc    BYTE PTR [rsi+0x60d4302],al
    20f1:	02 73 0c             	add    dh,BYTE PTR [rbx+0xc]
    20f4:	07                   	(bad)
    20f5:	08 00                	or     BYTE PTR [rax],al
    20f7:	00 00                	add    BYTE PTR [rax],al
    20f9:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .init_array:

0000000000003dc8 <.init_array>:
    3dc8:	40 11 00             	rex adc DWORD PTR [rax],eax
    3dcb:	00 00                	add    BYTE PTR [rax],al
    3dcd:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .fini_array:

0000000000003dd0 <.fini_array>:
    3dd0:	f0 10 00             	lock adc BYTE PTR [rax],al
    3dd3:	00 00                	add    BYTE PTR [rax],al
    3dd5:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .dynamic:

0000000000003dd8 <_DYNAMIC>:
    3dd8:	01 00                	add    DWORD PTR [rax],eax
    3dda:	00 00                	add    BYTE PTR [rax],al
    3ddc:	00 00                	add    BYTE PTR [rax],al
    3dde:	00 00                	add    BYTE PTR [rax],al
    3de0:	3a 00                	cmp    al,BYTE PTR [rax]
    3de2:	00 00                	add    BYTE PTR [rax],al
    3de4:	00 00                	add    BYTE PTR [rax],al
    3de6:	00 00                	add    BYTE PTR [rax],al
    3de8:	0c 00                	or     al,0x0
    3dea:	00 00                	add    BYTE PTR [rax],al
    3dec:	00 00                	add    BYTE PTR [rax],al
    3dee:	00 00                	add    BYTE PTR [rax],al
    3df0:	00 10                	add    BYTE PTR [rax],dl
    3df2:	00 00                	add    BYTE PTR [rax],al
    3df4:	00 00                	add    BYTE PTR [rax],al
    3df6:	00 00                	add    BYTE PTR [rax],al
    3df8:	0d 00 00 00 00       	or     eax,0x0
    3dfd:	00 00                	add    BYTE PTR [rax],al
    3dff:	00 64 12 00          	add    BYTE PTR [rdx+rdx*1+0x0],ah
    3e03:	00 00                	add    BYTE PTR [rax],al
    3e05:	00 00                	add    BYTE PTR [rax],al
    3e07:	00 19                	add    BYTE PTR [rcx],bl
    3e09:	00 00                	add    BYTE PTR [rax],al
    3e0b:	00 00                	add    BYTE PTR [rax],al
    3e0d:	00 00                	add    BYTE PTR [rax],al
    3e0f:	00 c8                	add    al,cl
    3e11:	3d 00 00 00 00       	cmp    eax,0x0
    3e16:	00 00                	add    BYTE PTR [rax],al
    3e18:	1b 00                	sbb    eax,DWORD PTR [rax]
    3e1a:	00 00                	add    BYTE PTR [rax],al
    3e1c:	00 00                	add    BYTE PTR [rax],al
    3e1e:	00 00                	add    BYTE PTR [rax],al
    3e20:	08 00                	or     BYTE PTR [rax],al
    3e22:	00 00                	add    BYTE PTR [rax],al
    3e24:	00 00                	add    BYTE PTR [rax],al
    3e26:	00 00                	add    BYTE PTR [rax],al
    3e28:	1a 00                	sbb    al,BYTE PTR [rax]
    3e2a:	00 00                	add    BYTE PTR [rax],al
    3e2c:	00 00                	add    BYTE PTR [rax],al
    3e2e:	00 00                	add    BYTE PTR [rax],al
    3e30:	d0 3d 00 00 00 00    	sar    BYTE PTR [rip+0x0],1        # 3e36 <_DYNAMIC+0x5e>
    3e36:	00 00                	add    BYTE PTR [rax],al
    3e38:	1c 00                	sbb    al,0x0
    3e3a:	00 00                	add    BYTE PTR [rax],al
    3e3c:	00 00                	add    BYTE PTR [rax],al
    3e3e:	00 00                	add    BYTE PTR [rax],al
    3e40:	08 00                	or     BYTE PTR [rax],al
    3e42:	00 00                	add    BYTE PTR [rax],al
    3e44:	00 00                	add    BYTE PTR [rax],al
    3e46:	00 00                	add    BYTE PTR [rax],al
    3e48:	f5                   	cmc
    3e49:	fe                   	(bad)
    3e4a:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3e4d:	00 00                	add    BYTE PTR [rax],al
    3e4f:	00 c0                	add    al,al
    3e51:	03 00                	add    eax,DWORD PTR [rax]
    3e53:	00 00                	add    BYTE PTR [rax],al
    3e55:	00 00                	add    BYTE PTR [rax],al
    3e57:	00 05 00 00 00 00    	add    BYTE PTR [rip+0x0],al        # 3e5d <_DYNAMIC+0x85>
    3e5d:	00 00                	add    BYTE PTR [rax],al
    3e5f:	00 a8 04 00 00 00    	add    BYTE PTR [rax+0x4],ch
    3e65:	00 00                	add    BYTE PTR [rax],al
    3e67:	00 06                	add    BYTE PTR [rsi],al
    3e69:	00 00                	add    BYTE PTR [rax],al
    3e6b:	00 00                	add    BYTE PTR [rax],al
    3e6d:	00 00                	add    BYTE PTR [rax],al
    3e6f:	00 e8                	add    al,ch
    3e71:	03 00                	add    eax,DWORD PTR [rax]
    3e73:	00 00                	add    BYTE PTR [rax],al
    3e75:	00 00                	add    BYTE PTR [rax],al
    3e77:	00 0a                	add    BYTE PTR [rdx],cl
    3e79:	00 00                	add    BYTE PTR [rax],al
    3e7b:	00 00                	add    BYTE PTR [rax],al
    3e7d:	00 00                	add    BYTE PTR [rax],al
    3e7f:	00 aa 00 00 00 00    	add    BYTE PTR [rdx+0x0],ch
    3e85:	00 00                	add    BYTE PTR [rax],al
    3e87:	00 0b                	add    BYTE PTR [rbx],cl
    3e89:	00 00                	add    BYTE PTR [rax],al
    3e8b:	00 00                	add    BYTE PTR [rax],al
    3e8d:	00 00                	add    BYTE PTR [rax],al
    3e8f:	00 18                	add    BYTE PTR [rax],bl
    3e91:	00 00                	add    BYTE PTR [rax],al
    3e93:	00 00                	add    BYTE PTR [rax],al
    3e95:	00 00                	add    BYTE PTR [rax],al
    3e97:	00 15 00 00 00 00    	add    BYTE PTR [rip+0x0],dl        # 3e9d <_DYNAMIC+0xc5>
	...
    3ea5:	00 00                	add    BYTE PTR [rax],al
    3ea7:	00 03                	add    BYTE PTR [rbx],al
    3ea9:	00 00                	add    BYTE PTR [rax],al
    3eab:	00 00                	add    BYTE PTR [rax],al
    3ead:	00 00                	add    BYTE PTR [rax],al
    3eaf:	00 e8                	add    al,ch
    3eb1:	3f                   	(bad)
    3eb2:	00 00                	add    BYTE PTR [rax],al
    3eb4:	00 00                	add    BYTE PTR [rax],al
    3eb6:	00 00                	add    BYTE PTR [rax],al
    3eb8:	02 00                	add    al,BYTE PTR [rax]
    3eba:	00 00                	add    BYTE PTR [rax],al
    3ebc:	00 00                	add    BYTE PTR [rax],al
    3ebe:	00 00                	add    BYTE PTR [rax],al
    3ec0:	18 00                	sbb    BYTE PTR [rax],al
    3ec2:	00 00                	add    BYTE PTR [rax],al
    3ec4:	00 00                	add    BYTE PTR [rax],al
    3ec6:	00 00                	add    BYTE PTR [rax],al
    3ec8:	14 00                	adc    al,0x0
    3eca:	00 00                	add    BYTE PTR [rax],al
    3ecc:	00 00                	add    BYTE PTR [rax],al
    3ece:	00 00                	add    BYTE PTR [rax],al
    3ed0:	07                   	(bad)
    3ed1:	00 00                	add    BYTE PTR [rax],al
    3ed3:	00 00                	add    BYTE PTR [rax],al
    3ed5:	00 00                	add    BYTE PTR [rax],al
    3ed7:	00 17                	add    BYTE PTR [rdi],dl
    3ed9:	00 00                	add    BYTE PTR [rax],al
    3edb:	00 00                	add    BYTE PTR [rax],al
    3edd:	00 00                	add    BYTE PTR [rax],al
    3edf:	00 80 06 00 00 00    	add    BYTE PTR [rax+0x6],al
    3ee5:	00 00                	add    BYTE PTR [rax],al
    3ee7:	00 07                	add    BYTE PTR [rdi],al
    3ee9:	00 00                	add    BYTE PTR [rax],al
    3eeb:	00 00                	add    BYTE PTR [rax],al
    3eed:	00 00                	add    BYTE PTR [rax],al
    3eef:	00 a8 05 00 00 00    	add    BYTE PTR [rax+0x5],ch
    3ef5:	00 00                	add    BYTE PTR [rax],al
    3ef7:	00 08                	add    BYTE PTR [rax],cl
    3ef9:	00 00                	add    BYTE PTR [rax],al
    3efb:	00 00                	add    BYTE PTR [rax],al
    3efd:	00 00                	add    BYTE PTR [rax],al
    3eff:	00 d8                	add    al,bl
    3f01:	00 00                	add    BYTE PTR [rax],al
    3f03:	00 00                	add    BYTE PTR [rax],al
    3f05:	00 00                	add    BYTE PTR [rax],al
    3f07:	00 09                	add    BYTE PTR [rcx],cl
    3f09:	00 00                	add    BYTE PTR [rax],al
    3f0b:	00 00                	add    BYTE PTR [rax],al
    3f0d:	00 00                	add    BYTE PTR [rax],al
    3f0f:	00 18                	add    BYTE PTR [rax],bl
    3f11:	00 00                	add    BYTE PTR [rax],al
    3f13:	00 00                	add    BYTE PTR [rax],al
    3f15:	00 00                	add    BYTE PTR [rax],al
    3f17:	00 fb                	add    bl,bh
    3f19:	ff                   	(bad)
    3f1a:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f1d:	00 00                	add    BYTE PTR [rax],al
    3f1f:	00 00                	add    BYTE PTR [rax],al
    3f21:	00 00                	add    BYTE PTR [rax],al
    3f23:	08 00                	or     BYTE PTR [rax],al
    3f25:	00 00                	add    BYTE PTR [rax],al
    3f27:	00 fe                	add    dh,bh
    3f29:	ff                   	(bad)
    3f2a:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f2d:	00 00                	add    BYTE PTR [rax],al
    3f2f:	00 68 05             	add    BYTE PTR [rax+0x5],ch
    3f32:	00 00                	add    BYTE PTR [rax],al
    3f34:	00 00                	add    BYTE PTR [rax],al
    3f36:	00 00                	add    BYTE PTR [rax],al
    3f38:	ff                   	(bad)
    3f39:	ff                   	(bad)
    3f3a:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f3d:	00 00                	add    BYTE PTR [rax],al
    3f3f:	00 01                	add    BYTE PTR [rcx],al
    3f41:	00 00                	add    BYTE PTR [rax],al
    3f43:	00 00                	add    BYTE PTR [rax],al
    3f45:	00 00                	add    BYTE PTR [rax],al
    3f47:	00 f0                	add    al,dh
    3f49:	ff                   	(bad)
    3f4a:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f4d:	00 00                	add    BYTE PTR [rax],al
    3f4f:	00 52 05             	add    BYTE PTR [rdx+0x5],dl
    3f52:	00 00                	add    BYTE PTR [rax],al
    3f54:	00 00                	add    BYTE PTR [rax],al
    3f56:	00 00                	add    BYTE PTR [rax],al
    3f58:	f9                   	stc
    3f59:	ff                   	(bad)
    3f5a:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f5d:	00 00                	add    BYTE PTR [rax],al
    3f5f:	00 03                	add    BYTE PTR [rbx],al
	...

Disassembly of section .got:

0000000000003fb8 <.got>:
	...

Disassembly of section .got.plt:

0000000000003fe8 <_GLOBAL_OFFSET_TABLE_>:
    3fe8:	d8 3d 00 00 00 00    	fdivr  DWORD PTR [rip+0x0]        # 3fee <_GLOBAL_OFFSET_TABLE_+0x6>
	...
    3ffe:	00 00                	add    BYTE PTR [rax],al
    4000:	36 10 00             	ss adc BYTE PTR [rax],al
    4003:	00 00                	add    BYTE PTR [rax],al
    4005:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .data:

0000000000004008 <__data_start>:
	...

0000000000004010 <__dso_handle>:
    4010:	10 40 00             	adc    BYTE PTR [rax+0x0],al
    4013:	00 00                	add    BYTE PTR [rax],al
    4015:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .bss:

0000000000004018 <__bss_start>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	47                   	rex.RXB
   1:	43                   	rex.XB
   2:	43 3a 20             	rex.XB cmp spl,BYTE PTR [r8]
   5:	28 47 4e             	sub    BYTE PTR [rdi+0x4e],al
   8:	55                   	push   rbp
   9:	29 20                	sub    DWORD PTR [rax],esp
   b:	31 32                	xor    DWORD PTR [rdx],esi
   d:	2e 32 2e             	cs xor ch,BYTE PTR [rsi]
  10:	31 20                	xor    DWORD PTR [rax],esp
  12:	32 30                	xor    dh,BYTE PTR [rax]
  14:	32 33                	xor    dh,BYTE PTR [rbx]
  16:	30 32                	xor    BYTE PTR [rdx],dh
  18:	30 31                	xor    BYTE PTR [rcx],dh
	...
