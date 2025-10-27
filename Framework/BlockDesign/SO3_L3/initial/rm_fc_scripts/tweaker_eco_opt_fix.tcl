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

###################################################################
###  Script Name: tweaker_cmd.tcl
###  Date : 01/07/2021
###  Time : 12:12:22
###  Parsed CMD : /remote/platform_pv1/Secure_Data_Run/google_css/24x7/niu/slowfs/pv_scratch29/24x7/nwtn/P-2019.03-SP4/optimization/PTECO-RMS/D20190820_5013452/ECO/flow_preparation/prepare/borr_shader_tile/tweaker_work/TweakerECO.config
###  Script Generator Ver. : 1.4
####################################################################
####################################################################
# script template version 0428.2020
####################################################################
set continue_on_tweaker_error true
set _parse_direction_span_length_spacing_table true
#set _avoid_power_strap_watch_endofline true
# User's Setting Begin
set apr_tool icc2
set sta_tool pt
set output_path ecoout
# User's Customer Setting
#set customize_twk_eco_setting ./customize_setting
#
set parse_var_file [glob [pwd]/../../../../*/*/eco_opt_rm_tcl_var.tcl]

if {[llength $parse_var_file] > 1 } {
  puts "RM-error: Found more than one eco_opt variable files"
} elseif {[llength $parse_var_file] == -1 } {
  puts "RM-error: No eco_opt variable file found "
} else {
  puts "RM-info : Sourcing \"[file normalize $parse_var_file]\""
  source $parse_var_file
} 

# User's Setting End
####################################################################
set slk_path_base_analysis true
suppress_message E11150 E11903 E11110 E02107 E11192
suppress_message E11105 E11903 E11902 E11191 E11207 E10108 -max 5
suppress_message E02180 -max 10
set script_path  $::env(DORADO_HOME)/etc/template/tweaker_t1/fix_timing/fix_all/
set general_path $::env(DORADO_HOME)/etc/template/general_script/
set utility_path $::env(DORADO_HOME)/etc/template/twk_utilities/
source $::env(DORADO_HOME)/etc/template/twk_utilities/special_command/script_generator/pd_twk_auto_eco.tcl
  
set auto_create_cell true
set auto_config_verilog_undeclared_module true
set _auto_config_verilog_undeclared_library_pin true
set skip_vlgin_error_modules true
set libin_read_internal_power  true
set slk_merge_twf true
set slk_ignore_twf_generated_clk true
###Need to source for lower tech node 5nm/7nm...
source /remote/us01home58/rajes/rules_lower_tech_node.tcl
#####
#
# No Filler1 Spacing Rule
set enable_no_fill1_spacing_rule false
  
set min_required_def_version 5.7
#set enable_no_filler1_spacing_rule false
  
#if { $JobMonitor } { 
#job_monitor::begin 
#}
  
set_multi_thread -auto
  
  
set netlist_physical_cells_to_be_ignored *FILLER* *DCAP*
  
### Enable FinFET Rule
### source ./FinFET_rule.tcl
  
set netlist_physical_cells_to_be_ignored *FILLER* *DCAP*

set pre_count [expr $eco_count - 1]
set saved_session_err 0
if {$pre_count > 0 } {
  set saved_session [file normalize "./../../../../eco_opt_dir_${pre_count}/tweaker_work/tweaker/tweaker_run/${output_path}/tweaker_session.db"]
  puts "RM-info : $saved_session"
  puts "RM-info : Saved Session found \"$saved_session\""
  puts "RM-info : Restoring Session"
  restore_session $saved_session
    
  ## Sourcing the variable file again to overwrite the saved values in session
  set parse_var_file [glob [pwd]/../../../../*/*/eco_opt_rm_tcl_var.tcl]

  if {[llength $parse_var_file] > 1 } {
    puts "RM-error: Found more than one eco_opt variable files"
  } elseif {[llength $parse_var_file] == -1 } {
    puts "RM-error: No eco_opt variable file found"
  } else {
    puts "RM-info : Sourcing \"[file normalize $parse_var_file]\""
    source $parse_var_file
  }

} else { 
  puts "RM-info : Input Preparation"
  
  #### Config Begin
  source ./load_design.tcl
  #### Config End 

}

#####################################################

puts "RM-info : eco_opt_types is \"$eco_opt_types\""
foreach eco_opt_type $eco_opt_types {
  switch $eco_opt_type {
    setup {
      puts "RM-info : Fixing Setup"
      set Setup 	1
      set Hold 	0
      set MaxTrans 	0
      set MaxTransClk 0
      set MaxCap 	0
    }
    hold {
      puts "RM-info : Fixing Hold"
      set Setup 	0
      set Hold 	1
      set MaxTrans 	0
      set MaxTransClk 0
      set MaxCap 	0
    }
    max_transition {
      puts "RM-info : Fixing MaxTrans"
      set Setup 	0
      set Hold 	0
      set MaxTrans 	1
      set MaxTransClk 0
      set MaxCap 	0
    }
    max_capacitance {
      puts "RM-info : Fixing MaxCap"
      set Setup 	0
      set Hold 	0
      set MaxCap 	1
      set MaxTrans 	0
      set MaxTransClk 0
    }
    default {
      puts "RM-Error : eco_opt_types is not defined. Fixing wont happen"
      ## Nothing for Now
    
    }
  }
  ##### ECO Solution Setting
  set Noise   0
  set SetupTwfECO 0
  set HoldTwfECO 	0
  set AdaptiveECO 0
  
  ##### Recovery Solution Setting
  ##set LeakagePower 	1
  set LeakagePower 	0
  set DynamicPower 	0
  set AreaRecovery 	0
  
  ##### Diagnosis Solution Setting
  set PlexorDiagnosis	0
  set JobMonitor         	0
  set CornerPruning      	0
  set HierPruning		0
  set LoadDesignOnly	0
  set MetalECO       	0	
  set HackSDF             0
  
  if { $HoldTwfECO } {
     puts "Enabling TWF Base Hold ECO"
     set slk_fix_hold_by_twf_cost true
     set slk_twf_cost_v2 true
     set slk_fix_hold_level 6
     set slk_fix_hold_high_effort_flow true
  }
  
  if { $CornerPruning } {
  extract_report
  set corner_pruning_enable_slack_scaling true   ; # default = true
  create_corner_pruning_db -setup 0.95 -hold 0.95 -auto_preserve 1 1 1 -file corner.tbl
  }
  
  
  #######################################################################
  # Create ECO Domain Begin
  
  if { $LeakagePower && !$DynamicPower } {
     set slk_leakage_power_lib $leakage_power_lib
     slkfix -create_power_eco_domain
  }
  if { !$LeakagePower && $DynamicPower } {
     set slk_dynamic_power_corner $dynamic_power_corner
     slkfix -create_whole_chip_domain
     slkdb -update_toggle_count
  }
  if { $LeakagePower && $DynamicPower } {
     set slk_leakage_power_lib $leakage_power_lib
     set slk_dynamic_power_corner $dynamic_power_corner
     slkfix -create_whole_chip_domain
     slkdb -update_toggle_count
  }
  if { $AreaRecovery } {
     slkfix -create_area_recovery_domain
  }
  if { $SetupTwfECO } { 
    slkfix -create_twf_setup_domain
  }
  
  if { $HackSDF } {
     ### NOTICE: PLEASE ALIGN "hack sdf's target slk" to "eco domain's target slk"
     set slk_hold_target_slk 0.03   ; # eco domain's target slk
     set slk_setup_target_slk 0.03  ; # eco domain's target slk
     slkfix -create_twf_hack_sdf_domain
  }
  
  if { $PlexorDiagnosis } {
     set slk_dynamic_power_corner $dynamic_power_corner
     set slk_leakage_power_lib $leakage_power_lib
     set slk_vt_cell_naming $vt_cell_naming
     ### grid system settings
     _dbg congestion_db_map_grid_on_row on
     set design_analysis_collecting_mode  center_point ; # center
     
     # "congestion_map_grid_size_by_row" must be the same as the "design_analysis_grid_height_by_row"
     set congestion_map_grid_size_by_row 5
     set design_analysis_grid_height_by_row $congestion_map_grid_size_by_row
     set slk_update_congestion_map true
     set slk_congestion_aware_threshold 0.8
     
     ### create congestion db and design analysis db
     create_congestion_db -bottom_routing_layer 2 -top_routing_layer 5
     create_design_analysis_grid_db
     
     # power_report_in -saif ${rpt_path}/toggle_to_tweaker.rpt
     # irdropin -hier_prefix AAA/BBB/CCC/top/  ${rpt_path}/ir_report_rh.rpt
     slkfix -create_whole_chip_domain
  }
  slkdc -check_slack_consistency
  
  if { $AdaptiveECO } {
    enable_adaptive_eco true
  }
  
  
  if { $LoadDesignOnly } {
    return
  }
  
  if { $PlexorDiagnosis } {
     create_congestion_db -bottom_routing_layer 2 -top_routing_layer 5
  }
  
  # ECO Begin
  # if pba mode is used, sync pba endpoint slack back to twf ###
  slkdb -update_twf_by_pba_endpoint
  
  # Extract dominate path and constraint
  if { [sizeof_collection [get_paths -all]] > 100000 } {
  # request from Tweaker team to skip 4/29/21   
  # extract_report 
  }
  
  # Create ECO Domain  End
  #######################################################################
  
  if { $Congestion_Aware_ECO } {
    set slk_congestion_aware_insertion true
  } 
  if { $On_Route_Buffer_Insertion } {
    set slk_on_route_buffer_insertion true
  }
  #### check clock as data #####
  check_clock_as_data -auto
  set slk_fix_watch_clock_as_data true
  
  # Apply drv factor
  set_drv_factor 0.8
  
  
  set TechNode [regsub {_t} $Node ""]
  set script_path  $::env(DORADO_HOME)/etc/template/tweaker_t1/fix_timing_for_$TechNode/fix_all/
  
  
  # Apply dont_use cells
  if { $dont_use_cells ne {}} {
  	set_dont_use_cell $dont_use_cells -quiet
  }
  if { $dont_touch_cells ne {}} {
  	set_dont_touch_cell $dont_touch_cells -quiet
  }
  if { $dont_touch_instance ne {}} {
  	set_dont_touch_instance $dont_touch_instance -quiet
  }
  
  if { [file exist $general_tweaker_setting_file_after_consistency]==1 } {
     source $general_tweaker_setting_file_after_consistency
  }
  
  ##### avoid space fragmentation (specify a cell name) #####
  ### set a void_space_fragmentation_by_cell { DELHVT05 }
  
  #if { $PlexorDiagnosis } {
  #   # GENERATING DESIGN ANALYSIS REPORTS
  #   plexor_diagnosis_system::generate_design_diagnosis_reports ${output_path}/report "pre"
  #} else {
  #   tweaker_diagnosis_system::generate_design_diagnosis_reports ${output_path}/report "pre"
  #}
  
  slkfix -design_list $DesignList
  set_dont_touch_assign_net false
  set slk_insert_allow_touch_assign_net true
  set_dont_touch_pin false -net -netlist_assign
  set slk_fix_si_first true
  set naming_rule ${eco_prefix}@DO_PREFIX_@DATE_@FIXTYPE_
  set slk_vt_cell_naming ${vt_cell_naming}
  dump_runtime
  
  ################################################################################
  ## Customer Preference 
  ################################################################################
  #if { [file exist $customize_twk_eco_setting]==1 } {
  #source $customize_twk_eco_setting
  #source $pd_twk_setting::output_script
  #
  #if { $JOB_MONITOR } {
  # job_monitor::finish
  #}
  #
  #return
  #}
  
  
  ##################################################################################
  ## MEtal ECO Setting
  ##################################################################################
  if { $MetalECO } {
  
  set metal_eco_mode true
  # Specify spare cells in three ways
  # 1. by given spare module
  eco -spare_module spare_module_name
  
  # 2. by given instance name pattern
  #eco -spare_inst *_spare
  
  # Specify gate array settings
  #set_gate_array -body BODY... -cell CELL...
  #set_gate_array -body DCAP* -cell GA*
  }
  
  ##################################################################################
  ## Leakage Optimization
  ##################################################################################
  if { $LeakagePower } {
  
  ## set vt cell for vt ratio result
  set slk_power_eco_swap_list_filename ./tweaker.peco.sz.list
  set slk_area_recovery_list_filename  ./tweaker.peco.del.list
  
  # Power Eco setting - VT swap
  source $script_path/../../power_eco/fix_power_eco_setting.1.tcl
  set slk_auto_sizing_rule vt
  #set slk_cell_extended_mapping_rule_regexp ${Fast2SlowRule}
  set_drv_factor 0.5
  set slk_auto_sizing_comb_logic_cell_only true
  slkfix -power_eco
  
  # Power Eco setting - Sizing down
  source $script_path/../../power_eco/fix_power_eco_setting.2.tcl
  set slk_auto_sizing_rule sizing
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  set_drv_factor 0.5
  slkfix -power_eco
  
  ## Power Eco setting - Deletion 
  source $script_path/../../power_eco/fix_power_eco_setting.deletion.tcl
  set_drv_factor 0.5
  slkfix -power_eco
  }
  
  ##################################################################################
  ## Dynamic Power Optimization
  ##################################################################################
  if { $DynamicPower } {
  
  ## set vt cell for vt ratio result
  set slk_fix_dynamic_power_swap_list_filename ./Batch_mode_tweaker.peco.rpt  ; # For Batch mode internal power    
  set slk_power_eco_swap_list_filename ./tweaker.peco.sz.list
  set slk_area_recovery_list_filename  ./tweaker.peco.del.list
  set slk_fix_dynamic_power_threshold 0.1         ; # 10 %
  
  
  ################################################
  # Internal Power ECO - Sizing for comb. cells
  ################################################
  source $script_path/../../dynamic_power/fix_internal_power_batch_mode_eco_setting.1.tcl
  set slk_auto_sizing_rule sizing       
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  slkfix -dynamic_power_eco
  
  ################################################
  # Final stage Internal Power ECO - VT+Sizing for comb. cells
  ################################################
  source $script_path/../../dynamic_power/fix_internal_power_eco_setting.1.tcl
  set slk_auto_sizing_rule vt_sizing    
  set slk_auto_sizing_rule sizing
  # set slk_cell_extended_mapping_rule_regexp { @S[0-9]+[LSH]VT  @S[0-9]+[LSH]VT }
  set slk_fix_dynamic_power_threshold 0.05 ; #Suggest set 5% ~ 10%
  slkfix -dynamic_power_eco
  set slk_fix_dynamic_power_threshold 0.1
  
  ################################################
  # Internal Power ECO - VT-swap & channel-length-swap for seq. cells
  ################################################
  source $script_path/../../dynamic_power/fix_internal_power_batch_mode_eco_setting.2.tcl
  set slk_auto_sizing_rule vt
  set slk_cell_extended_mapping_rule_regexp ${Fast2SlowRule}
  slkfix -dynamic_power_eco
  
  ################################################
  # Internal Power ECO - Deletion 
  ################################################
  source $script_path/../../dynamic_power/fix_internal_power_eco_setting.deletion.tcl
  set_drv_factor 0.6
  slkfix -dynamic_power_eco
  
  ################################################
  # Switching Power ECO - VT+Sizing for comb. cells
  ################################################
  source $script_path/../../dynamic_power/fix_switching_power_eco_setting.1.tcl
  set slk_auto_sizing_rule vt_sizing    
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  set slk_fix_dynamic_power_threshold 0.05 ; #Suggest set 5% ~ 10%
  slkfix -dynamic_power_eco
  
  ################################################
  # Switching Power ECO - VT-swap & channel-length-swap for seq. cells
  ################################################
  #source $script_path/fix_switching_power_eco_setting.2.tcl
  # set slk_auto_sizing_rule vt           
  # set slk_auto_sizing_rule sizing
  #slkfix -dynamic_power_eco
  
  ################################################
  # Switching Power ECO - Moving
  ################################################
  #source $script_path/fix_switching_power_eco_setting.moving.tcl
  #slkfix -dynamic_power_eco
  
  
  }
  
  
  
  ##################################################################################
  ## Area Optimization
  ##################################################################################
  if { $AreaRecovery } {
  
  ## set vt cell for vt ratio result
  set slk_vt_cell_naming ${vt_cell_naming}
  set slk_power_eco_swap_list_filename ./tweaker.area.sz.list
  set slk_area_recovery_list_filename  ./tweaker.area.del.list
  
  ## Area Recovery - Deletion
  source $script_path/../../area_recovery/fix_area_recovery_setting.deletion.tcl
  set_drv_factor 0.6
  slkfix -area_eco
  
  # Area Recovery - Sizing down
  source $script_path/../../area_recovery/fix_area_recovery_setting.sz.tcl
  set slk_auto_sizing_rule vt_sizing
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  set_drv_factor 0.7
  slkfix -area_eco
  }
  
  
  ##################################################################################
  ## Fix max transition
  ##################################################################################
  if { $MaxTrans } {
  set slk_ignore_vt_rule_checking_for_undefined_cell true
  set _eco_tcl_enable_on_route_insertion_cmd_with_max_distance true 
  set _eco_tcl_enable_on_route_insertion_cmd true
  set _slk_add_buffer_on_route_for_drv_fix true 
  set _eco_tcl_use_routing_cut_point true
  set slk_give_up_insert_buf_distance 6
  set slk_on_route_buffer_insertion true
  set slk_force_apply_on_route_insertion true
  set _icc2_eco_tcl_use_cmd_set_cell_location true   
  set _eco_tcl_on_route_insertion_max_distance_factor 10 
  set slk_on_route_search_range 3
  set _slk_dostree_use_detail_route  true 
  set _slk_hfi_drv_reduce_insert_count true  ;#false
  set _slk_hfi_drv_balance_loading true  ;#false
  
  # 1st run Fix Max. Transition Setting with vt swap
  source $script_path/fix_max_transition_setting.vtswap.tcl
  set slk_auto_sizing_rule vt
  set slk_auto_sizing_min_improved_slack 0.999
  #set slk_cell_extended_mapping_rule_regexp ${Slow2FastRule}
  save_eco_env  DOD_ECO_ENV_FIX_TRAN_VT
  slkfix -max_trans -all
  
  # 2nd run Fix Max. Transition Setting
  source $script_path/fix_max_transition_setting.sz.tcl
  set slk_auto_sizing_rule vt_sizing
  set slk_auto_sizing_rule sizing
  set slk_auto_sizing_min_improved_slack 0.999
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  save_eco_env  DOD_ECO_ENV_FIX_TRAN_SZ
  slkfix -max_trans -all
  
  # 3rd run Fix Max. Transition Setting with insertion
  ### # 3.1 run Fix Max. Transition by high fanout tree synthesis.
  ### # By this algorithm, there is possibility to create the new module ports.
  ### # Besides, routing pattern will not be referred even slk_on_route_buffer_insertion is enabled.
  ### source $script_pathsource $script_path/fix_max_transition_setting.hfts.tcl
  ### set slk_repeater_insertion_buff_list ${RepeaterList}
  ### slkfix -max_trans -all
  
  ### # 3.2 run Fix Max. Transition Setting
  source $script_path/fix_max_transition_setting.hfs.tcl
  set slk_repeater_insertion_buff_list ${RepeaterList}
  set enable_partial_blockages false
  #set_dont_touch_pin false [get_attribute [get_lib_cells * -filter "cell_type==macro" -quiet] calling_instance->pin]
  #set_dont_use_cell [get_lib_cells * -filter "@cell_type==macro" -quiet] false
  #set_dont_touch_cell [get_lib_cells * -filter "@cell_type==macro" -quiet] false
  set slk_setup_target_slk 0.025
  set_power_switch_cell * false
  set_isolation_cell * false
  set_level_shifter_cell * false
  set_always_on_cell * false
  set slk_on_route_search_range 5
  save_eco_env  DOD_ECO_ENV_FIX_TRAN_INS
  slkfix -max_trans -all
  
  
  set slk_setup_target_slk 0.00
  
  ### # 3.3 run Fix Max. Transition Setting by inserting inverter cells
  ### source $script_path/fix_max_transition_setting.inv.tcl
  ### set slk_repeater_insertion_inverter_list { INVX4 INVX6 }
  ### save_eco_env  DOD_ECO_ENV_FIX_TRAN_INS_INV
  ### slkfix -max_trans -all
  ### set slk_hfs_inveter_only false
  ### set slk_hfs_use_inverter false
  
  ### # 3.4 run Fix Max. Transition Setting by spare cells
  ### source $script_path/fix_max_transition_setting.hfs.byspare.tcl
  ### save_eco_env  DOD_ECO_ENV_FIX_TRAN_INS_SPARE
  ### set slk_repeater_insertion_buff_list ${RepeaterList}
  ### slkfix -max_trans -all
  }
  
  ##################################################################################
  ## Fix max clock transition
  ##################################################################################
  if { $MaxTransClk } {
  set _eco_tcl_enable_on_route_insertion_cmd_with_max_distance true 
  set _eco_tcl_enable_on_route_insertion_cmd true
  set _slk_add_buffer_on_route_for_drv_fix true     
  set _eco_tcl_use_routing_cut_point true
  set slk_give_up_insert_buf_distance 6
  set slk_on_route_buffer_insertion true
  set slk_force_apply_on_route_insertion true
  set _icc2_eco_tcl_use_cmd_set_cell_location true   
  set _eco_tcl_on_route_insertion_max_distance_factor 10 
  set slk_on_route_search_range 3
  set _slk_dostree_use_detail_route true ;#false
  set _slk_hfi_drv_reduce_insert_count true  ;#false
  set _slk_hfi_drv_balance_loading true  ;#false
  
  ### # 3.2 run Fix Max. Transition Setting
  source $script_path/fix_max_transition_setting.hfs.tcl
  set slk_fix_drv_dont_touch_data true
  set slk_fix_drv_dont_touch_clock false
  set slk_repeater_insertion_clock_buff_list ${ClkRepeaterList}
  set slk_setup_target_slk 0.025
  save_eco_env  DOD_ECO_ENV_FIX_TRAN_INS
  slkfix -max_trans -all
  
  
  }
  set slk_fix_drv_dont_touch_data false 
  ##################################################################################
  ## Fix max cap
  ##################################################################################
  if { $MaxCap } {
  set _eco_tcl_enable_on_route_insertion_cmd_with_max_distance true 
  set _eco_tcl_enable_on_route_insertion_cmd true
  set _slk_add_buffer_on_route_for_drv_fix true     
  set _eco_tcl_use_routing_cut_point true
  set slk_give_up_insert_buf_distance 6
  set slk_on_route_buffer_insertion true
  set slk_force_apply_on_route_insertion true
  set _icc2_eco_tcl_use_cmd_set_cell_location true   
  set _eco_tcl_on_route_insertion_max_distance_factor 10 
  set slk_on_route_search_range 3
  #set _slk_dostree_use_detail_route true ;#false
  set _slk_hfi_drv_reduce_insert_count true  ;#false
  set _slk_hfi_drv_balance_loading true  ;#false
  
  # 1st run Fix Max. Cap. Setting
  source $script_path/fix_max_cap_setting.vtswap.tcl
  set slk_auto_sizing_rule vt
  #set slk_cell_extended_mapping_rule_regexp ${Slow2FastRule}
  save_eco_env  DOD_ECO_ENV_FIX_CAP_VT
  slkfix -max_cap -all
  
  # 2nd run Fix Max. Cap. Setting
  source $script_path/fix_max_cap_setting.sz.tcl
  
  set slk_auto_sizing_rule vt_sizing
  set slk_auto_sizing_rule sizing
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  save_eco_env  DOD_ECO_ENV_FIX_CAP_SZ
  slkfix -max_cap -all
  
  # 3rd run Fix Max. Cap. Setting
  ### # 3.1 run Fix Max. Cap. by high fanout tree synthesis.
  ### # By this algorithm, there is possibility to create the new module ports.
  ### # Besides, routing pattern will not be referred even slk_on_route_buffer_insertion is enabled.
  ### source $script_pathsource $script_path/fix_max_cap_setting.hfts.tcl
  ### set slk_repeater_insertion_buff_list ${RepeaterList}
  ### save_eco_env  DOD_ECO_ENV_FIX_CAP_INS_HFTS
  ### slkfix -max_cap -all
  
  # 3.2 run Fix Max. Cap. Setting
  source $script_path/fix_max_cap_setting.hfs.tcl
  set slk_repeater_insertion_buff_list ${RepeaterList}
  save_eco_env  DOD_ECO_ENV_FIX_CAP_INS
  slkfix -max_cap -all
  
  ### # 3.3 run Fix Max. Cap Setting by inserting inverter cells
  ### source $script_path/fix_max_cap_setting.inv.tcl
  ### set slk_repeater_insertion_inverter_list { INVX4 INVX6 }
  ### slkfix -max_cap -all
  ### set slk_hfs_inveter_only false
  ### set slk_hfs_use_inverter false
  
  ### # 3.4 run Fix Max. Cap. Setting by free space from spare cell
  ### source $script_path/fix_max_cap_setting.hfs.byspare.tcl
  ### set slk_repeater_insertion_buff_list ${RepeaterList}
  ### save_eco_env  DOD_ECO_ENV_FIX_CAP_INS_SPARE
  ### slkfix -max_cap -all
  }
  ##################################################################################
  ## Fix SI glitch
  ##################################################################################
  if { $Noise } {
  set _eco_tcl_enable_on_route_insertion_cmd_with_max_distance true 
  set _eco_tcl_enable_on_route_insertion_cmd true
  set _slk_add_buffer_on_route_for_drv_fix true     
  set _eco_tcl_use_routing_cut_point true
  set slk_give_up_insert_buf_distance 6
  set slk_on_route_buffer_insertion true
  set slk_force_apply_on_route_insertion true
  set _icc2_eco_tcl_use_cmd_set_cell_location true   
  set _eco_tcl_on_route_insertion_max_distance_factor 10 
  set slk_on_route_search_range 3
  #set _slk_dostree_use_detail_route true ;#false
  set _slk_hfi_drv_reduce_insert_count true  ;#false
  set _slk_hfi_drv_balance_loading true  ;#false
  # 1rd run Fix Si Glitch Setting 
  ### # 1.1 run Fix Si Glitch by high fanout tree synthesis.
  ### # By this algorithm, there is possibility to create the new module ports.
  ### # Besides, routing pattern will not be referred even slk_on_route_buffer_insertion is enabled.
  ### source $script_pathsource $script_path/fix_si_glitch_setting.hfts.tcl
  ### set slk_repeater_insertion_buff_list ${RepeaterList}
  ### slkfix -noise -all
  #1.1 run Fix Si Glitch setting -- vt swap
  source $script_path/fix_si_glitch_setting.vtswap.tcl
  set slk_auto_sizing_rule vt
  #set slk_cell_extended_mapping_rule_regexp ${Slow2FastRule}
  slkfix -noise -all
  
  # 1.2 run Fix Si Glitch setting -- sizing
  source $script_path/fix_si_glitch_setting.sz.tcl
  set slk_auto_sizing_rule vt_sizing
  set slk_auto_sizing_rule sizing
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  slkfix -noise -all
  
  
  ### # 1.3 run Fix Si Glitch Setting by buffer insertion
  source $script_path/fix_si_glitch_setting.hfs.tcl
  set slk_repeater_insertion_buff_list ${RepeaterList}
  save_eco_env  DOD_ECO_ENV_FIX_SI_INS
  slkfix -noise -all
  
  ### # 1.4 run Fix Si Glitch Setting by adopting spare resource.
  ### source $script_path/fix_si_glitch_setting.hfs.byspare.tcl
  ### set slk_repeater_insertion_buff_list ${RepeaterList}
  ### save_eco_env  DOD_ECO_ENV_FIX_SI_INS_SPARE
  ### slkfix -noise -all
  }
  
  ##################################################################################
  ## Fix Setup
  ##################################################################################
  if { $Setup } {
  # Apply drv factor
  #set slk_drv_factor 0.8
  set_drv_factor 0.8
  set slk_ignore_vt_rule_checking_for_undefined_cell true
  set _eco_tcl_enable_on_route_insertion_cmd_with_max_distance true 
  set _eco_tcl_enable_on_route_insertion_cmd true
  set _slk_add_buffer_on_route_for_drv_fix true     
  set _eco_tcl_use_routing_cut_point true
  set slk_give_up_insert_buf_distance 6
  set _slk_add_buffer_on_route_for_setup_fix true 
  set _slk_add_buffer_on_route_for_hold_fix false
  set slk_on_route_buffer_insertion true
  set slk_force_apply_on_route_insertion true
  set _icc2_eco_tcl_use_cmd_set_cell_location true   
  set _eco_tcl_on_route_insertion_max_distance_factor 10 
  set slk_on_route_search_range 3
  #set _slk_dostree_use_detail_route true 
  set slk_on_route_buffer_insertion true
  set slk_force_apply_on_route_insertion true
  # If user wants to reduce WNS as first priority, please set below variable "true"
  set slk_fix_setup_minimize_worst_slack true
  #set _slk_dostree_use_detail_route false 
  set _slk_hfi_drv_reduce_insert_count false
  set _slk_hfi_drv_balance_loading false
  set _slk_dostree_use_detail_route false 
  
  # 1st run Fix Setup Setting by vt swapping ( if allowed )
  source $script_path/fix_setup_setting.vtswap.tcl 
  set slk_auto_sizing_rule vt
  #set slk_cell_extended_mapping_rule_regexp ${Slow2FastRule}
  set slk_auto_sizing_min_improved_slack 0.001
  save_eco_env  DOD_ECO_ENV_FIX_SETUP_VT
  slkfix -setup -all
  
  if { $SetupTwfECO } {
    slkfix -twf_setup
  }
  
  # 2nd run Fix Setup Setting -- sizing
  source $script_path/fix_setup_setting.1.tcl
  source $script_path/fix_setup_setting.2.tcl
  source $script_path/fix_setup_setting.3.tcl
  set slk_auto_sizing_rule sizing
  set slk_auto_sizing_rule vt_sizing
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  set slk_auto_sizing_min_improved_slack 0.001
  set slk_auto_sizing_max_fanout_limit 64 
  set slk_dont_touch_def_fixed_inst false
  set slk_auto_fix_max_wire_length_limit 450
  set slk_auto_sizing_high_effort true
  set slk_fix_setup_watch_hold_timing_window false
  
  save_eco_env  DOD_ECO_ENV_FIX_SETUP_SZ_1
  if { $SetupTwfECO } {
    slkfix -twf_setup
  }
  
  slkfix -setup -all
  set slk_auto_sizing_rule function
  
  slkfix -setup -all 
  
  #Bhanu#set slk_auto_fix_fit_to_free_space false
  #Bhanu#slkfix -setup -all
  #Bhanu#set slk_auto_fix_fit_to_free_space true
  
  # 5th run Fix Setup Setting -- down sizing peer
  source $script_path/fix_setup_setting.downsz.tcl
  save_eco_env  DOD_ECO_ENV_FIX_SETUP_DOWN_SZ_PEER
  slkfix -setup -all
  
  
  # 6th run Fix Setup Setting -- bypass buffer
  source $script_path/fix_setup_setting.bypass.tcl
  save_eco_env  DOD_ECO_ENV_FIX_SETUP_BYPASS
  slkfix -setup -all
  
  set _slk_dostree_use_detail_route true 
  # 7th run Fix Setup Setting -- split load
  source $script_path/fix_setup_setting.split.tcl
  set slk_repeater_insertion_buff_list ${RepeaterList}
  set slk_fix_setup_min_improved_slack_of_repeater_insertion 0.005
  set slk_preferred_delay_cell_distance_range 1 9999
  set slk_range_for_add_dummy_load -0.002 0
  set slk_fix_setup_repeater_insertion_factor 1
  set slk_fix_setup_by_repeater_insertion_force_fixing_threshold 1
  set slk_auto_fix_max_wire_length_limit 450
  set slk_fix_setup_watch_hold_timing_window false
  save_eco_env  DOD_ECO_ENV_FIX_SETUP_SPLIT
  slkfix -setup -all
  
  set _slk_dostree_use_detail_route false 
  #restore_eco_env  DOD_ECO_ENV_FIX_SETUP_SZ_1
  #set_drv_factor 1.0
  #slkfix -setup -all
  
  # 8th run Fix Setup Setting -- split cell
  #source $script_path/fix_setup_setting.splitcell.tcl 
  #save_eco_env  DOD_ECO_ENV_FIX_SETUP_SPLITCELL
  #slkfix -setup -all
  
  ### # 9th run Fix Setup Setting -- pin swap
  ### source $script_path/fix_setup_setting.pinswap.tcl
  ### save_eco_env  DOD_ECO_ENV_FIX_SETUP_PIN_SW
  ### slkfix -setup -all
  ### set slk_fix_setup_by_pinswap false
  
  #tweaker_diagnosis_system::generate_design_diagnosis_reports ${output_path}/report "setup_blocking_check"
  }
  
  ##################################################################################
  ## Fix Hold
  ##################################################################################
  #  long wire unit r derate
  set slk_rce_long_wire_unit_r_derate 1.2
  set_drv_factor 0.8
  
  if { $Hold } {
  set _slk_hfi_drv_reduce_insert_count false
  set _slk_hfi_drv_balance_loading false
  set _slk_dostree_use_detail_route false 
  set slk_on_route_buffer_insertion true
  set _slk_add_buffer_on_route_for_hold_fix false
  
  # 1st run Fix Hold Setting -- swapping (if allowed)
  source $script_path/fix_hold_setting.vtswap.tcl
  set slk_auto_sizing_rule vt
  #set slk_cell_extended_mapping_rule_regexp ${Fast2SlowRule}
  save_eco_env  DOD_ECO_ENV_FIX_HOLD_VT
  slkfix -hold -all
  
  # 2nd run Fix Hold Setting -- sizing
  source $script_path/fix_hold_setting.sz.tcl
  set slk_auto_sizing_rule vt_sizing
  set slk_auto_sizing_rule sizing
  #set slk_cell_extended_mapping_rule_regexp ${SizingRule}
  save_eco_env  DOD_ECO_ENV_FIX_HOLD_SZ
  slkfix -hold -all
  
  # 3rd run Fix Hold Setting -- dummy load hook-ups
  source $script_path/fix_hold_setting.dmy.tcl
  set slk_dummy_load_cell_list ${DummyList}
  save_eco_env  DOD_ECO_ENV_FIX_HOLD_DMY
  slkfix -hold -all
  # 4-1 run Fix Hold Setting -- insert buffers and delay cells
  source $script_path/fix_hold_setting.bi.1.tcl
  source $script_path/fix_hold_setting.bi.2.tcl
  source $script_path/fix_hold_setting.bi.3.tcl
  set slk_delay_insertion_buff_list ${DelayList}
  save_eco_env  DOD_ECO_ENV_FIX_HOLD_INS_1
  slkfix -hold -all
  # Extract setup margin by vt swap 
  source $script_path/fix_hold_setting.extract_setup.tcl
  #set slk_cell_extended_mapping_rule_regexp ${Fast2SlowRule}
  save_eco_env  DOD_ECO_ENV_FIX_HOLD_EXTSETUP
  #slkfix -hold -all
  
  set slk_fix_hold_by_extract_setup_margin false
  set slk_fix_hold_by_extract_extra_domain_setup_margin false
  
  # 4-4 run Fix Hold Setting -- insert buffers and delay cells
  #set slk_on_route_buffer_insertion false
  source $script_path/fix_hold_setting.bi.4.tcl
  set slk_delay_insertion_buff_list ${DelayList}
  save_eco_env  DOD_ECO_ENV_FIX_HOLD_INS_4
  slkfix -hold -all
  
  #### addition loop
  source $script_path/fix_hold_setting.bi.1.tcl
  source $script_path/fix_hold_setting.bi.2.tcl
  source $script_path/fix_hold_setting.bi.3.tcl
  set slk_dont_touch_unrecognized_bus false
  set slk_fix_hold_watch_driving_pin_slack false
  set slk_setup_target_slk 0.01
  #set slk_congestion_aware_insertion false
  set slk_fix_hold_at_sink_pin_only true
  set enable_partial_blockages false
  set slk_give_up_insert_buf_distance 10
  set slk_on_route_buffer_insertion false
  set_drv_factor 0.9
  
  slkfix -hold -all
  
  source $script_path/fix_hold_setting.bi.4.tcl
  set slk_delay_insertion_buff_list ${DelayList}
  set slk_fix_hold_at_sink_pin_only true
  slkfix -hold -all
  
  set slk_setup_target_slk 0.025
  set slk_ignore_drv true
  slkfix -hold -all
  
  
  
  ### # 4-5 run Fix Hold Setting -- insert buffers and delay cells by free space from spare cell
  ### source $script_path/fix_hold_setting.bi.spare.tcl
  ### set slk_delay_insertion_buff_list ${DelayList}
  ### save_eco_env  DOD_ECO_ENV_FIX_HOLD_INS_SPARE
  ### slkfix -hold -all
  
  ### # 4-6 run Fix Hold Setting -- insert buffers and delay cells by super mode 
  ### source $script_path/fix_hold_setting.bi.super.tcl
  ### save_eco_env  DOD_ECO_ENV_FIX_HOLD_INS_SUPER
  ### set slk_delay_insertion_buff_list ${DelayList}
  ### slkfix -hold -all
  
  #tweaker_diagnosis_system::generate_design_diagnosis_reports ${output_path}/report "hold_blocking_check"
  
  }
  # ECO End 
  
  ##################################################################################
  ## Hack SDF by Hold TWF
  ##################################################################################
  if { $HackSDF } {
  source $script_path/../../hacksdf/hacksdf_by_twf/twf_hacksdf_setting.tcl
  ### NOTICE: PLEASE ALIGN "hack sdf's target slk" to "eco domain's target slk"
  set slk_hold_target_slk 0.03  ; # hack sdf's target slk
  set slk_setup_target_slk 0.03 ; # hack sdf's target slk
  slkfix -twf_hack_sdf
  sdfout -folder ./${output_path}/
  return
  }
}
##################################################################################
## Dump Output
## 1. verilogout -file "filename" dumps whole chip netlist
##    verilogout "folder_name" dumps all .v's into the specified folder. ( normally for hierarchical case )
## 2. defout dumps a partial def where only the new or moved instances will be dumped.
##    It is suggested to feed this partial def to the P&R tool before eco route.
## 3. spefout dumps eco spef for each rc corner. 
## 4. Do Pre-ECO STA before handing off the result for real P&R ECO:
##               Pre-ECO STA ==> do STA with save_sta_session + eco.tcl + eco.spef 
##################################################################################
foreach sta ${sta_tool} {
    ecotclout -${sta}                               ./${output_path}/tcl/eco.${sta}.tcl
}
foreach apr ${apr_tool} {
    ecotclout -${apr} -high_level                   ./${output_path}/tcl/eco.${apr}_high_level.tcl
    ecotclout -${apr} -low_level                    ./${output_path}/tcl/eco.${apr}_low_level.tcl
}
verilogout                                          ./${output_path}/output
defout                                       ./${output_path}/output/place
defout -route_only 	          	    ./${output_path}/output/
spefout                                             ./${output_path}/spef/eco.spef
dump_runtime
report_cell_usage
save_session                                        ./${output_path}/tweaker_session.db

set name $DesignList
global name
#source /remote/us01home58/badig/twk_hig_level_abor_comment.tcl
#if { $PlexorDiagnosis } {
#   # GENERATING DESIGN ANALYSIS REPORTS
#   plexor_diagnosis_system::generate_design_diagnosis_reports ${output_path}/report "post"
#} else {
#   tweaker_diagnosis_system::generate_design_diagnosis_reports ${output_path}/report "post"
#}

puts "\[ Warning \] Design Analyisis : Please use browser to open these two html files"
puts "\[ Warning \] [file normalize ./${output_path}/report/Pre_ECO_Report_Summary].html"
puts "\[ Warning \] [file normalize ./${output_path}/report/Post_ECO_Report_Summary].html"

puts "\[ Warning \] ECO TCL : Please use ECO TCL in below directory"
puts "\[ Warning \] [file normalize ./${output_path}/tcl/]"

#if { $JobMonitor } {
#job_monitor::finish
#}
