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
# Script: load_block_budgets.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

#Send jobID back to parent for tracking purposes
if {[info exist env(JOB_ID)]} {
   puts "Block: $block_refname JobID: $env(JOB_ID) - START"
}

open_block $block_libfilename:$block_refname
reopen_block -edit
# This is necessary to protect against unexpected closing of the block prior to saving
save_block

if {[file exists ./block_budgets/$block_refname_no_label/top.tcl]} {
   puts "Block: $block_refname_no_label - Loading budgets"
   source -echo ./block_budgets/$block_refname_no_label/top.tcl
} else {
   puts "RM-error: No budgets loaded for block: $block_refname_no_label"
}

save_lib
close_lib
puts "Block: $block_refname - FINISHED"
