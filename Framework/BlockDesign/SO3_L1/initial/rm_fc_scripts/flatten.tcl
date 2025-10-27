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
# Script: flatten.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
if {$HPC_CORE != "" && $DESIGN_STYLE == "hier"} {
   rm_source -file ./rm_setup/design_setup.tcl -after_file flow_override.tcl
}

rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl
rm_source -file sidefile_setup.tcl -after_file technology_override.tcl
if {$HPC_CORE != ""} {rm_source -file ./rm_hpc_core_scripts/sidefile_setup_hpc_core.tcl}

set REPORT_PREFIX $CURRENT_STEP
file mkdir ${REPORTS_DIR}/${REPORT_PREFIX}
set PREVIOUS_STEP $ROUTE_OPT_BLOCK_NAME
set CURRENT_STEP $FLATTEN_BLOCK_NAME
puts "RM-info: PREVIOUS_STEP = $PREVIOUS_STEP"
puts "RM-info: CURRENT_STEP  = $CURRENT_STEP"
puts "RM-info: REPORT_PREFIX = $REPORT_PREFIX"
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_start.rpt {run_start}
set_svf ${OUTPUTS_DIR}/${FLATTEN_BLOCK_NAME}.svf 

rm_source -file $TCL_PVT_CONFIGURATION_FILE -optional -print "TCL_PVT_CONFIGURATION_FILE"

open_lib $DESIGN_LIBRARY
copy_block -from ${DESIGN_NAME}/${PREVIOUS_STEP} -to ${DESIGN_NAME}/${CURRENT_STEP}
current_block ${DESIGN_NAME}/${CURRENT_STEP}
link_block

if {$FLATTEN_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $FLATTEN_ACTIVE_SCENARIO_LIST
}

## Adjustment file for modes/corners/scenarios/models to applied to each step (optional)
rm_source -file $TCL_MODE_CORNER_SCENARIO_MODEL_ADJUSTMENT_FILE -optional -print "TCL_MODE_CORNER_SCENARIO_MODEL_ADJUSTMENT_FILE"

rm_source -file $TCL_LIB_CELL_PURPOSE_FILE -optional -print "TCL_LIB_CELL_PURPOSE_FILE"

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

## Multi Vt constraint file to be applied in each step (optional)
rm_source -file $TCL_MULTI_VT_CONSTRAINT_FILE -optional -print "TCL_MULTI_VT_CONSTRAINT_FILE"

##########################################################################################
## Settings
##########################################################################################
## set_stage : a command to apply stage-based application options; intended to be used after set_qor_strategy within RM scripts.
set_stage -step post_route

if {$HPC_CORE != "" } {
	set HPC_STAGE route_opt
	puts "RM-info: HPC_CORE is being set to $HPC_CORE; Loading HPC settings"
	set_hpc_options -core $HPC_CORE -stage $HPC_STAGE
}

##########################################################################################
## Pre-flatten customizations
##########################################################################################
rm_source -file $TCL_USER_FLATTEN_PRE_SCRIPT -optional -print "TCL_USER_FLATTEN_PRE_SCRIPT"

#################################################################################
## Change to Design Views
#################################################################################
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_qor_abstract_view.rpt {report_qor -pba_mode path -summary}

puts "RM-info: Swapping abstracts to design view for all blocks."
change_abstract -references $SUB_BLOCK_REFS -label $PREVIOUS_STEP -view design
report_abstracts

remove_timing_paths_disabled_blocks
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_qor_design_view.rpt {report_qor -pba_mode path -summary}

#################################################################################
## Uncommit blocks into top
#################################################################################

save_block -as ${DESIGN_NAME}/${FLATTEN_BLOCK_NAME}_pre_uncommit


set_editability -blocks [get_blocks -hier] -value true
foreach BLOCK $SUB_BLOCK_REFS {
  uncommit_block -design $BLOCK -type module
}

## Remove stale design views (i.e. abstract and frame)
foreach_in_collection design_view [get_blocks ${DESIGN_NAME}/${FLATTEN_BLOCK_NAME}.*] {  
  if {[get_attribute $design_view view_name] != "design"} {
    remove_block -force $design_view
  }
}

rm_source -file $TCL_USER_UNCOMMIT_POST_SCRIPT -optional -print "TCL_USER_UNCOMMIT_POST_SCRIPT"

#################################################################################
## Reload timing constraints
#################################################################################
remove_sdc
rm_source -file $TCL_MCMM_SETUP_FILE -print "TCL_MCMM_SETUP_FILE"
rm_source -file $TCL_MODE_CORNER_SCENARIO_MODEL_ADJUSTMENT_FILE -optional -print "TCL_MODE_CORNER_SCENARIO_MODEL_ADJUSTMENT_FILE"

rm_source -file $TCL_USER_MCMM_SETUP_POST_SCRIPT -optional -print "TCL_USER_MCMM_SETUP_POST_SCRIPT"

#################################################################################
## Reload the UPF 
#################################################################################
reset_upf

## For golden UPF flow only (if supplemental UPF is provided): enable golden UPF flow before reading UPF
if {[file exists [which $UPF_SUPPLEMENTAL_FILE]]} {set_app_options -name mv.upf.enable_golden_upf -value true}
if {[file exists [which $UPF_FILE]]} {
	load_upf $UPF_FILE

	## For golden UPF flow only (if supplemental UPF is provided): read supplemental UPF file
	if {[file exists [which $UPF_SUPPLEMENTAL_FILE]]} { 
		load_upf -supplemental $UPF_SUPPLEMENTAL_FILE
	} elseif {$UPF_SUPPLEMENTAL_FILE != ""} {
		puts "RM-error: UPF_SUPPLEMENTAL_FILE($UPF_SUPPLEMENTAL_FILE) is invalid. Please correct it."
	}

	## Read the supply set file
	if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
		load_upf $UPF_UPDATE_SUPPLY_SET_FILE
	} elseif {$UPF_UPDATE_SUPPLY_SET_FILE != ""} {
		puts "RM-error: UPF_UPDATE_SUPPLY_SET_FILE($UPF_UPDATE_SUPPLY_SET_FILE) is invalid. Please correct it."
	}

	puts "RM-info: Running commit_upf"
	commit_upf
} elseif {$UPF_FILE != ""} {
	puts "RM-error: UPF file($UPF_FILE) is invalid. Please correct it."
}

rm_source -file $TCL_USER_UPF_SETUP_POST_SCRIPT -optional -print "TCL_USER_UPF_SETUP_POST_SCRIPT"

##########################################################################################
## Post-flatten customizations
##########################################################################################
rm_source -file $TCL_USER_FLATTEN_POST_SCRIPT -optional -print "TCL_USER_FLATTEN_POST_SCRIPT" 

save_block 

##########################################################################################
## Report and output
##########################################################################################
if {$REPORT_QOR} {
	if {$REPORT_PARALLEL_SUBMIT_COMMAND != ""} {
		## Generate a file to pass necessary RM variables for running report_qor.tcl to the report_parallel command
		rm_generate_variables_for_report_parallel -work_directory ${REPORTS_DIR}/${REPORT_PREFIX} -file_name rm_tcl_var.tcl

		## Parallel reporting using the report_parallel command (requires a valid REPORT_PARALLEL_SUBMIT_COMMAND)
		report_parallel -work_directory ${REPORTS_DIR}/${REPORT_PREFIX} -submit_command ${REPORT_PARALLEL_SUBMIT_COMMAND} -max_cores ${REPORT_PARALLEL_MAX_CORES} -user_scripts [list "${REPORTS_DIR}/${REPORT_PREFIX}/rm_tcl_var.tcl" "[which report_qor.tcl]"]
	} else {
		## Classic reporting
		rm_source -file report_qor.tcl
	}
}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > flatten

exit 
