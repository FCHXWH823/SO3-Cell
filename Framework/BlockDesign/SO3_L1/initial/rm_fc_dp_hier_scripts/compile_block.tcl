#################################################################################################
#                                                                                               #
#     Portions Copyright © 2022 Synopsys, Inc. All rights reserved. Portions of                 #
#     these TCL scripts are proprietary to and owned by Synopsys, Inc. and may only             #
#     be used for internal use by educational institutions (including United States             #
#     government labs, research institutes and federally funded research                        #
#     development centers) on Synopsys tools for non-profit research, development,              #
#     instruction, and other non-commercial uses or as otherwise specifically set forth         #
#     by written agreement with Synopsys. All other use, reproduction, modification, or         #
#     distribution of these TCL scripts is strictly prohibited.                                 #
#                                                                                               #
#################################################################################################

##########################################################################################
# Tool: Fusion Compiler
# Script: compile_block.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_dp_setup.tcl
rm_source -file ./rm_setup/header_fc_dp.tcl
rm_source -file sidefile_setup.tcl -after_file technology_override.tcl

set_app_options -list {shell.dc_compatibility.return_tcl_errors false}
set_host_options -max_cores $DP_MAX_CORES_BLOCKS

rm_source -file $TCL_PVT_CONFIGURATION_FILE -optional -print "TCL_PVT_CONFIGURATION_FILE"

set top 0
# Check to see if the top level block is running
if {![info exists block_libfilename]} {
   set block_refname_no_label [get_attribute [get_blocks] name]
   set block_refname [lindex [split [lindex [split [get_attribute [get_blocks] full_name] :] 1] .] 0]
   set top 1
} else {
   open_block $block_libfilename:$block_refname
}

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

##########################################################################################
## Settings
##########################################################################################
## set_qor_strategy : a commmand which folds various settings of placement, optimization, timing, CTS, and routing, etc.
## - To query the target metric being set, use the "get_attribute [current_design] metric_target" command
##
## - Note: The strategy for hier DP has been hardcoded to "timing" as the intent is to prepare the design for budgetting.
set set_qor_strategy_cmd "set_qor_strategy -stage synthesis -metric timing"
puts "RM-info: Running $set_qor_strategy_cmd" 
eval ${set_qor_strategy_cmd}

set rm_lib_type [get_attribute -quiet [current_design] rm_lib_type]
if {$rm_lib_type != ""} {puts "RM-info: rm_lib_type = $rm_lib_type"}

## set_stage : a command to apply stage-based application options; intended to be used after set_qor_strategy within RM scripts.
set set_stage_cmd "set_stage -step synthesis"
puts "RM-info: Running ${set_stage_cmd}"
eval ${set_stage_cmd}

##if { [regexp {h$} $rm_lib_type] } {
##   set_app_options -name place.coarse.congestion_driven_max_util -value 0.85
##   ## Define boundary via INITIALIZE_FLOORPLAN_WIDTH and INITIALIZE_FLOORPLAN_HEIGHT or INITIALIZE_FLOORPLAN_BOUNDARY.
##   rm_source -file init_design.tcl.${rm_lib_type}.floorplanning ;# node/foundry specific
##   eval ${set_qor_strategy_cmd}
##}

if {[get_attribute -quiet [current_block] compile_fusion_step] == ""} {
  define_user_attribute -type string -classes design -name compile_fusion_step
  set_attribute [current_block] compile_fusion_step ""
}
set cur_compile_step [get_attribute [current_block] compile_fusion_step]

#--------------------------------------------------------------------------------------------------------------------------------#

set cur_fp_status [rm_detect_fp_valid_operations -operations {initialize_floorplan}] ;
## This is needed as boundary created via commit_block is too small.  Tracking enhancement via ESTAR (3349734).
if { $cur_fp_status == "initialize_floorplan" } {
  set_app_options -name compile.auto_floorplan.initialize -value true
}

if {![rm_source -file $TCL_USER_COMPILE_BLOCK_SCRIPT -optional -print "TCL_USER_COMPILE_BLOCK_SCRIPT"]} {
  if { $cur_compile_step == "" } {
    if {[sizeof_collection [get_cells -quiet -hierarchical -filter "is_soft_macro==true"]] > 0} {
      puts "RM-info: compile_fusion -to initial_map started @ $block_refname."
      set_editability -value false -blocks [get_blocks -hier]
      compile_fusion -to initial_map
      set_attribute [current_block] compile_fusion_step initial_map
    } else {
      puts "RM-info: compile_fusion -to logic_opto started @ $block_refname."
      compile_fusion -to logic_opto
      set_attribute [current_block] compile_fusion_step logic_opto
    }
  } elseif { $cur_compile_step == "initial_map" } {
      puts "RM-info: compile_fusion -form logic_opto -to logic_opto started @ $block_refname."
      compile_fusion -from logic_opto -to logic_opto
      set_attribute [current_block] compile_fusion_step logic_opto
  } else {

  }
}

#--------------------------------------------------------------------------------------------------------------------------------#

if { $cur_fp_status ==  "initialize_floorplan" } {
  puts "RM-info: clearing auto-floorplaning objects (terminals, site_row, VA)..."
  set auto_placed_terms [get_terminals -quiet]
  if {[sizeof_collection $auto_placed_terms]} {
    remove_terminals $auto_placed_terms
  }
  remove_site_rows -all
  remove_voltage_area_shapes -all
  remove_tracks -all
}

save_lib -all

if { !$top } {
   close_lib
}
