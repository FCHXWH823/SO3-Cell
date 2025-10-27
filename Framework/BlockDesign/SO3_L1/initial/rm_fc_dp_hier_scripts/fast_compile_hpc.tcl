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
# Script: fast_compile_hpc.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/fc_dp_setup.tcl
rm_source -file ./rm_setup/header_fc_dp.tcl
rm_source -file sidefile_setup.tcl -after_file technology_override.tcl
if {$HPC_CORE != ""} {
  if {$DESIGN_STYLE == "hier"} {rm_source -file ./dp_override.tcl}
  rm_source -file ./rm_hpc_core_scripts/sidefile_setup_hpc_core.tcl
}

set PREVIOUS_STEP $INIT_DESIGN_BLOCK_NAME
set CURRENT_STEP  $FAST_COMPILE_HPC_BLOCK_NAME

if { [info exists env(RM_VARFILE)] } { 
  if { [file exists $env(RM_VARFILE)] } { 
    rm_source -file $env(RM_VARFILE)
  } else {
    puts "RM-error: env(RM_VARFILE) specified but not found"
  }
}

set REPORT_PREFIX $CURRENT_STEP
file mkdir ${REPORTS_DIR}/${REPORT_PREFIX}
puts "RM-info: PREVIOUS_STEP = $PREVIOUS_STEP"
puts "RM-info: CURRENT_STEP  = $CURRENT_STEP"
puts "RM-info: REPORT_PREFIX = $REPORT_PREFIX"

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_start.rpt {run_start}

rm_source -file $TCL_PVT_CONFIGURATION_FILE -optional -print "TCL_PVT_CONFIGURATION_FILE"

########################################################################
## Open design
########################################################################
set DESIGN_VIEW "design" 

rm_open_design -from_lib      ${WORK_DIR}/${DESIGN_LIBRARY} \
               -block_name    $DESIGN_NAME \
               -from_label    $PREVIOUS_STEP \
               -to_label      $CURRENT_STEP \
               -view          $DESIGN_VIEW \
	       -dp_block_refs $DP_BLOCK_REFS

## Set Design Planning Flow Strategy
rm_set_dp_flow_strategy -dp_stage $DP_STAGE -dp_flow hierarchical -hier_fp_style $FLOORPLAN_STYLE

#################################################################################
## Insert DFT
#################################################################################
if {$HPC_CORE != "" } {
  if { $DFT_INSERT_ENABLE } {
    # Don't need to enable DFT during this step
    # DFT Constraints for fast compile
    if {[file exists [which $DFT_FAST_COMPILE_HPC_SCRIPT]]} {
      puts "RM-info: Loading : [which $DFT_FAST_COMPILE_HPC_SCRIPT]"
      rm_source -file $DFT_FAST_COMPILE_HPC_SCRIPT -optional -print "DFT_FAST_COMPILE_HPC_SCRIPT"  
    } elseif {$DFT_PORTS_FILE != ""} {
      puts "RM-Error: DFT setup from TestMAX Manager missing. Please run TestMAX Manager first"
    }
  } else {
    rm_source -file $DFT_VARS_SCRIPT -optional -print "DFT_VARS_SCRIPT"
    rm_source -file $DFT_SETUP_FILE -optional -print "DFT_SETUP_FILE"

    create_test_protocol
    preview_dft > ${OUTPUTS_DIR}/${DESIGN_NAME}.preview_dft
    insert_dft
  }
  save_block -as ${DESIGN_NAME}/insert_dft
}

####################################
## MV setup : provide a customized MV script	
####################################
## A Tcl script placeholder for your MV setup commands,such as power switch creation and level shifter insertion, etc
## MV_setup file to source HPC MV files
rm_source -file $TCL_MV_SETUP_FILE -optional -print "TCL_MV_SETUP_FILE"

#################################################################################
## Optional library setup files.
#################################################################################

## Adjustment file for modes/corners/scenarios/models to applied to each step (optional)
rm_source -file $TCL_MODE_CORNER_SCENARIO_MODEL_ADJUSTMENT_FILE -optional -print "TCL_MODE_CORNER_SCENARIO_MODEL_ADJUSTMENT_FILE"

## Library cell purpose file to be applied in each step (optional)
rm_source -file $TCL_LIB_CELL_PURPOSE_FILE -optional -print "TCL_LIB_CELL_PURPOSE_FILE"

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

## Multi Vt constraint file to be applied in each step (optional)
rm_source -file $TCL_MULTI_VT_CONSTRAINT_FILE -optional -print "TCL_MULTI_VT_CONSTRAINT_FILE"

#################################################################################
## Load custom HPC options and files.
#################################################################################
if {$HPC_CORE != "" } {
  rm_source -file $HPC_FAST_COMPILE_HPC_SETTINGS_FILE -print "HPC_FAST_COMPILE_HPC_SETTINGS_FILE"

  set HPC_STAGE "fast_compile"
  puts "RM-info: HPC_CORE is being set to $HPC_CORE; Loading HPC settings for stage $HPC_STAGE"
  redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/${DESIGN_NAME}.set_hpc_options {set_hpc_options -core $HPC_CORE -stage $HPC_STAGE -report_only}
  set_hpc_options -core $HPC_CORE -stage $HPC_STAGE
        
  rm_source -file $HPC_HIER_BOUNDS      -print "HPC_HIER_BOUNDS"
  rm_source -file $HPC_EXCLUSIVE_BOUNDS -print "HPC_EXCLUSIVE_BOUNDS"
}

####################################
## Pre-fast_compile customizations
####################################
rm_source -file $TCL_USER_FAST_COMPILE_HPC_PRE_SCRIPT -optional -print "TCL_USER_FAST_COMPILE_HPC_PRE_SCRIPT"

#################################################################################
## Start compile
## Run compile_fusion -to initial_place before committing the blocks
#################################################################################
save_block -as ${DESIGN_NAME}/pre_compile

## Set active scenarios for the step
if {$FAST_COMPILE_HPC_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $FAST_COMPILE_HPC_ACTIVE_SCENARIO_LIST
}
if {$HPC_CORE != "" } {current_scenario $FMAX_SCENARIO}

puts "RM-info: Running compile_fusion -to initial_map"
compile_fusion -to initial_map
save_block -as ${DESIGN_NAME}/initial_map

puts "RM-info: Running compile_fusion -from logic_opto -to logic_opto"
compile_fusion -from logic_opto -to logic_opto
connect_pg_net -automatic
save_block -as ${DESIGN_NAME}/logic_opto

##########################################################################################
## Initial Place Core specific custom settings
##########################################################################################
rm_source -file $TCL_USER_COMPILE_INITIAL_PLACE_PRE_SCRIPT -optional -print "TCL_USER_COMPILE_INITIAL_PLACE_PRE_SCRIPT"

puts "RM-info: Running compile_fusion -from initial_place -to initial_place"
compile_fusion -from initial_place -to initial_place
save_block -as ${DESIGN_NAME}/initial_place

## Legalize placement to remove cells overlapping exclusive bounds.
legalize_placement

## Change names
if {$DEFINE_NAME_RULES_OPTIONS != ""} {
  eval define_name_rules verilog $DEFINE_NAME_RULES_OPTIONS
}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_name_rules.log {report_name_rules}
change_names -rules verilog -hierarchy

####################################
## Post-fast_compile customizations
####################################
rm_source -file $TCL_USER_FAST_COMPILE_HPC_POST_SCRIPT -optional -print "TCL_USER_FAST_COMPILE_HPC_POST_SCRIPT"

save_block

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > fast_compile_hpc

exit 
