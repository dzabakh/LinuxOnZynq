
source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project.tcl

adi_project_create motor_control_zed
adi_project_files motor_control_zed [list \
  "system_top.v" \
  "system_constr.xdc" \
  "$ad_hdl_dir/projects/common/zed/zed_system_constr.xdc" ]

adi_project_run motor_control_zed


