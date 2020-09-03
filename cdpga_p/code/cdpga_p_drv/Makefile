#
# Software License Agreement (GPL License)
#
# Copyright (c) 2018, DUKELEC, Inc.
# All rights reserved.
#
# Author: Duke Fong <d@d-l.io>
#

obj-m := cdpga_p.o

CHECK_SPARSE ?= 0
TARGET_KERNEL ?= $(shell uname -r)

KERNELDIR ?= /lib/modules/$(TARGET_KERNEL)/build
PWD := $(shell pwd)

CPPFLAGS += -include $(KERNELDIR)/include/generated/autoconf.h
EXTRA_CFLAGS := -I$(src)/../include

all:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) C=$(CHECK_SPARSE)

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions *.symvers *.order
