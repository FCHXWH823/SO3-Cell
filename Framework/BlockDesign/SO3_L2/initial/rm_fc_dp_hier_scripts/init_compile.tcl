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
# Script: init_compile.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

#### NOTE: This file is only used for the Hierarchical Synthesis DP Flow.  

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_dp_setup.tcl
rm_source -file ./rm_setup/header_fc_dp.tcl
rm_source -file sidefile_setup.tcl -after_file technology_override.tcl

set PREVIOUS_STEP $COMMIT_BLOCK_BLOCK_NAME
set CURRENT_STEP  $INIT_COMPILE_BLOCK_NAME

if { [info exists env(RM_VARFILE)] } { 
  if { [file exists $env(RM_VARFILE)] } { 
    rm_source -file $env(RM_VARFILE)
  } else {
    puts "RM-error: env(RM_VARFILE) specified but not found"
  }
}

set REPORT_PREFIX ${CURRENT_STEP}
file mkdir ${REPORTS_DIR}/${REPORT_PREFIX}
puts "RM-info: PREVIOUS_STEP = $PREVIOUS_STEP"
puts "RM-info: CURRENT_STEP  = $CURRENT_STEP"
puts "RM-info: REPORT_PREFIX = $REPORT_PREFIX"

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_start.rpt {run_start}

rm_source -file $TCL_PVT_CONFIGURATION_FILE -optional -print "TCL_PVT_CONFIGURATION_FILE"

################################################################################
# Create and read the design	
################################################################################

rm_open_design -from_lib      ${WORK_DIR}/${DESIGN_LIBRARY} \
               -block_name    $DESIGN_NAME \
               -from_label    $PREVIOUS_STEP \
               -to_label      $CURRENT_STEP \
	       -dp_block_refs $DP_BLOCK_REFS

## Setup distributed processing options
set HOST_OPTIONS ""
if {$DISTRIBUTED} {
   ## Set host options for all blocks.
   set_host_options -name block_script -submit_command $BLOCK_DIST_JOB_COMMAND
   set HOST_OPTIONS "-host_options block_script"

   ## This is an advanced capability which enables custom resourcing for specific blocks.
   ## It is not needed if all blocks have the same resource requirements.  See the
   ## comments embedded for the BLOCK_DIST_JOB_FILE variable definition to setup.
   rm_source -file $BLOCK_DIST_JOB_FILE -optional -print "BLOCK_DIST_JOB_FILE"

   report_host_options
}

## Get block names for references defined by DP_BLOCK_REFS.  This list is used in some hier DP commands.
set child_blocks [ list ]
foreach block $DP_BLOCK_REFS {lappend child_blocks [get_object_name [get_blocks -hier -filter block_name==$block]]}
set all_blocks "$child_blocks [get_object_name [current_block]]"

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

####################################
## Pre-init_compile customizations
####################################
rm_source -file $TCL_USER_INIT_COMPILE_PRE_SCRIPT -optional -print "TCL_USER_INIT_COMPILE_PRE_SCRIPT"

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

if { [regexp {h$} $rm_lib_type] } {
   set_app_options -name place.coarse.congestion_driven_max_util -value 0.85
   ## Define boundary via INITIALIZE_FLOORPLAN_WIDTH and INITIALIZE_FLOORPLAN_HEIGHT or INITIALIZE_FLOORPLAN_BOUNDARY.
   rm_source -file init_design.tcl.${rm_lib_type}.floorplanning ;# node/foundry specific
   eval ${set_qor_strategy_cmd}
}

save_lib -all

set valid_operation_list {initialize_floorplan io_placement bump_placement macro_placement block_shaping va_shaping top_pin_placement block_pin_placement}
set cur_fp_status [rm_detect_fp_valid_operations -operations $valid_operation_list]

##########################################################################################
## Distributed block initial compile 
##########################################################################################

set compile_block_script ./rm_fc_dp_hier_scripts/compile_block.tcl 

set DP_BLOCKS_COMPILE [list] ;
foreach ref $DP_BLOCK_REFS {
  if { [lsearch $DP_BB_BLOCK_REFS $ref] < 0 } {
    lappend DP_BLOCKS_COMPILE $ref
  }
}

eval run_block_script -script ${compile_block_script} \
   -blocks [list "${DP_BLOCKS_COMPILE}"] \
   -work_dir ./work_dir/init_compile ${HOST_OPTIONS}

##########################################################################################
## Top initial compile 
##########################################################################################

define_user_attribute -type string -classes design -name compile_fusion_step

if {![rm_source -file $TCL_USER_INIT_COMPILE_SCRIPT -optional -print "TCL_USER_INIT_COMPILE_SCRIPT"]} {
  if {$FLOORPLAN_STYLE == "abutted"} {
     puts "RM-info : Skip top level compile in $FLOORPLAN_STYLE design"
  } else {
     set_editability -value false -blocks [get_blocks $child_blocks]
   
     set_app_options -name compile.auto_floorplan.enable -value false
   
     if {$cur_fp_status == ""} {
        puts "RM-info : Running compile_fusion to logic_opto for top-level when an input floorplan is provided."
        compile_fusion -to logic_opto
        set_attribute [current_block] compile_fusion_step logic_opto
     } else {
        puts "RM-info : Runing compile_fusion to initial_map for top-level when an input floorplan is not provided."
        compile_fusion -to initial_map
        set_attribute [current_block] compile_fusion_step initial_map
     }
  }

  set_editability -value true -blocks [get_blocks $child_blocks]
}

puts "RM-info : Running connect_pg_net -automatic on all blocks"
connect_pg_net -automatic -all_blocks

## Create the initial block abstract views.
if {$BOTTOM_BLOCK_VIEW == "abstract"} {
   eval create_abstract -force_recreate -placement -blocks [get_blocks $child_blocks] ${HOST_OPTIONS}
}

####################################
## Post-init_compile customizations
####################################
rm_source -file $TCL_USER_INIT_COMPILE_POST_SCRIPT -optional -print "TCL_USER_INIT_COMPILE_POST_SCRIPT"

save_lib -all

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > init_compile

exit 
