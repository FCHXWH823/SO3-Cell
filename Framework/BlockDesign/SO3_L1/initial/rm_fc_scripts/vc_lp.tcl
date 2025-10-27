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

#################################################################################
# Tool: Verification Compiler Low Power Static Signoff Script 
# Script: vclp.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
#################################################################################

## Enable the default behavior of sh_continue_on_error to be same as DC
set_app_var sh_continue_on_error true
set_app_var handle_hanging_crossover true
set_app_var enable_local_policy_match true
set_app_var upf_iso_filter_elements_with_applies_to ENABLE
set_app_var enable_multi_driver_analysis true
set_app_var implicit_scmr_pins true
set_app_var enable_verdi_debug true

source ./rm_utilities/procs_global.tcl 
source ./rm_utilities/procs_fc.tcl 
rm_source -file ./rm_setup/design_setup.tcl
rm_source -file ./rm_setup/fc_setup.tcl
rm_source -file ./rm_setup/header_fc.tcl

rm_source -file $TCL_USER_LIBRARY_SETUP_SCRIPT -optional -print "TCL_USER_LIBRARY_SETUP_SCRIPT"

set_app_var link_library $LINK_LIBRARY

read_file -netlist -top $DESIGN_NAME ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.vc_lp.v.gz

## Read UPF
if {$UPF_MODE == "golden"} {
	## For golden UPF flow
	read_upf $UPF_FILE -supplemental $OUTPUTS_DIR/${WRITE_DATA_BLOCK_NAME}.supplement.upf -strict_check false
} else {
	## For UPF prime flow
	read_upf $OUTPUTS_DIR/${WRITE_DATA_BLOCK_NAME}.upf
}

check_lp -stage upf
check_lp -stage design
check_lp -stage pg

report_lp -file ${REPORTS_DIR}/${DESIGN_NAME}.vc_lp_report_violations.PGNETLIST.rpt
report_lp -verbose -file ${REPORTS_DIR}/${DESIGN_NAME}.vc_lp_report_violations.PGNETLIST.verbose.rpt

save_session -session ${OUTPUTS_DIR}/${DESIGN_NAME}

puts "RM-info: End script [info script]\n"
exit
