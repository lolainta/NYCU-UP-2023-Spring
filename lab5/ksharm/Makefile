obj-m += kshram.o 
PWD := $(CURDIR) 
 
all: 
	make -C ../dist/modulebuild M=$(PWD) modules 
 
clean: 
	make -C ../dist/modulebuild M=$(PWD) clean

install: all
	mkdir -p ../rootfs/modules
	cp kshram.ko ../rootfs/modules

