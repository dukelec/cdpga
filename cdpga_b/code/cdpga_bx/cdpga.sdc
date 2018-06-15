# Constrain clock port clk with a 25ns requirement (40MHz)

create_clock -period 25 -name {global_clk} [get_nets {clk}]

set_clock_uncertainty -setup -from [get_clocks {global_clk}] -to [get_clocks {global_clk}] 0.200
#set_clock_uncertainty -hold -from [get_clocks {global_clk}] -to [get_clocks {global_clk}] 0.050

# create virtual clock
create_clock -name vclk -period 10
set_clock_uncertainty -setup 0.3 [get_clocks {vclk}]
set_input_delay -max 0.4 -clock vclk [get_ports {clk_i}]
set_output_delay -max 0.4 -clock vclk [get_ports {clk_o}]

