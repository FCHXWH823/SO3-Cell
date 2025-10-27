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
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

lappend search_path .
lappend search_path ./rm_tech_scripts 
lappend search_path ./rm_tech_scripts/rm_fm_scripts
lappend search_path ./rm_user_plugin_scripts 
lappend search_path ./rm_setup 
lappend search_path ./rm_fm_scripts 
lappend search_path ./rm_fc_scripts 
foreach path $SUPPLEMENTAL_SEARCH_PATH {
  set search_path "$path $search_path"
}

set_host_options -max_cores $FM_MAX_CORES

set sh_continue_on_error true

if {![file exists $OUTPUTS_DIR]} {file mkdir $OUTPUTS_DIR} ;# do not change this line or directory may not be created properly
if {![file exists $REPORTS_DIR]} {file mkdir $REPORTS_DIR} ;# do not change this line or directory may not be created properly

puts "RM-info: Hostname: [sh hostname]"; puts "RM-info: Date: [date]"; puts "RM-info: PID: [pid]"; puts "RM-info: PWD: [pwd]"

