set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

#PCIe_rstn
set_property PACKAGE_PIN AA19 [get_ports {pcie_rstn[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {pcie_rstn[0]}]

set_property PACKAGE_PIN W14 [get_ports si5338_iic_scl_io]
set_property IOSTANDARD LVCMOS25 [get_ports si5338_iic_scl_io]

set_property PACKAGE_PIN Y17 [get_ports si5338_iic_sda_io]
set_property IOSTANDARD LVCMOS25 [get_ports si5338_iic_sda_io]

set_property PACKAGE_PIN AC17 [get_ports {si5338_i2c_lsb[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {si5338_i2c_lsb[0]}]

# PCI Express reference clock 100MHz
set_property PACKAGE_PIN R6 [get_ports {pcie_ref_clk_p[0]}]
set_property PACKAGE_PIN R5 [get_ports {pcie_ref_clk_n[0]}]

# MGT locations

set_property PACKAGE_PIN T4 [get_ports {pcie_7x_mgt_rxp[3]}]
set_property PACKAGE_PIN V4 [get_ports {pcie_7x_mgt_rxp[2]}]
set_property PACKAGE_PIN Y4 [get_ports {pcie_7x_mgt_rxp[1]}]
set_property PACKAGE_PIN AB4 [get_ports {pcie_7x_mgt_rxp[0]}]


#set_property PACKAGE_PIN AD4 [get_ports {pcie_7x_mgt_rxp[3]}]
#set_property PACKAGE_PIN AC6 [get_ports {pcie_7x_mgt_rxp[2]}]
#set_property PACKAGE_PIN AE6 [get_ports {pcie_7x_mgt_rxp[1]}]
#set_property PACKAGE_PIN AD8 [get_ports {pcie_7x_mgt_rxp[0]}]


set_property LOC RAMB36_X6Y34 [get_cells  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.pcie_top_i/pcie_7x_i/pcie_bram_top/pcie_brams_rx/brams[0].ram/use_tdp.ramb36/genblk*.bram36_tdp_bl.bram36_tdp_bl}]
set_property LOC RAMB36_X6Y33 [get_cells  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.pcie_top_i/pcie_7x_i/pcie_bram_top/pcie_brams_rx/brams[1].ram/use_tdp.ramb36/genblk*.bram36_tdp_bl.bram36_tdp_bl}]
set_property LOC RAMB36_X6Y31 [get_cells  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.pcie_top_i/pcie_7x_i/pcie_bram_top/pcie_brams_tx/brams[0].ram/use_tdp.ramb36/genblk*.bram36_tdp_bl.bram36_tdp_bl}]
set_property LOC RAMB36_X6Y30 [get_cells  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.pcie_top_i/pcie_7x_i/pcie_bram_top/pcie_brams_tx/brams[1].ram/use_tdp.ramb36/genblk*.bram36_tdp_bl.bram36_tdp_bl}]

create_clock -period 10 [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_lane[0].gt_wrapper_i/gtx_channel.gtxe2_channel_i/TXOUTCLK}]
#

#
set_false_path -to [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/S*}]
#
#The following constraints are used to constrain the output of the BUFGMUX.
#This constraint is set for 250MHz because when the PCIe core is operating in Gen2
#mode, the 250MHz clock is selected.  Without these constraints, it is possible that
#static timing analysis could anayze the design using the 125MHz clock instead of the
#250MHz clock.
#
#
create_generated_clock -name clk_125mhz_mux_X0Y0 \
                        -source [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/I0}] \
                        -divide_by 1 \
                        [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/O}]
#
create_generated_clock -name clk_250mhz_mux_X0Y0 \
                        -source \
                        [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/I1}] \
                        -divide_by 1 -add \
                        -master_clock \
                        [get_clocks -of [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/I1}]] \
                        [get_pins  -hierarchical -filter {NAME=~*/comp_axi_enhanced_pcie/comp_enhanced_core_top_wrap/axi_pcie_enhanced_core_top_i/pcie_7x_v2_0_2_inst/pcie_top_with_gt_top.gt_ges.gt_top_i/pipe_wrapper_i/pipe_clock_int.pipe_clock_i/pclk_i1_bufgctrl.pclk_i1/O}]
#
set_clock_groups -name pcieclkmux -physically_exclusive -group clk_125mhz_mux_X0Y0 -group clk_250mhz_mux_X0Y0
#
#
###############################################################################
# Physical Constraints

#------------------------------------------------------------------------------
# Asynchronous Paths
#------------------------------------------------------------------------------

set_false_path -through [get_pins -hierarchical -filter {NAME=~*/RXELECIDLE}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/TXPHINITDONE}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/TXPHALIGNDONE}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/TXDLYSRESETDONE}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/RXDLYSRESETDONE}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/RXPHALIGNDONE}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/RXCDRLOCK}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/CFGMSGRECEIVEDPMETO}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/CPLLLOCK}]
set_false_path -through [get_pins -hierarchical -filter {NAME=~*/QPLLLOCK}]

################################################################################

###############################################################################
# End
###############################################################################
