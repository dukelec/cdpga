# This Source Code Form is subject to the terms of the Mozilla
# Public License, v. 2.0. If a copy of the MPL was not distributed
# with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2017 DUKELEC, All rights reserved.
#
# Author: Duke Fong <d@d-l.io>
#

# Usage:
#   $ COCOTB=/path/to/cocotb make

CDCTL_HDL = $(PWD)/..
VERILOG_SOURCES = $(PWD)/cdpga_bx_wrapper.v \
                  $(PWD)/cdpga_pll_sim.v \
                  $(CDCTL_HDL)/cdpga_bx.v

TOPLEVEL = cdpga_bx_wrapper
MODULE = test_cdpga_bx

include $(shell cocotb-config --makefiles)/Makefile.sim

