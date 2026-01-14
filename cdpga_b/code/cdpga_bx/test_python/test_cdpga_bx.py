# This Source Code Form is subject to the terms of the Mozilla
# Public License, v. 2.0. If a copy of the MPL was not distributed
# with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
# Copyright (c) 2017 DUKELEC, All rights reserved.
#
# Author: Duke Fong <d@d-l.io>
#

import cocotb
from cocotb.types import Logic, LogicArray
from cocotb.triggers import RisingEdge, ReadOnly, Timer
from cocotb.clock import Clock

CLK_FREQ = 40000000
CLK_PERIOD = 1000000000000 / CLK_FREQ


@cocotb.test()
async def test_cdpga_bx(dut):
    """
    test_cdpga_bx
    """
    dut._log.info("test_cdpga_bx start.")
    dut.rx.value = 0

    cocotb.start_soon(Clock(dut.clk, CLK_PERIOD).start())
    await Timer(5000000) # wait reset
    
    
    dut._log.info(f"get tx: {int(dut.tx.value)}, tx_en: {int(dut.tx_en.value)}")
    dut._log.info("set rx = 1")
    dut.rx.value = 1;
    
    await Timer(CLK_PERIOD)
    dut._log.info(f"get tx: {int(dut.tx.value)}, tx_en: {int(dut.tx_en.value)}")
    dut._log.info("set rx = 0")
    dut.rx.value = 0;
    
    await Timer(CLK_PERIOD * 6)
    dut._log.info(f"get tx: {int(dut.tx.value)}, tx_en: {int(dut.tx_en.value)}")
    dut._log.info("set rx = 1")
    dut.rx.value = 1;
    
    await Timer(5000000)
    dut._log.info("test_cdpga_bx done.")

