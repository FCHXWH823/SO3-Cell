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
# Script: promote_abstract_clock_data_script.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

switch $REPORT_PREFIX {
  compile {
    ## Populate to your needs.
  }
  clock_opt_cts {
    ## Promote  clock tree exceptions from blocks to the top
    promote_clock_data -auto_clock connected -balance_points
    ## Uncomment the following lines when using CCD-done blocks
    #  The following command promotes the median latency information from the blocks (stored during compute_clock_latency at block-level) as balance points on the clock pins
    #  set_block_to_top_map -auto_clock connected -report_only ; # resolve any warnings/ errors reported by this command
    #  promote_clock_data -port_latency -auto_clock connected
  }
  clock_opt_opto {
    ## Populate to your needs.
  }
  default {
    puts "RM-info: No clock data promotion from this step."
  }
}
