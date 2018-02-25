`timescale 1 ns / 1 ps

`define frequency 16000000 //(Hz)
`define cycle (1000000000.0/`frequency) //clock period (nS)


module cdctl_bx_e_tb;

reg clk;
reg rx;
wire tx;
wire tx_en;


initial
begin
    clk = 0;
    rx = 0;
end

always #(`cycle/2.0) clk = ~clk;


initial
begin
    rx = 1;
    #20000;
    $display($time, " tx: %b, tx_en: %b", tx, tx_en);
    
    rx = 0;
    #20000;
    rx = 1;
    $display($time, " tx: %b, tx_en: %b", tx, tx_en);
    
    rx = 0;
    #20000;
    rx = 1;
    $display($time, " tx: %b, tx_en: %b", tx, tx_en);
    
    rx = 0;
    #20000;
    rx = 1;
    $display($time, " tx: %b, tx_en: %b", tx, tx_en);
    
    #2000000;
    
    rx = 0;
    #20000;
    rx = 1;
    $display($time, " tx: %b, tx_en: %b", tx, tx_en);
end


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
