echo \#include \<gelf.h\> > test.c
echo void main\(void\) \{\} >> test.c

gcc test.c

if [ "$?" -ne "0" ]; then
  echo "Error: elf-loader requires the development version of libelf, which may be libelf-dev on your system. Make sure you have it installed."
  exit 1
fi
