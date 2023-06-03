TARGET := sdb
LIBNAME := capstone
CXX := g++
CXXFLAG := -std=c++17
SRC := $(wildcard *.cpp)
OBJ := $(patsubst %.cpp,%.o,$(SRC))

all:
	make sdb

%.o: %.cpp
	$(CXX) -c $^

sdb: $(OBJ)
	$(CXX) -o $@ $^ $(CXXFLAG) -l$(LIBNAME)

test: sdb
	./sdb examples/hello64
clean:
	rm -f $(TARGET)
	rm -f $(OBJ)
