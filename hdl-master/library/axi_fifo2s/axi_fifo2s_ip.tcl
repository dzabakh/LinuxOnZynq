# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create axi_fifo2s
adi_ip_files axi_fifo2s [list \
  "$ad_hdl_dir/library/common/ad_mem.v" \
  "$ad_hdl_dir/library/common/ad_axis_inf_rx.v" \
  "axi_fifo2s_wr.v" \
  "axi_fifo2s_rd.v" \
  "axi_fifo2s.v" ]

adi_ip_properties_lite axi_fifo2s

ipx::infer_bus_interfaces {{xilinx.com:interface:aximm:1.0}} [ipx::current_core]
ipx::remove_bus_interface {m} [ipx::current_core]
ipx::remove_bus_interface {m_signal_clock} [ipx::current_core]
ipx::remove_memory_map {m} [ipx::current_core]

ipx::save_core [ipx::current_core]

