
# pl ddr3 (use only when dma is not capable of keeping up).
# generic fifo interface - existence is oblivious to software.

proc p_plddr3_fifo {p_name m_name m_width} {

  global ad_hdl_dir

  set p_instance [get_bd_cells $p_name]
  set c_instance [current_bd_instance .]

  current_bd_instance $p_instance

  set m_instance [create_bd_cell -type hier $m_name]
  current_bd_instance $m_instance

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR3
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_clk

  create_bd_pin -dir I axi_xfer_req
  create_bd_pin -dir O -from 4 -to 0 axi_xfer_status

  create_bd_pin -dir I adc_rst
  create_bd_pin -dir I -type clk adc_clk
  create_bd_pin -dir I adc_wr
  create_bd_pin -dir O adc_wovf
  create_bd_pin -dir I -from [expr ($m_width-1)] -to 0 adc_wdata

  create_bd_pin -dir I dma_rstn
  create_bd_pin -dir O -type clk dma_clk
  create_bd_pin -dir O dma_wr
  create_bd_pin -dir I dma_wovf
  create_bd_pin -dir O -from 63 -to 0 dma_wdata

  set wfifo_ctl [create_bd_cell -type ip -vlnv analog.com:user:util_wfifo:1.0 wfifo_ctl]
  set_property -dict [list CONFIG.M_DATA_WIDTH $m_width] $wfifo_ctl
  set_property -dict [list CONFIG.S_DATA_WIDTH {512}] $wfifo_ctl

  set rfifo_ctl [create_bd_cell -type ip -vlnv analog.com:user:util_wfifo:1.0 rfifo_ctl]
  set_property -dict [list CONFIG.M_DATA_WIDTH {512}] $rfifo_ctl
  set_property -dict [list CONFIG.S_DATA_WIDTH {64}] $rfifo_ctl

  set wfifo_mem [create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:11.0 wfifo_mem]
  set_property -dict [list CONFIG.INTERFACE_TYPE {Native}] $wfifo_mem
  set_property -dict [list CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM}] $wfifo_mem
  set_property -dict [list CONFIG.Input_Data_Width $m_width] $wfifo_mem
  set_property -dict [list CONFIG.Output_Data_Width {512}] $wfifo_mem
  set_property -dict [list CONFIG.Overflow_Flag {true}] $wfifo_mem

  set rfifo_mem [create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:11.0 rfifo_mem]
  set_property -dict [list CONFIG.INTERFACE_TYPE {Native}] $rfifo_mem
  set_property -dict [list CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM}] $rfifo_mem
  set_property -dict [list CONFIG.Input_Data_Width {512}] $rfifo_mem
  set_property -dict [list CONFIG.Output_Data_Width {64}] $rfifo_mem
  set_property -dict [list CONFIG.Overflow_Flag {true}] $rfifo_mem
  set_property -dict [list CONFIG.Programmable_Full_Type {Single_Programmable_Full_Threshold_Constant}] $rfifo_mem
  set_property -dict [list CONFIG.Full_Threshold_Assert_Value {800}] $rfifo_mem

  set axi_fifo2s [create_bd_cell -type ip -vlnv analog.com:user:axi_fifo2s:1.0 axi_fifo2s]
  set_property -dict [list CONFIG.AXI_ADDRESS {0x80000000}] $axi_fifo2s
  set_property -dict [list CONFIG.AXI_ADDRLIMIT {0xa0000000}] $axi_fifo2s
  set_property -dict [list CONFIG.AXI_LENGTH {4}] $axi_fifo2s
  set_property -dict [list CONFIG.AXI_SIZE {6}] $axi_fifo2s
  set_property -dict [list CONFIG.DATA_WIDTH {512}] $axi_fifo2s

  set axi_ddr_cntrl [create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:2.0 axi_ddr_cntrl]
  set axi_ddr_cntrl_dir [get_property IP_DIR [get_ips [get_property CONFIG.Component_Name $axi_ddr_cntrl]]]
  file copy -force $ad_hdl_dir/projects/common/zc706/zc706_system_mig.prj "$axi_ddr_cntrl_dir/"
  set_property -dict [list CONFIG.XML_INPUT_FILE {zc706_system_mig.prj}] $axi_ddr_cntrl

  connect_bd_intf_net -intf_net sys_clk [get_bd_intf_pins sys_clk] [get_bd_intf_pins axi_ddr_cntrl/SYS_CLK]
  connect_bd_intf_net -intf_net DDR3 [get_bd_intf_pins DDR3] [get_bd_intf_pins axi_ddr_cntrl/DDR3]
  connect_bd_intf_net -intf_net axi_ddr3 [get_bd_intf_pins axi_ddr_cntrl/S_AXI] [get_bd_intf_pins axi_fifo2s/axi]

  connect_bd_net -net adc_rst                 [get_bd_pins adc_rst]
  connect_bd_net -net adc_rst                 [get_bd_pins axi_ddr_cntrl/sys_rst]
  connect_bd_net -net adc_rst                 [get_bd_pins axi_fifo2s/m_rst]
  connect_bd_net -net adc_clk                 [get_bd_pins adc_clk]
  connect_bd_net -net adc_clk                 [get_bd_pins wfifo_ctl/m_clk]
  connect_bd_net -net adc_clk                 [get_bd_pins wfifo_mem/wr_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins axi_ddr_cntrl/ui_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins axi_fifo2s/axi_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins axi_fifo2s/m_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins wfifo_ctl/s_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins wfifo_mem/rd_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins rfifo_ctl/m_clk]
  connect_bd_net -net axi_clk                 [get_bd_pins rfifo_mem/wr_clk]
  connect_bd_net -net dma_rstn                [get_bd_pins dma_rstn]
  connect_bd_net -net dma_rstn                [get_bd_pins axi_ddr_cntrl/aresetn]
  connect_bd_net -net dma_rstn                [get_bd_pins axi_fifo2s/axi_resetn]
  connect_bd_net -net dma_rstn                [get_bd_pins rfifo_ctl/rstn]
  connect_bd_net -net dma_rstn                [get_bd_pins wfifo_ctl/rstn]
  connect_bd_net -net dma_clk                 [get_bd_pins axi_ddr_cntrl/ui_addn_clk_0]
  connect_bd_net -net dma_clk                 [get_bd_pins rfifo_ctl/s_clk]
  connect_bd_net -net dma_clk                 [get_bd_pins rfifo_mem/rd_clk]
  connect_bd_net -net dma_clk                 [get_bd_pins dma_clk]

  connect_bd_net -net adc_wr                  [get_bd_pins adc_wr]                    [get_bd_pins wfifo_ctl/m_wr]
  connect_bd_net -net adc_wdata               [get_bd_pins adc_wdata]                 [get_bd_pins wfifo_ctl/m_wdata]
  connect_bd_net -net adc_wovf                [get_bd_pins adc_wovf]                  [get_bd_pins wfifo_ctl/m_wovf]
  connect_bd_net -net axi_xfer_req            [get_bd_pins axi_xfer_req]              [get_bd_pins axi_fifo2s/axi_xfer_req]
  connect_bd_net -net axi_xfer_status         [get_bd_pins axi_xfer_status]           [get_bd_pins axi_fifo2s/axi_xfer_status]
  connect_bd_net -net wfifo_ctl_fifo_rst      [get_bd_pins wfifo_ctl/fifo_rst]        [get_bd_pins wfifo_mem/rst]
  connect_bd_net -net wfifo_ctl_fifo_wr       [get_bd_pins wfifo_ctl/fifo_wr]         [get_bd_pins wfifo_mem/wr_en]
  connect_bd_net -net wfifo_ctl_fifo_wdata    [get_bd_pins wfifo_ctl/fifo_wdata]      [get_bd_pins wfifo_mem/din]
  connect_bd_net -net wfifo_ctl_fifo_wfull    [get_bd_pins wfifo_ctl/fifo_wfull]      [get_bd_pins wfifo_mem/full]
  connect_bd_net -net wfifo_ctl_fifo_wovf     [get_bd_pins wfifo_ctl/fifo_wovf]       [get_bd_pins wfifo_mem/overflow]
  connect_bd_net -net dma_wr                  [get_bd_pins dma_wr]                    [get_bd_pins rfifo_ctl/s_wr]
  connect_bd_net -net dma_wdata               [get_bd_pins dma_wdata]                 [get_bd_pins rfifo_ctl/s_wdata]
  connect_bd_net -net dma_wovf                [get_bd_pins dma_wovf]                  [get_bd_pins rfifo_ctl/s_wovf]
  connect_bd_net -net rfifo_ctl_fifo_rd       [get_bd_pins rfifo_ctl/fifo_rd]         [get_bd_pins rfifo_mem/rd_en]
  connect_bd_net -net rfifo_ctl_fifo_rdata    [get_bd_pins rfifo_ctl/fifo_rdata]      [get_bd_pins rfifo_mem/dout]
  connect_bd_net -net rfifo_ctl_fifo_rempty   [get_bd_pins rfifo_ctl/fifo_rempty]     [get_bd_pins rfifo_mem/empty]
  connect_bd_net -net wfifo_ctl_fifo_rd       [get_bd_pins wfifo_ctl/fifo_rd]         [get_bd_pins wfifo_mem/rd_en]
  connect_bd_net -net wfifo_ctl_fifo_rdata    [get_bd_pins wfifo_ctl/fifo_rdata]      [get_bd_pins wfifo_mem/dout]
  connect_bd_net -net wfifo_ctl_fifo_rempty   [get_bd_pins wfifo_ctl/fifo_rempty]     [get_bd_pins wfifo_mem/empty]
  connect_bd_net -net rfifo_ctl_fifo_rst      [get_bd_pins rfifo_ctl/fifo_rst]        [get_bd_pins rfifo_mem/rst]
  connect_bd_net -net rfifo_ctl_fifo_wr       [get_bd_pins rfifo_ctl/fifo_wr]         [get_bd_pins rfifo_mem/wr_en]
  connect_bd_net -net rfifo_ctl_fifo_wdata    [get_bd_pins rfifo_ctl/fifo_wdata]      [get_bd_pins rfifo_mem/din]
  connect_bd_net -net rfifo_ctl_fifo_wfull    [get_bd_pins rfifo_ctl/fifo_wfull]      [get_bd_pins rfifo_mem/full]
  connect_bd_net -net rfifo_ctl_fifo_wovf     [get_bd_pins rfifo_ctl/fifo_wovf]       [get_bd_pins rfifo_mem/overflow]
  connect_bd_net -net axi_fifo2s_swr          [get_bd_pins axi_fifo2s/m_wr]           [get_bd_pins wfifo_ctl/s_wr]
  connect_bd_net -net axi_fifo2s_swdata       [get_bd_pins axi_fifo2s/m_wdata]        [get_bd_pins wfifo_ctl/s_wdata]
  connect_bd_net -net axi_fifo2s_swovf        [get_bd_pins axi_fifo2s/m_wovf]         [get_bd_pins wfifo_ctl/s_wovf]
  connect_bd_net -net axi_fifo2s_axi_mwr      [get_bd_pins axi_fifo2s/axi_mwr]        [get_bd_pins rfifo_ctl/m_wr]
  connect_bd_net -net axi_fifo2s_axi_mwdata   [get_bd_pins axi_fifo2s/axi_mwdata]     [get_bd_pins rfifo_ctl/m_wdata]
  connect_bd_net -net axi_fifo2s_axi_mwovf    [get_bd_pins axi_fifo2s/axi_mwovf]      [get_bd_pins rfifo_ctl/m_wovf]
  connect_bd_net -net axi_fifo2s_axi_mwpfull  [get_bd_pins axi_fifo2s/axi_mwpfull]    [get_bd_pins rfifo_mem/prog_full]
 
  current_bd_instance $c_instance
}

