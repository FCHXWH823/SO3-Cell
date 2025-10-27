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
# Script: init_design_dp.tcl
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

set CURRENT_STEP ${INIT_DESIGN_DP_BLOCK_NAME} 

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

rm_source -file $TCL_USER_INIT_DESIGN_DP_PRE_SCRIPT -optional -print "TCL_USER_INIT_DESIGN_DP_PRE_SCRIPT"

########################################################################
## Design library creation/import
########################################################################
if {[file exists $DESIGN_LIBRARY]} {
	if {$INIT_DESIGN_INPUT == "ASCII" && !$NETLIST2GDS_FLOW && [info exists INCREMENTAL_INIT_DESIGN] && [file exists $DESIGN_LIBRARY]} {
		open_lib ${DESIGN_LIBRARY}
	} elseif {$INIT_DESIGN_INPUT == "ASCII" || $INIT_DESIGN_INPUT == "DC_ASCII" || $INIT_DESIGN_INPUT == "RTL"} {
		file delete -force $DESIGN_LIBRARY
	}
}

if { $INIT_DESIGN_INPUT == "DC_ASCII" || \
    ($INIT_DESIGN_INPUT == "RTL" && $RTL_SOURCE_FORMAT != "elaborated_ndm") || \
    ($INIT_DESIGN_INPUT == "ASCII" && $NETLIST2GDS_FLOW) || \
    ($INIT_DESIGN_INPUT == "ASCII" && !$NETLIST2GDS_FLOW && [info exists INCREMENTAL_INIT_DESIGN] && ![file exists $DESIGN_LIBRARY]) } {
	set create_lib_cmd "create_lib $DESIGN_LIBRARY"
	if {[file exists [which $TECH_FILE]]} {
		lappend create_lib_cmd -tech $TECH_FILE ;# recommended
	} elseif {$TECH_LIB != ""} {
		lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
	}
	if {$DESIGN_LIBRARY_SCALE_FACTOR != ""} {lappend create_lib_cmd -scale_factor $DESIGN_LIBRARY_SCALE_FACTOR}

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

        ## Enable CLIB on the fly creation (library configuration flow)
	## create_lib when executed will call library manager under the hood to generate CLIB for correspnding fames/dbs, store, and link them
	## Specify CLIB_REFERENCE_LIBRARY_CONFIGURATION_FLOW_FRAME_LIST and CLIB_REFERENCE_LIBRARY_CONFIGURATION_FLOW_DB_LIST in design_setup.tcl to enable it
	if {$CLIB_REFERENCE_LIBRARY_CONFIGURATION_FLOW_FRAME_LIST != "" && $CLIB_REFERENCE_LIBRARY_CONFIGURATION_FLOW_DB_LIST != ""} {
		set link_library $CLIB_REFERENCE_LIBRARY_CONFIGURATION_FLOW_DB_LIST
	}

	## Add all relevant reference libraries to the design library 
	lappend create_lib_cmd -ref_libs "\
	$rm_fusion_reference_library_list \
	$REFERENCE_LIBRARY \
	$CLIB_REFERENCE_LIBRARY_CONFIGURATION_FLOW_FRAME_LIST \
	$SUB_BLOCK_LIBRARIES \
	$PARASITIC_TECH_LIB"

	puts "RM-info: $create_lib_cmd"
	eval ${create_lib_cmd}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_ref_libs {report_ref_libs}
}

if {$INIT_DESIGN_INPUT == "DC_ASCII"} {
	################################################################
	## source write_icc2_files outputs from DC and commit UPF  
	################################################################
	if {[file exists ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl]} {
		## Read in design output files from Design Compiler's write_icc2_files command
		puts "RM-info: Sourcing [which ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl]"
		rm_source -file ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl

		if {$SET_QOR_STRATEGY_MODE == "early_design"} {
			## Automatically enable lenient policy for early_design mode 
			set_early_data_check_policy -policy lenient -if_not_exist
		} elseif {$EARLY_DATA_CHECK_POLICY != "none"} {
			## Design check manager
			set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
		}

		puts "RM-info: Running commit_upf"
		commit_upf
	} else {
		puts "RM-error : ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl is not found." 
		puts "RM-warning : ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl is required for DC_ASCII flow." 
	}
} ;# INIT_DESIGN_INPUT == DC_ASCII

if {$INIT_DESIGN_INPUT == "ASCII"} {
	########################################################################
	## Design creation : read the verilog
	########################################################################
	if {$DESIGN_STYLE == "hier" && $PHYSICAL_HIERARCHY_LEVEL != "bottom"} {
		## Specify the label to be used for the created design
		## Specifying the following application option will enable the tool to link to the sub-blocks of the same label
		set_app_options -name file.verilog.default_user_label -value $CURRENT_STEP
	
		read_verilog -top ${DESIGN_NAME} $VERILOG_NETLIST_FILES
		current_block ${DESIGN_NAME}/${CURRENT_STEP}
		if {$SET_QOR_STRATEGY_MODE == "early_design"} {
			## Automatically enable lenient policy for early_design mode 
			set_early_data_check_policy -policy lenient -if_not_exist
		} elseif {$EARLY_DATA_CHECK_POLICY != "none"} {
			## Design check manager
			set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
		}
		link_block
		save_lib
	
		## In the link performed above, the tool tries to link to sub-blocks with the same label as the current_block.
		## In the following step, change_abstract is used to link to the sub-blocks specified for place_opt step.
		if {$USE_ABSTRACTS_FOR_BLOCKS != ""} {
	 		puts "RM-info: Swap abstracts to [lindex $BLOCK_ABSTRACT_FOR_PLACE_OPT 0] abstracts for all blocks."
	 		change_abstract -view [lindex $BLOCK_ABSTRACT_FOR_PLACE_OPT 1] -references $USE_ABSTRACTS_FOR_BLOCKS -label [lindex $BLOCK_ABSTRACT_FOR_PLACE_OPT 0]
	 		report_abstracts
		}
	} else {
                read_verilog -top $DESIGN_NAME $VERILOG_NETLIST_FILES
                current_block $DESIGN_NAME
		if {$SET_QOR_STRATEGY_MODE == "early_design"} {
			## Automatically enable lenient policy for early_design mode 
			set_early_data_check_policy -policy lenient -if_not_exist
		} elseif {$EARLY_DATA_CHECK_POLICY != "none"} {
			## Design check manager
			set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
		}
                link_block
                save_lib
	}

	################################################################
	## Design creation : Read UPF file(s)  
	################################################################
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
		puts "RM-error : UPF file($UPF_FILE) is invalid. Please correct it."
	}
} ;# INIT_DESIGN_INPUT == ASCII

if {$INIT_DESIGN_INPUT == "RTL"} {
	#################################################################################
	## Read in the RTL design
	#################################################################################
	set_svf ${OUTPUTS_DIR}/${CURRENT_STEP}.svf

	# Controls HDLC naming style settings to make it easier to apply; the same UPF file across multiple tools at the RTL level
	set_app_options -name hdlin.naming.upf_compatible -value true
		
	rm_source -file $TCL_USER_READ_RTL_PRE_SCRIPT -optional -print "TCL_USER_READ_RTL_PRE_SCRIPT"
	
	########################################################################
	## Analyze / Elaborate
	########################################################################
	switch ${RTL_SOURCE_FORMAT} {
	        sverilog {
	                analyze -format sverilog ${RTL_SOURCE_FILES}
	                elaborate ${DESIGN_NAME}

                	# Following is applicable for designs wtih physical hierarchy; for intermediate and top-levels
                	# Specify the label of the sub-block to which sub-block instances are to be linked
                	if {$DESIGN_STYLE == "hier" && $PHYSICAL_HIERARCHY_LEVEL != "bottom" && $BLOCK_ABSTRACT_FOR_COMPILE != ""} {
				set_label_switch_list [lindex $BLOCK_ABSTRACT_FOR_COMPILE 0]
                	}
                	set_top_module ${DESIGN_NAME}
        	}
        	verilog {
        	        analyze -format verilog ${RTL_SOURCE_FILES}
        	        elaborate ${DESIGN_NAME}

                	# Following is applicable for designs wtih physical hierarchy; for intermediate and top-levels
                	# Specify the label of the sub-block to which sub-block instances are to be linked
                	if {$DESIGN_STYLE == "hier" && $PHYSICAL_HIERARCHY_LEVEL != "bottom" && $BLOCK_ABSTRACT_FOR_COMPILE != ""} {
				set_label_switch_list [lindex $BLOCK_ABSTRACT_FOR_COMPILE 0]
                	}
                	set_top_module ${DESIGN_NAME}
        	}
        	vhdl {
                	analyze -format vhdl ${RTL_SOURCE_FILES}
                	elaborate ${DESIGN_NAME}

                	# Following is applicable for designs wtih physical hierarchy; for intermediate and top-levels
                	# Specify the label of the sub-block to which sub-block instances are to be linked
                	if {$DESIGN_STYLE == "hier" && $PHYSICAL_HIERARCHY_LEVEL != "bottom" && $BLOCK_ABSTRACT_FOR_COMPILE != ""} {
				set_label_switch_list [lindex $BLOCK_ABSTRACT_FOR_COMPILE 0]
                	}
                	set_top_module ${DESIGN_NAME}
        	}
        	script {
			if {![rm_source -file $FC_RTL_READ_SCRIPT]} {
			## Note : The following executes only if FC_RTL_READ_SCRIPT is not sourced
				exit
			}
        	}
        	elaborated_ndm {
			if {[file exists $INIT_DESIGN_INPUT_LIBRARY] && $INIT_DESIGN_INPUT_BLOCK_NAME != ""} {
				## Copy source library and block label defined by INIT_DESIGN_INPUT_LIBRARY and INIT_DESIGN_INPUT_BLOCK_NAME respectively.
				open_lib -read ${INIT_DESIGN_INPUT_LIBRARY}
				copy_lib -from_lib ${INIT_DESIGN_INPUT_LIBRARY} -to_lib ${DESIGN_LIBRARY} -no_design
				copy_block -from ${INIT_DESIGN_INPUT_LIBRARY}:${INIT_DESIGN_INPUT_BLOCK_NAME} -to ${DESIGN_LIBRARY}:${DESIGN_NAME}/${CURRENT_STEP}
				close_lib ${INIT_DESIGN_INPUT_LIBRARY}
				current_lib ${DESIGN_LIBRARY}
				current_block ${DESIGN_NAME}/${CURRENT_STEP}
			} else {
				puts "RM-error: RTL_SOURCE_FORMAT is set to elaborated_ndm but either INIT_DESIGN_INPUT_LIBRARY or INIT_DESIGN_INPUT_BLOCK_NAME is invalid. Please fix it before you continue."
				exit
			}
        	}
        	default {
        	        puts "RM-error: Unknown RTL_SOURCE_FORMAT(${RTL_SOURCE_FORMAT})"
        	        exit 
        	}
	} ;# switch

	## Design check manager
	if {$SET_QOR_STRATEGY_MODE == "early_design"} {
		## Automatically enable lenient policy for early_design mode 
		set_early_data_check_policy -policy lenient -if_not_exist
	} elseif {$EARLY_DATA_CHECK_POLICY != "none"} {
		## Design check manager
		set_early_data_check_policy -policy $EARLY_DATA_CHECK_POLICY -if_not_exist
	}

	save_block -as ${DESIGN_NAME}/${CURRENT_STEP}_elaborated

	rm_source -file $TCL_USER_READ_RTL_POST_SCRIPT -optional -print "TCL_USER_READ_RTL_POST_SCRIPT"

	## Assure unique module names including hierarchical integration. Must run before physical constraints applied for MV designs
	set_app_option -name design.uniquify_naming_style -value ${DESIGN_NAME}_%s_%d
	set uniquify_cmd "uniquify $UNIQUIFY_OPTIONS"
	puts "RM-info: Uniquify the Design: $uniquify_cmd"
	eval ${uniquify_cmd}

	## Design mismatch reports
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/check_design.design_mismatch {check_design -ems_database check_design.design_mismatch.ems -checks design_mismatch}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_design_mismatch {report_design_mismatch -verbose}
	redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_unbound {report_unbound}

	## DFT Ports
	rm_source -file $DFT_PORTS_FILE -optional -print "DFT_PORTS_FILE"
	rm_source -file $TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT -optional -print "TCL_USER_CREATE_DFT_PORTS_POST_SCRIPT"
	
	################################################################
	## Read and commit the UPF file(s)  
	################################################################
	if {$UPF_MODE == "golden"} {set_app_options -name mv.upf.enable_golden_upf -value true}
	if {$UPF_MODE != "none"} {
		if {[file exists [which $UPF_FILE]]} {
	      		load_upf $UPF_FILE
			## Read the supply set file
			if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
			      load_upf $UPF_UPDATE_SUPPLY_SET_FILE
			} elseif {$UPF_UPDATE_SUPPLY_SET_FILE != ""} {
			      puts "RM-error: UPF_UPDATE_SUPPLY_SET_FILE($UPF_UPDATE_SUPPLY_SET_FILE) is invalid. Please correct it."
			}
			puts "RM-info: Running commit_upf"
	      		commit_upf
		} elseif {$UPF_FILE != ""} {
	      		puts "RM-error : UPF file($UPF_FILE) is invalid. Please correct it."
		}
	}
} ;# INIT_DESIGN_INPUT == RTL

if {$INIT_DESIGN_INPUT == "ASCII" || $INIT_DESIGN_INPUT == "RTL"} {
	################################################################
	## Floorplan input from TCL_FLOORPLAN_FILE_DP (from write_floorplan) or DEF_FLOORPLAN_FILES_DP (supports multiple DEF)
	################################################################
        if {$TECHNOLOGY_NODE != "" && !$SET_TECHNOLOGY_AFTER_FLOORPLAN} {
                set_technology -node $TECHNOLOGY_NODE
        }
	####################################
	## Floorplan : from DEF 
	####################################
	## Floorplanning by reading $DEF_FLOORPLAN_FILES_DP (supports multiple DEF files)
	#  Script first checks if all the specified DEF files are valid, if not, read_def is skipped
	if {$TCL_FLOORPLAN_FILE_DP != ""} {
	        rm_source -file $TCL_FLOORPLAN_FILE_DP
	} elseif {$DEF_FLOORPLAN_FILES_DP != ""} {
	#  Script first checks if all the specified DEF files are valid, if not, read_def is skipped
	        set RM_DEF_FLOORPLAN_FILE_is_not_found FALSE
	        foreach def_file $DEF_FLOORPLAN_FILES_DP {
	                if {![file exists [which $def_file]]} {
	                        puts "RM-error : DEF floorplan file ($def_file) is invalid."
	                        set RM_DEF_FLOORPLAN_FILE_is_not_found TRUE
	                }       
	        }       
	        if {!$RM_DEF_FLOORPLAN_FILE_is_not_found} {
	                set read_def_cmd "read_def $DEF_READ_OPTIONS [list $DEF_FLOORPLAN_FILES_DP]"
	                #set read_def_cmd "read_def -add_def_only_objects $DEF_OBJECTS_TO_ADD [list $DEF_FLOORPLAN_FILES_DP]" 
	                #if {$DEF_SITE_NAME_PAIRS != ""} {lappend read_def_cmd -convert $DEF_SITE_NAME_PAIRS}
	                puts "RM-info: Creating floorplan from DEF file DEF_FLOORPLAN_FILES_DP ($DEF_FLOORPLAN_FILES_DP)"
	                puts "RM-info: $read_def_cmd"
                  eval ${read_def_cmd}
	
			if {$DEF_RESOLVE_PG_NETS} {
				redirect -var x {catch {resolve_pg_nets}} ;# workaround in case resolve_pg_nets returns warning that causes conditional to exit unexpectedly 
				puts $x
				if {[regexp ".*NDMUI-096.*" $x]} {
					puts "RM-error: UPF may have an issue. Please review and correct it."
				}
			}
	      	} else {
	      		puts "RM-error : At least one of the DEF_FLOORPLAN_FILES_DP specified is invalid. Please correct it."
	      		puts "RM-info: Skipped reading of DEF_FLOORPLAN_FILES_DP"
	      	}
	}

	if {$INIT_DESIGN_INPUT != "RTL"} {
		################################################################
		## SCANDEF  
		################################################################        
		if {[file exists [which $DEF_SCAN_FILE]]} {
		        read_def $DEF_SCAN_FILE
		} elseif {$DEF_SCAN_FILE != ""} {
		        puts "RM-error : DEF_SCAN_FILE($DEF_SCAN_FILE) is invalid. Please correct it."
		}
	}
}

################################################################
## Technology & settings  
################################################################
## Technology setup includes routing layer direction, offset, site default, and site symmetry
#  - If TECH_FILE is used, technology setup is required 
#  - If TECH_LIB is used while it does not contain the technology setup, then it is required
#  Specify your technology setup script through TCL_TECH_SETUP_FILE. RM default is init_design.tech_setup.tcl.
if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
	rm_source -file $TCL_TECH_SETUP_FILE -optional -print "TCL_TECH_SETUP_FILE"
}

## Read a file in PRF format which specifies tech/library physical rules and attributes.
if {[file exists [which $PHYSICAL_RULES_FILE]]} {
	read_physical_rules $PHYSICAL_RULES_FILE
}

if {$NETLIST2GDS_FLOW} {
	################################################################
	## connect_pg_net
	################################################################
	if {![rm_source -file $TCL_USER_CONNECT_PG_NET_SCRIPT -optional -print "TCL_USER_CONNECT_PG_NET_SCRIPT"]} {
	## Note : the following executes only if TCL_USER_CONNECT_PG_NET_SCRIPT is not sourced
		connect_pg_net
        	# For non-MV designs with more than one PG, you should use connect_pg_net in manual mode.
	}
}


########################################################################
## Timing and design constraints	
########################################################################
## Parasitics
if {$PARASITIC_TECH_LIB == "" } {
	## Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
	## Refer to examples/TCL_PARASITIC_SETUP_FILE.tcl for sample commands
	## This is only sourced if PARASITIC_TECH_LIB is not specified  
	rm_source -file $TCL_PARASITIC_SETUP_FILE -optional -print "TCL_PARASITIC_SETUP_FILE"
}

## MCMM
#  Two examples are provided: 
#  - examples/TCL_MCMM_SETUP_FILE.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
#    and scenarios; source mode, corner, and scenario constraints, respectively 
#  - examples/TCL_MCMM_SETUP_FILE.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
#    and scenarios; source scenario constraints which are then expanded to associated modes and corners
rm_source -file $TCL_MCMM_SETUP_FILE -optional -print "TCL_MCMM_SETUP_FILE"

## Design constrains (such as dont_touch, size_only, clock-gating settings)
rm_source -file $TCL_CONSTRAINTS_SETUP_FILE -optional -print "TCL_CONSTRAINTS_SETUP_FILE"

########################################################################
## Additional constraints
########################################################################
## Placement spacing labels, spacing rules, and abutment rules 
if {$TCL_PLACEMENT_CONSTRAINT_FILE_LIST != ""} {
  foreach file $TCL_PLACEMENT_CONSTRAINT_FILE_LIST {
    rm_source -file $file
  }
}

## Set min/max routing layers.
if {$MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
if {$MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}

if {$INIT_DESIGN_INPUT != "RTL"} {
	## Remove all propagated clocks
	set cur_mode [current_mode]
	foreach_in_collection mode [all_modes] {
		current_mode $mode
	        remove_propagated_clocks [all_clocks]
		remove_propagated_clocks [get_ports]
		remove_propagated_clocks [get_pins -hierarchical]
	}
	current_mode $cur_mode
}

## Clock NDR
## Specify TCL_CTS_NDR_RULE_FILE with your script to create and associate your clock NDR rules.
## RM default is ./examples/cts_ndr.tcl which is an RM provided example. Refer to the script for setup and details.
## You need to also specify CTS_NDR_RULE_NAME, CTS_INTERNAL_NDR_RULE_NAME, or CTS_LEAF_NDR_RULE_NAME for it to take effect.
rm_source -file $TCL_CTS_NDR_RULE_FILE -optional -print "TCL_CTS_NDR_RULE_FILE"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_routing_rules {report_routing_rules -verbose}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_clock_routing_rules {report_clock_routing_rules}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_clock_settings {report_clock_settings}

## Lib cell usage restrictions (set_lib_cell_purpose)
## By default, RM sources set_lib_cell_purpose.tcl for dont use, tie cell, hold fixing, CTS and CTS-exclusive cell restrictions. 
## For advanced nodes, set_lib_cell_purpose.tcl sources node specific dont use sidefile for the corresponding node.
## You can replace it with your own script by specifying the TCL_LIB_CELL_PURPOSE_FILE variable.  
rm_source -file $TCL_LIB_CELL_PURPOSE_FILE -optional -print "TCL_LIB_CELL_PURPOSE_FILE"

## Refer to examples/init_design.additional_setup.tcl for additional examples on group_path, set_clock_gating_check, and set_power_derate

####################################
## Post-init_design customizations
####################################
rm_source -file $TCL_USER_INIT_DESIGN_DP_POST_SCRIPT -optional -print "TCL_USER_INIT_DESIGN_DP_POST_SCRIPT"

if {$UPF_MODE == "golden"} {
	save_upf ${OUTPUTS_DIR}/${CURRENT_STEP}.supplemental.upf
} else {
	save_upf ${OUTPUTS_DIR}/${CURRENT_STEP}.save_upf
}

save_block
save_block -as ${DESIGN_NAME}/${CURRENT_STEP}

redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/run_end.rpt {run_end}

write_qor_data -report_list "performance host_machine report_app_options" -label $REPORT_PREFIX -output $WRITE_QOR_DATA_DIR

report_msg -summary
print_message_info -ids * -summary
echo [date] > init_design_dp
exit
