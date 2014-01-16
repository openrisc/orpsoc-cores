#ifndef _OR1K_ELF_H_
#define _OR1K_ELF_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

uint8_t *load_elf_file(char* elf_file_name, int *size);
unsigned int read_32(uint8_t *bin_file, unsigned int address);
unsigned short read_16(uint8_t *bin_file, unsigned int address);

#ifdef __cplusplus
}
#endif

#endif
