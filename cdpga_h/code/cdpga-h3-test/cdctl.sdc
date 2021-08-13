#
# Software License Agreement (MIT License)
#
# Copyright (c) 2018, DUKELEC, Inc.
# All rights reserved.
#
# Author: Duke Fong <duke@dukelec.com>
#

create_clock -name "clk_25m" -period 40ns [get_ports clk]
derive_clock_uncertainty

set_false_path -from * -to [get_ports {out[*]}]

