
CC		= gcc
CFLAGS	= -Wall -g -D_GNU_SOURCE -fPIC
LDFLAGS = -lunwind -lunwind-$(shell uname -m)
PROGS	= chals libpoem.so

all: $(PROGS)

%.o: %.c
	$(CC) -c $< $(CFLAGS)

%.so: %.c
	$(CC) -o $@ $< $(CFLAGS) --shared

chals: chals.o libpoem.so
	$(CC) -o $@ $^ $(LDFLAGS)

libpoem.so: libpoem.o
	$(CC) -o $@ -shared $^ $(LDFLAGS)

test: libsolver.so
	LD_LIBRARY_PATH=`pwd` LD_PRELOAD=./libsolver.so ./chals

run:
	LD_LIBRARY_PATH=`pwd` ./chals

cleanup:
	rm -f *.o

clean:
	rm -f $(PROGS) *.o
	rm -rf __pycache__

