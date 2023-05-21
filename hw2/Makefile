TARGET := sdb
LIBNAME := capstone
CXX := g++

all:
	make sdb

sdb: sdb.cpp
	$(CXX) -o $@ $^ -std=c++20 -l$(LIBNAME)

run: sdb hello64
	./sdb ./hello64

clean:
	rm $(TARGET)
