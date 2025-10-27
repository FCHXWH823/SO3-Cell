###########################################################################
# Synopsys(R) Fusion Compiler Flat Design Planning Reference Methodology
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
####################################=######################################

Overview
========
A reference methodology provides a set of reference scripts that serve as a good
starting point for running a tool. These scripts are not designed to run in their
current form. You should use them as a reference and adapt them for use in your
design environment.

* The goal of the flat design planning flow is the generation of a complete design floorplan.
* The primary inputs to the flow are RTL files, MCMM constraints, UPF constraints, technology 
  node setup, and parasitic data.
* The flow will export a completed design floorplan.
* The exported floorplan is a primary input into the P&R flow.
* A helper file (header_from_dprm.tcl) is exported to aid in automation between the design 
  planning and P&R flows.

Features
========

* Creates the initial design library

* Performs a fast compile to establish approx standard cell area

* Establishes floorplan

* Automatic macro placement

* Physical only cell insertion (i.e. boundary cells, tap cells)

* Check and fix floorplan rules (based on pre-defined rules)

* Power insertion based on user provided PG script

* Standard cell placement to facilitate robust floorplan checks.

* Place top-level ports

* Write out the floorplan for export to P&R flow

* Write out header_from_dprm.tcl to aid in handshaking between DP & P&R flows

Notes:
1) Each of the major floorplanning operations are enabled OOTB but can be disabled
   to handle partial floorplanning (i.e. input DEF provided, etc.).
   
2) The P&R flow now performs checking of the input design floorplan.  If floorplanning
   elements are missing it will instruct the user to go back to the DP flow to add the
   missing elements.  The DP Makefile includes a "refine flow".  The flow starts with
   the create_floorplan_refine task.  The DESIGN_LIBRARY and CREATE_FLOORPLAN_FLAT_BLOCK_NAME
   variables need to be set appropriately.  The task scripts are the same as the main flow. 
   The variables CREATE_FLOORPLAN_OPERATIONS, CREATE_POWER_OPERATIONS, and PLACE_PINS_OPERATIONS 
   will need to be adjusted according to the design needs.  Below are the refine flow tasks.  
   See Makefile_dp_flat for more details.
   
   * create_floorplan_refine
   * create_power_refine
   * place_pins_refine
   * write_data_dp_refine

Instructions for Using the Fusion Compiler Flat Design Planning RM
=================================================================
To execute the Fusion Compiler Flat Design Planning flow, use the
following command:

	% make -f rm_setup/Makefile_dp_flat all_dp

	Replace "all_dp" with any other desired step in the
	Makefile_dp_flat, such as create_floorplan, create_power, etc.

Flow Steps
==========
The Fusion Compiler Flat Design Planning Reference Methodology
flow includes the following steps:
(Refer to the makefile : rm_setup/Makefile_dp_flat)

* init_design_dp
	- Read design inputs and create the inital design library.

* compile_dp
	- Performs a fast compile to establish approx standard cell area.

* create_floorplan
	- Performs the following floorplanning operations: initialize_floorplan, 
	  macro placement, boundary cell insertion, tap cell insertion.
	- All operation are enabled by default.  Operations can be enabled/disabled
	  via the RM variable "CREATE_FLOORPLAN_OPERATIONS".

* create_power
	- Performs the following floorplanning operations: power insertion, stdcell placement
	- All operation are enabled by default.  Operations can be enabled/disabled
	  via the RM variable "CREATE_POWER_OPERATIONS".

* place_pins
	- Places the design pins based on provided constraints.

* write_data
	- Writes flat design data including floorplan, netlist,
          power/ground netlist, SDC, UPF, etc.

* all_dp
	- Performs all of the above steps.

Files Included With the Fusion Compiler Flat Design Planning RM
==============================================================
* The files used in the Fusion Compiler Flat Design Planning RM are as follows:
	- rm_setup/Makefile_dp_flat
	- rm_setup/fc_dp_setup.tcl
	- rm_setup/design_setup.tcl
	- rm_fc_dp_flat_scripts/init_design_dp.tcl
	- rm_fc_dp_flat_scripts/compile_dp.tcl
	- rm_fc_dp_flat_scripts/create_floorplan.tcl
	- rm_fc_dp_flat_scripts/create_power.tcl
	- rm_fc_dp_flat_scripts/place_pins.tcl
	- rm_fc_scripts/write_data.tcl
