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

set_lib_cell_purpose probe/* -exclude {optimization hold cts power}
set_lib_cell_purpose */AOI222_X1_DH_P -exclude {optimization hold cts power}
set_lib_cell_purpose */AOI222_X1_DH_N -exclude {optimization hold cts power}
set_lib_cell_purpose */OAI222_X1_DH_P -exclude {optimization hold cts power}
set_lib_cell_purpose */OAI222_X1_DH_N -exclude {optimization hold cts power}
