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
# Script: init_dp_fc.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_dp_setup.tcl
rm_source -file ./rm_setup/header_fc_dp.tcl
rm_source -file sidefile_setup.tcl -after_file technology_override.tcl

set CURRENT_STEP  ${INIT_DP_BLOCK_NAME}

if { [info exists env(RM_VARFILE)] } { 
  if { [file exists $env(RM_VARFILE)] } { 
    rm_source -file $env(RM_VARFILE)
  } else {
    puts "RM-error: env(RM_VARFILE) specified but not found"
  }
}

set REPORT_PREFIX ${CURRENT_STEP}
file mkdir ${REPORTS_DIR}/${REPORT_PREFIX}
puts "RM-info: CURRENT_STEP  = $CURRENT_STEP"
puts "RM-info: REPORT_PREFIX = $REPORT_PREFIX"

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_start.rpt {run_start}

rm_source -file $TCL_USER_LIBRARY_SETUP_SCRIPT -optional -print "TCL_USER_LIBRARY_SETUP_SCRIPT"

################################################################################
## Pre-init_dp User Customizations
################################################################################
rm_source -file $TCL_USER_INIT_DP_PRE_SCRIPT -optional -print "TCL_USER_INIT_DP_PRE_SCRIPT"

################################################################################
# Create and read the design	
################################################################################

if {[file exists ${WORK_DIR}/${DESIGN_LIBRARY}]} {
   file delete -force ${WORK_DIR}/${DESIGN_LIBRARY}
}

set create_lib_cmd "create_lib ${WORK_DIR}/${DESIGN_LIBRARY}"

if {[file exists [which $TECH_FILE]]} {
   lappend create_lib_cmd -tech $TECH_FILE ;# recommended
} elseif {$TECH_LIB != ""} {
   lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
}

if {$PARASITIC_TECH_LIB != "" } {
   lappend create_lib_cmd -use_parasitic_tech_lib $PARASITIC_TECH_LIB ;# optional
}

## Construct a list for fusion libraries created on the fly by using RM's Makefile create_fusion_reference_library target
## This is only applicable if you use RM's Makefile to create the fusion libraries which outputs $FUSION_REFERENCE_LIBRARY_DIR 
set rm_fusion_reference_library_list ""
if {[file exists $FUSION_REFERENCE_LIBRARY_DIR]} {
	foreach lib [glob -type d $FUSION_REFERENCE_LIBRARY_DIR/*] {
		puts "RM-info: adding $lib to the reference library list"
		lappend rm_fusion_reference_library_list $lib	
	}
} elseif {$FUSION_REFERENCE_LIBRARY_DIR != "" && [file exists create_fusion_reference_library]} {
	puts "RM-error: $FUSION_REFERENCE_LIBRARY_DIR is specified but not found, please correct it!"
}

## Add all relevant reference libraries to the design library 
lappend create_lib_cmd -ref_libs "\
$rm_fusion_reference_library_list \
$REFERENCE_LIBRARY \
$PARASITIC_TECH_LIB"

puts "RM-info : $create_lib_cmd"
eval $create_lib_cmd

if {!$NETLIST2GDS_FLOW} {
   switch ${RTL_SOURCE_FORMAT} {
      sverilog {
         puts "RM-info : Reading RTL file(s) $RTL_SOURCE_FILES"
         analyze -format sverilog ${RTL_SOURCE_FILES}
         elaborate ${DESIGN_NAME}
      
         ## Specify the label to use for blocks built bottom-up, in a mixed-hierarchy design. 
         if {$BLOCK_ABSTRACT_LABEL_FOR_BOTTOM_UP_BLOCKS != ""} {
            set_label_switch_list  "$BLOCK_ABSTRACT_LABEL_FOR_BOTTOM_UP_BLOCKS"
         }
         set_top_module ${DESIGN_NAME}
      }
      verilog {
         puts "RM-info : Reading RTL file(s) $RTL_SOURCE_FILES"
         analyze -format verilog ${RTL_SOURCE_FILES}
         elaborate ${DESIGN_NAME}
      
         ## Specify the label to use for blocks built bottom-up, in a mixed-hierarchy design. 
         if {$BLOCK_ABSTRACT_LABEL_FOR_BOTTOM_UP_BLOCKS != ""} {
            set_label_switch_list  "$BLOCK_ABSTRACT_LABEL_FOR_BOTTOM_UP_BLOCKS"
         }
         set_top_module ${DESIGN_NAME}
      }
      vhdl {
         puts "RM-info : Reading RTL file(s) $RTL_SOURCE_FILES"
         analyze -format vhdl ${RTL_SOURCE_FILES}
         elaborate ${DESIGN_NAME}
      
         ## Specify the label to use for blocks built bottom-up, in a mixed-hierarchy design. 
         if {$BLOCK_ABSTRACT_LABEL_FOR_BOTTOM_UP_BLOCKS != ""} {
            set_label_switch_list  "$BLOCK_ABSTRACT_LABEL_FOR_BOTTOM_UP_BLOCKS"
         }
         set_top_module ${DESIGN_NAME}
      }
      script {
         if {![rm_source -file $FC_RTL_READ_SCRIPT]} {
            ## Note : The following executes only if FC_RTL_READ_SCRIPT is not sourced
            exit
         }
      }
      default {
         puts "RM-error: Unknown RTL_SOURCE_FORMAT (${RTL_SOURCE_FORMAT})"
         exit 
      }
   }

   ## Design check manager
   if {$EARLY_DATA_CHECK_POLICY != "none"} {set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist}

   rename_block -to_block ${DESIGN_NAME}/${CURRENT_STEP}

   rm_source -file $TCL_USER_READ_RTL_POST_SCRIPT -optional -print "TCL_USER_READ_RTL_POST_SCRIPT"

   ## Set Design Planning Flow Strategy
   rm_set_dp_flow_strategy -dp_stage $DP_STAGE -dp_flow hierarchical -hier_fp_style $FLOORPLAN_STYLE

   ## Set technology mega switch
   if {$TECHNOLOGY_NODE != "" && !$SET_TECHNOLOGY_AFTER_FLOORPLAN} {
      set_technology -node $TECHNOLOGY_NODE
   }

   ## DFT Ports
   rm_source -file $DFT_PORTS_FILE -optional -print "DFT_PORTS_FILE"
   rm_source -file $TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT -optional -print "TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT"

   ## Load UPF file
   if {[file exists [which $UPF_FILE]]} {
      puts "RM-info : Loading UPF file $UPF_FILE"
      load_upf $UPF_FILE
      if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
         puts "RM-info : Loading UPF update supply set file $UPF_UPDATE_SUPPLY_SET_FILE"
         load_upf $UPF_UPDATE_SUPPLY_SET_FILE
      }
   } else {
      puts "RM-warning : UPF file not found"
   }

   ## Technology setup for routing layer direction, offset, site default, and site symmetry.
   #  If TECH_FILE is specified, they should be properly set.
   #  If TECH_LIB is used and it does not contain such information, then they should be set here as well.
   if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
      rm_source -file $TCL_TECH_SETUP_FILE -optional -print "TCL_TECH_SETUP_FILE"
   }

   ## Read a file in PRF format which specifies tech/library physical rules and attributes.
   if {[file exists [which $PHYSICAL_RULES_FILE]]} {
      read_physical_rules $PHYSICAL_RULES_FILE
   }

   if {$PARASITIC_TECH_LIB == "" } {
	## Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command
	## Refer to examples/TCL_PARASITIC_SETUP_FILE.tcl for sample commands
	## This is only sourced if PARASITIC_TECH_LIB is not specified
	rm_source -file $TCL_PARASITIC_SETUP_FILE -optional -print "TCL_PARASITIC_SETUP_FILE"
   }

   ## Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
   #  Two examples are provided: 
   #  - examples/TCL_MCMM_SETUP_FILE.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
   #    and scenarios; source mode, corner, and scenario constraints, respectively 
   #  - examples/TCL_MCMM_SETUP_FILE.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
   #    and scenarios; source scenario constraints which are then expanded to associated modes and corners
   rm_source -file $TCL_MCMM_SETUP_FILE

   # adjust commit_upf after mcmm setup due to 9001437105
   # mv.cells.rename_isolation_cell_with_formal_name is default true since 19.03

   # Adjust commit_upf after mcmm setup preventing iso rename. Refer to mv.cells.rename_isolation_cell_with_formal_name for details.
   if {[file exists [which $UPF_FILE]]} {
      commit_upf
   }

} else {
   if {$DP_HIGH_CAPACITY_MODE} {
      ## Read in the DESIGN_NAME outline.  This will create the outline view in the database.
      ## - Running high capacity mode when block views are abstracts.
      puts "RM-info : Reading verilog outline (${VERILOG_NETLIST_FILES})"
      read_verilog_outline -design ${DESIGN_NAME}/${CURRENT_STEP} -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}
   } else {
      ## Read in the full DESIGN_NAME.  This will create the DESIGN_NAME view in the database
      puts "RM-info : Reading full chip verilog (${VERILOG_NETLIST_FILES})"
      read_verilog -design ${DESIGN_NAME}/${CURRENT_STEP} -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}
   }

   ## Design check manager
   if {$EARLY_DATA_CHECK_POLICY != "none"} {set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist}

   ## Set Design Planning Flow Strategy
   rm_set_dp_flow_strategy -dp_stage $DP_STAGE -dp_flow hierarchical -hier_fp_style $FLOORPLAN_STYLE

   ## Set technology mega switch
   if {$TECHNOLOGY_NODE != "" && !$SET_TECHNOLOGY_AFTER_FLOORPLAN} {
      set_technology -node $TECHNOLOGY_NODE
   }

   ## UPF is loaded in split_constraints.tcl for high-capacity mode.
   if {!$DP_HIGH_CAPACITY_MODE} {
      ## Load UPF file
      if {[file exists [which $UPF_FILE]]} {
         puts "RM-info : Loading UPF file $UPF_FILE"
         load_upf $UPF_FILE
         if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
            puts "RM-info : Loading UPF update supply set file $UPF_UPDATE_SUPPLY_SET_FILE"
            load_upf $UPF_UPDATE_SUPPLY_SET_FILE
         }
      } else {
         puts "RM-warning : UPF file not found"
      }
   }

   ## Technology setup for routing layer direction, offset, site default, and site symmetry.
   #  If TECH_FILE is specified, they should be properly set.
   #  If TECH_LIB is used and it does not contain such information, then they should be set here as well.
   if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
      rm_source -file $TCL_TECH_SETUP_FILE -optional -print "TCL_TECH_SETUP_FILE"
   }

   ## Read a file in PRF format which specifies tech/library physical rules and attributes.
   if {[file exists [which $PHYSICAL_RULES_FILE]]} {
   	read_physical_rules $PHYSICAL_RULES_FILE
   }

   if {$PARASITIC_TECH_LIB == "" } {
	## Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command
	## Refer to examples/TCL_PARASITIC_SETUP_FILE.tcl for sample commands
	## This is only sourced if PARASITIC_TECH_LIB is not specified
	rm_source -file $TCL_PARASITIC_SETUP_FILE -optional -print "TCL_PARASITIC_SETUP_FILE"
   }

   ## MCMM is loaded in split_constraints.tcl for high-capacity mode.
   if {!$DP_HIGH_CAPACITY_MODE} {
      ## Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
      #  Two examples are provided: 
      #  - examples/TCL_MCMM_SETUP_FILE.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
      #    and scenarios; source mode, corner, and scenario constraints, respectively 
      #  - examples/TCL_MCMM_SETUP_FILE.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
      #    and scenarios; source scenario constraints which are then expanded to associated modes and corners
      rm_source -file $TCL_MCMM_SETUP_FILE

      # adjust commit_upf after mcmm setup due to 9001437105
      # mv.cells.rename_isolation_cell_with_formal_name is default true since 19.03

      # Adjust commit_upf after mcmm setup preventing iso rename. Refer to mv.cells.rename_isolation_cell_with_formal_name for details.
      if {[file exists [which $UPF_FILE]]} {
         commit_upf
      }
   }
}

rm_source -file $TCL_TIMING_RULER_SETUP_FILE -optional -print "Warning: TCL_TIMING_RULER_SETUP_FILE not specified. Timing ruler will not work accurately if it is not defined."

##################################################################################################
## 				Routing settings						##
##################################################################################################
## Set max routing layer
if {$MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
## Set min routing layer
if {$MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}

####################################
# Check Design: Pre-Floorplanning
####################################
if {$CHECK_DESIGN} {
   redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/check_design.pre_floorplan \
    {check_design -ems_database check_design.pre_floorplan.ems -checks dp_pre_floorplan}
}

####################################
# Floorplanning
####################################
if {$DEF_FLOORPLAN_FILES_DP != ""} {
   ## Check if all the specified DEF files are valid.  If not, read_def is skipped
   set RM_DEF_FLOORPLAN_FILE_is_not_found FALSE
   foreach def_file $DEF_FLOORPLAN_FILES_DP {
      if {![file exists [which $def_file]]} {
         puts "RM-error : DEF floorplan file ($def_file) is invalid."
         set RM_DEF_FLOORPLAN_FILE_is_not_found TRUE
      }
   }

   if {!$RM_DEF_FLOORPLAN_FILE_is_not_found} {
      set read_def_cmd "read_def $DEF_READ_OPTIONS [list $DEF_FLOORPLAN_FILES_DP]"
      ## if {$DEF_SITE_NAME_PAIRS != ""} {lappend read_def_cmd -convert $DEF_SITE_NAME_PAIRS}
      puts "RM-info : Creating floorplan from DEF file DEF_FLOORPLAN_FILES_DP ($DEF_FLOORPLAN_FILES_DP)"
      puts "RM-info: $read_def_cmd"
      eval ${read_def_cmd}
   } else {
      puts "RM-error : At least one of the DEF_FLOORPLAN_FILES_DP specified is invalid. Pls correct it."
      puts "RM-info: Skipped reading of DEF_FLOORPLAN_FILES_DP"
   }
} elseif {[file exists [which $TCL_FLOORPLAN_FILE_DP]]} {
   rm_source -file $TCL_FLOORPLAN_FILE_DP
} elseif {$NETLIST2GDS_FLOW} {
   ## Floorplan initialization (node specific file)
   rm_source -file $SIDEFILE_INIT_DP_FLOORPLANNING

   rm_source -file $TCL_TRACK_CREATION_FILE -optional -print "TCL_TRACK_CREATION_FILE"
} else {
   puts "RM-info: Floorplan initialization occurs in the create_floorplan task for the FC Hierarchical Synthesis flow"
}

###########################################
## General process node specific settings
###########################################

if {$NETLIST2GDS_FLOW} {
   ## set_technology for nodes requiring set_technology to be done after floorplanning or incoming designs without set_technology 
   if {$TECHNOLOGY_NODE != "" && ($SET_TECHNOLOGY_AFTER_FLOORPLAN || [get_attribute [current_block] technology_node -quiet] == "")} {
      set_technology -node $TECHNOLOGY_NODE
   }
   ## Technology settings (node specific file)
   rm_source -file $SIDEFILE_INIT_DP_TECH_SETTINGS -optional -print "SIDEFILE_INIT_DP_TECH_SETTINGS"
}

## Placement spacing labels, spacing rules, and abutment rules 
if {$TCL_PLACEMENT_CONSTRAINT_FILE_LIST != ""} {
  foreach file $TCL_PLACEMENT_CONSTRAINT_FILE_LIST {
    rm_source -file $file
  }
}

## Lib cell usage restrictions (set_lib_cell_purpose)
## By default, RM sources set_lib_cell_purpose.tcl for dont use, tie cell, hold fixing, CTS and CTS-exclusive cell restrictions. 
## For advanced nodes, set_lib_cell_purpose.tcl sources node specific dont use sidefile for the corresponding node.
## You can replace it with your own script by specifying the TCL_LIB_CELL_PURPOSE_FILE variable.  
rm_source -file $TCL_LIB_CELL_PURPOSE_FILE -optional -print "TCL_LIB_CELL_PURPOSE_FILE"

################################################################################
## Post-init_dp User Customizations
################################################################################
rm_source -file $TCL_USER_INIT_DP_POST_SCRIPT -optional -print "TCL_USER_INIT_DP_POST_SCRIPT"

if {$COMPRESS_LIBS} {
  save_lib -all -compress
} else {
  save_lib -all
}

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > init_dp

exit 
