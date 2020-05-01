# 
# Synthesis run script generated by Vivado
# 

  set_param gui.test TreeTableDev
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1
set_property target_language Verilog [current_project]
set_property board em.avnet.com:zynq:zed:d [current_project]
set_param project.compositeFile.enableAutoGeneration 0
set_property ip_repo_paths {
  D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/axi_register_1.0
  D:/ROSTA/hdl-master/projects/test_ip_core
  D:/ROSTA/hdl-master/library
} [current_fileset]

add_files D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/system.bd
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_ps7_0/system_sys_ps7_0.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_iic_main_0/system_axi_iic_main_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_iic_main_0/system_axi_iic_main_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_xbar_0/system_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0_clocks.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0_OOC.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0_board.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_iic_fmc_1/system_axi_iic_fmc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_axi_iic_fmc_1/system_axi_iic_fmc_1_board.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_auto_pc_20/system_auto_pc_20_ooc.xdc]
set_property used_in_implementation false [get_files -all d:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/ip/system_auto_pc_21/system_auto_pc_21_ooc.xdc]
set_property used_in_implementation false [get_files -all D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/system_ooc.xdc]
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property is_locked true [get_files D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/system.bd]

read_verilog {
  D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.srcs/sources_1/bd/system/hdl/system_wrapper.v
  D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/system_top.v
}
read_xdc D:/ROSTA/hdl-master/projects/common/zed/zed_system_constr.xdc
set_property used_in_implementation false [get_files D:/ROSTA/hdl-master/projects/common/zed/zed_system_constr.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos/adv7511_zed.data/wt [current_project]
set_property parent.project_dir D:/ROSTA/hdl-master/projects/adv7511/zed_for_noos [current_project]
synth_design -top system_top -part xc7z020clg484-1
write_checkpoint system_top.dcp
report_utilization -file system_top_utilization_synth.rpt -pb system_top_utilization_synth.pb
