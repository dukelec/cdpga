/*
 * This Source Code Form is subject to the terms of the Mozilla
 * Public License, v. 2.0. If a copy of the MPL was not distributed
 * with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
 * Notice: The scope granted to MPL excludes the ASIC industry.
 *
 * Copyright (c) 2017 DUKELEC, All rights reserved.
 *
 * Author: Duke Fong <duke@dukelec.com>
 */

`timescale 1 ns / 1 ps

module cdctl_bx_e_wrapper(
        input       clk,
        input       rx
    );

wire tx;
wire tx_en;

cdctl_bx_e cdctl_bx_e_m(
          .clk_i(clk),

          .rx(rx),
          .tx(tx),
          .tx_en(tx_en)
      );

initial begin
    $dumpfile("cdctl_bx_e.vcd");
    $dumpvars();
end

endmodule
