


source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project.tcl

adi_project_create fmcomms1_kc705
adi_project_files fmcomms1_kc705 [list \
  "system_top.v" \
  "system_constr.xdc"\
  "$ad_hdl_dir/projects/common/kc705/kc705_system_constr.xdc" ]

adi_project_run fmcomms1_kc705


