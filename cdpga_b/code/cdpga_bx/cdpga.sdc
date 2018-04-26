# Constrain clock port clk with a 25ns requirement (40MHz)

create_clock -period 25 -name {global_clk} [get_nets {clk_i}]

set_clock_uncertainty -setup -from [get_clocks {global_clk}] -to [get_clocks {global_clk}] 0.200
set_clock_uncertainty -hold -from [get_clocks {global_clk}] -to [get_clocks {global_clk}] 0.050

