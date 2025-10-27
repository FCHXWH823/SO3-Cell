###############################################################################
# Synopsys(R) Fusion Compiler Reference Methodology Unpack Utility
# Version: U-2022.12-SP4
# Copyright (C) 2014-2023 Synopsys, Inc. All rights reserved.
###############################################################################

Overview
========
The Fusion Compiler RM Unpack Utility helps you to create
directories and infrastructure quickly to run the Reference Methodology on
your design. This script performs the following steps:

   * Creates a directory structure for running all blocks, with a run directory
     for the top block in the Design Planning (DP) flow, and a run directory for
     each block in the Place and Route (PnR) flow.

   * Makes a local copy of the RM scripts directory for each block run directory,
     so that you can do block-specific modifications to the scripts.

   * Sets some of the block-specific RM flow variables in that block's copy of the
     RM scripts:

     rm_setup/design_setup.tcl:
        $DESIGN_NAME                : Name of current block
        $DESIGN_STYLE               : flat | hier
        $PHYSICAL_HIERARCHY_LEVEL   : For hier designs, top | intermediate | bottom
        $RELEASE_DIR_DP             : Release directory for DP flow, sets to ../../release/dp
        $RELEASE_DIR_PNR            : Release directory for PnR flow, sets to ../../release/pnr

    rm_setup/fc_dp_setup.tcl:
        $DP_BLOCK_REFS              : All block references (design or abstract)
        $DP_INTERMEDIATE_LEVEL_BLOCK_REFS    : All block references that use design views
        $DP_FLOW                    : 'flat' or 'hier' DP flow

    rm_setup/fc_setup.tcl:
        $USE_ABSTRACTS_FOR_BLOCKS   : For hier designs, all abstract block references
        $INIT_DESIGN_INPUT          : Set to DP_RM_NDM for accepting NDM handoff from DP flow
	    $SUB_BLOCK_REFS             : List of all descendant block refs that need to be linked

  * Links the relevant Makefile from the rm_setup directory for the block into the
    run directory.  For example, ./rm_setup/Makefile is linked to ./Makefile

  * Deletes the files from the block ./rm_setup directories that are not relevant to
    that flow.  The deleted files for DP run directories are:
         Makefile
         fc_setup.tcl
    The deleted files for the PNR run directories are:
         Makefile_dp
         fc_setup.tcl

By performing these steps, the unpack utility reduces some of the effort needed
to create run directories and insert design-specific modifications to the RM
scripts. This enables you to start running your design through the RM flow quicker.

The unpack utility is completely optional; you can use the RM flow in your
preferred directory structure. There is no part of the Fusion Compiler RM flow
itself that is dependent on the run directory structure created by the
unpack utility.

Using the RM Unpack Utility
===========================
The RM Unpack Utility is a Perl script called unpack_rm_dirs.pl and is available
in the RM scripts directory. The script takes two mandatory arguments:
configuration file and installation directory as follows:

% unpack_rm_dirs.pl <config_file> <install_dir>

The first argument is a design hierarchy configuration file. This file contains
the name of every block in the design, and the hierarchical relationship between
the blocks. Hierarchy can be indicated either by tabs or single spaces. For
example, if a multi-level physical hierarchy (MPH) design has top hierarchy TOP,
a middle hierarchy MID1 which contains two bottom hierarchies BOT1_1 and BOT1_2,
and another middle hierarchy MID2 which contains two bottom hierarchies BOT2_1
and BOT2_2, then the tab-formatted configuration file would look like this:

TOP
	MID1
		BOT1_1
		BOT1_2
	MID2
		BOT2_1
		BOT2_2

Or alternately with single spaces:

TOP
 MID1
  BOT1_1
  BOT1_2
 MID2
  BOT2_1
  BOT2_2

A flat design is represented with just one line indicating the design name:

FLAT

Multiply-instantiated blocks (MIBs) are also supported. Since the hierarchy
config file uses block reference names rather than instance names, this means
that MIB block references will appear multiple times in the file. For example,
if MIB1 and MIB2 are multiply-instantiated blocks, the config file might look
like this:

CHIPTOP
	MIB1
	MIB1
	MIB1
	MIB2
	MIB2

The hierarchy configuration file can be manually created by the user to populate
run directories for both DP and PnR flows. Or, if physical hierarchy is unknown
and is being planned and created during design planning, then a hierarchy
configuration file can be used for setting up PnR runs only. The DP flow creates
and writes out a configuration file during the write_data stage. This file is
written to <dp_run_dir>/work/write_data/design_hier.cfg.

The second argument to unpack_rm_dirs.pl is an installation directory. This
directory must already exist. This is the location where unpack_rm_dirs.pl will
create run directories for each block, make local copies of the RM scripts for
each block, and populate the RM flow variables that were previously listed. If
the RM scripts directory already exists in the installation directory, then
unpack_rm_dirs.pl will give a warning that it will not overwrite the master RM
scripts, and it will proceed with installation. If the block installation
directories already exist, then unpack_rm_dirs.pl aborts.

For example, suppose the Q-2019.12-SP4 RM scripts are installed in a directory
called $projdir, and a configuration file called design_hier.cfg has been
defined using the multi-level physical hierarchy example from above. Perform the
following steps to run the unpack utility:

prompt> cd $projdir/RM_FC_Q-2019.12-SP4
prompt> unpack_rm_dirs.pl design_hier.cfg $projdir

After doing this, the following directory structure will exist under $projdir.

$projdir
   RM_FC_Q-2019.12-SP4
      rm_setup
      rm_fc_dp_scripts
      rm_fc_scripts
   dp
      TOP
         rm_setup
         rm_fc_dp_scripts
   pnr
      TOP
         rm_setup
         rm_fc_scripts
      MID1
         rm_setup
         rm_fc_scripts
      MID2
         rm_setup
         rm_fc_scripts
      BOT1_1
         rm_setup
         rm_fc_scripts
      BOT1_2
         rm_setup
         rm_fc_scripts
      BOT2_1
         rm_setup
         rm_fc_scripts
      BOT2_2
         rm_setup
         rm_fc_scripts
   release
      dp
         TOP
      pnr
         TOP
         MID1
         MID2
         BOT1_1
         BOT1_2
         BOT2_1
         BOT2_2

RM_FC_Q-2019.12-SP4 will be encountered but not overwritten. The dp and pnr block
run directories are created by the unpack script. The release directory is
shown, but is not actually created by the unpack utility. Rather, the RM flow
variable RELEASE_DIR_DP is set to ../../release/dp and the RM flow variable
RELEASE_DIR_PNR is set to ../../release/pnr. These directories do not get created
until the export Makefile target is executed.

The end result is a complete run environment under the project directory, with
the master RM scripts, a design planning run area for the top hierarchy, a
place-and-route implementation area for every physical hierarchy, all with their
own local copy of the RM scripts that can be edited for block specific settings.
The directory also contains a release area for releasing design planning data to
the place-and-route flow and another release area for releasing block
place-and-route data to the parent hierarchy.
