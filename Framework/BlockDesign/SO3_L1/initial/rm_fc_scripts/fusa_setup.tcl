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
# Script: fusa_setup.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

## Load the SSF File
load_ssf $FUSA_SSF_FILE 

## Load physical updates for the SSF File
if { $FUSA_SSF_UPDATE_FILE != "" } {
	load_ssf $FUSA_SSF_UPDATE_FILE 
}

## Load the Auxilliary SSF from Spyglass FuSa
if { $FUSA_SSF_AUX_FILE != "" } {
	load_ssf $FUSA_SSF_AUX_FILE
}


##########################################################################################
## Safety Register Setup
##########################################################################################
## Required app options for Safety Registers and DCLS
if {[sizeof_collection [get_safety_register_rules -quiet]]} {
        
	## Ensure TAP cells are placed abutted either side of safety registers, default is shared
  	set_app_options -name place.legalize.enable_safety_register_groups_dual_taps -value true

}
# ----------------------------------------------------------
#
# DCLS Setup
#
# ----------------------------------------------------------
if {[sizeof_collection [get_safety_core_groups -quiet]]} {

  puts "RM-info: Safety Cores are defined"
  
  # ----------------------------------------------------------
  # Recommended
  # ----------------------------------------------------------
  # turn off spare cell placement, not taking DCLS placement into account
  set_app_options -name  place.coarse.enable_spare_cell_placement -value false

  # turn off PSE re-clustering, not taking DCLS placement into account
  set_app_options -name opt.dft.disable_fe_pse_reclustering -value true

  # ----------------------------------------------------------
  # Required placement app options for DCLS FuSa flow
  # ----------------------------------------------------------
  # Improve DCLS core placement separation
  set_app_options -name place.coarse.grp_rep_gbs_use_slow_snaps -value true 
  set_app_options -name place.coarse.grp_rep_gbs_start_stronger -value true
  
  # fix issue where cells of cores were being placed over macros   
  set_app_options -name place.coarse.grp_rep_gbs_aware_blockage_shove  -value true
  
  # new auto bounds feature
  set_app_options -name place.coarse.grp_rep_gbs_add_move_bounds -value true

  # ----------------------------------------------------------
  # Stop DFT port punching through cores
  # ----------------------------------------------------------
  # create separate partion for Safety Cores
  # provided DFT Codecs are defined in each core hierarchys
  if { $FUSA_ENABLE_DCLS_SCAN_PROTECTION } {
    puts "RM-info: Enabling DCLS Scan Protection"
    set cores [get_attribute -objects [get_safety_core_groups] -name safety_cores]
    set i 0
    foreach_in_collection core $cores {
      set coreName [get_object_name $core]
      puts "Defining DFT Partition for Safety Core $coreName"
      define_dft_partition partition_${i} -include $coreName
      incr i
    }
  }

  # ----------------------------------------------------------
  # Split the DCLS clock nets
  #   also performs freeze ports on core clocks
  # ----------------------------------------------------------
  if { ($FUSA_CLOCK_SPLIT_BUF != "") && ($FUSA_CLOCK_SPLIT_INV != "") } {
    puts "RM-info: Performing DCLS clock Splitting"
    set splitPins [get_attribute -objects [get_safety_core_groups] -name split_pins]
    insert_redundant_trees \
    -safety_core_groups [get_safety_core_groups] \
    -buffer_lib_cell $FUSA_CLOCK_SPLIT_BUF \
    -inverter_lib_cell $FUSA_CLOCK_SPLIT_INV \
    -pins $splitPins
  }


  redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_safety_core_groups {report_safety_core_groups}
}

# ----------------------------------------------------------
#
# FuSa Flow Sign In Check
#
# ----------------------------------------------------------
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}/report_safety_status.check_setup {report_safety_status -check_setup}

