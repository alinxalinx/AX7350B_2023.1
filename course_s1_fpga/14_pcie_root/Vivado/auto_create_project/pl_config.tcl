#////////////////////////////////////////////////////////////////////////////////
#  project：PCIe_test                                                          //
#                                                                              //
#  Author: JunFN                                                               //
#          853808728@qq.com                                                    //
#          ALINX(shanghai) Technology Co.,Ltd                                  //
#          黑金                                                                //
#     WEB: http://www.alinx.cn/                                                //
#                                                                              //
#////////////////////////////////////////////////////////////////////////////////
#                                                                              //
# Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
#                    All rights reserved                                       //
#                                                                              //
# This source file may be used and distributed without restriction provided    //
# that this copyright statement is not removed from the file and that any      //
# derivative work contains the original copyright notice and the associated    //
# disclaimer.                                                                  //
#                                                                              // 
#////////////////////////////////////////////////////////////////////////////////

#================================================================================
#  Revision History:
#  Date          By            Revision    Change Description
# --------------------------------------------------------------------------------
#  2023/8/22                   1.0          Original
#=================================================================================

  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]

  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  set pcie_ref [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_ref ]

  set pcie_7x_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt ]

  set si5338_iic [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 si5338_iic ]


  # Create ports
  set pcie_rstn [ create_bd_port -dir O -from 0 -to 0 -type rst pcie_rstn ]
  set si5338_i2c_lsb [ create_bd_port -dir O -from 0 -to 0 si5338_i2c_lsb ]
  
  # Create instance: axi_cdma_0, and set properties
  set axi_cdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0 ]
  set_property -dict [list \
    CONFIG.C_INCLUDE_SG {0} \
    CONFIG.C_M_AXI_DATA_WIDTH {128} \
    CONFIG.C_M_AXI_MAX_BURST_LEN {4} \
  ] $axi_cdma_0


  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [list \
    CONFIG.NUM_MI {1} \
    CONFIG.NUM_SI {2} \
  ] $axi_interconnect_0


  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [list \
    CONFIG.NUM_MI {3} \
    CONFIG.NUM_SI {2} \
  ] $axi_interconnect_1


  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_2 ]

  # Create instance: axi_pcie_0, and set properties
  set axi_pcie_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_pcie:2.9 axi_pcie_0 ]
  set_property -dict [list \
    CONFIG.BAR0_SCALE {Gigabytes} \
    CONFIG.BAR0_SIZE {1} \
    CONFIG.BASEADDR {0x00000000} \
    CONFIG.BASE_CLASS_MENU {Bridge_device} \
    CONFIG.CLASS_CODE {0x060400} \
    CONFIG.DEVICE_ID {0x7124} \
    CONFIG.HIGHADDR {0x001FFFFF} \
    CONFIG.INCLUDE_RC {Root_Port_of_PCI_Express_Root_Complex} \
    CONFIG.MAX_LINK_SPEED {5.0_GT/s} \
    CONFIG.M_AXI_DATA_WIDTH {128} \
    CONFIG.NO_OF_LANES {X4} \
    CONFIG.SUB_CLASS_INTERFACE_MENU {InfiniBand_to_PCI_host_bridge} \
    CONFIG.S_AXI_DATA_WIDTH {128} \
  ] $axi_pcie_0


  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.2 util_ds_buf_0 ]
  set_property CONFIG.C_BUF_TYPE {IBUFDSGTE} $util_ds_buf_0


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property CONFIG.CONST_VAL {0} $xlconstant_1


  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property CONFIG.CONST_VAL {0} $xlconstant_0


  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_0_1 [get_bd_intf_pins util_ds_buf_0/CLK_IN_D] [get_bd_intf_ports pcie_ref]
  connect_bd_intf_net -intf_net axi_cdma_0_M_AXI [get_bd_intf_pins axi_cdma_0/M_AXI] [get_bd_intf_pins axi_interconnect_2/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins axi_pcie_0/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins axi_interconnect_1/M01_AXI] [get_bd_intf_pins axi_pcie_0/S_AXI_CTL]
  connect_bd_intf_net -intf_net axi_interconnect_1_M02_AXI [get_bd_intf_pins axi_interconnect_1/M02_AXI] [get_bd_intf_pins axi_cdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI [get_bd_intf_pins axi_interconnect_2/M00_AXI] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M01_AXI [get_bd_intf_pins axi_interconnect_2/M01_AXI] [get_bd_intf_pins axi_interconnect_1/S01_AXI]
  connect_bd_intf_net -intf_net axi_pcie_0_M_AXI [get_bd_intf_pins axi_pcie_0/M_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axi_pcie_0_pcie_7x_mgt [get_bd_intf_pins axi_pcie_0/pcie_7x_mgt] [get_bd_intf_ports pcie_7x_mgt]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_pins processing_system7_0/DDR] [get_bd_intf_ports DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_pins processing_system7_0/FIXED_IO] [get_bd_intf_ports FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_IIC_0 [get_bd_intf_pins processing_system7_0/IIC_0] [get_bd_intf_ports si5338_iic]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins axi_interconnect_1/S00_AXI]

  # Create port connections
  connect_bd_net -net axi_cdma_0_cdma_introut [get_bd_pins axi_cdma_0/cdma_introut] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_pins axi_pcie_0/axi_aclk_out] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins axi_cdma_0/m_axi_aclk] [get_bd_pins axi_cdma_0/s_axi_lite_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_interconnect_1/M02_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axi_interconnect_2/M01_ACLK] [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
  connect_bd_net -net axi_pcie_0_axi_ctl_aclk_out [get_bd_pins axi_pcie_0/axi_ctl_aclk_out] [get_bd_pins axi_interconnect_1/M01_ACLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk]
  connect_bd_net -net axi_pcie_0_interrupt_out [get_bd_pins axi_pcie_0/interrupt_out] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net axi_pcie_0_mmcm_lock [get_bd_pins axi_pcie_0/mmcm_lock] [get_bd_pins proc_sys_reset_0/dcm_locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_ports pcie_rstn] [get_bd_pins axi_interconnect_1/M01_ARESETN]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins proc_sys_reset_1/peripheral_aresetn] [get_bd_pins axi_cdma_0/s_axi_lite_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins axi_interconnect_1/M02_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axi_interconnect_2/M01_ARESETN] [get_bd_pins axi_pcie_0/axi_aresetn]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins proc_sys_reset_1/ext_reset_in]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins util_ds_buf_0/IBUF_OUT] [get_bd_pins axi_pcie_0/REFCLK]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins xlconcat_0/dout] [get_bd_pins processing_system7_0/IRQ_F2P]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconstant_0/dout] [get_bd_pins axi_pcie_0/INTX_MSI_Request]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins xlconstant_1/dout] [get_bd_ports si5338_i2c_lsb]

  # Create address segments
  assign_bd_address -offset 0x7E200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_cdma_0/S_AXI_LITE/Reg] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_pcie_0/S_AXI/BAR0] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_pcie_0/S_AXI_CTL/CTL0] -force
  assign_bd_address -offset 0x40000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_cdma_0/Data] [get_bd_addr_segs axi_pcie_0/S_AXI/BAR0] -force
  assign_bd_address -offset 0x50000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces axi_cdma_0/Data] [get_bd_addr_segs axi_pcie_0/S_AXI_CTL/CTL0] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_cdma_0/Data] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force
  assign_bd_address -offset 0x00000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_pcie_0/M_AXI] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] -force

  # Exclude Address Segments
  exclude_bd_addr_seg -offset 0x7E200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces axi_cdma_0/Data] [get_bd_addr_segs axi_cdma_0/S_AXI_LITE/Reg]
