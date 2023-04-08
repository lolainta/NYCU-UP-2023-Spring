CPP		= g++
CFLAGS	= -Wall -g -D_GNU_SOURCE -fPIC
LDFLAGS = -lunwind -lunwind-$(shell uname -m)
PROGS	= sandbox.so
.PHONY: all test clean

all: $(PROGS)

%.so: %.cpp
	$(CPP) -o $@ $< $(CFLAGS) --shared
test: launcher sandbox.so
	@echo Example 1
	./launcher ./sandbox.so config.txt cat /etc/passwd
	@echo Example 2
	./launcher ./sandbox.so config.txt cat /etc/hosts
	@echo Example 3
	./launcher ./sandbox.so config.txt cat /etc/ssl/certs/Amazon_Root_CA_1.pem
	@echo Example 4
	@echo Deleted
	@echo Example 5
	./launcher ./sandbox.so config.txt wget http://google.com -t 1
	@echo Example 6
	./launcher ./sandbox.so config.txt wget https://www.nycu.edu.tw -t 1
	@echo Example 7
	./launcher ./sandbox.so config.txt wget http://www.google.com -q -t 1
	@echo Example 8
	./launcher ./sandbox.so config.txt python3 -c 'import os;os.system("wget http://www.google.com -q -t 1")'

clean:
	rm -f $(PROGS)
	rm -f index.html*

