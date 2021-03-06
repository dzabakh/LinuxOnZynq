# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# Block Designs: bd/system/system.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system || ORIG_REF_NAME==system}]

# IP: bd/system/ip/system_sys_ps7_0/system_sys_ps7_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_sys_ps7_0 || ORIG_REF_NAME==system_sys_ps7_0}]

# IP: bd/system/ip/system_axi_iic_main_0/system_axi_iic_main_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_iic_main_0 || ORIG_REF_NAME==system_axi_iic_main_0}]

# IP: bd/system/ip/system_sys_i2c_mixer_0/system_sys_i2c_mixer_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_sys_i2c_mixer_0 || ORIG_REF_NAME==system_sys_i2c_mixer_0}]

# IP: bd/system/ip/system_sys_concat_intc_0/system_sys_concat_intc_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_sys_concat_intc_0 || ORIG_REF_NAME==system_sys_concat_intc_0}]

# IP: bd/system/ip/system_axi_cpu_interconnect_0/system_axi_cpu_interconnect_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_cpu_interconnect_0 || ORIG_REF_NAME==system_axi_cpu_interconnect_0}]

# IP: bd/system/ip/system_xbar_0/system_xbar_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_xbar_0 || ORIG_REF_NAME==system_xbar_0}]

# IP: bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_sys_rstgen_0 || ORIG_REF_NAME==system_sys_rstgen_0}]

# IP: bd/system/ip/system_sys_logic_inv_0/system_sys_logic_inv_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_sys_logic_inv_0 || ORIG_REF_NAME==system_sys_logic_inv_0}]

# IP: bd/system/ip/system_axi_hdmi_clkgen_0/system_axi_hdmi_clkgen_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_hdmi_clkgen_0 || ORIG_REF_NAME==system_axi_hdmi_clkgen_0}]

# IP: bd/system/ip/system_axi_hdmi_core_0/system_axi_hdmi_core_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_hdmi_core_0 || ORIG_REF_NAME==system_axi_hdmi_core_0}]

# IP: bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_hdmi_dma_0 || ORIG_REF_NAME==system_axi_hdmi_dma_0}]

# IP: bd/system/ip/system_axi_hdmi_interconnect_1/system_axi_hdmi_interconnect_1.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_hdmi_interconnect_1 || ORIG_REF_NAME==system_axi_hdmi_interconnect_1}]

# IP: bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_sys_audio_clkgen_0 || ORIG_REF_NAME==system_sys_audio_clkgen_0}]

# IP: bd/system/ip/system_axi_spdif_tx_core_0/system_axi_spdif_tx_core_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_spdif_tx_core_0 || ORIG_REF_NAME==system_axi_spdif_tx_core_0}]

# IP: bd/system/ip/system_axi_i2s_adi_0/system_axi_i2s_adi_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_i2s_adi_0 || ORIG_REF_NAME==system_axi_i2s_adi_0}]

# IP: bd/system/ip/system_axi_iic_fmc_1/system_axi_iic_fmc_1.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_iic_fmc_1 || ORIG_REF_NAME==system_axi_iic_fmc_1}]

# IP: bd/system/ip/system_axi_register_0_0/system_axi_register_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_axi_register_0_0 || ORIG_REF_NAME==system_axi_register_0_0}]

# IP: bd/system/ip/system_auto_pc_15/system_auto_pc_15.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_auto_pc_15 || ORIG_REF_NAME==system_auto_pc_15}]

# IP: bd/system/ip/system_auto_pc_18/system_auto_pc_18.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_auto_pc_18 || ORIG_REF_NAME==system_auto_pc_18}]

# IP: bd/system/ip/system_auto_pc_19/system_auto_pc_19.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==system_auto_pc_19 || ORIG_REF_NAME==system_auto_pc_19}]

# XDC: bd/system/ip/system_sys_ps7_0/system_sys_ps7_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_sys_ps7_0 || ORIG_REF_NAME==system_sys_ps7_0}] {/inst }]/inst ]]

# XDC: bd/system/ip/system_axi_iic_main_0/system_axi_iic_main_0_ooc.xdc

# XDC: bd/system/ip/system_axi_iic_main_0/system_axi_iic_main_0_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_iic_main_0 || ORIG_REF_NAME==system_axi_iic_main_0}] {/U0 }]/U0 ]]

# XDC: bd/system/ip/system_xbar_0/system_xbar_0_ooc.xdc

# XDC: bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_sys_rstgen_0 || ORIG_REF_NAME==system_sys_rstgen_0}] {/U0 }]/U0 ]]

# XDC: bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0_ooc.xdc

# XDC: bd/system/ip/system_sys_rstgen_0/system_sys_rstgen_0_board.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_sys_rstgen_0 || ORIG_REF_NAME==system_sys_rstgen_0}] {/U0 }]/U0 ]]

# XDC: bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_hdmi_dma_0 || ORIG_REF_NAME==system_axi_hdmi_dma_0}] {/U0 }]/U0 ]]

# XDC: bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0_clocks.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_hdmi_dma_0 || ORIG_REF_NAME==system_axi_hdmi_dma_0}] {/U0 }]/U0 ]]

# XDC: bd/system/ip/system_axi_hdmi_dma_0/system_axi_hdmi_dma_0_ooc.xdc

# XDC: bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_sys_audio_clkgen_0 || ORIG_REF_NAME==system_sys_audio_clkgen_0}] {/inst }]/inst ]]

# XDC: bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0_OOC.xdc

# XDC: bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0_board.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_sys_audio_clkgen_0 || ORIG_REF_NAME==system_sys_audio_clkgen_0}] {/inst }]/inst ]]

# XDC: bd/system/ip/system_axi_iic_fmc_1/system_axi_iic_fmc_1_ooc.xdc

# XDC: bd/system/ip/system_axi_iic_fmc_1/system_axi_iic_fmc_1_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==system_axi_iic_fmc_1 || ORIG_REF_NAME==system_axi_iic_fmc_1}] {/U0 }]/U0 ]]

# XDC: bd/system/ip/system_auto_pc_15/system_auto_pc_15_ooc.xdc

# XDC: bd/system/ip/system_auto_pc_18/system_auto_pc_18_ooc.xdc

# XDC: bd/system/ip/system_auto_pc_19/system_auto_pc_19_ooc.xdc

# XDC: bd/system/system_ooc.xdc

# XDC: D:/ROSTA/hdl-master/projects/common/zed/zed_system_constr.xdc
