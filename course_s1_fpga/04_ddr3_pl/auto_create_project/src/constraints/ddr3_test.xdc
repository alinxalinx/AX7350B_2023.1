set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# Set DCI_CASCADE          
set_property slave_banks {33} [get_iobanks 34]

create_clock -period 20.000 [get_ports sys_clk]


set_property IOSTANDARD LVCMOS18 [get_ports sys_clk]
set_property PACKAGE_PIN J14 [get_ports sys_clk]


set_property IOSTANDARD LVCMOS18 [get_ports sys_rst]
set_property PACKAGE_PIN G12 [get_ports sys_rst]

set_property VCCAUX_IO DONTCARE [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[0]}]
set_property PACKAGE_PIN F5 [get_ports {led[0]}]

set_property VCCAUX_IO DONTCARE [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[1]}]
set_property PACKAGE_PIN E5 [get_ports {led[1]}]

set_property VCCAUX_IO DONTCARE [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[2]}]
set_property PACKAGE_PIN G5 [get_ports {led[2]}]

set_property VCCAUX_IO DONTCARE [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led[3]}]
set_property PACKAGE_PIN G6 [get_ports {led[3]}]


create_clock -period 5 [get_ports clk0_p]
set_property VCCAUX_IO DONTCARE [get_ports clk0_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk0_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports clk0_n]
set_property PACKAGE_PIN C8  [get_ports clk0_p]
set_property PACKAGE_PIN C7  [get_ports clk0_n]

set_property IOSTANDARD LVCMOS33 [get_ports si5338_scl]
set_property PACKAGE_PIN W14 [get_ports si5338_scl]

set_property IOSTANDARD LVCMOS33 [get_ports si5338_sda]
set_property PACKAGE_PIN Y17 [get_ports si5338_sda]

set_property IOSTANDARD LVCMOS33 [get_ports si5338_i2c_lsb]
set_property PACKAGE_PIN AC17 [get_ports si5338_i2c_lsb]

set_property VCCAUX_IO DONTCARE [get_ports fan_pwm]
set_property IOSTANDARD LVCMOS15 [get_ports fan_pwm]
set_property PACKAGE_PIN E6 [get_ports fan_pwm]

