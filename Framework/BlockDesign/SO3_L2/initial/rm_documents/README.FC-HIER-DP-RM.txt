###############################################################################
# Synopsys(R) Fusion Compiler Hierarchical Design Planning Reference Methodology
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
###############################################################################

Overview 
========
A reference methodology provides a set of reference scripts that serve as a good
starting point for running a tool. These scripts are not designed to run in their
current form. You should use them as a reference and adapt them for use in your
design environment.
 
This RM script package contains scripts to perform the Fusion Compiler Hierarchical Synthesis
Design Planning flow.  This flow takes in RTL files as primary input. 

Note: To run the traditional hierarchical DP flow, download IC Compiler II RM and run Makefile_dp_hier_fc_traditional.

Instructions for Using the Fusion Compiler Hierarchical Synthesis Design Planning RM
====================================================================================
Hierarchical Synthesis Flow ( with RTL input netlist ) :

        To execute the FC Hierarchical Synthesis Design Planning flow , use the following Makefile command :

        % make -f rm_setup/Makefile_dp_hier all

	This flow performs the following steps:
	a) analyze and elaborate full chip RTL netlist 
	b) splits the constraints 
	c) commits the block 
	d) compile_fusion -to logic_opto on block netlist 
	e) compile_fusion -to initial_map on top-level netlist
	f) with above top-level initial_map netlist , run DP flow upto pin placement  
	g) Logic optimization of top-level netlist ( compile_fusion logic_opto ) to provide better netlist for Budgeting . 
        h) estimates timing and generates boundary timing for top and sub-blocks

	In this flow , if floorplan data is provided ( core_area , macro and pin location etc ) , it will skip some of redundant steps above.


Flow Steps
==========
The Fusion Compiler Hierarchical Synthesis Design Planning Reference Methodology flow includes the following steps (see the makefile: rm_setup/Makefile_dp_hier):

The following list includes the default steps with brief descriptions:
* init_dp
	- Analyze and elaborate the RTL and other design inputs
	- Top Chip-level SDC and UPF files are partitioned into top-level and block-level files.

* commit_blocks
	- Blocks are committed to physical hierarchy.
	- Load top and block constraints.

* init_compile
	- Block level logic_opto implementation . Reads block-level SDC,UPF from
	  split_constraints step and blocks are logic optimized

* create_floorplan
        - initialize_floorplan
	- Creates placement abstracts for each block.
	- Place I/O drivers in the design (chip level).
	- Place top-level ports of design (hier block).

* shaping
	- Shapes and places physical blocks (including power domains
          and voltage areas).

* placement
	- Performs global macro and standard cell placement.

* create_power
	- Inserts the power and ground structures for the design and
          pushes these structures into the blocks.

* clock_trunk_planning (optional)
	- Performs block and top-level clock trunk synthesis.

* place_pins
	- Performs global routing of the interface nets and block pin
          assignment.

* top_compile
	-  Performs top level logic optimization for better netlist input 
	   to pre_timing

* timing_budget
	- Performs estimated timing on the blocks and create 
	  optimized abstracts used for top level optimization.
	- Performs virtual optimization of the block and top paths.
	- Creates timing budgets for blocks.

* write_data_dp
	- Writes hierarchical design data including netlist,
          power/ground netlist, Synopsys Design Constraints (SDC), and UPF.

* all
	- Performs all of the above steps.


Files Included with the Fusion Compiler Hierarchical Synthesis Design Planning RM
=============================================================
* rm_setup/Makefile_dp_hier
* rm_setup/icc2_dp_setup.tcl
* rm_setup/design_setup.tcl
* rm_fc_dp_hier_scripts/init_dp.tcl
* rm_fc_dp_hier_scripts/commit_blocks.tcl
* rm_fc_dp_hier_scripts/init_compile.tcl
* rm_fc_dp_hier_scripts/create_floorplan.tcl
* rm_fc_dp_hier_scripts/shaping.tcl
* rm_fc_dp_hier_scripts/placement.tcl
* rm_fc_dp_hier_scripts/create_power.tcl
* rm_fc_dp_hier_scripts/clock_trunk_planning.tcl
* rm_fc_dp_hier_scripts/place_pins.tcl
* rm_fc_dp_hier_scripts/top_compile.tcl
* rm_fc_dp_hier_scripts/timing_budget.tcl
* rm_fc_scripts/write_data.tcl
