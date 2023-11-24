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
set_msg_config -id {Common 17-41} -limit 10000000
create_project -in_memory -part xc7k325tffg676-2L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/Exp4.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/Exp4.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {c:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/Exp4.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{c:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/mem_test.coe}}
read_verilog {
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/function.vh}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/cache/addr_define.vh}
}
set_property file_type "Verilog Header" [get_files {{C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/function.vh}}]
set_property file_type "Verilog Header" [get_files {{C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/cache/addr_define.vh}}]
read_verilog -library xil_defaultlib {
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/ALU.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/CPUTEST.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/Code2Inst.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/CtrlUnit.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/Font816.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/HazardDetectionUnit.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/ImmGen.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/common/MUX2T1_32.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/common/MUX4T1_32.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/common/REG32.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/REG_EX_MEM.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/REG_ID_EX.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/REG_IF_ID.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/REG_MEM_WB.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/RV32core.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/core/Regs.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/VGATEST.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/common/add_32.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/btn_scan.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/cache/cache.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/clk_diff.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/common/cmp_32.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/cache/cmu.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/cache/sim/data_ram.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/debug_clk.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/display.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/my_clk_gen.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/parallel2serial.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/auxillary/vga.v}
  {C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/top.v}
}
read_ip -quiet {{c:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/Exp4.srcs/sources_1/ip/ROM_D/ROM_D.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/Exp4.srcs/sources_1/ip/ROM_D/ROM_D_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/constraint.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Zonghui Wang/Desktop/risc v/Code4Teach/Exp4/code/constraint.xdc}}]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7k325tffg676-2L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
