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


########################################################################################
# Script: "REDHAWK_MCMM_CONFIG.power_integrity.rh.rhsc.local.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

#INFO: The usage also support for both SCSM ond MCMM n GRID system 
set_scenario_status func.ss_125c  -ir_drop true
set_scenario_status func.ff_125c  -ir_drop true


create_rail_scenario -name static_func.ss_125c -scenario func.ss_125c
set_rail_scenario -name static_func.ss_125c -voltage_drop static 
#
create_rail_scenario -name dynamic_func.ss_125c -scenario func.ss_125c
set_rail_scenario -name dynamic_func.ss_125c -voltage_drop dynamic
#
create_rail_scenario -name static_func.ff_125c -scenario func.ff_125c
set_rail_scenario -name static_func.ff_125c -voltage_drop static
 
#INFO: Launch analyze_rail for MCMM Rail analysis on GRID system
#INFO: Below usage require set_host_options -submit_command { local }  
set_host_options -submit_protocol sge -submit_command { local }
#
#INFO: analyze_rail is not needed as IR Driven optimization features (IRDP/IRDCCD) will invoke it automatically
