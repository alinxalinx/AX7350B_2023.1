set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property PACKAGE_PIN J14 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS18 [get_ports sys_clk]

set_property PACKAGE_PIN E6 [get_ports fan_pwm]
set_property IOSTANDARD LVCMOS15 [get_ports fan_pwm]

set_property IOSTANDARD LVCMOS15 [get_ports {leds_tri_o[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {leds_tri_o[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {leds_tri_o[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {leds_tri_o[3]}]
set_property PACKAGE_PIN F5 [get_ports {leds_tri_o[0]}]
set_property PACKAGE_PIN E5 [get_ports {leds_tri_o[1]}]
set_property PACKAGE_PIN G5 [get_ports {leds_tri_o[2]}]
set_property PACKAGE_PIN G6 [get_ports {leds_tri_o[3]}]

set_property IOSTANDARD LVCMOS15 [get_ports {btns_tri_i[*]}]
set_property PACKAGE_PIN H6 [get_ports {btns_tri_i[0]}]
set_property PACKAGE_PIN H7 [get_ports {btns_tri_i[1]}]
set_property PACKAGE_PIN H8 [get_ports {btns_tri_i[2]}]
set_property PACKAGE_PIN J8 [get_ports {btns_tri_i[3]}]