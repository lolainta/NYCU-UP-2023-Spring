CPP		= g++
CFLAGS	= -Wall -g -D_GNU_SOURCE -fPIC
LDFLAGS = -lunwind -lunwind-$(shell uname -m)
PROGS	= sandbox.so

all: $(PROGS)

%.so: %.c
	$(CPP) -o $@ $< $(CFLAGS) --shared

clean:
	rm -f $(PROGS)

