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
## Script: incremental_design_setup.tcl
## Version: U-2022.12-SP4
## Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
###########################################################################################

set INIT_DESIGN_INPUT           "ASCII" ;# Specify one of the 3 options: ASCII | DC_ASCII | NDM; default is ASCII.
                                ;# 1.ASCII: assumes all design input files are ASCII and will read them in individually.
                                ;# 2.NDM: specify your own floorplanned NDM path and skip the design creation steps (read_verilog, load_upf, read_def etc);
                                ;#   script opens $DESIGN_LIBRARY and copies over INIT_DESIGN_INPUT_BLOCK as $DESIGN_NAME/$INIT_DESIGN_BLOCK_NAME to start with;
                                ;#   INIT_DESIGN_INPUT_BLOCK_NAME is required


##################################################
### Verilog, dc inputs, upf, mcmm, timing, etc 
##################################################
set VERILOG_NETLIST_FILES       ""      ;# Verilog netlist files;
                                        ;#      for PNR: required if INIT_DESIGN_INPUT is set to ASCII; not required for DC_ASCII or NDM

set UPF_FILE                    ""      ;# A UPF file
                                        ;#      for PNR: required if INIT_DESIGN_INPUT is set to ASCII; not required for DC_ASCII or NDM
set UPF_SUPPLEMENTAL_FILE       ""      ;# The supplemental UPF file. Only needed if you are running golden UPF flow, in which case, you need both UPF_FILE and this.
                                        ;#      for PNR: required if INIT_DESIGN_INPUT is set to ASCII; not required for DC_ASCII or NDM
                                        ;#          If UPF_SUPPLEMENTAL_FILE is specified, scripts assume golden UPF flow. load_upf and save_upf commands will be different.
set UPF_UPDATE_SUPPLY_SET_FILE  ""      ;# A UPF file to resolve UPF supply sets

set TCL_MCMM_SETUP_FILE         ""      ;# Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
                                        ;# two examples are provided : 
                                        ;# examples/TCL_MCMM_SETUP_FILE.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
                                        ;# and scenarios; source mode, corner, and scenario constraints, respectively 
                                        ;# examples/TCL_MCMM_SETUP_FILE.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
                                        ;# and scenarios; source scenario constraints which are then expanded to associated modes and corners
                                        ;#      for PNR: required if INIT_DESIGN_INPUT is set to ASCII; not required for DC_ASCII or NDM
set TCL_PARASITIC_SETUP_FILE    ""      ;# Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
                                        ;# refer to the example in examples/TCL_PARASITIC_SETUP_FILE.tcl

########################################################################################## 
### Variables for pre and post plugins 
##  Placeholder plugin scripts are available in the rm_user_plugin_scripts directory. Use of the placeholder scripts is not required. Path to the plugin scripts can be updated as needed. 
###########################################################################################
set TCL_USER_NON_PERSISTENT_SCRIPT      "non_persistent_script.tcl" ;# An optional Tcl file to be sourced in each step after opening a block.
set TCL_USER_INIT_DESIGN_PRE_SCRIPT     "init_design_pre_script.tcl" ;# An optional Tcl file to be sourced at the very beginning of init_design.tcl.
set TCL_USER_INIT_DESIGN_POST_SCRIPT    "init_design_post_script.tcl" ;# An optional Tcl file to be sourced at the very end of init_design.tcl before save_block.

##################################################
### 4. DEF, floorplan, placement constraints, etc 
##################################################
set TCL_FLOORPLAN_FILE                  "" ;# Optional; Tcl floorplan file written by the write_floorplan command; for example, floorplan/floorplan.tcl;
                                        ;# TCL_FLOORPLAN_FILE and DEF_FLOORPLAN_FILES are mutually exclusive; please specify only one of them;
                                        ;# Not effective if INIT_DESIGN_INPUT = DC_ASCII or NDM.
                                        ;# The write_floorplan command writes a floorplan.tcl Tcl script and a floorplan.def DEF file;
                                        ;# reading floorplan.tcl alone can restore the entire floorplan - refer to write_floorplan man for more details

set DEF_FLOORPLAN_FILES                 "" ;# Optional; DEF files which contain the floorplan information; for ex: "1.def 2.def"; not required for DP
                                        ;#      for PNR: required if INIT_DESIGN_INPUT is set to ASCII and neither TCL_FLOORPLAN_FILE or 
                                        ;#               initialize_floorplan is used; DEF_FLOORPLAN_FILES and TCL_FLOORPLAN_FILE are mutually exclusive;
                                        ;#               not required if INIT_DESIGN_INPUT = DC_ASCII or NDM
set DEF_READ_OPTIONS                    "-add_def_only_objects all" ;# default is "-add_def_only_objects all"; set it to "" (empty) if you don't need any option
                                        ;# specifies the options used by read_def command
set TCL_ADDITIONAL_FLOORPLAN_FILE       "" ;# a supplementary Tcl constraint file; sourced after TCL_FLOORPLAN_FILE or DEF_FLOORPLAN_FILE is read; 
                                        ;# can be used to cover additional floorplan constructs,such as bounds, pin guides, or route guides, etc

set DEF_SCAN_FILE                       "" ;# Optional; A scan DEF file for scan chain information;
                                           ;# for PNR: not required if INIT_DESIGN_INPUT = DC_ASCII or NDM, as SCANDEF is expected to be loaded already   

set TCL_FLOORPLAN_RULE_SCRIPT           "" ;# Specify your floorplan rule file (which contains set_floorplan_*_rules commands) or a script to generate such rules;
                                        ;# if specified, will be sourced in init_design.tcl for check_floorplan_rules and for some nodes, it will be sourced by sidefiles

set TCL_USER_SPARE_CELL_PRE_SCRIPT      "" ;# An optional Tcl file for spare cell insertion to be sourced before place_opt;
                                        ;# Example : examples/TCL_USER_SPARE_CELL_PRE_SCRIPT.tcl
set TCL_USER_SPARE_CELL_POST_SCRIPT     "" ;# An optional Tcl file for spare cell insertion to be sourced after place_opt;
                                        ;# Example : examples/TCL_USER_SPARE_CELL_POST_SCRIPT.tcl
