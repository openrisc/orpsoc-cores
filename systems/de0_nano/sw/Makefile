all: spi_image.vh spi_loader.vh

spi_loader.vh: spi_loader.elf
	or1k-elf-objcopy -O binary spi_loader.elf spi_loader.bin
	python ./wb_rom_gen.py spi_loader.bin > spi_loader.vh

%.elf: %.S
	or1k-elf-gcc -nostdlib $< -o $@

%.vh: %.elf
	or1k-elf-objcopy -O verilog $< $@

clean:
	rm spi_image.vh spi_image.elf
