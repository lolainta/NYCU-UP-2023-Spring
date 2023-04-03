/*
 * Lab problem set for UNIX programming course
 * by Chun-Ying Huang <chuang@cs.nctu.edu.tw>
 * License: GPLv2
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <seccomp.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <sys/random.h>

#define errquit(m)	{ perror(m); _exit(-1); }

typedef int (*printf_ptr_t)(const char *fmt, ...);
typedef void (*solver_t)(printf_ptr_t);

int
os_urandom() {
	int v;
	if(getrandom(&v, sizeof(v), 0) < 0) errquit("getrandom");
	return v;
}

int
sandbox() {
	scmp_filter_ctx ctx;
	if(getenv("NO_SANDBOX") != NULL) return 0;
	if((ctx = seccomp_init(SCMP_ACT_KILL)) == NULL) errquit("seccomp_init");
	if(seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(write), 0) < 0) errquit("seccomp_rule_add");
	if(seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(brk), 0) < 0) errquit("seccomp_rule_add");
	if(seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(getrandom), 0) < 0) errquit("seccomp_rule_add");
	if(seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(newfstatat), 0) < 0) errquit("seccomp_rule_add");
	if(seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(exit), 0) < 0) errquit("seccomp_rule_add");
	if(seccomp_rule_add(ctx, SCMP_ACT_ALLOW, SCMP_SYS(exit_group), 0) < 0) errquit("seccomp_rule_add");
	if(seccomp_load(ctx) < 0) errquit("seccomp_load");
	seccomp_release(ctx);
	return 0;
}

int
guess() {
	char buf[16];
	int val, sz;
	printf("Show me your answer? ");
	if((sz = read(0, buf, 128)) < 0) errquit("guess/read");
	printf("** guess: %d byte(s) read\n", sz);
	if(sscanf(buf, "%d", &val) != 1) errquit("guess/sscanf");
	return strtol(buf, NULL, 0);
}

int
main() {
	pid_t pid;
	int e, bytes, nread, magic = 0x12345678;
	char buf[64];
	solver_t fptr;

	setvbuf(stdin,  NULL, _IONBF, 0);
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stderr, NULL, _IONBF, 0);

	printf("How many bytes of the solver executable do you want to send to me? ");
	if(fgets(buf, sizeof(buf), stdin) == NULL) errquit("read");
	if(sscanf(buf, "%d", &bytes) != 1) errquit("sscanf");

	if(bytes > 0) {
		printf("What relative address in the executable do you want to call? ");
		if(fgets(buf, sizeof(buf), stdin) == NULL) errquit("read");
		if(sscanf(buf, "%d", &magic) != 1) errquit("sscanf");

		e = (1+bytes/4096)*4096;
		if((fptr = mmap(NULL, e < 65536 ? e : 65536,
					PROT_READ|PROT_WRITE|PROT_EXEC,
					MAP_PRIVATE|MAP_ANON, -1, 0)) == NULL)
			errquit("mmap");

		printf("Send me your code (%d bytes): ", bytes);
		nread = 0;
		while(nread != bytes) {
			if((e = read(0, fptr+nread, bytes)) < 0)
				errquit("read");
			nread += e;
		}
		printf("** code: %d byte(s) received.\n", nread);

		if((pid = fork()) < 0) errquit("fork");
		if(pid == 0) {
			sandbox();
			fptr += magic;
			fptr(printf);
			printf("** Function evaluation done.\n");
			_exit(0);
		}
		if(waitpid(pid, &e, 0) < 0) errquit("waitpid");
	}

	bzero(buf, sizeof(buf));
	magic = os_urandom() & 0x7fffffff;
	nread = guess();
	if(magic == nread) {
		printf("** Good Job!\n");
		if((e = open("/FLAG", O_RDONLY)) < 0) errquit("open");
		while(read(e, buf, 1) == 1) {
			if(magic != nread) {
				printf("** Unexpected solution, please fixit!\n");
				break;
			}
			write(1, buf, 1);
		}
		close(e);
	} else {
		printf("** No no no ... magic = %x\n", magic);
	}

	return 0;
}
