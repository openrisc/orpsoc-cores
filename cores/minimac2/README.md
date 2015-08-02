minimac2
========


This core is part of the Milkymist System-on-Chip. Unlike first the version of
minimac, minimac2 doesn't do DMA, but provides Wishbone slave interface for
packet buffer stored in on-chip memory.

Features
--------

* Minimal 10/100 Ethernet MAC.
* Full duplex only.
* Directly connects to standard MII PHYs.
* Bit-banged MDIO

References
----------

* [minimac1 datasheet](http://aspid.ru/dump/~veprbl/minimac.pdf)
* [CSR bus specification](http://aspid.ru/dump/~veprbl/csr.pdf)
* [microudp network stack](https://github.com/m-labs/milkymist/blob/master/software/libnet/microudp.c)
