// Author: Duke Fong

module cdctl_bx_e(
    input       clk_i,
    output      clk_o,

    input       rx,
    output      tx,
    output reg  tx_en
);

assign clk_o = ~clk_i;
wire clk = clk_o;

reg reset_n = 0;
reg [2:0] reset_cnt = 0;
always @(posedge clk) begin
    reset_cnt <= reset_cnt + 1;
    if (reset_cnt == 3'b111)
        reset_n <= 1;
end

reg [7:0] counter;

assign tx = ~rx;

always @(posedge clk or negedge reset_n)
    if (!reset_n) begin
        counter <= 0;
        tx_en <= 0;
    end
    else begin
        counter <= counter + 1'b1;
        if (counter >= 10) begin
            counter <= 0;
            tx_en <= !tx_en;
        end
    end

endmodule

