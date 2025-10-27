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
# Script: prime_eco_opt_fix.tcl
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
##########################################################################################

## Provide debug info where fixing is not possible
set parse_var_file [glob [pwd]/*/*/eco_opt_rm_tcl_var.tcl]
if {[llength $parse_var_file] > 1 } {
  puts "RM-error: Found more than one eco_opt variable files"
} elseif {[llength $parse_var_file] == -1 } {
  puts "RM-error: No eco_opt variable file found "
} else {
  puts "RM-info : Sourcing \"[file normalize $parse_var_file]\""
  source $parse_var_file
}

if {$ECO_OPT_WITH_PBA} {
  set pba_mode "path"
} elseif {!$ECO_OPT_WITH_PBA} {
  set pba_mode "none"
} else {
  set pba_mode "exhaustive "
}

if {$ECO_OPT_PHYSICAL_MODE == ""} {
  set physical_mode "open_site"
} else {
  set physical_mode $ECO_OPT_PHYSICAL_MODE
}

foreach eco_opt_type $eco_opt_types {
  switch $eco_opt_type {
    setup {
  
      set cmd "fix_eco_timing -type setup -physical_mode $physical_mode -pba_mode $pba_mode -verbose"
      puts "RM-info: $cmd"
      eval $cmd
  
    }
    hold {
      
      if { $PRIME_ECO_HOLD_BUFFS != "" } {
        set cmd "fix_eco_timing -type hold -physical_mode $physical_mode -verbose -pba_mode $pba_mode -buffer_list [list $PRIME_ECO_HOLD_BUFFS]"
      } else {
        set cmd "fix_eco_timing -type hold -physical_mode $physical_mode -verbose -setup_margin 0 -pba_mode $pba_mode -methods {size_cell}"
      }
      puts "RM-info: $cmd"
      eval $cmd
    
    }
    max_transition {
      
      if { $PRIME_ECO_DRC_BUFFS != "" } {
        set cmd "fix_eco_drc -type max_transition -physical_mode $physical_mode -buffer_list [list $PRIME_ECO_DRC_BUFFS]"
      } else {
        set cmd "fix_eco_drc -type max_transition -physical_mode $physical_mode -methods {size_cell}"
      }
      puts "RM-info: $cmd"
      eval $cmd
    
    }
    max_capacitance {
      
      if { $PRIME_ECO_DRC_BUFFS != "" } {
        set cmd "fix_eco_drc -type max_capacitance -physical_mode $physical_mode -buffer_list [list $PRIME_ECO_DRC_BUFFS]"
      } else {
        set cmd "fix_eco_drc -type max_capacitance -physical_mode $physical_mode -methods {size_cell}"
      }
      puts "RM-info: $cmd"
      eval $cmd
    
    }
    user_defined {
      ## Sample Timing ECO
      set cmd "fix_eco_timing -type setup -path_selection_options {-pba_mode $pba_mode \
        -max_paths 10000 -nworst 10} -methods size_cell \
        -cell_type combinational -physical_mode $physical_mode -ignore_drc -verbose \
        -setup_margin 0.050"
      puts "RM-info: $cmd"
      eval $cmd
       
      set cmd "fix_eco_timing -type setup -path_selection_options {-pba_mode $pba_mode \
        -max_paths 10000 -nworst 10} -methods size_cell \
        -cell_type sequential -physical_mode $physical_mode -ignore_drc -verbose \
        -setup_margin 0.050"
      puts "RM-info: $cmd"
      eval $cmd
    }
    default {
      ## Other possible eco types (see man pages)
      ## --------------------------------------------------------------
      ##
      ## fix_eco_drc        -type  [max_transition|max_capacitance|max_fanout|noise|delta_delay|cell_em]
      ## fix_eco_power      -type  [combinational|sequential|transparent_latch|clock_network]
      ## fix_eco_timing     -type  [setup|hold]
      ##
      ## fix_eco_timing -type setup -path_selection_options {-pba_mode exhaustive \
      ##   -max_paths 10000 -nworst 10} -methods size_cell -cell_type combinational -physical_mode occupied_site -ignore_drc -verbose
      ## fix_eco_timing -type setup -path_selection_options {-pba_mode exhaustive \
      ##   -max_paths 10000 -nworst 10} -methods size_cell -cell_type sequential -physical_mode occupied_site -ignore_drc -verbose
      ## 
    }
  }
  report_global_timing > ./rpts/report_global_timing.$eco_opt_type.rpt 
}
## Optional for ASCII flows
## --------------------------------------------------------------
## write_implement_changes -format verilog -output ./work/prime_eco.v
## write_implement_changes -format def     -output ./work/prime_eco.def


##----------------------------------------------------------------------------
## End of File
##----------------------------------------------------------------------------
