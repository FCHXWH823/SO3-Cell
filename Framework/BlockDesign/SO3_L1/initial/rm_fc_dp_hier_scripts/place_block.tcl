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

#set_app_options -list {shell.common.monitor_cpu_memory true} ;
set_app_options -list {shell.dc_compatibility.return_tcl_errors false} ;
set_host_options -max_cores $DP_MAX_CORES_BLOCKS ;

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
puts "RM-info: Running block placement for $block_libfilename:$block_refname ($PLACEMENT_STYLE mode) ..."

## Non-persistent settings to be applied in each step (optional)
rm_source -file $TCL_USER_NON_PERSISTENT_SCRIPT -optional -print "TCL_USER_NON_PERSISTENT_SCRIPT"

#--------------------------------------------------------------------------------------------------------------------------------#
set_app_options -name {plan.macro.style} -value $PLACEMENT_STYLE
set_macro_constraints -style $MACRO_CONSTRAINT_STYLE [get_cells -hierarchical -filter "is_hard_macro==true"]

#--------------------------------------------------------------------------------------------------------------------------------#
create_placement -floorplan ;

#--------------------------------------------------------------------------------------------------------------------------------#
create_frame -block_all $MAX_ROUTING_LAYER ; 
create_abstract ;

save_lib -all ;

if { !$top } {
   close_lib ;
}
