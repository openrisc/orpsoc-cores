#include <stdio.h>

uint8_t* load_elf_file(char* elf_file_name, int *size);
unsigned int read_32(uint8_t *bin_file, unsigned int address);
unsigned short read_16(uint8_t *bin_file, unsigned int address);
