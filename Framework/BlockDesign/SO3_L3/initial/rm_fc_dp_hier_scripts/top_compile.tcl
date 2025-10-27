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
# Script: top_compile.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
# Descriptions:
#  This stage is to perform top-level logic_opto stage. It's only needed when user didn't 
#  provided a floorplan. Otherwise, top-level logic_opto had been done in initial_compile
##########################################################################################

#### NOTE: This file is only used for the Hierarchical Synthesis DP Flow.  

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_dp_setup.tcl
rm_source -file ./rm_setup/header_fc_dp.tcl
rm_source -file sidefile_setup.tcl -after_file technology_override.tcl

set PREVIOUS_STEP $PLACE_PINS_BLOCK_NAME
set CURRENT_STEP  $TOP_COMPILE_BLOCK_NAME

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
## Pre-Top Compile User Customizations
####################################
rm_source -file $TCL_USER_TOP_COMPILE_PRE_SCRIPT -optional -print "TCL_USER_TOP_COMPILE_PRE_SCRIPT"

## When user provided floorplan, continue on top level logic_opto

   
##########################################################################################
## Top logic_opto compile 
##########################################################################################
if {[get_attribute [current_block] compile_fusion_step] == "initial_map"} {

   # create abstract and load the block constraints for bottom level blocks
   puts "RM-info : Running create_abstract -timing_level $BLOCK_ABSTRACT_TIMING_LEVEL -blocks \"$child_blocks\" -read_only $HOST_OPTIONS"
   eval create_abstract -timing_level $BLOCK_ABSTRACT_TIMING_LEVEL -blocks [get_blocks $child_blocks] -read_only $HOST_OPTIONS

   save_lib -all

   # run compile logic optimization for mid level blocks
   set compile_block_script ./rm_fc_dp_hier_scripts/compile_block.tcl 
   if {$DP_INTERMEDIATE_LEVEL_BLOCK_REFS != ""} {
      eval run_block_script -script ${compile_block_script} \
         -blocks [list "${DP_INTERMEDIATE_LEVEL_BLOCK_REFS}"] \
         -work_dir ./work_dir/top_compile ${HOST_OPTIONS}
   }

   if {$FLOORPLAN_STYLE == "abutted"} {
      puts "RM-info : Skip top level compile in $FLOORPLAN_STYLE design"
   } else {
      # run compile logic optimization for top level
      set_app_options -name compile.auto_floorplan.enable -value false
   
      puts "RM-info :Start top level compile_fusion to logic_opto ..."
      set_editability -value false -blocks [get_blocks $child_blocks]
      compile_fusion -from logic_opto -to logic_opto
      set_attribute [current_block] compile_fusion_step logic_opto
      ## Ensure any cells added in top and intermediate blocks are placed.
      set_editability -value false -blocks [get_blocks $child_blocks]

      if { [sizeof_collection [get_cells -quiet -hierarchical -filter "is_placed==false"]]} {
         foreach blk $DP_INTERMEDIATE_LEVEL_BLOCK_REFS {
            set_editability -value true -blocks [get_blocks -hier -filter block_name==$blk]
         }
         eval create_placement -floorplan -use_seed_locs $HOST_OPTIONS
      }
      set_editability -value true -blocks [get_blocks $child_blocks]
   }

   puts "RM-info : Running connect_pg_net -automatic on all blocks"
   connect_pg_net -automatic -all_blocks
}

####################################
## Post-Top Compile User Customizations
####################################
rm_source -file $TCL_USER_TOP_COMPILE_POST_SCRIPT -optional -print "TCL_USER_TOP_COMPILE_POST_SCRIPT"

save_lib -all

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > top_compile

exit 
