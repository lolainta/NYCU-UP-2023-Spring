/*
 * Lab problem set for UNIX programming course
 * by Chun-Ying Huang <chuang@cs.nctu.edu.tw>
 * License: GPLv2
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>

#define errquit(m) { perror(m); exit(-1); }

#define LEN_CODE	(10*0x10000)
#define LEN_STACK	8192
#define TIMEOUT		60 //+99999999

void shell(char *stack, int slen) {
	int n;

	alarm(TIMEOUT);

	printf("\nshell> ");

	if((n = read(0, stack+(LEN_STACK/2), LEN_STACK/2)) < 0) errquit("read");
	printf("# %d bytes command received.\n", n);

	asm volatile (
		"mov %0, %%rsp\n"
		"xor %%rax, %%rax\n"
		"xor %%rbx, %%rbx\n"
		"xor %%rcx, %%rcx\n"
		"xor %%rdx, %%rdx\n"
		"xor %%rdi, %%rdi\n"
		"xor %%rsi, %%rsi\n"
		"xor %%rbp, %%rbp\n"
		"xor %%r8,  %%r8\n"
		"xor %%r9,  %%r9\n"
		"xor %%r10, %%r10\n"
		"xor %%r11, %%r11\n"
		"xor %%r12, %%r12\n"
		"xor %%r13, %%r13\n"
		"xor %%r14, %%r14\n"
		"xor %%r15, %%r15\n"
		"ret\n"
		:
		: "r" (stack+(LEN_STACK/2))
	);
}

int main() {
	char *code, *stack;
	uint32_t *codeint;
	long i, t;

	setvbuf(stdin,  NULL, _IONBF, 0);
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	code = mmap(NULL, LEN_CODE, PROT_READ|PROT_WRITE|PROT_EXEC,
			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	if(code == MAP_FAILED) errquit("mmap");
	codeint = (uint32_t*) code;

	stack = mmap(NULL, LEN_STACK, PROT_READ|PROT_WRITE,
			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
	if(stack == MAP_FAILED) errquit("mmap");

	memset(stack, 0, LEN_STACK);
	t = time(0);
	srand(t);
	for(i = 0; i < LEN_CODE/4; i++) {
		codeint[i] = (rand()<<16) | (rand() & 0xffff);
	}
	codeint[rand() % (LEN_CODE/4 - 1)] = 0xc3050f;
	if(mprotect(code, LEN_CODE, PROT_READ|PROT_EXEC) < 0) errquit("mprotect");

	printf("** Timestamp is %lu\n", t);
	printf("** Random bytes generated at %p\n", code);
	printf("** Runtime limitation is %d second(s)\n", TIMEOUT);

	alarm(TIMEOUT);

	while(1) {
		int st, pid = fork();
		if(pid == 0) {
			shell(stack, LEN_STACK);
			exit(0);
		}
		if(waitpid(pid, &st, 0) < 0)
			break;
		if(WIFEXITED(st)) {
			printf("** CMD: terminated with exit code %d\n", WEXITSTATUS(st));
		} else if(WIFSIGNALED(st)) {
			printf("** CMD: signaled with term signal %d\n", WTERMSIG(st));
		} else {
			printf("** CMD: terminated with unhandled state\n");
		}
	}

	return 0;
}
