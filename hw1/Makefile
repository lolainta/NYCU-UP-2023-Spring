CPP		= g++
CFLAGS	= -Wall -g -D_GNU_SOURCE -fPIC -std=gnu++17 -ldl
LDFLAGS = -lunwind -lunwind-$(shell uname -m)
PROGS	= sandbox.so moon
CONFIG_DIR = ./configs
.PHONY: all test clean self

all: $(PROGS)

self: $(PROGS)
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt $(shell pwd)/moon

moon: moon.cpp
	$(CPP) -o $@ $^

%.so: %.cpp elf-parser.c config.cpp
	$(CPP) -o $@ $^ $(CFLAGS) --shared

example1: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt cat /etc/passwd

example2: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt cat /etc/hosts

example3: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt cat /etc/ssl/certs/Amazon_Root_CA_1.pem

example5: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt wget http://google.com -t 1

example6: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt wget https://www.nycu.edu.tw -t 1

example7: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt wget http://www.google.com -q -t 1

example8: launcher ./sandbox.so
	./launcher ./sandbox.so $(CONFIG_DIR)/config.txt python3 -c 'import os;os.system("wget http://www.google.com -q -t 1")'

test:
	make example1
	make example2
	make example3
	make example5
	make example6
	make example7
	make example8

clean:
	rm -f $(PROGS)
	rm -f index.html*
	rm -f *.log
	rm -f *.o

