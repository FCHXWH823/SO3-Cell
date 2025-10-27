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
# Script: mpc.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

## -----------------------------------------------------------------------------
## Description:
## This is a basic Minimum Physical Constraint (MPC) file for providing some
## physical guidance until a more complete floorplan exists.
## It defaults to auto floorplan but users can modify and 
## enhance the physical constraints provided.
## -----------------------------------------------------------------------------

set_app_options -name compile.auto_floorplan.enable -value true

## -----------------------------------------------------------------------------
## End of File
## -----------------------------------------------------------------------------
