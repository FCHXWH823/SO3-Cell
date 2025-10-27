###############################################################################
# Synopsys(R) Fusion Compiler Reference Methodology
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
###############################################################################

Overview 
========
This RM script package contains scripts to run a full RTL to GDSII flow. You can run
from synthesis through the entire place and route flow with these scripts. 

Instructions for Using the Fusion Compiler Reference Methodology
====================================================================
To run the RTL2GDS flow for synthesis and place and route use the following Makefile command:

   % make -f rm_setup/Makefile all

You can replace "all" with any other step, such as compile, place_opt, or clock_opt_cts in 
the Makefile. To enable the unified physical synthesis flow change the UNIFIED variable to
true in the Makefile. By default it is false and runs the classic flow. 

Flow Steps
==========
The Fusion Compiler Reference Methodology flow includes the following 
default steps (see the makefile: rm_setup/Makefile):

1. init_design 
   Data preparation. Reads design inputs. Creates the design. Floorplanning. 

2. compile
   Synthesize the netlist and perform some placement and optimization

2. (Classic flow only) place_opt
   Placement and optimization in the classic flow.

3. clock_opt_cts
   Clock tree synthesis and clock routing.
   If concurrent clock and data (CCD) optimization is enabled, performs
   CCD clock tree synthesis.

4. clock_opt_opto
   Data path optimization based on propagated clock latencies and clock 
   routing patching. Performs global route based optimization and will 
   fully global-route the database. Can enable shield creation.  
   If concurrent clock and data (CCD) optimization is enabled, performs
   CCD optimization and clock routing. 

5. route_auto
   Runs track assignment and detail routing for signal nets, and 
   reshielding.

6. route_opt
   Postroute optimization.

7. chip_finish
   Decouping capacitance cell insertion, regular filler cell insertion, 
   and signal electromigration analysis and fixing.

8. icv_in_design
   Signoff design rule checking, automatic design rule fixing, and metal 
   fill creation with IC Validator In-Design.

9. (Optional) write_data
   Runs the change_names command and writes out Verilog, DEF, GDSII, OASIS, 
   UPF, UPF supplemental file, write_script, and parasitics output, with write_data.tcl

10. (Optional) eco_opt
    ECO fusion for selected metrics with eco_opt.tcl

11. (Optional) pt_eco
    Freeze-silicon or non-freeze-silicon PrimeTime ECO flow.

12. (Optional) pt_eco_incremental_1 and pt_eco_incremental_2
    pt_eco_incremental_1 initializes the Galaxy incremental ECO flow.
    pt_eco_incremental_2 runs the Galaxy incremental ECO flow.

13. (Optional) redhawk_in_design
    RedHawk Fusion flows with the
    redhawk_in_design_pnr.tcl

14. (Optional) fm_r2g
    Formality formal verification with the fm_r2g.tcl script for RTL 
    to Gate verification.

15. (Optional) fm_g2g
    Formality formal verification with the fm_g2g.tcl script for Gate
    to Gate verification.

16. (Optional) vc_lp
    Verification Compiler low-power static signoff analysis with the 
    vc_lp.tcl script.

17. (Optional) summary
    Summary report (in the table format) for all the steps across the flow,
    with summary.tcl


Files Included with the Fusion Compiler Reference Methodology
=============================================================

The rm_setup and rm_fc_scripts directory contains the flow scripts:

* rm_setup/Makefile
 Makefile for running the Fusion Compiler RTL2GDS Reference Methodolgy scripts.

* rm_setup/design_setup.tcl
 Defines variables specific to design input. These variables are shared by all 
 Fusion Compiler Reference Methodology scripts, such as TECH_FILE, 
 REFERENCE_LIBRARY, and VERILOG_NETLIST_FILE.
  
* rm_setup/fc_setup.tcl
 Defines flow variables and RTL design specific information for the RTL flow. 

* rm_fc_scripts/init_design.tcl
 Create the NDM design library, read in the RTL or gated netlist files, floorplan files,
 multivoltage power intent, timing, and physical constraints for the design.
 
* rm_fc_scripts/compile.tcl
 Perform either RTL or Gate level DFT insertion. 
  
 The script, by default, runs the unified flow where compile_fusion synthesizes the 
 netlist and performs placement and optimization. The database will be a placed, optimized, 
 and legalized design ready for clock tree synthesis. You can also select the classic flow 
 by setting the UNIFIED_FLOW tcl variable to false in the fc_setup.tcl. This runs the 
 compile_fusion to initial_opto and complete final placement and optimization with place_opt. 
 Once compile is finished, it writes out report files and the ASCII files of the design. 

* rm_fc_scripts/place_opt.tcl
 This script runs the place_opt equivalent commands and the route_global 
 command for generating the congestion map, and performs reporting. 

 The place_opt flow in place_opt.tcl is only executed in the classic flow. It finishes 
 placement and optimization after compile_fusion initial_opto in compile.tcl. For details, 
 see the place_opt.tcl script.

* rm_fc_scripts/clock_opt_cts.tcl
  This script performs clock tree synthesis, routing, and reporting. 
  If CCD_FLOW is enabled, the script performs CCD clock tree synthesis.

* rm_fc_scripts/clock_opt_opto.tcl
  This script runs the clock_opt -from final_opto command and the
  route_group -all_clock_nets command to route or patch broken nets, and reporting.
  If CCD_FLOW is enabled, the clock_opt -from final_opto command performs 
  CCD optimizations.

* rm_fc_scripts/route_auto.tcl
  This script runs the route_global command for global routing, the route_track 
  command for track assignment, and the route_detail command for detail routing 
  of signal nets. 

* rm_fc_scripts/route_opt.tcl
  This script runs three consecutive route_opt commands for postroute optimization, 
  postroute CCD, and postroute clock tree optimization. In the last route_opt run, 
  CCD and power optimizations are disabled and the size-only mode is set to
  equal_or_smaller.

* rm_fc_scripts/icv_in_design.tcl

  This script runs the IC Validator In-Design signoff_check_drc command for 
  design rule checking, the signoff_fix_drc command for automatic design rule fixing,
  and the signoff_create_metal_fill command for metal fill creation.

* rm_fc_scripts/write_data.tcl

  This script generates output files for the design. It runs the 
  write_verilog, save_upf, write_def, write_script, write_parasitics, write_gds,
  and write_gds commands.

* rm_fc_scripts/route_opt.eco_opt.tcl

  If ECO_OPT_PT_PATH (PT path) is specified, the script runs the following commands:
   - set_pt_options to set PrimeTime options
   - report_pt_options to report PrimeTime options 
   - set_starrc_options to set StarRC configurations (optional)
   - check_pt_qor to check PrimeTime timing before running the eco_opt command
   - eco_opt on specified metrics 
   - check_pt_qor afterwards to check PrimeTime timing after the eco_opt command

* rm_fc_scripts/timing_eco.tcl

  Standalone timing closure ECO script that supports either ECO fusion or a 
  pre-defined PrimeTime ECO change file. The ECO fusion supports pre-defined 
  recipes for eco_opt. Can be run before or after the chip finishing step.

* rm_fc_scripts/functional_eco.tcl

  Performs either minimum-physical-impact (MPI) or freeze silicon mode changes
  to the design. Can be run before or after the chip finishing step.
 
* rm_fc_scripts/fm_g2g.tcl
  This script runs in Formality and checks the files out of the mapped netlist of
  the compile step against the resulting Verilog netlist from the
  end of the RTL2GDS flow.

* rm_fc_scripts/fm_r2g.tcl
  Performs formal verification of the design. It checks the files before compile 
  and the resulting netlist after compile.

* rm_fc_scripts/redhawk_in_design_pnr.tcl
  This script can perform the following analyses on the power grid structure:
    - Rail Integrity Check (including the Missing Via Check)
    - Missing Via Insertion
    - Static
    - Vectorless Dynamic
    - Vector-Based Dynamic
    - Electromigration
    - Minimum Path Resistance
    - Effective Resistance
    - Power Grid Augmentation (PGA)

  Before performing any of the previous analyses, you must
  - Set the REDHAWK_* variables in rm_setup/design_setup.tcl
    and rm_setup/fc_setup.tcl.
  - Ensure that the RedHawk executable can be found by your scripts
    by setting the following variable:
    * The REDHAWK_DIR Tcl variable in rm_setup/design_setup.tcl

* For Verification Compiler low power static signoff: 
  rm_fc_scripts/vc_lp.tcl    

  This script runs in VC-LP and checks the Verilog and UPF files 
  generated by the Fusion Compiler tool with the check_lp and report_lp 
  commands. 

## Supporting scripts

* rm_fc_scripts/report_qor.tcl

  You can specify running the reporting script with the REPORT_QOR
  variable. By default, it runs the report_qor.tcl script. 

  The report_qor.tcl script is called by each of the implementation scripts
   to run the following reporting commands: 
  report_mode, report_scenarios, report_pvt, report_constraint, report_qor, 
  report_timing, analyze_design_violations, report_threshold_voltage_group, 
  report_power, report_mv_path, report_clock_qor, report_design, report_congestion 
  check_design, check_netlist, report_app_options, and report_user_units.
 
  The reports are written to the $REPORTS_DIR directory.  

* rm_fc_scripts/init_design.mcmm_example.explicit.tcl 
  init_design.mcmm_example.auto_expanded.tcl

     - init_design.mcmm_example.explicit.tcl: 
       This script creates a shared mode, two corners, and two scenarios 
       with mode, corner, and scenario constraints all explicitly provided.

     - init_design.mcmm_example.auto_expanded.tcl:
       This script creates two scenarios with scenario constraints and
       automatically expands the constraints to the associated modes and
       scenarios. 

  This script is sourced in init_design.tcl

* rm_fc_scripts/init_design_flat_design_planning_example.tcl
  This script includes examples for I/O and macro placement.
  This script is sourced in init_design.tcl

* rm_fc_scripts/init_design_std_cell_rail_example.tcl
  This script includes examples for standard cell PG rail creation.
  This script is sourced in init_design.tcl

* init_design.tech_setup.tcl
  This script includes technology-related settings, such as routing direction, 
  offset, site default, and the site symmetry list.

  If you use a technology file (TECH_FILE is defined), the init_design.tcl
  script sources the technology setup script before the read_def or
  initialize_floorplan command.

  If you use a technology library (TECH_LIB is defined), by default, the
  init_design.tcl script assumes that the technology information is already 
  loaded and does not source the technology setup script. To source the 
  technology setup script, set the TECH_LIB_INCLUDES_TECH_SETUP_INFO variable 
  to false.

* rm_fc_scripts/init_design.tech_setup.tcl
  This script includes technology-related settings, such as routing direction, 
  offset, site default, and the site symmetry list.

  If you use a technology file (TECH_FILE is defined), the init_design.tcl
  script sources the technology setup script before the read_def or
  initialize_floorplan command.

  If you use a technology library (TECH_LIB is defined), by default, the
  init_design.tcl script assumes that the technology information is already 
  loaded and does not source the technology setup script. To source the 
  technology setup script, set the TECH_LIB_INCLUDES_TECH_SETUP_INFO variable 
  to false.

* rm_fc_scripts/import_from_dp.tcl
  If the INIT_DESIGN_INPUT variable is set to DP_RM_NDM, init_design.tcl 
  accepts the design library generated by the FC-DP-RM. This script copies 
  the design library from the FC-DP-RM release area specified by the
  RELEASE_DIR_DP variable.
  This script is sourced in init_design.tcl

* rm_fc_scripts/set_lib_cell_purpose.tcl
  This script includes the following library cell purpose restrictions, and is sourced 
  by rm_fc_scripts/settings.compile.tcl and rm_fc_scripts/settings.place_opt.tcl:
  - Don't use, which is controlled by the new TCL_LIB_CELL_DONT_USE_FILE
    variable
  - Hold fixing, which is controlled by the HOLD_FIX_LIB_CELL_PATTERN_LIST
    variable
  - Clock tree synthesis, which is controlled by the 
    CTS_LIB_CELL_PATTERN_LIST variable
  - Clock tree synthesis only, which is controlled by the 
    CTS_ONLY_LIB_CELL_PATTERN_LIST variable

* rm_fc_scripts/summary.tcl
  This script is sourced when you choose the "summary" target. It generates 
  a summary report (summary.rpt) in the $REPORTS_DIR directory for all steps 
  completed in the flow. The summary data is presented in the table format.
