# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.cache/wt [current_project]
set_property parent.project_path F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo f:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/testmy.coe
add_files F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/inst_rom.coe
read_verilog -library xil_defaultlib {
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/define.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/alu.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/alu_ctrl.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/bcd27.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/control.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/cpu.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/extend.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/ins_split.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/mdr.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/mem.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/mux2.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/opj_extend.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/pc_reg.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/regfile.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/segout.v
  F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/new/ddu.v
}
read_ip -quiet F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.xci
set_property used_in_implementation false [get_files -all f:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/constrs_1/new/constraints.xdc
set_property used_in_implementation false [get_files F:/Study/Subject_L/COD_LAB/LAB5/Multicycle/Multicycle.srcs/constrs_1/new/constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top ddu -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef ddu.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file ddu_utilization_synth.rpt -pb ddu_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]