# We redefine how to build object files
MAKEFLAGS += --no-builtin-rules

AS = arm-linux-gnueabihf-as
ASFLAGS = -g
LD = arm-linux-gnueabihf-ld

TARGET = tictactoe

.PHONY: default run debug test clean

default: $(TARGET)

DEBUG_PORT = 1234
DEBUG_RUN = $(TARGET) < test_files/simple.txt
debug: $(TARGET)
	@# This is terminated by gdb-multiarch when it exits
	qemu-arm -singlestep -g $(DEBUG_PORT) $(DEBUG_RUN) &
	gdb-multiarch \
		--symbols=$^ \
		-ex 'target remote localhost:$(DEBUG_PORT)' \
		-ex 'layout src' \
		-ex 'layout regs'

test: $(TARGET)
	bats $(shell find -name 'test_*.bats')

clean:
	rm -rf $(TARGET) $(wildcard *.o)

%: %.o
	$(LD) $^ $(ASFLAGS) -o $@

%.o: %.s
	$(AS) $^ $(ASFLAGS) -o $@
