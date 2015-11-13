BOOTROM_ADDR ?= 0xf0000000
CC=riscv32-unknown-elf-gcc

TARGET ?= bootrom 
all: $(TARGET).vh

bootrom.elf: bootrom.S
	riscv32-unknown-elf-gcc -DBOOTROM_ADDR=$(BOOTROM_ADDR) -m32 -nostdlib $< -o $@

%.vh: %.bin
	python ./wb_rom_gen.py $< > $@

%.bin: %.elf
	riscv32-unknown-elf-objcopy -O binary $< $@

%.elf: %.S
	riscv32-unknown-elf-gcc -nostdlib $< -o $@

clean:
	rm bootrom.elf $(TARGET).vh
