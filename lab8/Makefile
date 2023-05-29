TARGET := runner
LIBNAME := capstone
CXX := g++

all:
	make $(TARGET)

%.o: %.cpp
	$(CXX) -c $^

runner: runner.cpp
	$(CXX) -o $@ $^ -std=c++20 -l$(LIBNAME) -static-pie

run: runner sample1
	./runner ./sample1
	./runner ./sample2
	./runner ./sample3

clean:
	rm $(TARGET)
	rm pcb.o
