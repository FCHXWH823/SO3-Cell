###################################################################

# Created by write_sdc on Wed Mar  4 18:45:46 2015

###################################################################
set sdc_version 2.0

create_clock [get_ports clk]  -period 0.125

# input delays
set_input_delay 0.0 [all_inputs] -clock clk

# output delays
set_output_delay 0.0 [all_outputs] -clock clk
