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
# Script: block_create_frame.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
source -echo ./rm_setup/design_setup.tcl
source -echo ./rm_setup/fc_dp_setup.tcl
source -echo ./rm_setup/header_fc_dp.tcl

#Send jobID back to parent for tracking purposes
if {[info exist env(JOB_ID)]} {
   puts "Block: $block_refname JobID: $env(JOB_ID) - START"
}

open_block -read $block_libfilename:$block_refname

# The tool creates a zero-spacing routing blockage only on the specified layer and the layers below it
# By default all layers below $MIN_ROUTING_LAYER are blocked
create_frame -block_all $MIN_ROUTING_LAYER

close_lib
puts "Block: $block_refname - FINISHED"
