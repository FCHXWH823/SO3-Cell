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
# Script: create_floorplan.tcl
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

set PREVIOUS_STEP $INIT_COMPILE_BLOCK_NAME
set CURRENT_STEP  $CREATE_FLOORPLAN_BLOCK_NAME

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
## Source floorplan rules file.
####################################
rm_source -file $TCL_FLOORPLAN_RULE_SCRIPT -optional -print "TCL_FLOORPLAN_RULE_SCRIPT"

####################################
## Pre-floorplan customizations
####################################
rm_source -file $TCL_USER_CREATE_FLOORPLAN_PRE_SCRIPT -optional -print "TCL_USER_CREATE_FLOORPLAN_PRE_SCRIPT"

######################################
## Initialize the floorplan
######################################
if {[rm_detect_fp_valid_operations -operations {initialize_floorplan}] == "initialize_floorplan"} {

   rm_source -file $TCL_USER_INITIALIZE_FLOORPLAN_PRE_SCRIPT -optional -print "TCL_USER_INITIALIZE_FLOORPLAN_PRE_SCRIPT"

   ## Floorplan initialization (node specific file)
   rm_source -file $SIDEFILE_CREATE_FLOORPLAN_FLOORPLANNING

   rm_source -file $TCL_USER_INITIALIZE_FLOORPLAN_POST_SCRIPT -optional -print "TCL_USER_INITIALIZE_FLOORPLAN_POST_SCRIPT"
}

rm_source -file $TCL_TRACK_CREATION_FILE -optional -print "TCL_TRACK_CREATION_FILE"

## set_technology for nodes requiring set_technology to be done after floorplanning or incoming designs without set_technology 
if {$TECHNOLOGY_NODE != "" && ($SET_TECHNOLOGY_AFTER_FLOORPLAN || [get_attribute [current_block] technology_node -quiet] == "")} {
  set_technology -node $TECHNOLOGY_NODE
}

## Technology settings (node specific file)
rm_source -file $SIDEFILE_INIT_DP_TECH_SETTINGS -optional -print "SIDEFILE_INIT_DP_TECH_SETTINGS"

## Custom floorplanning (e.g. macro placement, blockages, voltage area creation, etc.)
## - Note that auto placement may move pre-placed macros.  Set to fixed if this is not desired.
rm_source -file $TCL_PHYSICAL_CONSTRAINTS_FILE -optional -print "TCL_PHYSICAL_CONSTRAINTS_FILE"

## Check floorplan post initialization.  Located after track creation.
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/check_floorplan_rules.floorplan_init {check_floorplan_rules -error_view floorplan_rules_floorplan_init}

# It is expected that check_mv_design will complain about two items:
# ---------- Power domain rule ----------
# Error: Power domain '<domain name>' does not have any primary voltage area. (MV-019)
# This is because at this point in the flow the VA has not been created.  It will be created
# during block shaping.
#
# ---------- PG net rule ----------
# Error: PG net '<switched PG Net name>' has no valid PG source(s) or driver(s). (MV-007)
# At this point in the flow the PG switch has not been implemented so the switched power supplies
# do not have a driver.  This will be fixed during PG creation.

# check_mv_design -erc_mode and -power_connectivity
##redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/check_mv_design.erc_mode {check_mv_design -erc_mode}
##redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/check_mv_design.power_connectivity {check_mv_design -power_connectivity}

rm_source -file $TCL_TIMING_RULER_SETUP_FILE -optional -print "Warning: TCL_TIMING_RULER_SETUP_FILE not specified. Timing ruler will not work accurately if it is not defined."

########################################################################
## Place IO cells for chip level design (if IOs are not placed). 
########################################################################

if {[rm_detect_fp_valid_operations -operations {io_placement}] == "io_placement"} {
  if {[file exists [which $TCL_PAD_CONSTRAINTS_FILE]]} {
    puts "RM-info : Running place_io..."
    rm_source -optional -file $TCL_USER_PLACE_IO_PRE_SCRIPT -print TCL_USER_PLACE_IO_PRE_SCRIPT ;
    rm_source -file $TCL_PAD_CONSTRAINTS_FILE -print TCL_USER_PLACE_IO_PRE_SCRIPT ;
    place_io ;
    rm_source -file $TCL_RDL_FILE -optional -print "TCL_RDL_FILE"
    set_attribute -objects [get_cells -quiet -filter is_io==true -hier]    -name status -value fixed
    set_attribute -objects [get_cells -quiet -filter pad_cell==true -hier] -name status -value fixed
    rm_source -optional -file $TCL_USER_PLACE_IO_POST_SCRIPT -print TCL_USER_PLACE_IO_POST_SCRIPT ; 
  } else {
    puts "RM-error: [sizeof_collection $unplaced_ios] unplaced io cells found." ;
  }
}

########################################################################
## Place top-level ports for hierarchical design (e.g. not chip level).
########################################################################

## Determine if top-level port placement is provided in input DEF/TCL floorplan file.
define_user_attribute -type string -classes design -name top_pin_placement
if {[rm_detect_fp_valid_operations -operations {top_pin_placement}] == "top_pin_placement"} {
  set_attribute [current_block] top_pin_placement "0"
} else {
  set_attribute [current_block] top_pin_placement "1"
}

## Perform pin placement when both conditions below are met:
## 1) Pin placement is enabled for this task 
## 2) User wants to run even though pin placement was detected in input DEF/TCL
if {($PLACE_PINS_SELF == "create_floorplan" || $PLACE_PINS_SELF == "both") && (![get_attribute [current_block] top_pin_placement] || $PLACE_PINS_SELF != "none")} {
  ## This file contains the pin constraints in TCL format (i.e. set_*_pin_constraints)
  rm_source -file $TCL_PIN_CONSTRAINT_FILE_SELF -optional -print "TCL_PIN_CONSTRAINT_FILE_SELF"

  ## This file contains the pin constraints in pin constraint format.
  if {[file exists [which $CUSTOM_PIN_CONSTRAINT_FILE_SELF]]} {
    read_pin_constraints -file_name $CUSTOM_PIN_CONSTRAINT_FILE_SELF
  }

  ## Place pins
  place_pins -self

  if {$PLACE_PINS_SELF == "create_floorplan"} {
    ## Optionally fix place ports to prevent movement by downstream commands (i.e. compile_fusion).
    if {$FIX_PORT_PLACEMENT} {
      set port_list [get_ports -quiet -filter "port_type!=power && port_type!=ground && physical_status==placed"]
      if {[sizeof_collection $port_list] > 0} {
        set_attribute $port_list physical_status "fixed"
      }
    }

    ## Check and report unplaced ports.
    set unplaced_ports [get_ports -quiet -filter "port_type!=power && port_type!=ground && physical_status==unplaced"]
    foreach_in_collection port $unplaced_ports {
      set port_name [get_object_name $port]
      puts "RM-warning: Port \"$port_name\" is unplaced."
    }
  }

  ## Write top-level port constraint file based on actual port locations.
  write_pin_constraints -self \
    -file_name $OUTPUTS_DIR/preferred_port_locations.tcl \
    -physical_pin_constraint {side | offset | layer} \
    -from_existing_pins

  ## Verify Top-level Port Placement Results
  redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/check_pin_placement {check_pin_placement -self -pre_route true -pin_spacing true -sides true -layers true -stacking true}

  ## Generate Top-level Port Placement Report
  redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_pin_placement {report_pin_placement -self}
}

####################################
## Post-floorplan customizations
####################################
rm_source -file $TCL_USER_CREATE_FLOORPLAN_POST_SCRIPT -optional -print "TCL_USER_CREATE_FLOORPLAN_POST_SCRIPT"

save_lib -all

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > create_floorplan

exit 
