all: spi_image.vh

%.elf: %.S
	or1k-elf-gcc -nostdlib $< -o $@

%.vh: %.elf
	or1k-elf-objcopy -O verilog $< $@

clean:
	rm spi_image.vh spi_image.elf
