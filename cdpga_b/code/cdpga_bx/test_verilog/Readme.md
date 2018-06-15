Simulation by `iverilog`:

```
cdpga_bx/test_verilog $ iverilog -o cdpga_bx cdpga_tb.v cdpga_pll_sim.v ../cdpga_bx.v
cdpga_bx/test_verilog $ vvp cdpga_bx
VCD info: dumpfile cdpga_bx.vcd opened for output.
               20000 tx: 0, tx_en: 0
               40000 tx: 1, tx_en: 0
               60000 tx: 1, tx_en: 1
               80000 tx: 1, tx_en: 0
             2100000 tx: 1, tx_en: 1
cdpga_bx/test_verilog $
```

Then you can check the wav file by `GTKWave`.
