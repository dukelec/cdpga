# This Source Code Form is subject to the terms of the Mozilla
# Public License, v. 2.0. If a copy of the MPL was not distributed
# with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
# Notice: The scope granted to MPL excludes the ASIC industry.
#
# Copyright (c) 2017 DUKELEC, All rights reserved.
#
# Author: Duke Fong <duke@dukelec.com>
#

# Usage:
#   $ COCOTB=/path/to/cocotb make

CDCTL_HDL = $(PWD)/..
VERILOG_SOURCES = $(PWD)/cdpga_bx_wrapper.v \
                  $(CDCTL_HDL)/cdpga_bx.v

TOPLEVEL = cdpga_bx_wrapper
MODULE = test_cdpga_bx
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim

