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
# Script: create_fusion_reference_library.tcl
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

## Create fusion library
## FUSION_REFERENCE_LIBRARY_FRAM_LIST, FUSION_REFERENCE_LIBRARY_LOG_DIR require user inputs
if {$FUSION_REFERENCE_LIBRARY_FRAM_LIST != "" && $FUSION_REFERENCE_LIBRARY_DB_LIST != ""} {

	if {[file exists $FUSION_REFERENCE_LIBRARY_DIR]} {
		puts "RM-info: FUSION_REFERENCE_LIBRARY_DIR ($FUSION_REFERENCE_LIBRARY_DIR) is specified and exists. The directory will be overwritten." 
	}

	lc_sh {\
		source ./rm_setup/design_setup.tcl; \
		source ./rm_setup/header_fc.tcl; \
		compile_fusion_lib -frame $FUSION_REFERENCE_LIBRARY_FRAM_LIST \
		-dbs $FUSION_REFERENCE_LIBRARY_DB_LIST \
		-log_file_dir $FUSION_REFERENCE_LIBRARY_LOG_DIR \
		-output_directory $FUSION_REFERENCE_LIBRARY_DIR \
		-force
	}
} else {
	puts "RM-error: either FUSION_REFERENCE_LIBRARY_FRAM_LIST or FUSION_REFERENCE_LIBRARY_DB_LIST is not specified. Fusion library creation is skipped!"	
}

echo [date] > create_fusion_reference_library
exit
