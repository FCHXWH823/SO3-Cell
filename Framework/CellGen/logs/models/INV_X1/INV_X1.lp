\ Model transistor_placement
\ LP format - for model browsing. Use MPS format to capture full model detail.
\ Signature: 0x908ca13cfabf1703
Minimize
  3 t_c_0 + 12 ut_c_0 + 3 t_c_1 + 12 ut_c_1 + 3 t_c_2 + 12 ut_c_2
   + t_eol_c_r[0,3] + t_eol_c_r[0,2] + t_eol_c_r[0,1] + t_eol_c_r[0,0]
   + t_eol_c_r[1,3] + t_eol_c_r[1,2] + t_eol_c_r[1,1] + t_eol_c_r[1,0]
   + t_eol_c_r[2,3] + t_eol_c_r[2,2] + t_eol_c_r[2,1] + t_eol_c_r[2,0]
   + 6 ut_eol_c_r[0,7] + 6 ut_eol_c_r[0,6] + 6 ut_eol_c_r[0,5]
   + 6 ut_eol_c_r[0,4] + 6 ut_eol_c_r[1,7] + 6 ut_eol_c_r[1,6]
   + 6 ut_eol_c_r[1,5] + 6 ut_eol_c_r[1,4] + 6 ut_eol_c_r[2,7]
   + 6 ut_eol_c_r[2,6] + 6 ut_eol_c_r[2,5] + 6 ut_eol_c_r[2,4]
   + 60 v_ZN_v[0] + 60 v_ZN_v[1] + 60 v_I_v[0] + 60 v_I_v[1] + 0 l_e_1
   - p_e_r_1 - z_1_I_ZN_3_0 - z_1_I_ZN_0_3 - z_1_ZN_I_3_0 - z_1_ZN_I_0_3
   + 100 o_m_p_7 + 100 o_m_p_6 + 100 o_m_p_5 + 100 o_m_p_4
Subject To
 top_assign_orient_0_MM1: c_top_MM1_c1_o0 = 1
 top_assign_orient_1_MM1: c_top_MM1_c1_o1 = 0
 pmos_net_G_MM1_col_1_o: c_top_MM1_c1_o0 + c_top_MM1_c1_o1 - pmos_net_I_c1
   <= 0
 pmos_net_S_MM1_col_0_o0: c_top_MM1_c1_o0 - pmos_net_VDD_c0 <= 0
 pmos_net_D_MM1_col_2_o0: c_top_MM1_c1_o0 - pmos_net_ZN_c2 <= 0
 pmos_net_D_MM1_col_0_o1: c_top_MM1_c1_o1 - pmos_net_ZN_c0 <= 0
 pmos_net_S_MM1_col_2_o1: c_top_MM1_c1_o1 - pmos_net_VDD_c2 <= 0
 bot_assign_MM0: c_bot_MM0_c1_o0 + c_bot_MM0_c1_o1 = 1
 nmos_net_G_MM0_col_1_o: c_bot_MM0_c1_o0 + c_bot_MM0_c1_o1 - nmos_net_I_c1
   <= 0
 nmos_net_S_MM0_col_0_o0: c_bot_MM0_c1_o0 - nmos_net_VSS_c0 <= 0
 nmos_net_D_MM0_col_2_o0: c_bot_MM0_c1_o0 - nmos_net_ZN_c2 <= 0
 nmos_net_D_MM0_col_0_o1: c_bot_MM0_c1_o1 - nmos_net_ZN_c0 <= 0
 nmos_net_S_MM0_col_2_o1: c_bot_MM0_c1_o1 - nmos_net_VSS_c2 <= 0
 pmos_one_per_col_1: c_top_MM1_c1_o0 + c_top_MM1_c1_o1 <= 1
 dummy_assign_pmos_col_1: c_top_MM1_c1_o0 + c_top_MM1_c1_o1
   + pmos_net_dummy_c1 = 1
 avoid_different_nets_ZN_I_col_1: pmos_net_ZN_c0 + pmos_net_dummy_c1
   + pmos_net_I_c2 - nmos_net_dummy_c1 <= 2
 avoid_different_nets_ZN_VDD_col_1: pmos_net_ZN_c0 + pmos_net_dummy_c1
   + pmos_net_VDD_c2 - nmos_net_dummy_c1 <= 2
 avoid_different_nets_I_ZN_col_1: pmos_net_I_c0 + pmos_net_dummy_c1
   + pmos_net_ZN_c2 - nmos_net_dummy_c1 <= 2
 avoid_different_nets_I_VDD_col_1: pmos_net_I_c0 + pmos_net_dummy_c1
   + pmos_net_VDD_c2 - nmos_net_dummy_c1 <= 2
 avoid_different_nets_VDD_ZN_col_1: pmos_net_VDD_c0 + pmos_net_dummy_c1
   + pmos_net_ZN_c2 - nmos_net_dummy_c1 <= 2
 avoid_different_nets_VDD_I_col_1: pmos_net_VDD_c0 + pmos_net_dummy_c1
   + pmos_net_I_c2 - nmos_net_dummy_c1 <= 2
 R21: pmos_net_dummy_c0 + pmos_net_dummy_c1 <= 1
 R22: pmos_net_dummy_c1 + pmos_net_dummy_c2 <= 1
 nmos_one_per_col_1: c_bot_MM0_c1_o0 + c_bot_MM0_c1_o1 <= 1
 dummy_assign_nmos_col_1: c_bot_MM0_c1_o0 + c_bot_MM0_c1_o1
   + nmos_net_dummy_c1 = 1
 avoid_different_nets_ZN_I_col_1: - pmos_net_dummy_c1 + nmos_net_ZN_c0
   + nmos_net_dummy_c1 + nmos_net_I_c2 <= 2
 avoid_different_nets_ZN_VSS_col_1: - pmos_net_dummy_c1 + nmos_net_ZN_c0
   + nmos_net_dummy_c1 + nmos_net_VSS_c2 <= 2
 avoid_different_nets_I_ZN_col_1: - pmos_net_dummy_c1 + nmos_net_I_c0
   + nmos_net_dummy_c1 + nmos_net_ZN_c2 <= 2
 avoid_different_nets_I_VSS_col_1: - pmos_net_dummy_c1 + nmos_net_I_c0
   + nmos_net_dummy_c1 + nmos_net_VSS_c2 <= 2
 avoid_different_nets_VSS_ZN_col_1: - pmos_net_dummy_c1 + nmos_net_VSS_c0
   + nmos_net_dummy_c1 + nmos_net_ZN_c2 <= 2
 avoid_different_nets_VSS_I_col_1: - pmos_net_dummy_c1 + nmos_net_VSS_c0
   + nmos_net_dummy_c1 + nmos_net_I_c2 <= 2
 R31: nmos_net_dummy_c0 + nmos_net_dummy_c1 <= 1
 R32: nmos_net_dummy_c1 + nmos_net_dummy_c2 <= 1
 pmos_one_net_per_col_0: pmos_net_ZN_c0 + pmos_net_dummy_c0 + pmos_net_I_c0
   + pmos_net_VDD_c0 = 1
 pmos_one_net_per_col_0: nmos_net_ZN_c0 + nmos_net_dummy_c0 + nmos_net_I_c0
   + nmos_net_VSS_c0 = 1
 pmos_one_net_per_col_1: pmos_net_ZN_c1 + pmos_net_dummy_c1 + pmos_net_I_c1
   + pmos_net_VDD_c1 = 1
 pmos_one_net_per_col_1: nmos_net_ZN_c1 + nmos_net_dummy_c1 + nmos_net_I_c1
   + nmos_net_VSS_c1 = 1
 pmos_one_net_per_col_2: pmos_net_ZN_c2 + pmos_net_dummy_c2 + pmos_net_I_c2
   + pmos_net_VDD_c2 = 1
 pmos_one_net_per_col_2: nmos_net_ZN_c2 + nmos_net_dummy_c2 + nmos_net_I_c2
   + nmos_net_VSS_c2 = 1
 dummy_or_misalign_ge_dummy_1: - dummayallign_c1 + dummy_or_misalign_c1
   >= 0
 dummy_or_misalign_ge_mis_1: - misalign_c1 + dummy_or_misalign_c1 >= 0
 dummy_or_misalign_le_sum_1: - misalign_c1 - dummayallign_c1
   + dummy_or_misalign_c1 <= 0
 temp_misalign_c_rule1_dummy_c1: - pmos_net_dummy_c1 + nmos_net_dummy_c1
   + temp_misalign_net_c1 >= 0
 temp_misalign_c_rule2_dummy_c1: pmos_net_dummy_c1 - nmos_net_dummy_c1
   + temp_misalign_net_c1 >= 0
 temp_misalign_c_rule3_dummy_c1: - pmos_net_dummy_c1 - nmos_net_dummy_c1
   + temp_misalign_net_c1 <= 0
 temp_misalign_c_rule4_dummy_c1: pmos_net_dummy_c1 + nmos_net_dummy_c1
   + temp_misalign_net_c1 <= 2
 temp_misalign_c_ge_temp_misalign_net_dummy_c1: temp_misalign_c1
   - temp_misalign_net_c1 >= 0
 temp_misalign_c_rule1_I_c1: - pmos_net_I_c1 + nmos_net_I_c1
   + temp_misalign_net_c1 >= 0
 temp_misalign_c_rule2_I_c1: pmos_net_I_c1 - nmos_net_I_c1
   + temp_misalign_net_c1 >= 0
 temp_misalign_c_rule3_I_c1: - pmos_net_I_c1 - nmos_net_I_c1
   + temp_misalign_net_c1 <= 0
 temp_misalign_c_rule4_I_c1: pmos_net_I_c1 + nmos_net_I_c1
   + temp_misalign_net_c1 <= 2
 temp_misalign_c_ge_temp_misalign_net_I_c1: temp_misalign_c1
   - temp_misalign_net_c1 >= 0
 misalign_c_le_sum_mis_net_c1: misalign_c1 <= 0
 temp_misalign_c_le_sum_mis_net_c1: temp_misalign_c1 - temp_misalign_net_c1
   - temp_misalign_net_c1 <= 0
 dummyalign_c_rule1_c1: - pmos_net_dummy_c1 + dummayallign_c1 <= 0
 dummyalign_c_rule2_c1: - nmos_net_dummy_c1 + dummayallign_c1 <= 0
 dummyalign_c_rule3_c1: - pmos_net_dummy_c1 - nmos_net_dummy_c1
   + dummayallign_c1 >= -1
 misalign_col_maximum: misalign_c1 = 0
 temp_misalign_col_maximum: temp_misalign_c1 = 0
 a_net_le_pmos_ZN_col1_left: - pmos_net_ZN_c0 + a_net_ZN_col1_left <= 0
 a_net_le_sumother_ZN_col1_left: - pmos_net_ZN_c2 - nmos_net_ZN_c2
   + a_net_ZN_col1_left <= 0
 a_net_ge_sumother_ZN_col1_left: - 3 pmos_net_ZN_c0 - pmos_net_ZN_c2
   - nmos_net_ZN_c2 + 3 a_net_ZN_col1_left >= -3
 a_net_le_pmos_I_col1_left: - pmos_net_I_c0 + a_net_I_col1_left <= 0
 a_net_le_sumother_I_col1_left: - pmos_net_I_c2 + a_net_I_col1_left <= 0
 a_net_ge_sumother_I_col1_left: - 3 pmos_net_I_c0 - pmos_net_I_c2
   + 3 a_net_I_col1_left >= -3
 b_net_le_nmos_ZN_col1_left: - nmos_net_ZN_c0 + b_net_ZN_col1_left <= 0
 b_net_already_ZN_col1_left: a_net_ZN_col1_left + b_net_ZN_col1_left <= 1
 b_net_ge_sumother_ZN_col1_left: 3 pmos_net_ZN_c0 - pmos_net_ZN_c2
   - 3 nmos_net_ZN_c0 - nmos_net_ZN_c2 + 3 b_net_ZN_col1_left >= -3
 b_net_le_sumother_ZN_col1_left: - pmos_net_ZN_c2 - nmos_net_ZN_c2
   + b_net_ZN_col1_left <= 0
 b_net_le_nmos_I_col1_left: - nmos_net_I_c0 + b_net_I_col1_left <= 0
 b_net_ge_sumother_I_col1_left: - 3 nmos_net_I_c0 - nmos_net_I_c2
   + 3 b_net_I_col1_left >= -3
 b_net_le_sumother_I_col1_left: - nmos_net_I_c2 + b_net_I_col1_left <= 0
 a_net_le_pmos_ZN_col1_right: - pmos_net_ZN_c2 + a_net_ZN_col1_right <= 0
 a_net_le_sumother_ZN_col1_right: - pmos_net_ZN_c0 - nmos_net_ZN_c0
   + a_net_ZN_col1_right <= 0
 a_net_ge_sumother_ZN_col1_right: - pmos_net_ZN_c0 - 3 pmos_net_ZN_c2
   - nmos_net_ZN_c0 + 3 a_net_ZN_col1_right >= -3
 a_net_le_pmos_I_col1_right: - pmos_net_I_c2 + a_net_I_col1_right <= 0
 a_net_le_sumother_I_col1_right: - pmos_net_I_c0 + a_net_I_col1_right <= 0
 a_net_ge_sumother_I_col1_right: - pmos_net_I_c0 - 3 pmos_net_I_c2
   + 3 a_net_I_col1_right >= -3
 b_net_le_nmos_ZN_col1_right: - nmos_net_ZN_c2 + b_net_ZN_col1_right <= 0
 b_net_already_ZN_col1_right: a_net_ZN_col1_right + b_net_ZN_col1_right
   <= 1
 b_net_ge_sumother_ZN_col1_right: - pmos_net_ZN_c0 + 3 pmos_net_ZN_c2
   - nmos_net_ZN_c0 - 3 nmos_net_ZN_c2 + 3 b_net_ZN_col1_right >= -3
 b_net_le_sumother_ZN_col1_right: - pmos_net_ZN_c0 - nmos_net_ZN_c0
   + b_net_ZN_col1_right <= 0
 b_net_le_nmos_I_col1_right: - nmos_net_I_c2 + b_net_I_col1_right <= 0
 b_net_ge_sumother_I_col1_right: - nmos_net_I_c0 - 3 nmos_net_I_c2
   + 3 b_net_I_col1_right >= -3
 b_net_le_sumother_I_col1_right: - nmos_net_I_c0 + b_net_I_col1_right <= 0
 a_VSS_col1_rule1: - a_net_ZN_col1_left - a_net_I_col1_left
   + a_VSS_col1_final >= 0
 a_VSS_col1_rule2: - a_net_ZN_col1_right - a_net_I_col1_right
   + a_VSS_col1_final >= 0
 a_VSS_col1_rule3: - a_net_ZN_col1_left - a_net_I_col1_left
   - a_net_ZN_col1_right - a_net_I_col1_right + a_VSS_col1_final <= 0
 b_VSS_col1_rule1: - b_net_ZN_col1_left - b_net_I_col1_left
   + b_VSS_col1_final >= 0
 b_VSS_col1_rule2: - b_net_ZN_col1_right - b_net_I_col1_right
   + b_VSS_col1_final >= 0
 b_VSS_col1_rule3: - b_net_ZN_col1_left - b_net_I_col1_left
   - b_net_ZN_col1_right - b_net_I_col1_right + b_VSS_col1_final <= 0
 left_exist_rule1_1_ZN: left_ZN_exist_1 <= 0
 left_exist_rule2_1_ZN: 3 left_ZN_exist_1 >= 0
 right_exist_rule1_1_ZN: right_ZN_exist_1 <= 0
 right_exist_rule2_1_ZN: 3 right_ZN_exist_1 >= 0
 min_cut_rule1_1_ZN: e_net_ZN_col1 - left_ZN_exist_1 <= 0
 min_cut_rule2_1_ZN: e_net_ZN_col1 - right_ZN_exist_1 <= 0
 min_cut_rule3_1_ZN: 3 e_net_ZN_col1 - left_ZN_exist_1 - right_ZN_exist_1
   >= -1
 left_exist_rule1_1_I: left_I_exist_1 <= 0
 left_exist_rule2_1_I: 3 left_I_exist_1 >= 0
 right_exist_rule1_1_I: right_I_exist_1 <= 0
 right_exist_rule2_1_I: 3 right_I_exist_1 >= 0
 min_cut_rule1_1_I: e_net_I_col1 - left_I_exist_1 <= 0
 min_cut_rule2_1_I: e_net_I_col1 - right_I_exist_1 <= 0
 min_cut_rule3_1_I: 3 e_net_I_col1 - left_I_exist_1 - right_I_exist_1
   >= -1
 track_limit_col1: misalign_c1 + a_VSS_col1_final + b_VSS_col1_final <= 3
 track_plus_e_limit_col1: misalign_c1 + a_VSS_col1_final + b_VSS_col1_final
   + e_net_ZN_col1 + e_net_I_col1 <= 7
 root_find_ZN_pp_3: indicator_ZN_pp_3 - root_node_ZN_pp_3 >= 0
 root_find_ZN_nn_3: indicator_ZN_nn_3 - root_node_ZN_nn_3 >= 0
 root_find_ZN_ac_3: indicator_ZN_ac_3 - root_node_ZN_ac_3 >= 0
 max_indicator_find_ZN_pp_3: indicator_ZN_pp_3 - max_indicator_ZN_pp_3
   >= 0
 max_indicator_find_ZN_nn_3: indicator_ZN_nn_3 - max_indicator_ZN_nn_3
   >= 0
 max_indicator_find_ZN_ac_3: indicator_ZN_ac_3 - max_indicator_ZN_ac_3
   >= 0
 lower_bound_ZN_ac_3: - pmos_net_ZN_c0 - nmos_net_ZN_c0 + indicator_ZN_ac_3
   >= -1
 upper_bound_v1_ZN_ac_3: - pmos_net_ZN_c0 + indicator_ZN_ac_3 <= 0
 upper_bound_v2_ZN_ac_3: - nmos_net_ZN_c0 + indicator_ZN_ac_3 <= 0
 combined_net_ZN_pp_3: - pmos_net_ZN_c0 + indicator_ZN_pp_3
   + indicator_ZN_ac_3 = 0
 combined_net_ZN_nn_3: - nmos_net_ZN_c0 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 = 0
 min_indicator_constr_p_ZN_0: min_indicator_ZN + 3 indicator_ZN_pp_3 <= 3
 min_indicator_constr_n_ZN_0: min_indicator_ZN + 3 indicator_ZN_nn_3 <= 3
 min_indicator_constr_a_ZN_0: min_indicator_ZN + 3 indicator_ZN_ac_3 <= 3
 root_node_match_p_ZN_0: - min_indicator_ZN <= 0
 root_node_match_n_ZN_0: - min_indicator_ZN <= 0
 root_node_match_a_ZN_0: - min_indicator_ZN <= 0
 max_bbox_constr_p_ZN_0: max_bbox_ZN - 3 indicator_ZN_pp_3 >= -3
 max_bbox_constr_n_ZN_0: max_bbox_ZN - 3 indicator_ZN_nn_3 >= -3
 max_bbox_constr_a_ZN_0: max_bbox_ZN - 3 indicator_ZN_ac_3 >= -3
 max_indicator_match_p_ZN_0: - max_bbox_ZN - 2 max_indicator_ZN_pp_3 >= -2
 max_indicator_match_n_ZN_0: - max_bbox_ZN - 2 max_indicator_ZN_nn_3 >= -2
 max_indicator_match_a_ZN_0: - max_bbox_ZN - 2 max_indicator_ZN_ac_3 >= -2
 root_find_ZN_pp_6: indicator_ZN_pp_6 - root_node_ZN_pp_6 >= 0
 root_find_ZN_nn_6: indicator_ZN_nn_6 - root_node_ZN_nn_6 >= 0
 root_find_ZN_ac_6: indicator_ZN_ac_6 - root_node_ZN_ac_6 >= 0
 max_indicator_find_ZN_pp_6: indicator_ZN_pp_6 - max_indicator_ZN_pp_6
   >= 0
 max_indicator_find_ZN_nn_6: indicator_ZN_nn_6 - max_indicator_ZN_nn_6
   >= 0
 max_indicator_find_ZN_ac_6: indicator_ZN_ac_6 - max_indicator_ZN_ac_6
   >= 0
 lower_bound_ZN_ac_6: - pmos_net_ZN_c1 - nmos_net_ZN_c1 + indicator_ZN_ac_6
   >= -1
 upper_bound_v1_ZN_ac_6: - pmos_net_ZN_c1 + indicator_ZN_ac_6 <= 0
 upper_bound_v2_ZN_ac_6: - nmos_net_ZN_c1 + indicator_ZN_ac_6 <= 0
 combined_net_ZN_pp_6: - pmos_net_ZN_c1 + indicator_ZN_pp_6
   + indicator_ZN_ac_6 = 0
 combined_net_ZN_nn_6: - nmos_net_ZN_c1 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 = 0
 min_indicator_constr_p_ZN_1: min_indicator_ZN + 3 indicator_ZN_pp_6 <= 4
 min_indicator_constr_n_ZN_1: min_indicator_ZN + 3 indicator_ZN_nn_6 <= 4
 min_indicator_constr_a_ZN_1: min_indicator_ZN + 3 indicator_ZN_ac_6 <= 4
 root_node_match_p_ZN_1: - min_indicator_ZN + root_node_ZN_pp_6 <= 0
 root_node_match_n_ZN_1: - min_indicator_ZN + root_node_ZN_nn_6 <= 0
 root_node_match_a_ZN_1: - min_indicator_ZN + root_node_ZN_ac_6 <= 0
 max_bbox_constr_p_ZN_1: max_bbox_ZN - 3 indicator_ZN_pp_6 >= -2
 max_bbox_constr_n_ZN_1: max_bbox_ZN - 3 indicator_ZN_nn_6 >= -2
 max_bbox_constr_a_ZN_1: max_bbox_ZN - 3 indicator_ZN_ac_6 >= -2
 max_indicator_match_p_ZN_1: - max_bbox_ZN - max_indicator_ZN_pp_6 >= -2
 max_indicator_match_n_ZN_1: - max_bbox_ZN - max_indicator_ZN_nn_6 >= -2
 max_indicator_match_a_ZN_1: - max_bbox_ZN - max_indicator_ZN_ac_6 >= -2
 root_find_ZN_pp_9: indicator_ZN_pp_9 - root_node_ZN_pp_9 >= 0
 root_find_ZN_nn_9: indicator_ZN_nn_9 - root_node_ZN_nn_9 >= 0
 root_find_ZN_ac_9: indicator_ZN_ac_9 - root_node_ZN_ac_9 >= 0
 max_indicator_find_ZN_pp_9: indicator_ZN_pp_9 - max_indicator_ZN_pp_9
   >= 0
 max_indicator_find_ZN_nn_9: indicator_ZN_nn_9 - max_indicator_ZN_nn_9
   >= 0
 max_indicator_find_ZN_ac_9: indicator_ZN_ac_9 - max_indicator_ZN_ac_9
   >= 0
 lower_bound_ZN_ac_9: - pmos_net_ZN_c2 - nmos_net_ZN_c2 + indicator_ZN_ac_9
   >= -1
 upper_bound_v1_ZN_ac_9: - pmos_net_ZN_c2 + indicator_ZN_ac_9 <= 0
 upper_bound_v2_ZN_ac_9: - nmos_net_ZN_c2 + indicator_ZN_ac_9 <= 0
 combined_net_ZN_pp_9: - pmos_net_ZN_c2 + indicator_ZN_pp_9
   + indicator_ZN_ac_9 = 0
 combined_net_ZN_nn_9: - nmos_net_ZN_c2 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 = 0
 min_indicator_constr_p_ZN_2: min_indicator_ZN + 3 indicator_ZN_pp_9 <= 5
 min_indicator_constr_n_ZN_2: min_indicator_ZN + 3 indicator_ZN_nn_9 <= 5
 min_indicator_constr_a_ZN_2: min_indicator_ZN + 3 indicator_ZN_ac_9 <= 5
 root_node_match_p_ZN_2: - min_indicator_ZN + 2 root_node_ZN_pp_9 <= 0
 root_node_match_n_ZN_2: - min_indicator_ZN + 2 root_node_ZN_nn_9 <= 0
 root_node_match_a_ZN_2: - min_indicator_ZN + 2 root_node_ZN_ac_9 <= 0
 max_bbox_constr_p_ZN_2: max_bbox_ZN - 3 indicator_ZN_pp_9 >= -1
 max_bbox_constr_n_ZN_2: max_bbox_ZN - 3 indicator_ZN_nn_9 >= -1
 max_bbox_constr_a_ZN_2: max_bbox_ZN - 3 indicator_ZN_ac_9 >= -1
 max_indicator_match_p_ZN_2: - max_bbox_ZN >= -2
 max_indicator_match_n_ZN_2: - max_bbox_ZN >= -2
 max_indicator_match_a_ZN_2: - max_bbox_ZN >= -2
 one_root_node_enable_ZN: root_node_ZN_pp_3 + root_node_ZN_nn_3
   + root_node_ZN_ac_3 + root_node_ZN_pp_6 + root_node_ZN_nn_6
   + root_node_ZN_ac_6 + root_node_ZN_pp_9 + root_node_ZN_nn_9
   + root_node_ZN_ac_9 = 1
 one_max_indicator_enable_ZN: max_indicator_ZN_pp_3 + max_indicator_ZN_nn_3
   + max_indicator_ZN_ac_3 + max_indicator_ZN_pp_6 + max_indicator_ZN_nn_6
   + max_indicator_ZN_ac_6 + max_indicator_ZN_pp_9 + max_indicator_ZN_nn_9
   + max_indicator_ZN_ac_9 = 1
 y_detector_dtermine_lb_ZN_0: - indicator_ZN_pp_3 - indicator_ZN_nn_3
   - indicator_ZN_ac_3 - indicator_ZN_pp_6 - indicator_ZN_nn_6
   - indicator_ZN_ac_6 - indicator_ZN_pp_9 - indicator_ZN_nn_9
   - indicator_ZN_ac_9 + 3 io_detector_ZN >= 0
 y_detector_dtermine_ub_ZN_0: - indicator_ZN_pp_3 - indicator_ZN_nn_3
   - indicator_ZN_ac_3 - indicator_ZN_pp_6 - indicator_ZN_nn_6
   - indicator_ZN_ac_6 - indicator_ZN_pp_9 - indicator_ZN_nn_9
   - indicator_ZN_ac_9 + io_detector_ZN <= 0
 on_off_constraint_by_indicator_ZN_pv_3_pp_3_co: - indicator_ZN_pp_3
   + y_ZN_edge_connector_pv_3_pp_3_co <= 0
 on_off_constraint_by_sum_actives_ZN_pv_3_pp_3_co: - io_detector_ZN
   + y_ZN_edge_connector_pv_3_pp_3_co <= 0
 on_off_constraint_by_mixing_ZN_pv_3_pp_3_co: - indicator_ZN_pp_3
   - io_detector_ZN + y_ZN_edge_connector_pv_3_pp_3_co >= -1
 edge_flow_ub_ZN_pv_3_pp_3_ve: - y_ZN_edge_connector_pv_3_pp_3_co
   + f_ZN_edge_connector_pv_3_pp_3_co <= 0
 edge_flow_lb_ZN_pv_3_pp_3_ve: y_ZN_edge_connector_pv_3_pp_3_co
   + f_ZN_edge_connector_pv_3_pp_3_co >= 0
 on_off_constraint_by_indicator_ZN_pv_3_ac_3_co: - indicator_ZN_ac_3
   + y_ZN_edge_connector_pv_3_ac_3_co <= 0
 on_off_constraint_by_sum_actives_ZN_pv_3_ac_3_co: - io_detector_ZN
   + y_ZN_edge_connector_pv_3_ac_3_co <= 0
 on_off_constraint_by_mixing_ZN_pv_3_ac_3_co: - indicator_ZN_ac_3
   - io_detector_ZN + y_ZN_edge_connector_pv_3_ac_3_co >= -1
 edge_flow_ub_ZN_pv_3_ac_3_ve: - y_ZN_edge_connector_pv_3_ac_3_co
   + f_ZN_edge_connector_pv_3_ac_3_co <= 0
 edge_flow_lb_ZN_pv_3_ac_3_ve: y_ZN_edge_connector_pv_3_ac_3_co
   + f_ZN_edge_connector_pv_3_ac_3_co >= 0
 on_off_constraint_by_indicator_ZN_nv_3_nn_3_co: - indicator_ZN_nn_3
   + y_ZN_edge_connector_nv_3_nn_3_co <= 0
 on_off_constraint_by_sum_actives_ZN_nv_3_nn_3_co: - io_detector_ZN
   + y_ZN_edge_connector_nv_3_nn_3_co <= 0
 on_off_constraint_by_mixing_ZN_nv_3_nn_3_co: - indicator_ZN_nn_3
   - io_detector_ZN + y_ZN_edge_connector_nv_3_nn_3_co >= -1
 edge_flow_ub_ZN_nv_3_nn_3_ve: - y_ZN_edge_connector_nv_3_nn_3_co
   + f_ZN_edge_connector_nv_3_nn_3_co <= 0
 edge_flow_lb_ZN_nv_3_nn_3_ve: y_ZN_edge_connector_nv_3_nn_3_co
   + f_ZN_edge_connector_nv_3_nn_3_co >= 0
 on_off_constraint_by_indicator_ZN_nv_3_ac_3_co: - indicator_ZN_ac_3
   + y_ZN_edge_connector_nv_3_ac_3_co <= 0
 on_off_constraint_by_sum_actives_ZN_nv_3_ac_3_co: - io_detector_ZN
   + y_ZN_edge_connector_nv_3_ac_3_co <= 0
 on_off_constraint_by_mixing_ZN_nv_3_ac_3_co: - indicator_ZN_ac_3
   - io_detector_ZN + y_ZN_edge_connector_nv_3_ac_3_co >= -1
 edge_flow_ub_ZN_nv_3_ac_3_ve: - y_ZN_edge_connector_nv_3_ac_3_co
   + f_ZN_edge_connector_nv_3_ac_3_co <= 0
 edge_flow_lb_ZN_nv_3_ac_3_ve: y_ZN_edge_connector_nv_3_ac_3_co
   + f_ZN_edge_connector_nv_3_ac_3_co >= 0
 on_off_constraint_by_indicator_ZN_pv_6_pp_6_co: - indicator_ZN_pp_6
   + y_ZN_edge_connector_pv_6_pp_6_co <= 0
 on_off_constraint_by_sum_actives_ZN_pv_6_pp_6_co: - io_detector_ZN
   + y_ZN_edge_connector_pv_6_pp_6_co <= 0
 on_off_constraint_by_mixing_ZN_pv_6_pp_6_co: - indicator_ZN_pp_6
   - io_detector_ZN + y_ZN_edge_connector_pv_6_pp_6_co >= -1
 edge_flow_ub_ZN_pv_6_pp_6_ve: - y_ZN_edge_connector_pv_6_pp_6_co
   + f_ZN_edge_connector_pv_6_pp_6_co <= 0
 edge_flow_lb_ZN_pv_6_pp_6_ve: y_ZN_edge_connector_pv_6_pp_6_co
   + f_ZN_edge_connector_pv_6_pp_6_co >= 0
 on_off_constraint_by_indicator_ZN_pv_6_ac_6_co: - indicator_ZN_ac_6
   + y_ZN_edge_connector_pv_6_ac_6_co <= 0
 on_off_constraint_by_sum_actives_ZN_pv_6_ac_6_co: - io_detector_ZN
   + y_ZN_edge_connector_pv_6_ac_6_co <= 0
 on_off_constraint_by_mixing_ZN_pv_6_ac_6_co: - indicator_ZN_ac_6
   - io_detector_ZN + y_ZN_edge_connector_pv_6_ac_6_co >= -1
 edge_flow_ub_ZN_pv_6_ac_6_ve: - y_ZN_edge_connector_pv_6_ac_6_co
   + f_ZN_edge_connector_pv_6_ac_6_co <= 0
 edge_flow_lb_ZN_pv_6_ac_6_ve: y_ZN_edge_connector_pv_6_ac_6_co
   + f_ZN_edge_connector_pv_6_ac_6_co >= 0
 on_off_constraint_by_indicator_ZN_nv_6_nn_6_co: - indicator_ZN_nn_6
   + y_ZN_edge_connector_nv_6_nn_6_co <= 0
 on_off_constraint_by_sum_actives_ZN_nv_6_nn_6_co: - io_detector_ZN
   + y_ZN_edge_connector_nv_6_nn_6_co <= 0
 on_off_constraint_by_mixing_ZN_nv_6_nn_6_co: - indicator_ZN_nn_6
   - io_detector_ZN + y_ZN_edge_connector_nv_6_nn_6_co >= -1
 edge_flow_ub_ZN_nv_6_nn_6_ve: - y_ZN_edge_connector_nv_6_nn_6_co
   + f_ZN_edge_connector_nv_6_nn_6_co <= 0
 edge_flow_lb_ZN_nv_6_nn_6_ve: y_ZN_edge_connector_nv_6_nn_6_co
   + f_ZN_edge_connector_nv_6_nn_6_co >= 0
 on_off_constraint_by_indicator_ZN_nv_6_ac_6_co: - indicator_ZN_ac_6
   + y_ZN_edge_connector_nv_6_ac_6_co <= 0
 on_off_constraint_by_sum_actives_ZN_nv_6_ac_6_co: - io_detector_ZN
   + y_ZN_edge_connector_nv_6_ac_6_co <= 0
 on_off_constraint_by_mixing_ZN_nv_6_ac_6_co: - indicator_ZN_ac_6
   - io_detector_ZN + y_ZN_edge_connector_nv_6_ac_6_co >= -1
 edge_flow_ub_ZN_nv_6_ac_6_ve: - y_ZN_edge_connector_nv_6_ac_6_co
   + f_ZN_edge_connector_nv_6_ac_6_co <= 0
 edge_flow_lb_ZN_nv_6_ac_6_ve: y_ZN_edge_connector_nv_6_ac_6_co
   + f_ZN_edge_connector_nv_6_ac_6_co >= 0
 on_off_constraint_by_indicator_ZN_pv_9_pp_9_co: - indicator_ZN_pp_9
   + y_ZN_edge_connector_pv_9_pp_9_co <= 0
 on_off_constraint_by_sum_actives_ZN_pv_9_pp_9_co: - io_detector_ZN
   + y_ZN_edge_connector_pv_9_pp_9_co <= 0
 on_off_constraint_by_mixing_ZN_pv_9_pp_9_co: - indicator_ZN_pp_9
   - io_detector_ZN + y_ZN_edge_connector_pv_9_pp_9_co >= -1
 edge_flow_ub_ZN_pv_9_pp_9_ve: - y_ZN_edge_connector_pv_9_pp_9_co
   + f_ZN_edge_connector_pv_9_pp_9_co <= 0
 edge_flow_lb_ZN_pv_9_pp_9_ve: y_ZN_edge_connector_pv_9_pp_9_co
   + f_ZN_edge_connector_pv_9_pp_9_co >= 0
 on_off_constraint_by_indicator_ZN_pv_9_ac_9_co: - indicator_ZN_ac_9
   + y_ZN_edge_connector_pv_9_ac_9_co <= 0
 on_off_constraint_by_sum_actives_ZN_pv_9_ac_9_co: - io_detector_ZN
   + y_ZN_edge_connector_pv_9_ac_9_co <= 0
 on_off_constraint_by_mixing_ZN_pv_9_ac_9_co: - indicator_ZN_ac_9
   - io_detector_ZN + y_ZN_edge_connector_pv_9_ac_9_co >= -1
 edge_flow_ub_ZN_pv_9_ac_9_ve: - y_ZN_edge_connector_pv_9_ac_9_co
   + f_ZN_edge_connector_pv_9_ac_9_co <= 0
 edge_flow_lb_ZN_pv_9_ac_9_ve: y_ZN_edge_connector_pv_9_ac_9_co
   + f_ZN_edge_connector_pv_9_ac_9_co >= 0
 on_off_constraint_by_indicator_ZN_nv_9_nn_9_co: - indicator_ZN_nn_9
   + y_ZN_edge_connector_nv_9_nn_9_co <= 0
 on_off_constraint_by_sum_actives_ZN_nv_9_nn_9_co: - io_detector_ZN
   + y_ZN_edge_connector_nv_9_nn_9_co <= 0
 on_off_constraint_by_mixing_ZN_nv_9_nn_9_co: - indicator_ZN_nn_9
   - io_detector_ZN + y_ZN_edge_connector_nv_9_nn_9_co >= -1
 edge_flow_ub_ZN_nv_9_nn_9_ve: - y_ZN_edge_connector_nv_9_nn_9_co
   + f_ZN_edge_connector_nv_9_nn_9_co <= 0
 edge_flow_lb_ZN_nv_9_nn_9_ve: y_ZN_edge_connector_nv_9_nn_9_co
   + f_ZN_edge_connector_nv_9_nn_9_co >= 0
 on_off_constraint_by_indicator_ZN_nv_9_ac_9_co: - indicator_ZN_ac_9
   + y_ZN_edge_connector_nv_9_ac_9_co <= 0
 on_off_constraint_by_sum_actives_ZN_nv_9_ac_9_co: - io_detector_ZN
   + y_ZN_edge_connector_nv_9_ac_9_co <= 0
 on_off_constraint_by_mixing_ZN_nv_9_ac_9_co: - indicator_ZN_ac_9
   - io_detector_ZN + y_ZN_edge_connector_nv_9_ac_9_co >= -1
 edge_flow_ub_ZN_nv_9_ac_9_ve: - y_ZN_edge_connector_nv_9_ac_9_co
   + f_ZN_edge_connector_nv_9_ac_9_co <= 0
 edge_flow_lb_ZN_nv_9_ac_9_ve: y_ZN_edge_connector_nv_9_ac_9_co
   + f_ZN_edge_connector_nv_9_ac_9_co >= 0
 row_selection_on_off_rule1_ZN_pp_3: - 2 indicator_ZN_pp_3
   + c_mar_row_ZN_pp_3_r[3] + c_mar_row_ZN_pp_3_r[2] <= 0
 row_selection_on_off_rule2_ZN_pp_3: - 2 io_detector_ZN
   + c_mar_row_ZN_pp_3_r[3] + c_mar_row_ZN_pp_3_r[2] <= 0
 row_selection_on_off_rule3_ZN_pp_3: - indicator_ZN_pp_3 - io_detector_ZN
   + c_mar_row_ZN_pp_3_r[3] + c_mar_row_ZN_pp_3_r[2] >= -1
 case_selection_on_off_rule1_ZN_pp_3_3: - c_mar_row_ZN_pp_3_r[3]
   + c_mar_row_ZN_pp_3_3_case[0] <= 0
 case_selection_on_off_rule2_ZN_pp_3_3: - c_mar_row_ZN_pp_3_r[3]
   + c_mar_row_ZN_pp_3_3_case[0] >= 0
 mar_constraint_ZN_pp_3_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_pp_3_3_case[0] <= 0
 mar_constraint_ZN_pp_3_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_pp_3_3_case[0] <= 0
 mar_constraint_ZN_pp_3_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_pp_3_3_case[0] <= 0
 case_selection_on_off_rule1_ZN_pp_3_2: - c_mar_row_ZN_pp_3_r[2]
   + c_mar_row_ZN_pp_3_2_case[0] <= 0
 case_selection_on_off_rule2_ZN_pp_3_2: - c_mar_row_ZN_pp_3_r[2]
   + c_mar_row_ZN_pp_3_2_case[0] >= 0
 mar_constraint_ZN_pp_3_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_pp_3_2_case[0] <= 0
 mar_constraint_ZN_pp_3_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_pp_3_2_case[0] <= 0
 mar_constraint_ZN_pp_3_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_pp_3_2_case[0] <= 0
 row_selection_on_off_rule1_ZN_nn_3: - 2 indicator_ZN_nn_3
   + c_mar_row_ZN_nn_3_r[1] + c_mar_row_ZN_nn_3_r[0] <= 0
 row_selection_on_off_rule2_ZN_nn_3: - 2 io_detector_ZN
   + c_mar_row_ZN_nn_3_r[1] + c_mar_row_ZN_nn_3_r[0] <= 0
 row_selection_on_off_rule3_ZN_nn_3: - indicator_ZN_nn_3 - io_detector_ZN
   + c_mar_row_ZN_nn_3_r[1] + c_mar_row_ZN_nn_3_r[0] >= -1
 case_selection_on_off_rule1_ZN_nn_3_1: - c_mar_row_ZN_nn_3_r[1]
   + c_mar_row_ZN_nn_3_1_case[0] <= 0
 case_selection_on_off_rule2_ZN_nn_3_1: - c_mar_row_ZN_nn_3_r[1]
   + c_mar_row_ZN_nn_3_1_case[0] >= 0
 mar_constraint_ZN_nn_3_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_nn_3_1_case[0] <= 0
 mar_constraint_ZN_nn_3_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_nn_3_1_case[0] <= 0
 mar_constraint_ZN_nn_3_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_nn_3_1_case[0] <= 0
 case_selection_on_off_rule1_ZN_nn_3_0: - c_mar_row_ZN_nn_3_r[0]
   + c_mar_row_ZN_nn_3_0_case[0] <= 0
 case_selection_on_off_rule2_ZN_nn_3_0: - c_mar_row_ZN_nn_3_r[0]
   + c_mar_row_ZN_nn_3_0_case[0] >= 0
 mar_constraint_ZN_nn_3_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_nn_3_0_case[0] <= 0
 mar_constraint_ZN_nn_3_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_nn_3_0_case[0] <= 0
 mar_constraint_ZN_nn_3_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_nn_3_0_case[0] <= 0
 row_selection_on_off_rule1_ZN_ac_3: - 4 indicator_ZN_ac_3
   + c_mar_row_ZN_ac_3_r[3] + c_mar_row_ZN_ac_3_r[2]
   + c_mar_row_ZN_ac_3_r[1] + c_mar_row_ZN_ac_3_r[0] <= 0
 row_selection_on_off_rule2_ZN_ac_3: - 4 io_detector_ZN
   + c_mar_row_ZN_ac_3_r[3] + c_mar_row_ZN_ac_3_r[2]
   + c_mar_row_ZN_ac_3_r[1] + c_mar_row_ZN_ac_3_r[0] <= 0
 row_selection_on_off_rule3_ZN_ac_3: - indicator_ZN_ac_3 - io_detector_ZN
   + c_mar_row_ZN_ac_3_r[3] + c_mar_row_ZN_ac_3_r[2]
   + c_mar_row_ZN_ac_3_r[1] + c_mar_row_ZN_ac_3_r[0] >= -1
 case_selection_on_off_rule1_ZN_ac_3_3: - c_mar_row_ZN_ac_3_r[3]
   + c_mar_row_ZN_ac_3_3_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_3_3: - c_mar_row_ZN_ac_3_r[3]
   + c_mar_row_ZN_ac_3_3_case[0] >= 0
 mar_constraint_ZN_ac_3_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_ac_3_3_case[0] <= 0
 mar_constraint_ZN_ac_3_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_ac_3_3_case[0] <= 0
 mar_constraint_ZN_ac_3_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_ac_3_3_case[0] <= 0
 case_selection_on_off_rule1_ZN_ac_3_2: - c_mar_row_ZN_ac_3_r[2]
   + c_mar_row_ZN_ac_3_2_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_3_2: - c_mar_row_ZN_ac_3_r[2]
   + c_mar_row_ZN_ac_3_2_case[0] >= 0
 mar_constraint_ZN_ac_3_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_ac_3_2_case[0] <= 0
 mar_constraint_ZN_ac_3_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_ac_3_2_case[0] <= 0
 mar_constraint_ZN_ac_3_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_ac_3_2_case[0] <= 0
 case_selection_on_off_rule1_ZN_ac_3_1: - c_mar_row_ZN_ac_3_r[1]
   + c_mar_row_ZN_ac_3_1_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_3_1: - c_mar_row_ZN_ac_3_r[1]
   + c_mar_row_ZN_ac_3_1_case[0] >= 0
 mar_constraint_ZN_ac_3_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_ac_3_1_case[0] <= 0
 mar_constraint_ZN_ac_3_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_ac_3_1_case[0] <= 0
 mar_constraint_ZN_ac_3_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_ac_3_1_case[0] <= 0
 case_selection_on_off_rule1_ZN_ac_3_0: - c_mar_row_ZN_ac_3_r[0]
   + c_mar_row_ZN_ac_3_0_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_3_0: - c_mar_row_ZN_ac_3_r[0]
   + c_mar_row_ZN_ac_3_0_case[0] >= 0
 mar_constraint_ZN_ac_3_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_ac_3_0_case[0] <= 0
 mar_constraint_ZN_ac_3_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_ac_3_0_case[0] <= 0
 mar_constraint_ZN_ac_3_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_ac_3_0_case[0] <= 0
 row_selection_on_off_rule1_ZN_pp_6: - 2 indicator_ZN_pp_6
   + c_mar_row_ZN_pp_6_r[3] + c_mar_row_ZN_pp_6_r[2] <= 0
 row_selection_on_off_rule2_ZN_pp_6: - 2 io_detector_ZN
   + c_mar_row_ZN_pp_6_r[3] + c_mar_row_ZN_pp_6_r[2] <= 0
 row_selection_on_off_rule3_ZN_pp_6: - indicator_ZN_pp_6 - io_detector_ZN
   + c_mar_row_ZN_pp_6_r[3] + c_mar_row_ZN_pp_6_r[2] >= -1
 case_selection_on_off_rule1_ZN_pp_6_3: - c_mar_row_ZN_pp_6_r[3]
   + c_mar_row_ZN_pp_6_3_case[0] + c_mar_row_ZN_pp_6_3_case[1] <= 0
 case_selection_on_off_rule2_ZN_pp_6_3: - c_mar_row_ZN_pp_6_r[3]
   + c_mar_row_ZN_pp_6_3_case[0] + c_mar_row_ZN_pp_6_3_case[1] >= 0
 mar_constraint_ZN_pp_6_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_pp_6_3_case[0] <= 0
 mar_constraint_ZN_pp_6_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_pp_6_3_case[0] <= 0
 mar_constraint_ZN_pp_6_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_pp_6_3_case[0] <= 0
 mar_constraint_ZN_pp_6_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_pp_6_3_case[1] <= 0
 mar_constraint_ZN_pp_6_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_pp_6_3_case[1] <= 0
 mar_constraint_ZN_pp_6_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_pp_6_3_case[1] <= 0
 case_selection_on_off_rule1_ZN_pp_6_2: - c_mar_row_ZN_pp_6_r[2]
   + c_mar_row_ZN_pp_6_2_case[0] + c_mar_row_ZN_pp_6_2_case[1] <= 0
 case_selection_on_off_rule2_ZN_pp_6_2: - c_mar_row_ZN_pp_6_r[2]
   + c_mar_row_ZN_pp_6_2_case[0] + c_mar_row_ZN_pp_6_2_case[1] >= 0
 mar_constraint_ZN_pp_6_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_pp_6_2_case[0] <= 0
 mar_constraint_ZN_pp_6_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_pp_6_2_case[0] <= 0
 mar_constraint_ZN_pp_6_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_pp_6_2_case[0] <= 0
 mar_constraint_ZN_pp_6_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_pp_6_2_case[1] <= 0
 mar_constraint_ZN_pp_6_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_pp_6_2_case[1] <= 0
 mar_constraint_ZN_pp_6_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_pp_6_2_case[1] <= 0
 row_selection_on_off_rule1_ZN_nn_6: - 2 indicator_ZN_nn_6
   + c_mar_row_ZN_nn_6_r[1] + c_mar_row_ZN_nn_6_r[0] <= 0
 row_selection_on_off_rule2_ZN_nn_6: - 2 io_detector_ZN
   + c_mar_row_ZN_nn_6_r[1] + c_mar_row_ZN_nn_6_r[0] <= 0
 row_selection_on_off_rule3_ZN_nn_6: - indicator_ZN_nn_6 - io_detector_ZN
   + c_mar_row_ZN_nn_6_r[1] + c_mar_row_ZN_nn_6_r[0] >= -1
 case_selection_on_off_rule1_ZN_nn_6_1: - c_mar_row_ZN_nn_6_r[1]
   + c_mar_row_ZN_nn_6_1_case[0] + c_mar_row_ZN_nn_6_1_case[1] <= 0
 case_selection_on_off_rule2_ZN_nn_6_1: - c_mar_row_ZN_nn_6_r[1]
   + c_mar_row_ZN_nn_6_1_case[0] + c_mar_row_ZN_nn_6_1_case[1] >= 0
 mar_constraint_ZN_nn_6_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_nn_6_1_case[0] <= 0
 mar_constraint_ZN_nn_6_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_nn_6_1_case[0] <= 0
 mar_constraint_ZN_nn_6_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_nn_6_1_case[0] <= 0
 mar_constraint_ZN_nn_6_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_nn_6_1_case[1] <= 0
 mar_constraint_ZN_nn_6_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_nn_6_1_case[1] <= 0
 mar_constraint_ZN_nn_6_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_nn_6_1_case[1] <= 0
 case_selection_on_off_rule1_ZN_nn_6_0: - c_mar_row_ZN_nn_6_r[0]
   + c_mar_row_ZN_nn_6_0_case[0] + c_mar_row_ZN_nn_6_0_case[1] <= 0
 case_selection_on_off_rule2_ZN_nn_6_0: - c_mar_row_ZN_nn_6_r[0]
   + c_mar_row_ZN_nn_6_0_case[0] + c_mar_row_ZN_nn_6_0_case[1] >= 0
 mar_constraint_ZN_nn_6_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_nn_6_0_case[0] <= 0
 mar_constraint_ZN_nn_6_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_nn_6_0_case[0] <= 0
 mar_constraint_ZN_nn_6_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_nn_6_0_case[0] <= 0
 mar_constraint_ZN_nn_6_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_nn_6_0_case[1] <= 0
 mar_constraint_ZN_nn_6_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_nn_6_0_case[1] <= 0
 mar_constraint_ZN_nn_6_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_nn_6_0_case[1] <= 0
 row_selection_on_off_rule1_ZN_ac_6: - 4 indicator_ZN_ac_6
   + c_mar_row_ZN_ac_6_r[3] + c_mar_row_ZN_ac_6_r[2]
   + c_mar_row_ZN_ac_6_r[1] + c_mar_row_ZN_ac_6_r[0] <= 0
 row_selection_on_off_rule2_ZN_ac_6: - 4 io_detector_ZN
   + c_mar_row_ZN_ac_6_r[3] + c_mar_row_ZN_ac_6_r[2]
   + c_mar_row_ZN_ac_6_r[1] + c_mar_row_ZN_ac_6_r[0] <= 0
 row_selection_on_off_rule3_ZN_ac_6: - indicator_ZN_ac_6 - io_detector_ZN
   + c_mar_row_ZN_ac_6_r[3] + c_mar_row_ZN_ac_6_r[2]
   + c_mar_row_ZN_ac_6_r[1] + c_mar_row_ZN_ac_6_r[0] >= -1
 case_selection_on_off_rule1_ZN_ac_6_3: - c_mar_row_ZN_ac_6_r[3]
   + c_mar_row_ZN_ac_6_3_case[0] + c_mar_row_ZN_ac_6_3_case[1] <= 0
 case_selection_on_off_rule2_ZN_ac_6_3: - c_mar_row_ZN_ac_6_r[3]
   + c_mar_row_ZN_ac_6_3_case[0] + c_mar_row_ZN_ac_6_3_case[1] >= 0
 mar_constraint_ZN_ac_6_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_ac_6_3_case[0] <= 0
 mar_constraint_ZN_ac_6_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_ac_6_3_case[0] <= 0
 mar_constraint_ZN_ac_6_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_ac_6_3_case[0] <= 0
 mar_constraint_ZN_ac_6_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_ac_6_3_case[1] <= 0
 mar_constraint_ZN_ac_6_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_ac_6_3_case[1] <= 0
 mar_constraint_ZN_ac_6_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_ac_6_3_case[1] <= 0
 case_selection_on_off_rule1_ZN_ac_6_2: - c_mar_row_ZN_ac_6_r[2]
   + c_mar_row_ZN_ac_6_2_case[0] + c_mar_row_ZN_ac_6_2_case[1] <= 0
 case_selection_on_off_rule2_ZN_ac_6_2: - c_mar_row_ZN_ac_6_r[2]
   + c_mar_row_ZN_ac_6_2_case[0] + c_mar_row_ZN_ac_6_2_case[1] >= 0
 mar_constraint_ZN_ac_6_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_ac_6_2_case[0] <= 0
 mar_constraint_ZN_ac_6_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_ac_6_2_case[0] <= 0
 mar_constraint_ZN_ac_6_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_ac_6_2_case[0] <= 0
 mar_constraint_ZN_ac_6_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_ac_6_2_case[1] <= 0
 mar_constraint_ZN_ac_6_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_ac_6_2_case[1] <= 0
 mar_constraint_ZN_ac_6_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_ac_6_2_case[1] <= 0
 case_selection_on_off_rule1_ZN_ac_6_1: - c_mar_row_ZN_ac_6_r[1]
   + c_mar_row_ZN_ac_6_1_case[0] + c_mar_row_ZN_ac_6_1_case[1] <= 0
 case_selection_on_off_rule2_ZN_ac_6_1: - c_mar_row_ZN_ac_6_r[1]
   + c_mar_row_ZN_ac_6_1_case[0] + c_mar_row_ZN_ac_6_1_case[1] >= 0
 mar_constraint_ZN_ac_6_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_ac_6_1_case[0] <= 0
 mar_constraint_ZN_ac_6_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_ac_6_1_case[0] <= 0
 mar_constraint_ZN_ac_6_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_ac_6_1_case[0] <= 0
 mar_constraint_ZN_ac_6_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_ac_6_1_case[1] <= 0
 mar_constraint_ZN_ac_6_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_ac_6_1_case[1] <= 0
 mar_constraint_ZN_ac_6_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_ac_6_1_case[1] <= 0
 case_selection_on_off_rule1_ZN_ac_6_0: - c_mar_row_ZN_ac_6_r[0]
   + c_mar_row_ZN_ac_6_0_case[0] + c_mar_row_ZN_ac_6_0_case[1] <= 0
 case_selection_on_off_rule2_ZN_ac_6_0: - c_mar_row_ZN_ac_6_r[0]
   + c_mar_row_ZN_ac_6_0_case[0] + c_mar_row_ZN_ac_6_0_case[1] >= 0
 mar_constraint_ZN_ac_6_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_ac_6_0_case[0] <= 0
 mar_constraint_ZN_ac_6_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_ac_6_0_case[0] <= 0
 mar_constraint_ZN_ac_6_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_ac_6_0_case[0] <= 0
 mar_constraint_ZN_ac_6_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_ac_6_0_case[1] <= 0
 mar_constraint_ZN_ac_6_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_ac_6_0_case[1] <= 0
 mar_constraint_ZN_ac_6_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_ac_6_0_case[1] <= 0
 row_selection_on_off_rule1_ZN_pp_9: - 2 indicator_ZN_pp_9
   + c_mar_row_ZN_pp_9_r[3] + c_mar_row_ZN_pp_9_r[2] <= 0
 row_selection_on_off_rule2_ZN_pp_9: - 2 io_detector_ZN
   + c_mar_row_ZN_pp_9_r[3] + c_mar_row_ZN_pp_9_r[2] <= 0
 row_selection_on_off_rule3_ZN_pp_9: - indicator_ZN_pp_9 - io_detector_ZN
   + c_mar_row_ZN_pp_9_r[3] + c_mar_row_ZN_pp_9_r[2] >= -1
 case_selection_on_off_rule1_ZN_pp_9_3: - c_mar_row_ZN_pp_9_r[3]
   + c_mar_row_ZN_pp_9_3_case[0] <= 0
 case_selection_on_off_rule2_ZN_pp_9_3: - c_mar_row_ZN_pp_9_r[3]
   + c_mar_row_ZN_pp_9_3_case[0] >= 0
 mar_constraint_ZN_pp_9_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_pp_9_3_case[0] <= 0
 mar_constraint_ZN_pp_9_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_pp_9_3_case[0] <= 0
 mar_constraint_ZN_pp_9_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_pp_9_3_case[0] <= 0
 case_selection_on_off_rule1_ZN_pp_9_2: - c_mar_row_ZN_pp_9_r[2]
   + c_mar_row_ZN_pp_9_2_case[0] <= 0
 case_selection_on_off_rule2_ZN_pp_9_2: - c_mar_row_ZN_pp_9_r[2]
   + c_mar_row_ZN_pp_9_2_case[0] >= 0
 mar_constraint_ZN_pp_9_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_pp_9_2_case[0] <= 0
 mar_constraint_ZN_pp_9_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_pp_9_2_case[0] <= 0
 mar_constraint_ZN_pp_9_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_pp_9_2_case[0] <= 0
 row_selection_on_off_rule1_ZN_nn_9: - 2 indicator_ZN_nn_9
   + c_mar_row_ZN_nn_9_r[1] + c_mar_row_ZN_nn_9_r[0] <= 0
 row_selection_on_off_rule2_ZN_nn_9: - 2 io_detector_ZN
   + c_mar_row_ZN_nn_9_r[1] + c_mar_row_ZN_nn_9_r[0] <= 0
 row_selection_on_off_rule3_ZN_nn_9: - indicator_ZN_nn_9 - io_detector_ZN
   + c_mar_row_ZN_nn_9_r[1] + c_mar_row_ZN_nn_9_r[0] >= -1
 case_selection_on_off_rule1_ZN_nn_9_1: - c_mar_row_ZN_nn_9_r[1]
   + c_mar_row_ZN_nn_9_1_case[0] <= 0
 case_selection_on_off_rule2_ZN_nn_9_1: - c_mar_row_ZN_nn_9_r[1]
   + c_mar_row_ZN_nn_9_1_case[0] >= 0
 mar_constraint_ZN_nn_9_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_nn_9_1_case[0] <= 0
 mar_constraint_ZN_nn_9_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_nn_9_1_case[0] <= 0
 mar_constraint_ZN_nn_9_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_nn_9_1_case[0] <= 0
 case_selection_on_off_rule1_ZN_nn_9_0: - c_mar_row_ZN_nn_9_r[0]
   + c_mar_row_ZN_nn_9_0_case[0] <= 0
 case_selection_on_off_rule2_ZN_nn_9_0: - c_mar_row_ZN_nn_9_r[0]
   + c_mar_row_ZN_nn_9_0_case[0] >= 0
 mar_constraint_ZN_nn_9_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_nn_9_0_case[0] <= 0
 mar_constraint_ZN_nn_9_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_nn_9_0_case[0] <= 0
 mar_constraint_ZN_nn_9_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_nn_9_0_case[0] <= 0
 row_selection_on_off_rule1_ZN_ac_9: - 4 indicator_ZN_ac_9
   + c_mar_row_ZN_ac_9_r[3] + c_mar_row_ZN_ac_9_r[2]
   + c_mar_row_ZN_ac_9_r[1] + c_mar_row_ZN_ac_9_r[0] <= 0
 row_selection_on_off_rule2_ZN_ac_9: - 4 io_detector_ZN
   + c_mar_row_ZN_ac_9_r[3] + c_mar_row_ZN_ac_9_r[2]
   + c_mar_row_ZN_ac_9_r[1] + c_mar_row_ZN_ac_9_r[0] <= 0
 row_selection_on_off_rule3_ZN_ac_9: - indicator_ZN_ac_9 - io_detector_ZN
   + c_mar_row_ZN_ac_9_r[3] + c_mar_row_ZN_ac_9_r[2]
   + c_mar_row_ZN_ac_9_r[1] + c_mar_row_ZN_ac_9_r[0] >= -1
 case_selection_on_off_rule1_ZN_ac_9_3: - c_mar_row_ZN_ac_9_r[3]
   + c_mar_row_ZN_ac_9_3_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_9_3: - c_mar_row_ZN_ac_9_r[3]
   + c_mar_row_ZN_ac_9_3_case[0] >= 0
 mar_constraint_ZN_ac_9_3_left_edge: - t_ZN_c_r[0,3]
   + c_mar_row_ZN_ac_9_3_case[0] <= 0
 mar_constraint_ZN_ac_9_3_real_metal: - t_ZN_c_r[1,3]
   + c_mar_row_ZN_ac_9_3_case[0] <= 0
 mar_constraint_ZN_ac_9_3_right_edge: - t_ZN_c_r[2,3]
   + c_mar_row_ZN_ac_9_3_case[0] <= 0
 case_selection_on_off_rule1_ZN_ac_9_2: - c_mar_row_ZN_ac_9_r[2]
   + c_mar_row_ZN_ac_9_2_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_9_2: - c_mar_row_ZN_ac_9_r[2]
   + c_mar_row_ZN_ac_9_2_case[0] >= 0
 mar_constraint_ZN_ac_9_2_left_edge: - t_ZN_c_r[0,2]
   + c_mar_row_ZN_ac_9_2_case[0] <= 0
 mar_constraint_ZN_ac_9_2_real_metal: - t_ZN_c_r[1,2]
   + c_mar_row_ZN_ac_9_2_case[0] <= 0
 mar_constraint_ZN_ac_9_2_right_edge: - t_ZN_c_r[2,2]
   + c_mar_row_ZN_ac_9_2_case[0] <= 0
 case_selection_on_off_rule1_ZN_ac_9_1: - c_mar_row_ZN_ac_9_r[1]
   + c_mar_row_ZN_ac_9_1_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_9_1: - c_mar_row_ZN_ac_9_r[1]
   + c_mar_row_ZN_ac_9_1_case[0] >= 0
 mar_constraint_ZN_ac_9_1_left_edge: - t_ZN_c_r[0,1]
   + c_mar_row_ZN_ac_9_1_case[0] <= 0
 mar_constraint_ZN_ac_9_1_real_metal: - t_ZN_c_r[1,1]
   + c_mar_row_ZN_ac_9_1_case[0] <= 0
 mar_constraint_ZN_ac_9_1_right_edge: - t_ZN_c_r[2,1]
   + c_mar_row_ZN_ac_9_1_case[0] <= 0
 case_selection_on_off_rule1_ZN_ac_9_0: - c_mar_row_ZN_ac_9_r[0]
   + c_mar_row_ZN_ac_9_0_case[0] <= 0
 case_selection_on_off_rule2_ZN_ac_9_0: - c_mar_row_ZN_ac_9_r[0]
   + c_mar_row_ZN_ac_9_0_case[0] >= 0
 mar_constraint_ZN_ac_9_0_left_edge: - t_ZN_c_r[0,0]
   + c_mar_row_ZN_ac_9_0_case[0] <= 0
 mar_constraint_ZN_ac_9_0_real_metal: - t_ZN_c_r[1,0]
   + c_mar_row_ZN_ac_9_0_case[0] <= 0
 mar_constraint_ZN_ac_9_0_right_edge: - t_ZN_c_r[2,0]
   + c_mar_row_ZN_ac_9_0_case[0] <= 0
 global_zero_constraint_ZN_pv_3_pv_4_3: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_3_pv_4_3 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_3_pv_4_3: min_indicator_ZN
   + 3 y_ZN_edge_pv_3_pv_4_3 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_pv_3_pv_4_3: - max_bbox_ZN
   + 3 y_ZN_edge_pv_3_pv_4_3 <= 2
 edge_flow_ub_ZN_pv_3_pv_4_3: - y_ZN_edge_pv_3_pv_4_3
   + f_ZN_edge_pv_3_pv_4_3 <= 0
 edge_flow_lb_ZN_pv_3_pv_4_3: y_ZN_edge_pv_3_pv_4_3 + f_ZN_edge_pv_3_pv_4_3
   >= 0
 global_zero_constraint_ZN_pv_3_pv_4_2: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_3_pv_4_2 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_3_pv_4_2: min_indicator_ZN
   + 3 y_ZN_edge_pv_3_pv_4_2 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_pv_3_pv_4_2: - max_bbox_ZN
   + 3 y_ZN_edge_pv_3_pv_4_2 <= 2
 edge_flow_ub_ZN_pv_3_pv_4_2: - y_ZN_edge_pv_3_pv_4_2
   + f_ZN_edge_pv_3_pv_4_2 <= 0
 edge_flow_lb_ZN_pv_3_pv_4_2: y_ZN_edge_pv_3_pv_4_2 + f_ZN_edge_pv_3_pv_4_2
   >= 0
 global_zero_constraint_ZN_nv_3_nv_4_1: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_3_nv_4_1 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_3_nv_4_1: min_indicator_ZN
   + 3 y_ZN_edge_nv_3_nv_4_1 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_nv_3_nv_4_1: - max_bbox_ZN
   + 3 y_ZN_edge_nv_3_nv_4_1 <= 2
 edge_flow_ub_ZN_nv_3_nv_4_1: - y_ZN_edge_nv_3_nv_4_1
   + f_ZN_edge_nv_3_nv_4_1 <= 0
 edge_flow_lb_ZN_nv_3_nv_4_1: y_ZN_edge_nv_3_nv_4_1 + f_ZN_edge_nv_3_nv_4_1
   >= 0
 global_zero_constraint_ZN_nv_3_nv_4_0: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_3_nv_4_0 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_3_nv_4_0: min_indicator_ZN
   + 3 y_ZN_edge_nv_3_nv_4_0 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_nv_3_nv_4_0: - max_bbox_ZN
   + 3 y_ZN_edge_nv_3_nv_4_0 <= 2
 edge_flow_ub_ZN_nv_3_nv_4_0: - y_ZN_edge_nv_3_nv_4_0
   + f_ZN_edge_nv_3_nv_4_0 <= 0
 edge_flow_lb_ZN_nv_3_nv_4_0: y_ZN_edge_nv_3_nv_4_0 + f_ZN_edge_nv_3_nv_4_0
   >= 0
 global_zero_constraint_ZN_pv_4_pv_6_3: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_4_pv_6_3 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_4_pv_6_3: min_indicator_ZN
   + 3 y_ZN_edge_pv_4_pv_6_3 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_pv_4_pv_6_3: - max_bbox_ZN
   + 3 y_ZN_edge_pv_4_pv_6_3 <= 2
 edge_flow_ub_ZN_pv_4_pv_6_3: - y_ZN_edge_pv_4_pv_6_3
   + f_ZN_edge_pv_4_pv_6_3 <= 0
 edge_flow_lb_ZN_pv_4_pv_6_3: y_ZN_edge_pv_4_pv_6_3 + f_ZN_edge_pv_4_pv_6_3
   >= 0
 global_zero_constraint_ZN_pv_4_pv_6_2: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_4_pv_6_2 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_4_pv_6_2: min_indicator_ZN
   + 3 y_ZN_edge_pv_4_pv_6_2 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_pv_4_pv_6_2: - max_bbox_ZN
   + 3 y_ZN_edge_pv_4_pv_6_2 <= 2
 edge_flow_ub_ZN_pv_4_pv_6_2: - y_ZN_edge_pv_4_pv_6_2
   + f_ZN_edge_pv_4_pv_6_2 <= 0
 edge_flow_lb_ZN_pv_4_pv_6_2: y_ZN_edge_pv_4_pv_6_2 + f_ZN_edge_pv_4_pv_6_2
   >= 0
 global_zero_constraint_ZN_nv_4_nv_6_1: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_4_nv_6_1 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_4_nv_6_1: min_indicator_ZN
   + 3 y_ZN_edge_nv_4_nv_6_1 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_nv_4_nv_6_1: - max_bbox_ZN
   + 3 y_ZN_edge_nv_4_nv_6_1 <= 2
 edge_flow_ub_ZN_nv_4_nv_6_1: - y_ZN_edge_nv_4_nv_6_1
   + f_ZN_edge_nv_4_nv_6_1 <= 0
 edge_flow_lb_ZN_nv_4_nv_6_1: y_ZN_edge_nv_4_nv_6_1 + f_ZN_edge_nv_4_nv_6_1
   >= 0
 global_zero_constraint_ZN_nv_4_nv_6_0: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_4_nv_6_0 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_4_nv_6_0: min_indicator_ZN
   + 3 y_ZN_edge_nv_4_nv_6_0 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_nv_4_nv_6_0: - max_bbox_ZN
   + 3 y_ZN_edge_nv_4_nv_6_0 <= 2
 edge_flow_ub_ZN_nv_4_nv_6_0: - y_ZN_edge_nv_4_nv_6_0
   + f_ZN_edge_nv_4_nv_6_0 <= 0
 edge_flow_lb_ZN_nv_4_nv_6_0: y_ZN_edge_nv_4_nv_6_0 + f_ZN_edge_nv_4_nv_6_0
   >= 0
 global_zero_constraint_ZN_pv_6_pv_8_3: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_6_pv_8_3 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_6_pv_8_3: min_indicator_ZN
   + 3 y_ZN_edge_pv_6_pv_8_3 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_pv_6_pv_8_3: - max_bbox_ZN
   + 3 y_ZN_edge_pv_6_pv_8_3 <= 1
 edge_flow_ub_ZN_pv_6_pv_8_3: - y_ZN_edge_pv_6_pv_8_3
   + f_ZN_edge_pv_6_pv_8_3 <= 0
 edge_flow_lb_ZN_pv_6_pv_8_3: y_ZN_edge_pv_6_pv_8_3 + f_ZN_edge_pv_6_pv_8_3
   >= 0
 global_zero_constraint_ZN_pv_6_pv_8_2: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_6_pv_8_2 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_6_pv_8_2: min_indicator_ZN
   + 3 y_ZN_edge_pv_6_pv_8_2 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_pv_6_pv_8_2: - max_bbox_ZN
   + 3 y_ZN_edge_pv_6_pv_8_2 <= 1
 edge_flow_ub_ZN_pv_6_pv_8_2: - y_ZN_edge_pv_6_pv_8_2
   + f_ZN_edge_pv_6_pv_8_2 <= 0
 edge_flow_lb_ZN_pv_6_pv_8_2: y_ZN_edge_pv_6_pv_8_2 + f_ZN_edge_pv_6_pv_8_2
   >= 0
 global_zero_constraint_ZN_nv_6_nv_8_1: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_6_nv_8_1 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_6_nv_8_1: min_indicator_ZN
   + 3 y_ZN_edge_nv_6_nv_8_1 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_nv_6_nv_8_1: - max_bbox_ZN
   + 3 y_ZN_edge_nv_6_nv_8_1 <= 1
 edge_flow_ub_ZN_nv_6_nv_8_1: - y_ZN_edge_nv_6_nv_8_1
   + f_ZN_edge_nv_6_nv_8_1 <= 0
 edge_flow_lb_ZN_nv_6_nv_8_1: y_ZN_edge_nv_6_nv_8_1 + f_ZN_edge_nv_6_nv_8_1
   >= 0
 global_zero_constraint_ZN_nv_6_nv_8_0: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_6_nv_8_0 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_6_nv_8_0: min_indicator_ZN
   + 3 y_ZN_edge_nv_6_nv_8_0 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_nv_6_nv_8_0: - max_bbox_ZN
   + 3 y_ZN_edge_nv_6_nv_8_0 <= 1
 edge_flow_ub_ZN_nv_6_nv_8_0: - y_ZN_edge_nv_6_nv_8_0
   + f_ZN_edge_nv_6_nv_8_0 <= 0
 edge_flow_lb_ZN_nv_6_nv_8_0: y_ZN_edge_nv_6_nv_8_0 + f_ZN_edge_nv_6_nv_8_0
   >= 0
 global_zero_constraint_ZN_pv_8_pv_9_3: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_8_pv_9_3 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_8_pv_9_3: min_indicator_ZN
   + 3 y_ZN_edge_pv_8_pv_9_3 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_pv_8_pv_9_3: - max_bbox_ZN
   + 3 y_ZN_edge_pv_8_pv_9_3 <= 1
 edge_flow_ub_ZN_pv_8_pv_9_3: - y_ZN_edge_pv_8_pv_9_3
   + f_ZN_edge_pv_8_pv_9_3 <= 0
 edge_flow_lb_ZN_pv_8_pv_9_3: y_ZN_edge_pv_8_pv_9_3 + f_ZN_edge_pv_8_pv_9_3
   >= 0
 global_zero_constraint_ZN_pv_8_pv_9_2: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_pv_8_pv_9_2 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_pv_8_pv_9_2: min_indicator_ZN
   + 3 y_ZN_edge_pv_8_pv_9_2 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_pv_8_pv_9_2: - max_bbox_ZN
   + 3 y_ZN_edge_pv_8_pv_9_2 <= 1
 edge_flow_ub_ZN_pv_8_pv_9_2: - y_ZN_edge_pv_8_pv_9_2
   + f_ZN_edge_pv_8_pv_9_2 <= 0
 edge_flow_lb_ZN_pv_8_pv_9_2: y_ZN_edge_pv_8_pv_9_2 + f_ZN_edge_pv_8_pv_9_2
   >= 0
 global_zero_constraint_ZN_nv_8_nv_9_1: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_8_nv_9_1 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_8_nv_9_1: min_indicator_ZN
   + 3 y_ZN_edge_nv_8_nv_9_1 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_nv_8_nv_9_1: - max_bbox_ZN
   + 3 y_ZN_edge_nv_8_nv_9_1 <= 1
 edge_flow_ub_ZN_nv_8_nv_9_1: - y_ZN_edge_nv_8_nv_9_1
   + f_ZN_edge_nv_8_nv_9_1 <= 0
 edge_flow_lb_ZN_nv_8_nv_9_1: y_ZN_edge_nv_8_nv_9_1 + f_ZN_edge_nv_8_nv_9_1
   >= 0
 global_zero_constraint_ZN_nv_8_nv_9_0: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_nv_8_nv_9_0 <= -1
 active_c_ge_min_indicator_min_bbox_ZN_nv_8_nv_9_0: min_indicator_ZN
   + 3 y_ZN_edge_nv_8_nv_9_0 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_nv_8_nv_9_0: - max_bbox_ZN
   + 3 y_ZN_edge_nv_8_nv_9_0 <= 1
 edge_flow_ub_ZN_nv_8_nv_9_0: - y_ZN_edge_nv_8_nv_9_0
   + f_ZN_edge_nv_8_nv_9_0 <= 0
 edge_flow_lb_ZN_nv_8_nv_9_0: y_ZN_edge_nv_8_nv_9_0 + f_ZN_edge_nv_8_nv_9_0
   >= 0
 global_zero_constraint_ZN_m1_4_pv_4_ve: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_via_enable_m1_4_pv_4
   <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_4_pv_4_ve: min_indicator_ZN
   + 3 y_ZN_edge_via_enable_m1_4_pv_4 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_m1_4_pv_4_ve: - max_bbox_ZN
   + 3 y_ZN_edge_via_enable_m1_4_pv_4 <= 2
 edge_flow_ub_ZN_m1_4_pv_4_ve: - y_ZN_edge_via_enable_m1_4_pv_4
   + f_ZN_edge_via_enable_m1_4_pv_4 <= 0
 edge_flow_lb_ZN_m1_4_pv_4_ve: y_ZN_edge_via_enable_m1_4_pv_4
   + f_ZN_edge_via_enable_m1_4_pv_4 >= 0
 global_zero_constraint_ZN_m1_4_nv_4_ve: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_via_enable_m1_4_nv_4
   <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_4_nv_4_ve: min_indicator_ZN
   + 3 y_ZN_edge_via_enable_m1_4_nv_4 <= 4
 active_c_ge_max_bbox_min_bbox_ZN_m1_4_nv_4_ve: - max_bbox_ZN
   + 3 y_ZN_edge_via_enable_m1_4_nv_4 <= 2
 edge_flow_ub_ZN_m1_4_nv_4_ve: - y_ZN_edge_via_enable_m1_4_nv_4
   + f_ZN_edge_via_enable_m1_4_nv_4 <= 0
 edge_flow_lb_ZN_m1_4_nv_4_ve: y_ZN_edge_via_enable_m1_4_nv_4
   + f_ZN_edge_via_enable_m1_4_nv_4 >= 0
 global_zero_constraint_ZN_m1_4_m1_8_7: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_m1_4_m1_8_r_7 <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_4_m1_8_7: min_indicator_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_7 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_m1_4_m1_8_7: - max_bbox_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_7 <= 1
 edge_flow_ub_ZN_m1_4_m1_8_7: - y_ZN_edge_m1_4_m1_8_r_7
   + f_ZN_edge_m1_4_m1_8_r_7 <= 0
 edge_flow_lb_ZN_m1_4_m1_8_7: y_ZN_edge_m1_4_m1_8_r_7
   + f_ZN_edge_m1_4_m1_8_r_7 >= 0
 global_zero_constraint_ZN_m1_4_m1_8_6: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_m1_4_m1_8_r_6 <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_4_m1_8_6: min_indicator_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_6 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_m1_4_m1_8_6: - max_bbox_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_6 <= 1
 edge_flow_ub_ZN_m1_4_m1_8_6: - y_ZN_edge_m1_4_m1_8_r_6
   + f_ZN_edge_m1_4_m1_8_r_6 <= 0
 edge_flow_lb_ZN_m1_4_m1_8_6: y_ZN_edge_m1_4_m1_8_r_6
   + f_ZN_edge_m1_4_m1_8_r_6 >= 0
 global_zero_constraint_ZN_m1_4_m1_8_5: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_m1_4_m1_8_r_5 <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_4_m1_8_5: min_indicator_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_5 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_m1_4_m1_8_5: - max_bbox_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_5 <= 1
 edge_flow_ub_ZN_m1_4_m1_8_5: - y_ZN_edge_m1_4_m1_8_r_5
   + f_ZN_edge_m1_4_m1_8_r_5 <= 0
 edge_flow_lb_ZN_m1_4_m1_8_5: y_ZN_edge_m1_4_m1_8_r_5
   + f_ZN_edge_m1_4_m1_8_r_5 >= 0
 global_zero_constraint_ZN_m1_4_m1_8_4: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_m1_4_m1_8_r_4 <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_4_m1_8_4: min_indicator_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_4 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_m1_4_m1_8_4: - max_bbox_ZN
   + 3 y_ZN_edge_m1_4_m1_8_r_4 <= 1
 edge_flow_ub_ZN_m1_4_m1_8_4: - y_ZN_edge_m1_4_m1_8_r_4
   + f_ZN_edge_m1_4_m1_8_r_4 <= 0
 edge_flow_lb_ZN_m1_4_m1_8_4: y_ZN_edge_m1_4_m1_8_r_4
   + f_ZN_edge_m1_4_m1_8_r_4 >= 0
 global_zero_constraint_ZN_m1_8_pv_8_ve: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_via_enable_m1_8_pv_8
   <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_8_pv_8_ve: min_indicator_ZN
   + 3 y_ZN_edge_via_enable_m1_8_pv_8 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_m1_8_pv_8_ve: - max_bbox_ZN
   + 3 y_ZN_edge_via_enable_m1_8_pv_8 <= 1
 edge_flow_ub_ZN_m1_8_pv_8_ve: - y_ZN_edge_via_enable_m1_8_pv_8
   + f_ZN_edge_via_enable_m1_8_pv_8 <= 0
 edge_flow_lb_ZN_m1_8_pv_8_ve: y_ZN_edge_via_enable_m1_8_pv_8
   + f_ZN_edge_via_enable_m1_8_pv_8 >= 0
 global_zero_constraint_ZN_m1_8_nv_8_ve: - indicator_ZN_pp_3
   - indicator_ZN_nn_3 - indicator_ZN_ac_3 - indicator_ZN_pp_6
   - indicator_ZN_nn_6 - indicator_ZN_ac_6 - indicator_ZN_pp_9
   - indicator_ZN_nn_9 - indicator_ZN_ac_9 + y_ZN_edge_via_enable_m1_8_nv_8
   <= -1
 active_c_ge_min_indicator_min_one_ZN_m1_8_nv_8_ve: min_indicator_ZN
   + 3 y_ZN_edge_via_enable_m1_8_nv_8 <= 5
 active_c_ge_max_bbox_min_bbox_ZN_m1_8_nv_8_ve: - max_bbox_ZN
   + 3 y_ZN_edge_via_enable_m1_8_nv_8 <= 1
 edge_flow_ub_ZN_m1_8_nv_8_ve: - y_ZN_edge_via_enable_m1_8_nv_8
   + f_ZN_edge_via_enable_m1_8_nv_8 <= 0
 edge_flow_lb_ZN_m1_8_nv_8_ve: y_ZN_edge_via_enable_m1_8_nv_8
   + f_ZN_edge_via_enable_m1_8_nv_8 >= 0
 via_enable_ZN_m1_8_pv_4: - v_ZN_v[0] + y_ZN_edge_via_enable_m1_4_pv_4
   <= 0
 via_enable_ZN_m1_8_nv_4: - v_ZN_v[0] + y_ZN_edge_via_enable_m1_4_nv_4
   <= 0
 via_enable_ZN_m1_8_pv_8: - v_ZN_v[1] + y_ZN_edge_via_enable_m1_8_pv_8
   <= 0
 via_enable_ZN_m1_8_nv_8: - v_ZN_v[1] + y_ZN_edge_via_enable_m1_8_nv_8
   <= 0
 t_activation_ZN_pv_3_pv_4_0_3: t_ZN_c_r[0,3] - y_ZN_edge_pv_3_pv_4_3 >= 0
 t_activation_ZN_pv_3_pv_4_1_3: t_ZN_c_r[1,3] - y_ZN_edge_pv_3_pv_4_3 >= 0
 logical_constraint_ZN_pv_3_pv_4_j_index_3: - t_eol_c_r[2,3]
   - t_ZN_c_r[2,3] + y_ZN_edge_pv_3_pv_4_3 <= 0
 t_activation_ZN_pv_3_pv_4_0_2: t_ZN_c_r[0,2] - y_ZN_edge_pv_3_pv_4_2 >= 0
 t_activation_ZN_pv_3_pv_4_1_2: t_ZN_c_r[1,2] - y_ZN_edge_pv_3_pv_4_2 >= 0
 logical_constraint_ZN_pv_3_pv_4_j_index_2: - t_eol_c_r[2,2]
   - t_ZN_c_r[2,2] + y_ZN_edge_pv_3_pv_4_2 <= 0
 t_activation_ZN_nv_3_nv_4_0_1: t_ZN_c_r[0,1] - y_ZN_edge_nv_3_nv_4_1 >= 0
 t_activation_ZN_nv_3_nv_4_1_1: t_ZN_c_r[1,1] - y_ZN_edge_nv_3_nv_4_1 >= 0
 logical_constraint_ZN_nv_3_nv_4_j_index_1: - t_eol_c_r[2,1]
   - t_ZN_c_r[2,1] + y_ZN_edge_nv_3_nv_4_1 <= 0
 t_activation_ZN_nv_3_nv_4_0_0: t_ZN_c_r[0,0] - y_ZN_edge_nv_3_nv_4_0 >= 0
 t_activation_ZN_nv_3_nv_4_1_0: t_ZN_c_r[1,0] - y_ZN_edge_nv_3_nv_4_0 >= 0
 logical_constraint_ZN_nv_3_nv_4_j_index_0: - t_eol_c_r[2,0]
   - t_ZN_c_r[2,0] + y_ZN_edge_nv_3_nv_4_0 <= 0
 t_activation_ZN_pv_4_pv_6_0_3: t_ZN_c_r[0,3] - y_ZN_edge_pv_4_pv_6_3 >= 0
 t_activation_ZN_pv_4_pv_6_1_3: t_ZN_c_r[1,3] - y_ZN_edge_pv_4_pv_6_3 >= 0
 logical_constraint_ZN_pv_4_pv_6_j_index_3: - t_eol_c_r[2,3]
   - t_ZN_c_r[2,3] + y_ZN_edge_pv_4_pv_6_3 <= 0
 t_activation_ZN_pv_4_pv_6_0_2: t_ZN_c_r[0,2] - y_ZN_edge_pv_4_pv_6_2 >= 0
 t_activation_ZN_pv_4_pv_6_1_2: t_ZN_c_r[1,2] - y_ZN_edge_pv_4_pv_6_2 >= 0
 logical_constraint_ZN_pv_4_pv_6_j_index_2: - t_eol_c_r[2,2]
   - t_ZN_c_r[2,2] + y_ZN_edge_pv_4_pv_6_2 <= 0
 t_activation_ZN_nv_4_nv_6_0_1: t_ZN_c_r[0,1] - y_ZN_edge_nv_4_nv_6_1 >= 0
 t_activation_ZN_nv_4_nv_6_1_1: t_ZN_c_r[1,1] - y_ZN_edge_nv_4_nv_6_1 >= 0
 logical_constraint_ZN_nv_4_nv_6_j_index_1: - t_eol_c_r[2,1]
   - t_ZN_c_r[2,1] + y_ZN_edge_nv_4_nv_6_1 <= 0
 t_activation_ZN_nv_4_nv_6_0_0: t_ZN_c_r[0,0] - y_ZN_edge_nv_4_nv_6_0 >= 0
 t_activation_ZN_nv_4_nv_6_1_0: t_ZN_c_r[1,0] - y_ZN_edge_nv_4_nv_6_0 >= 0
 logical_constraint_ZN_nv_4_nv_6_j_index_0: - t_eol_c_r[2,0]
   - t_ZN_c_r[2,0] + y_ZN_edge_nv_4_nv_6_0 <= 0
 t_activation_ZN_pv_6_pv_8_1_3: t_ZN_c_r[1,3] - y_ZN_edge_pv_6_pv_8_3 >= 0
 t_activation_ZN_pv_6_pv_8_2_3: t_ZN_c_r[2,3] - y_ZN_edge_pv_6_pv_8_3 >= 0
 logical_constraint_ZN_pv_6_pv_8_i_index_minus_1_3: - t_eol_c_r[0,3]
   - t_ZN_c_r[0,3] + y_ZN_edge_pv_6_pv_8_3 <= 0
 t_activation_ZN_pv_6_pv_8_1_2: t_ZN_c_r[1,2] - y_ZN_edge_pv_6_pv_8_2 >= 0
 t_activation_ZN_pv_6_pv_8_2_2: t_ZN_c_r[2,2] - y_ZN_edge_pv_6_pv_8_2 >= 0
 logical_constraint_ZN_pv_6_pv_8_i_index_minus_1_2: - t_eol_c_r[0,2]
   - t_ZN_c_r[0,2] + y_ZN_edge_pv_6_pv_8_2 <= 0
 t_activation_ZN_nv_6_nv_8_1_1: t_ZN_c_r[1,1] - y_ZN_edge_nv_6_nv_8_1 >= 0
 t_activation_ZN_nv_6_nv_8_2_1: t_ZN_c_r[2,1] - y_ZN_edge_nv_6_nv_8_1 >= 0
 logical_constraint_ZN_nv_6_nv_8_i_index_minus_1_1: - t_eol_c_r[0,1]
   - t_ZN_c_r[0,1] + y_ZN_edge_nv_6_nv_8_1 <= 0
 t_activation_ZN_nv_6_nv_8_1_0: t_ZN_c_r[1,0] - y_ZN_edge_nv_6_nv_8_0 >= 0
 t_activation_ZN_nv_6_nv_8_2_0: t_ZN_c_r[2,0] - y_ZN_edge_nv_6_nv_8_0 >= 0
 logical_constraint_ZN_nv_6_nv_8_i_index_minus_1_0: - t_eol_c_r[0,0]
   - t_ZN_c_r[0,0] + y_ZN_edge_nv_6_nv_8_0 <= 0
 t_activation_ZN_pv_8_pv_9_1_3: t_ZN_c_r[1,3] - y_ZN_edge_pv_8_pv_9_3 >= 0
 t_activation_ZN_pv_8_pv_9_2_3: t_ZN_c_r[2,3] - y_ZN_edge_pv_8_pv_9_3 >= 0
 logical_constraint_ZN_pv_8_pv_9_i_index_minus_1_3: - t_eol_c_r[0,3]
   - t_ZN_c_r[0,3] + y_ZN_edge_pv_8_pv_9_3 <= 0
 t_activation_ZN_pv_8_pv_9_1_2: t_ZN_c_r[1,2] - y_ZN_edge_pv_8_pv_9_2 >= 0
 t_activation_ZN_pv_8_pv_9_2_2: t_ZN_c_r[2,2] - y_ZN_edge_pv_8_pv_9_2 >= 0
 logical_constraint_ZN_pv_8_pv_9_i_index_minus_1_2: - t_eol_c_r[0,2]
   - t_ZN_c_r[0,2] + y_ZN_edge_pv_8_pv_9_2 <= 0
 t_activation_ZN_nv_8_nv_9_1_1: t_ZN_c_r[1,1] - y_ZN_edge_nv_8_nv_9_1 >= 0
 t_activation_ZN_nv_8_nv_9_2_1: t_ZN_c_r[2,1] - y_ZN_edge_nv_8_nv_9_1 >= 0
 logical_constraint_ZN_nv_8_nv_9_i_index_minus_1_1: - t_eol_c_r[0,1]
   - t_ZN_c_r[0,1] + y_ZN_edge_nv_8_nv_9_1 <= 0
 t_activation_ZN_nv_8_nv_9_1_0: t_ZN_c_r[1,0] - y_ZN_edge_nv_8_nv_9_0 >= 0
 t_activation_ZN_nv_8_nv_9_2_0: t_ZN_c_r[2,0] - y_ZN_edge_nv_8_nv_9_0 >= 0
 logical_constraint_ZN_nv_8_nv_9_i_index_minus_1_0: - t_eol_c_r[0,0]
   - t_ZN_c_r[0,0] + y_ZN_edge_nv_8_nv_9_0 <= 0
 t_activation_ZN_m1_4_m1_8_0_7: ut_ZN_c_r[0,7] - y_ZN_edge_m1_4_m1_8_r_7
   >= 0
 t_activation_ZN_m1_4_m1_8_1_7: ut_ZN_c_r[1,7] - y_ZN_edge_m1_4_m1_8_r_7
   >= 0
 t_activation_ZN_m1_4_m1_8_2_7: ut_ZN_c_r[2,7] - y_ZN_edge_m1_4_m1_8_r_7
   >= 0
 t_activation_ZN_m1_4_m1_8_0_6: ut_ZN_c_r[0,6] - y_ZN_edge_m1_4_m1_8_r_6
   >= 0
 t_activation_ZN_m1_4_m1_8_1_6: ut_ZN_c_r[1,6] - y_ZN_edge_m1_4_m1_8_r_6
   >= 0
 t_activation_ZN_m1_4_m1_8_2_6: ut_ZN_c_r[2,6] - y_ZN_edge_m1_4_m1_8_r_6
   >= 0
 t_activation_ZN_m1_4_m1_8_0_5: ut_ZN_c_r[0,5] - y_ZN_edge_m1_4_m1_8_r_5
   >= 0
 t_activation_ZN_m1_4_m1_8_1_5: ut_ZN_c_r[1,5] - y_ZN_edge_m1_4_m1_8_r_5
   >= 0
 t_activation_ZN_m1_4_m1_8_2_5: ut_ZN_c_r[2,5] - y_ZN_edge_m1_4_m1_8_r_5
   >= 0
 t_activation_ZN_m1_4_m1_8_0_4: ut_ZN_c_r[0,4] - y_ZN_edge_m1_4_m1_8_r_4
   >= 0
 t_activation_ZN_m1_4_m1_8_1_4: ut_ZN_c_r[1,4] - y_ZN_edge_m1_4_m1_8_r_4
   >= 0
 t_activation_ZN_m1_4_m1_8_2_4: ut_ZN_c_r[2,4] - y_ZN_edge_m1_4_m1_8_r_4
   >= 0
 flow_conservation_ZN_ac_3: f_ZN_edge_connector_pv_3_ac_3_co
   + f_ZN_edge_connector_nv_3_ac_3_co - cap_ZN_ac_3 = 0
 flow_conservation_ZN_nn_3: f_ZN_edge_connector_nv_3_nn_3_co - cap_ZN_nn_3
   = 0
 middle_node_ZN_nv_3: cap_ZN_nv_3 = 0
 flow_conservation_ZN_nv_3: - f_ZN_edge_connector_nv_3_nn_3_co
   - f_ZN_edge_connector_nv_3_ac_3_co - f_ZN_edge_nv_3_nv_4_1
   - f_ZN_edge_nv_3_nv_4_0 - cap_ZN_nv_3 = 0
 flow_conservation_ZN_pp_3: f_ZN_edge_connector_pv_3_pp_3_co - cap_ZN_pp_3
   = 0
 middle_node_ZN_pv_3: cap_ZN_pv_3 = 0
 flow_conservation_ZN_pv_3: - f_ZN_edge_connector_pv_3_pp_3_co
   - f_ZN_edge_connector_pv_3_ac_3_co - f_ZN_edge_pv_3_pv_4_3
   - f_ZN_edge_pv_3_pv_4_2 - cap_ZN_pv_3 = 0
 middle_node_ZN_m1_4: cap_ZN_m1_4 = 0
 flow_conservation_ZN_m1_4: - f_ZN_edge_via_enable_m1_4_pv_4
   - f_ZN_edge_via_enable_m1_4_nv_4 - f_ZN_edge_m1_4_m1_8_r_7
   - f_ZN_edge_m1_4_m1_8_r_6 - f_ZN_edge_m1_4_m1_8_r_5
   - f_ZN_edge_m1_4_m1_8_r_4 - cap_ZN_m1_4 = 0
 middle_node_ZN_nv_4: cap_ZN_nv_4 = 0
 flow_conservation_ZN_nv_4: f_ZN_edge_nv_3_nv_4_1 + f_ZN_edge_nv_3_nv_4_0
   - f_ZN_edge_nv_4_nv_6_1 - f_ZN_edge_nv_4_nv_6_0
   + f_ZN_edge_via_enable_m1_4_nv_4 - cap_ZN_nv_4 = 0
 middle_node_ZN_pv_4: cap_ZN_pv_4 = 0
 flow_conservation_ZN_pv_4: f_ZN_edge_pv_3_pv_4_3 + f_ZN_edge_pv_3_pv_4_2
   - f_ZN_edge_pv_4_pv_6_3 - f_ZN_edge_pv_4_pv_6_2
   + f_ZN_edge_via_enable_m1_4_pv_4 - cap_ZN_pv_4 = 0
 flow_conservation_ZN_ac_6: f_ZN_edge_connector_pv_6_ac_6_co
   + f_ZN_edge_connector_nv_6_ac_6_co - cap_ZN_ac_6 = 0
 flow_conservation_ZN_nn_6: f_ZN_edge_connector_nv_6_nn_6_co - cap_ZN_nn_6
   = 0
 middle_node_ZN_nv_6: cap_ZN_nv_6 = 0
 flow_conservation_ZN_nv_6: - f_ZN_edge_connector_nv_6_nn_6_co
   - f_ZN_edge_connector_nv_6_ac_6_co + f_ZN_edge_nv_4_nv_6_1
   + f_ZN_edge_nv_4_nv_6_0 - f_ZN_edge_nv_6_nv_8_1 - f_ZN_edge_nv_6_nv_8_0
   - cap_ZN_nv_6 = 0
 flow_conservation_ZN_pp_6: f_ZN_edge_connector_pv_6_pp_6_co - cap_ZN_pp_6
   = 0
 middle_node_ZN_pv_6: cap_ZN_pv_6 = 0
 flow_conservation_ZN_pv_6: - f_ZN_edge_connector_pv_6_pp_6_co
   - f_ZN_edge_connector_pv_6_ac_6_co + f_ZN_edge_pv_4_pv_6_3
   + f_ZN_edge_pv_4_pv_6_2 - f_ZN_edge_pv_6_pv_8_3 - f_ZN_edge_pv_6_pv_8_2
   - cap_ZN_pv_6 = 0
 middle_node_ZN_m1_8: cap_ZN_m1_8 = 0
 flow_conservation_ZN_m1_8: f_ZN_edge_m1_4_m1_8_r_7
   + f_ZN_edge_m1_4_m1_8_r_6 + f_ZN_edge_m1_4_m1_8_r_5
   + f_ZN_edge_m1_4_m1_8_r_4 - f_ZN_edge_via_enable_m1_8_pv_8
   - f_ZN_edge_via_enable_m1_8_nv_8 - cap_ZN_m1_8 = 0
 middle_node_ZN_nv_8: cap_ZN_nv_8 = 0
 flow_conservation_ZN_nv_8: f_ZN_edge_nv_6_nv_8_1 + f_ZN_edge_nv_6_nv_8_0
   - f_ZN_edge_nv_8_nv_9_1 - f_ZN_edge_nv_8_nv_9_0
   + f_ZN_edge_via_enable_m1_8_nv_8 - cap_ZN_nv_8 = 0
 middle_node_ZN_pv_8: cap_ZN_pv_8 = 0
 flow_conservation_ZN_pv_8: f_ZN_edge_pv_6_pv_8_3 + f_ZN_edge_pv_6_pv_8_2
   - f_ZN_edge_pv_8_pv_9_3 - f_ZN_edge_pv_8_pv_9_2
   + f_ZN_edge_via_enable_m1_8_pv_8 - cap_ZN_pv_8 = 0
 flow_conservation_ZN_ac_9: f_ZN_edge_connector_pv_9_ac_9_co
   + f_ZN_edge_connector_nv_9_ac_9_co - cap_ZN_ac_9 = 0
 flow_conservation_ZN_nn_9: f_ZN_edge_connector_nv_9_nn_9_co - cap_ZN_nn_9
   = 0
 middle_node_ZN_nv_9: cap_ZN_nv_9 = 0
 flow_conservation_ZN_nv_9: - f_ZN_edge_connector_nv_9_nn_9_co
   - f_ZN_edge_connector_nv_9_ac_9_co + f_ZN_edge_nv_8_nv_9_1
   + f_ZN_edge_nv_8_nv_9_0 - cap_ZN_nv_9 = 0
 flow_conservation_ZN_pp_9: f_ZN_edge_connector_pv_9_pp_9_co - cap_ZN_pp_9
   = 0
 middle_node_ZN_pv_9: cap_ZN_pv_9 = 0
 flow_conservation_ZN_pv_9: - f_ZN_edge_connector_pv_9_pp_9_co
   - f_ZN_edge_connector_pv_9_ac_9_co + f_ZN_edge_pv_8_pv_9_3
   + f_ZN_edge_pv_8_pv_9_2 - cap_ZN_pv_9 = 0
 root_find_I_pp_3: indicator_I_pp_3 - root_node_I_pp_3 >= 0
 root_find_I_nn_3: indicator_I_nn_3 - root_node_I_nn_3 >= 0
 root_find_I_ac_3: indicator_I_ac_3 - root_node_I_ac_3 >= 0
 max_indicator_find_I_pp_3: indicator_I_pp_3 - max_indicator_I_pp_3 >= 0
 max_indicator_find_I_nn_3: indicator_I_nn_3 - max_indicator_I_nn_3 >= 0
 max_indicator_find_I_ac_3: indicator_I_ac_3 - max_indicator_I_ac_3 >= 0
 lower_bound_I_ac_3: - pmos_net_I_c0 - nmos_net_I_c0 + indicator_I_ac_3
   >= -1
 upper_bound_v1_I_ac_3: - pmos_net_I_c0 + indicator_I_ac_3 <= 0
 upper_bound_v2_I_ac_3: - nmos_net_I_c0 + indicator_I_ac_3 <= 0
 combined_net_I_pp_3: - pmos_net_I_c0 + indicator_I_pp_3 + indicator_I_ac_3
   = 0
 combined_net_I_nn_3: - nmos_net_I_c0 + indicator_I_nn_3 + indicator_I_ac_3
   = 0
 min_indicator_constr_p_I_0: min_indicator_I + 3 indicator_I_pp_3 <= 3
 min_indicator_constr_n_I_0: min_indicator_I + 3 indicator_I_nn_3 <= 3
 min_indicator_constr_a_I_0: min_indicator_I + 3 indicator_I_ac_3 <= 3
 root_node_match_p_I_0: - min_indicator_I <= 0
 root_node_match_n_I_0: - min_indicator_I <= 0
 root_node_match_a_I_0: - min_indicator_I <= 0
 max_bbox_constr_p_I_0: max_bbox_I - 3 indicator_I_pp_3 >= -3
 max_bbox_constr_n_I_0: max_bbox_I - 3 indicator_I_nn_3 >= -3
 max_bbox_constr_a_I_0: max_bbox_I - 3 indicator_I_ac_3 >= -3
 max_indicator_match_p_I_0: - max_bbox_I - 2 max_indicator_I_pp_3 >= -2
 max_indicator_match_n_I_0: - max_bbox_I - 2 max_indicator_I_nn_3 >= -2
 max_indicator_match_a_I_0: - max_bbox_I - 2 max_indicator_I_ac_3 >= -2
 root_find_I_pp_6: indicator_I_pp_6 - root_node_I_pp_6 >= 0
 root_find_I_nn_6: indicator_I_nn_6 - root_node_I_nn_6 >= 0
 root_find_I_ac_6: indicator_I_ac_6 - root_node_I_ac_6 >= 0
 max_indicator_find_I_pp_6: indicator_I_pp_6 - max_indicator_I_pp_6 >= 0
 max_indicator_find_I_nn_6: indicator_I_nn_6 - max_indicator_I_nn_6 >= 0
 max_indicator_find_I_ac_6: indicator_I_ac_6 - max_indicator_I_ac_6 >= 0
 lower_bound_I_ac_6: - pmos_net_I_c1 - nmos_net_I_c1 + indicator_I_ac_6
   >= -1
 upper_bound_v1_I_ac_6: - pmos_net_I_c1 + indicator_I_ac_6 <= 0
 upper_bound_v2_I_ac_6: - nmos_net_I_c1 + indicator_I_ac_6 <= 0
 combined_net_I_pp_6: - pmos_net_I_c1 + indicator_I_pp_6 + indicator_I_ac_6
   = 0
 combined_net_I_nn_6: - nmos_net_I_c1 + indicator_I_nn_6 + indicator_I_ac_6
   = 0
 min_indicator_constr_p_I_1: min_indicator_I + 3 indicator_I_pp_6 <= 4
 min_indicator_constr_n_I_1: min_indicator_I + 3 indicator_I_nn_6 <= 4
 min_indicator_constr_a_I_1: min_indicator_I + 3 indicator_I_ac_6 <= 4
 root_node_match_p_I_1: - min_indicator_I + root_node_I_pp_6 <= 0
 root_node_match_n_I_1: - min_indicator_I + root_node_I_nn_6 <= 0
 root_node_match_a_I_1: - min_indicator_I + root_node_I_ac_6 <= 0
 max_bbox_constr_p_I_1: max_bbox_I - 3 indicator_I_pp_6 >= -2
 max_bbox_constr_n_I_1: max_bbox_I - 3 indicator_I_nn_6 >= -2
 max_bbox_constr_a_I_1: max_bbox_I - 3 indicator_I_ac_6 >= -2
 max_indicator_match_p_I_1: - max_bbox_I - max_indicator_I_pp_6 >= -2
 max_indicator_match_n_I_1: - max_bbox_I - max_indicator_I_nn_6 >= -2
 max_indicator_match_a_I_1: - max_bbox_I - max_indicator_I_ac_6 >= -2
 root_find_I_pp_9: indicator_I_pp_9 - root_node_I_pp_9 >= 0
 root_find_I_nn_9: indicator_I_nn_9 - root_node_I_nn_9 >= 0
 root_find_I_ac_9: indicator_I_ac_9 - root_node_I_ac_9 >= 0
 max_indicator_find_I_pp_9: indicator_I_pp_9 - max_indicator_I_pp_9 >= 0
 max_indicator_find_I_nn_9: indicator_I_nn_9 - max_indicator_I_nn_9 >= 0
 max_indicator_find_I_ac_9: indicator_I_ac_9 - max_indicator_I_ac_9 >= 0
 lower_bound_I_ac_9: - pmos_net_I_c2 - nmos_net_I_c2 + indicator_I_ac_9
   >= -1
 upper_bound_v1_I_ac_9: - pmos_net_I_c2 + indicator_I_ac_9 <= 0
 upper_bound_v2_I_ac_9: - nmos_net_I_c2 + indicator_I_ac_9 <= 0
 combined_net_I_pp_9: - pmos_net_I_c2 + indicator_I_pp_9 + indicator_I_ac_9
   = 0
 combined_net_I_nn_9: - nmos_net_I_c2 + indicator_I_nn_9 + indicator_I_ac_9
   = 0
 min_indicator_constr_p_I_2: min_indicator_I + 3 indicator_I_pp_9 <= 5
 min_indicator_constr_n_I_2: min_indicator_I + 3 indicator_I_nn_9 <= 5
 min_indicator_constr_a_I_2: min_indicator_I + 3 indicator_I_ac_9 <= 5
 root_node_match_p_I_2: - min_indicator_I + 2 root_node_I_pp_9 <= 0
 root_node_match_n_I_2: - min_indicator_I + 2 root_node_I_nn_9 <= 0
 root_node_match_a_I_2: - min_indicator_I + 2 root_node_I_ac_9 <= 0
 max_bbox_constr_p_I_2: max_bbox_I - 3 indicator_I_pp_9 >= -1
 max_bbox_constr_n_I_2: max_bbox_I - 3 indicator_I_nn_9 >= -1
 max_bbox_constr_a_I_2: max_bbox_I - 3 indicator_I_ac_9 >= -1
 max_indicator_match_p_I_2: - max_bbox_I >= -2
 max_indicator_match_n_I_2: - max_bbox_I >= -2
 max_indicator_match_a_I_2: - max_bbox_I >= -2
 one_root_node_enable_I: root_node_I_pp_3 + root_node_I_nn_3
   + root_node_I_ac_3 + root_node_I_pp_6 + root_node_I_nn_6
   + root_node_I_ac_6 + root_node_I_pp_9 + root_node_I_nn_9
   + root_node_I_ac_9 = 1
 one_max_indicator_enable_I: max_indicator_I_pp_3 + max_indicator_I_nn_3
   + max_indicator_I_ac_3 + max_indicator_I_pp_6 + max_indicator_I_nn_6
   + max_indicator_I_ac_6 + max_indicator_I_pp_9 + max_indicator_I_nn_9
   + max_indicator_I_ac_9 = 1
 y_detector_dtermine_lb_I_nv_8: - indicator_I_pp_3 - indicator_I_nn_3
   - indicator_I_ac_3 - indicator_I_pp_6 - indicator_I_nn_6
   - indicator_I_ac_6 - indicator_I_pp_9 - indicator_I_nn_9
   - indicator_I_ac_9 + 3 io_detector_I >= 0
 y_detector_dtermine_ub_I_nv_8: - indicator_I_pp_3 - indicator_I_nn_3
   - indicator_I_ac_3 - indicator_I_pp_6 - indicator_I_nn_6
   - indicator_I_ac_6 - indicator_I_pp_9 - indicator_I_nn_9
   - indicator_I_ac_9 + io_detector_I <= 0
 on_off_constraint_by_indicator_I_pv_3_pp_3_co: - indicator_I_pp_3
   + y_I_edge_connector_pv_3_pp_3_co <= 0
 on_off_constraint_by_sum_actives_I_pv_3_pp_3_co: - io_detector_I
   + y_I_edge_connector_pv_3_pp_3_co <= 0
 on_off_constraint_by_mixing_I_pv_3_pp_3_co: - indicator_I_pp_3
   - io_detector_I + y_I_edge_connector_pv_3_pp_3_co >= -1
 edge_flow_ub_I_pv_3_pp_3_ve: - 2 y_I_edge_connector_pv_3_pp_3_co
   + f_I_edge_connector_pv_3_pp_3_co <= 0
 edge_flow_lb_I_pv_3_pp_3_ve: 2 y_I_edge_connector_pv_3_pp_3_co
   + f_I_edge_connector_pv_3_pp_3_co >= 0
 on_off_constraint_by_indicator_I_pv_3_ac_3_co: - indicator_I_ac_3
   + y_I_edge_connector_pv_3_ac_3_co <= 0
 on_off_constraint_by_sum_actives_I_pv_3_ac_3_co: - io_detector_I
   + y_I_edge_connector_pv_3_ac_3_co <= 0
 on_off_constraint_by_mixing_I_pv_3_ac_3_co: - indicator_I_ac_3
   - io_detector_I + y_I_edge_connector_pv_3_ac_3_co >= -1
 edge_flow_ub_I_pv_3_ac_3_ve: - 2 y_I_edge_connector_pv_3_ac_3_co
   + f_I_edge_connector_pv_3_ac_3_co <= 0
 edge_flow_lb_I_pv_3_ac_3_ve: 2 y_I_edge_connector_pv_3_ac_3_co
   + f_I_edge_connector_pv_3_ac_3_co >= 0
 on_off_constraint_by_indicator_I_nv_3_nn_3_co: - indicator_I_nn_3
   + y_I_edge_connector_nv_3_nn_3_co <= 0
 on_off_constraint_by_sum_actives_I_nv_3_nn_3_co: - io_detector_I
   + y_I_edge_connector_nv_3_nn_3_co <= 0
 on_off_constraint_by_mixing_I_nv_3_nn_3_co: - indicator_I_nn_3
   - io_detector_I + y_I_edge_connector_nv_3_nn_3_co >= -1
 edge_flow_ub_I_nv_3_nn_3_ve: - 2 y_I_edge_connector_nv_3_nn_3_co
   + f_I_edge_connector_nv_3_nn_3_co <= 0
 edge_flow_lb_I_nv_3_nn_3_ve: 2 y_I_edge_connector_nv_3_nn_3_co
   + f_I_edge_connector_nv_3_nn_3_co >= 0
 on_off_constraint_by_indicator_I_nv_3_ac_3_co: - indicator_I_ac_3
   + y_I_edge_connector_nv_3_ac_3_co <= 0
 on_off_constraint_by_sum_actives_I_nv_3_ac_3_co: - io_detector_I
   + y_I_edge_connector_nv_3_ac_3_co <= 0
 on_off_constraint_by_mixing_I_nv_3_ac_3_co: - indicator_I_ac_3
   - io_detector_I + y_I_edge_connector_nv_3_ac_3_co >= -1
 edge_flow_ub_I_nv_3_ac_3_ve: - 2 y_I_edge_connector_nv_3_ac_3_co
   + f_I_edge_connector_nv_3_ac_3_co <= 0
 edge_flow_lb_I_nv_3_ac_3_ve: 2 y_I_edge_connector_nv_3_ac_3_co
   + f_I_edge_connector_nv_3_ac_3_co >= 0
 on_off_constraint_by_indicator_I_pv_6_pp_6_co: - indicator_I_pp_6
   + y_I_edge_connector_pv_6_pp_6_co <= 0
 on_off_constraint_by_sum_actives_I_pv_6_pp_6_co: - io_detector_I
   + y_I_edge_connector_pv_6_pp_6_co <= 0
 on_off_constraint_by_mixing_I_pv_6_pp_6_co: - indicator_I_pp_6
   - io_detector_I + y_I_edge_connector_pv_6_pp_6_co >= -1
 edge_flow_ub_I_pv_6_pp_6_ve: - 2 y_I_edge_connector_pv_6_pp_6_co
   + f_I_edge_connector_pv_6_pp_6_co <= 0
 edge_flow_lb_I_pv_6_pp_6_ve: 2 y_I_edge_connector_pv_6_pp_6_co
   + f_I_edge_connector_pv_6_pp_6_co >= 0
 on_off_constraint_by_indicator_I_pv_6_ac_6_co: - indicator_I_ac_6
   + y_I_edge_connector_pv_6_ac_6_co <= 0
 on_off_constraint_by_sum_actives_I_pv_6_ac_6_co: - io_detector_I
   + y_I_edge_connector_pv_6_ac_6_co <= 0
 on_off_constraint_by_mixing_I_pv_6_ac_6_co: - indicator_I_ac_6
   - io_detector_I + y_I_edge_connector_pv_6_ac_6_co >= -1
 edge_flow_ub_I_pv_6_ac_6_ve: - 2 y_I_edge_connector_pv_6_ac_6_co
   + f_I_edge_connector_pv_6_ac_6_co <= 0
 edge_flow_lb_I_pv_6_ac_6_ve: 2 y_I_edge_connector_pv_6_ac_6_co
   + f_I_edge_connector_pv_6_ac_6_co >= 0
 on_off_constraint_by_indicator_I_nv_6_nn_6_co: - indicator_I_nn_6
   + y_I_edge_connector_nv_6_nn_6_co <= 0
 on_off_constraint_by_sum_actives_I_nv_6_nn_6_co: - io_detector_I
   + y_I_edge_connector_nv_6_nn_6_co <= 0
 on_off_constraint_by_mixing_I_nv_6_nn_6_co: - indicator_I_nn_6
   - io_detector_I + y_I_edge_connector_nv_6_nn_6_co >= -1
 edge_flow_ub_I_nv_6_nn_6_ve: - 2 y_I_edge_connector_nv_6_nn_6_co
   + f_I_edge_connector_nv_6_nn_6_co <= 0
 edge_flow_lb_I_nv_6_nn_6_ve: 2 y_I_edge_connector_nv_6_nn_6_co
   + f_I_edge_connector_nv_6_nn_6_co >= 0
 on_off_constraint_by_indicator_I_nv_6_ac_6_co: - indicator_I_ac_6
   + y_I_edge_connector_nv_6_ac_6_co <= 0
 on_off_constraint_by_sum_actives_I_nv_6_ac_6_co: - io_detector_I
   + y_I_edge_connector_nv_6_ac_6_co <= 0
 on_off_constraint_by_mixing_I_nv_6_ac_6_co: - indicator_I_ac_6
   - io_detector_I + y_I_edge_connector_nv_6_ac_6_co >= -1
 edge_flow_ub_I_nv_6_ac_6_ve: - 2 y_I_edge_connector_nv_6_ac_6_co
   + f_I_edge_connector_nv_6_ac_6_co <= 0
 edge_flow_lb_I_nv_6_ac_6_ve: 2 y_I_edge_connector_nv_6_ac_6_co
   + f_I_edge_connector_nv_6_ac_6_co >= 0
 on_off_constraint_by_indicator_I_pv_9_pp_9_co: - indicator_I_pp_9
   + y_I_edge_connector_pv_9_pp_9_co <= 0
 on_off_constraint_by_sum_actives_I_pv_9_pp_9_co: - io_detector_I
   + y_I_edge_connector_pv_9_pp_9_co <= 0
 on_off_constraint_by_mixing_I_pv_9_pp_9_co: - indicator_I_pp_9
   - io_detector_I + y_I_edge_connector_pv_9_pp_9_co >= -1
 edge_flow_ub_I_pv_9_pp_9_ve: - 2 y_I_edge_connector_pv_9_pp_9_co
   + f_I_edge_connector_pv_9_pp_9_co <= 0
 edge_flow_lb_I_pv_9_pp_9_ve: 2 y_I_edge_connector_pv_9_pp_9_co
   + f_I_edge_connector_pv_9_pp_9_co >= 0
 on_off_constraint_by_indicator_I_pv_9_ac_9_co: - indicator_I_ac_9
   + y_I_edge_connector_pv_9_ac_9_co <= 0
 on_off_constraint_by_sum_actives_I_pv_9_ac_9_co: - io_detector_I
   + y_I_edge_connector_pv_9_ac_9_co <= 0
 on_off_constraint_by_mixing_I_pv_9_ac_9_co: - indicator_I_ac_9
   - io_detector_I + y_I_edge_connector_pv_9_ac_9_co >= -1
 edge_flow_ub_I_pv_9_ac_9_ve: - 2 y_I_edge_connector_pv_9_ac_9_co
   + f_I_edge_connector_pv_9_ac_9_co <= 0
 edge_flow_lb_I_pv_9_ac_9_ve: 2 y_I_edge_connector_pv_9_ac_9_co
   + f_I_edge_connector_pv_9_ac_9_co >= 0
 on_off_constraint_by_indicator_I_nv_9_nn_9_co: - indicator_I_nn_9
   + y_I_edge_connector_nv_9_nn_9_co <= 0
 on_off_constraint_by_sum_actives_I_nv_9_nn_9_co: - io_detector_I
   + y_I_edge_connector_nv_9_nn_9_co <= 0
 on_off_constraint_by_mixing_I_nv_9_nn_9_co: - indicator_I_nn_9
   - io_detector_I + y_I_edge_connector_nv_9_nn_9_co >= -1
 edge_flow_ub_I_nv_9_nn_9_ve: - 2 y_I_edge_connector_nv_9_nn_9_co
   + f_I_edge_connector_nv_9_nn_9_co <= 0
 edge_flow_lb_I_nv_9_nn_9_ve: 2 y_I_edge_connector_nv_9_nn_9_co
   + f_I_edge_connector_nv_9_nn_9_co >= 0
 on_off_constraint_by_indicator_I_nv_9_ac_9_co: - indicator_I_ac_9
   + y_I_edge_connector_nv_9_ac_9_co <= 0
 on_off_constraint_by_sum_actives_I_nv_9_ac_9_co: - io_detector_I
   + y_I_edge_connector_nv_9_ac_9_co <= 0
 on_off_constraint_by_mixing_I_nv_9_ac_9_co: - indicator_I_ac_9
   - io_detector_I + y_I_edge_connector_nv_9_ac_9_co >= -1
 edge_flow_ub_I_nv_9_ac_9_ve: - 2 y_I_edge_connector_nv_9_ac_9_co
   + f_I_edge_connector_nv_9_ac_9_co <= 0
 edge_flow_lb_I_nv_9_ac_9_ve: 2 y_I_edge_connector_nv_9_ac_9_co
   + f_I_edge_connector_nv_9_ac_9_co >= 0
 row_selection_on_off_rule1_I_pp_3: - 2 indicator_I_pp_3
   + c_mar_row_I_pp_3_r[3] + c_mar_row_I_pp_3_r[2] <= 0
 row_selection_on_off_rule2_I_pp_3: - 2 io_detector_I
   + c_mar_row_I_pp_3_r[3] + c_mar_row_I_pp_3_r[2] <= 0
 row_selection_on_off_rule3_I_pp_3: - indicator_I_pp_3 - io_detector_I
   + c_mar_row_I_pp_3_r[3] + c_mar_row_I_pp_3_r[2] >= -1
 case_selection_on_off_rule1_I_pp_3_3: - c_mar_row_I_pp_3_r[3]
   + c_mar_row_I_pp_3_3_case[0] <= 0
 case_selection_on_off_rule2_I_pp_3_3: - c_mar_row_I_pp_3_r[3]
   + c_mar_row_I_pp_3_3_case[0] >= 0
 mar_constraint_I_pp_3_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_pp_3_3_case[0] <= 0
 mar_constraint_I_pp_3_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_pp_3_3_case[0] <= 0
 mar_constraint_I_pp_3_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_pp_3_3_case[0] <= 0
 case_selection_on_off_rule1_I_pp_3_2: - c_mar_row_I_pp_3_r[2]
   + c_mar_row_I_pp_3_2_case[0] <= 0
 case_selection_on_off_rule2_I_pp_3_2: - c_mar_row_I_pp_3_r[2]
   + c_mar_row_I_pp_3_2_case[0] >= 0
 mar_constraint_I_pp_3_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_pp_3_2_case[0] <= 0
 mar_constraint_I_pp_3_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_pp_3_2_case[0] <= 0
 mar_constraint_I_pp_3_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_pp_3_2_case[0] <= 0
 row_selection_on_off_rule1_I_nn_3: - 2 indicator_I_nn_3
   + c_mar_row_I_nn_3_r[1] + c_mar_row_I_nn_3_r[0] <= 0
 row_selection_on_off_rule2_I_nn_3: - 2 io_detector_I
   + c_mar_row_I_nn_3_r[1] + c_mar_row_I_nn_3_r[0] <= 0
 row_selection_on_off_rule3_I_nn_3: - indicator_I_nn_3 - io_detector_I
   + c_mar_row_I_nn_3_r[1] + c_mar_row_I_nn_3_r[0] >= -1
 case_selection_on_off_rule1_I_nn_3_1: - c_mar_row_I_nn_3_r[1]
   + c_mar_row_I_nn_3_1_case[0] <= 0
 case_selection_on_off_rule2_I_nn_3_1: - c_mar_row_I_nn_3_r[1]
   + c_mar_row_I_nn_3_1_case[0] >= 0
 mar_constraint_I_nn_3_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_nn_3_1_case[0] <= 0
 mar_constraint_I_nn_3_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_nn_3_1_case[0] <= 0
 mar_constraint_I_nn_3_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_nn_3_1_case[0] <= 0
 case_selection_on_off_rule1_I_nn_3_0: - c_mar_row_I_nn_3_r[0]
   + c_mar_row_I_nn_3_0_case[0] <= 0
 case_selection_on_off_rule2_I_nn_3_0: - c_mar_row_I_nn_3_r[0]
   + c_mar_row_I_nn_3_0_case[0] >= 0
 mar_constraint_I_nn_3_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_nn_3_0_case[0] <= 0
 mar_constraint_I_nn_3_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_nn_3_0_case[0] <= 0
 mar_constraint_I_nn_3_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_nn_3_0_case[0] <= 0
 row_selection_on_off_rule1_I_ac_3: - 4 indicator_I_ac_3
   + c_mar_row_I_ac_3_r[3] + c_mar_row_I_ac_3_r[2] + c_mar_row_I_ac_3_r[1]
   + c_mar_row_I_ac_3_r[0] <= 0
 row_selection_on_off_rule2_I_ac_3: - 4 io_detector_I
   + c_mar_row_I_ac_3_r[3] + c_mar_row_I_ac_3_r[2] + c_mar_row_I_ac_3_r[1]
   + c_mar_row_I_ac_3_r[0] <= 0
 row_selection_on_off_rule3_I_ac_3: - indicator_I_ac_3 - io_detector_I
   + c_mar_row_I_ac_3_r[3] + c_mar_row_I_ac_3_r[2] + c_mar_row_I_ac_3_r[1]
   + c_mar_row_I_ac_3_r[0] >= -1
 case_selection_on_off_rule1_I_ac_3_3: - c_mar_row_I_ac_3_r[3]
   + c_mar_row_I_ac_3_3_case[0] <= 0
 case_selection_on_off_rule2_I_ac_3_3: - c_mar_row_I_ac_3_r[3]
   + c_mar_row_I_ac_3_3_case[0] >= 0
 mar_constraint_I_ac_3_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_ac_3_3_case[0] <= 0
 mar_constraint_I_ac_3_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_ac_3_3_case[0] <= 0
 mar_constraint_I_ac_3_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_ac_3_3_case[0] <= 0
 case_selection_on_off_rule1_I_ac_3_2: - c_mar_row_I_ac_3_r[2]
   + c_mar_row_I_ac_3_2_case[0] <= 0
 case_selection_on_off_rule2_I_ac_3_2: - c_mar_row_I_ac_3_r[2]
   + c_mar_row_I_ac_3_2_case[0] >= 0
 mar_constraint_I_ac_3_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_ac_3_2_case[0] <= 0
 mar_constraint_I_ac_3_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_ac_3_2_case[0] <= 0
 mar_constraint_I_ac_3_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_ac_3_2_case[0] <= 0
 case_selection_on_off_rule1_I_ac_3_1: - c_mar_row_I_ac_3_r[1]
   + c_mar_row_I_ac_3_1_case[0] <= 0
 case_selection_on_off_rule2_I_ac_3_1: - c_mar_row_I_ac_3_r[1]
   + c_mar_row_I_ac_3_1_case[0] >= 0
 mar_constraint_I_ac_3_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_ac_3_1_case[0] <= 0
 mar_constraint_I_ac_3_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_ac_3_1_case[0] <= 0
 mar_constraint_I_ac_3_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_ac_3_1_case[0] <= 0
 case_selection_on_off_rule1_I_ac_3_0: - c_mar_row_I_ac_3_r[0]
   + c_mar_row_I_ac_3_0_case[0] <= 0
 case_selection_on_off_rule2_I_ac_3_0: - c_mar_row_I_ac_3_r[0]
   + c_mar_row_I_ac_3_0_case[0] >= 0
 mar_constraint_I_ac_3_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_ac_3_0_case[0] <= 0
 mar_constraint_I_ac_3_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_ac_3_0_case[0] <= 0
 mar_constraint_I_ac_3_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_ac_3_0_case[0] <= 0
 row_selection_on_off_rule1_I_pp_6: - 2 indicator_I_pp_6
   + c_mar_row_I_pp_6_r[3] + c_mar_row_I_pp_6_r[2] <= 0
 row_selection_on_off_rule2_I_pp_6: - 2 io_detector_I
   + c_mar_row_I_pp_6_r[3] + c_mar_row_I_pp_6_r[2] <= 0
 row_selection_on_off_rule3_I_pp_6: - indicator_I_pp_6 - io_detector_I
   + c_mar_row_I_pp_6_r[3] + c_mar_row_I_pp_6_r[2] >= -1
 case_selection_on_off_rule1_I_pp_6_3: - c_mar_row_I_pp_6_r[3]
   + c_mar_row_I_pp_6_3_case[0] + c_mar_row_I_pp_6_3_case[1] <= 0
 case_selection_on_off_rule2_I_pp_6_3: - c_mar_row_I_pp_6_r[3]
   + c_mar_row_I_pp_6_3_case[0] + c_mar_row_I_pp_6_3_case[1] >= 0
 mar_constraint_I_pp_6_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_pp_6_3_case[0] <= 0
 mar_constraint_I_pp_6_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_pp_6_3_case[0] <= 0
 mar_constraint_I_pp_6_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_pp_6_3_case[0] <= 0
 mar_constraint_I_pp_6_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_pp_6_3_case[1] <= 0
 mar_constraint_I_pp_6_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_pp_6_3_case[1] <= 0
 mar_constraint_I_pp_6_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_pp_6_3_case[1] <= 0
 case_selection_on_off_rule1_I_pp_6_2: - c_mar_row_I_pp_6_r[2]
   + c_mar_row_I_pp_6_2_case[0] + c_mar_row_I_pp_6_2_case[1] <= 0
 case_selection_on_off_rule2_I_pp_6_2: - c_mar_row_I_pp_6_r[2]
   + c_mar_row_I_pp_6_2_case[0] + c_mar_row_I_pp_6_2_case[1] >= 0
 mar_constraint_I_pp_6_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_pp_6_2_case[0] <= 0
 mar_constraint_I_pp_6_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_pp_6_2_case[0] <= 0
 mar_constraint_I_pp_6_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_pp_6_2_case[0] <= 0
 mar_constraint_I_pp_6_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_pp_6_2_case[1] <= 0
 mar_constraint_I_pp_6_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_pp_6_2_case[1] <= 0
 mar_constraint_I_pp_6_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_pp_6_2_case[1] <= 0
 row_selection_on_off_rule1_I_nn_6: - 2 indicator_I_nn_6
   + c_mar_row_I_nn_6_r[1] + c_mar_row_I_nn_6_r[0] <= 0
 row_selection_on_off_rule2_I_nn_6: - 2 io_detector_I
   + c_mar_row_I_nn_6_r[1] + c_mar_row_I_nn_6_r[0] <= 0
 row_selection_on_off_rule3_I_nn_6: - indicator_I_nn_6 - io_detector_I
   + c_mar_row_I_nn_6_r[1] + c_mar_row_I_nn_6_r[0] >= -1
 case_selection_on_off_rule1_I_nn_6_1: - c_mar_row_I_nn_6_r[1]
   + c_mar_row_I_nn_6_1_case[0] + c_mar_row_I_nn_6_1_case[1] <= 0
 case_selection_on_off_rule2_I_nn_6_1: - c_mar_row_I_nn_6_r[1]
   + c_mar_row_I_nn_6_1_case[0] + c_mar_row_I_nn_6_1_case[1] >= 0
 mar_constraint_I_nn_6_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_nn_6_1_case[0] <= 0
 mar_constraint_I_nn_6_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_nn_6_1_case[0] <= 0
 mar_constraint_I_nn_6_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_nn_6_1_case[0] <= 0
 mar_constraint_I_nn_6_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_nn_6_1_case[1] <= 0
 mar_constraint_I_nn_6_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_nn_6_1_case[1] <= 0
 mar_constraint_I_nn_6_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_nn_6_1_case[1] <= 0
 case_selection_on_off_rule1_I_nn_6_0: - c_mar_row_I_nn_6_r[0]
   + c_mar_row_I_nn_6_0_case[0] + c_mar_row_I_nn_6_0_case[1] <= 0
 case_selection_on_off_rule2_I_nn_6_0: - c_mar_row_I_nn_6_r[0]
   + c_mar_row_I_nn_6_0_case[0] + c_mar_row_I_nn_6_0_case[1] >= 0
 mar_constraint_I_nn_6_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_nn_6_0_case[0] <= 0
 mar_constraint_I_nn_6_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_nn_6_0_case[0] <= 0
 mar_constraint_I_nn_6_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_nn_6_0_case[0] <= 0
 mar_constraint_I_nn_6_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_nn_6_0_case[1] <= 0
 mar_constraint_I_nn_6_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_nn_6_0_case[1] <= 0
 mar_constraint_I_nn_6_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_nn_6_0_case[1] <= 0
 row_selection_on_off_rule1_I_ac_6: - 4 indicator_I_ac_6
   + c_mar_row_I_ac_6_r[3] + c_mar_row_I_ac_6_r[2] + c_mar_row_I_ac_6_r[1]
   + c_mar_row_I_ac_6_r[0] <= 0
 row_selection_on_off_rule2_I_ac_6: - 4 io_detector_I
   + c_mar_row_I_ac_6_r[3] + c_mar_row_I_ac_6_r[2] + c_mar_row_I_ac_6_r[1]
   + c_mar_row_I_ac_6_r[0] <= 0
 row_selection_on_off_rule3_I_ac_6: - indicator_I_ac_6 - io_detector_I
   + c_mar_row_I_ac_6_r[3] + c_mar_row_I_ac_6_r[2] + c_mar_row_I_ac_6_r[1]
   + c_mar_row_I_ac_6_r[0] >= -1
 case_selection_on_off_rule1_I_ac_6_3: - c_mar_row_I_ac_6_r[3]
   + c_mar_row_I_ac_6_3_case[0] + c_mar_row_I_ac_6_3_case[1] <= 0
 case_selection_on_off_rule2_I_ac_6_3: - c_mar_row_I_ac_6_r[3]
   + c_mar_row_I_ac_6_3_case[0] + c_mar_row_I_ac_6_3_case[1] >= 0
 mar_constraint_I_ac_6_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_ac_6_3_case[0] <= 0
 mar_constraint_I_ac_6_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_ac_6_3_case[0] <= 0
 mar_constraint_I_ac_6_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_ac_6_3_case[0] <= 0
 mar_constraint_I_ac_6_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_ac_6_3_case[1] <= 0
 mar_constraint_I_ac_6_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_ac_6_3_case[1] <= 0
 mar_constraint_I_ac_6_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_ac_6_3_case[1] <= 0
 case_selection_on_off_rule1_I_ac_6_2: - c_mar_row_I_ac_6_r[2]
   + c_mar_row_I_ac_6_2_case[0] + c_mar_row_I_ac_6_2_case[1] <= 0
 case_selection_on_off_rule2_I_ac_6_2: - c_mar_row_I_ac_6_r[2]
   + c_mar_row_I_ac_6_2_case[0] + c_mar_row_I_ac_6_2_case[1] >= 0
 mar_constraint_I_ac_6_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_ac_6_2_case[0] <= 0
 mar_constraint_I_ac_6_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_ac_6_2_case[0] <= 0
 mar_constraint_I_ac_6_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_ac_6_2_case[0] <= 0
 mar_constraint_I_ac_6_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_ac_6_2_case[1] <= 0
 mar_constraint_I_ac_6_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_ac_6_2_case[1] <= 0
 mar_constraint_I_ac_6_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_ac_6_2_case[1] <= 0
 case_selection_on_off_rule1_I_ac_6_1: - c_mar_row_I_ac_6_r[1]
   + c_mar_row_I_ac_6_1_case[0] + c_mar_row_I_ac_6_1_case[1] <= 0
 case_selection_on_off_rule2_I_ac_6_1: - c_mar_row_I_ac_6_r[1]
   + c_mar_row_I_ac_6_1_case[0] + c_mar_row_I_ac_6_1_case[1] >= 0
 mar_constraint_I_ac_6_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_ac_6_1_case[0] <= 0
 mar_constraint_I_ac_6_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_ac_6_1_case[0] <= 0
 mar_constraint_I_ac_6_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_ac_6_1_case[0] <= 0
 mar_constraint_I_ac_6_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_ac_6_1_case[1] <= 0
 mar_constraint_I_ac_6_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_ac_6_1_case[1] <= 0
 mar_constraint_I_ac_6_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_ac_6_1_case[1] <= 0
 case_selection_on_off_rule1_I_ac_6_0: - c_mar_row_I_ac_6_r[0]
   + c_mar_row_I_ac_6_0_case[0] + c_mar_row_I_ac_6_0_case[1] <= 0
 case_selection_on_off_rule2_I_ac_6_0: - c_mar_row_I_ac_6_r[0]
   + c_mar_row_I_ac_6_0_case[0] + c_mar_row_I_ac_6_0_case[1] >= 0
 mar_constraint_I_ac_6_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_ac_6_0_case[0] <= 0
 mar_constraint_I_ac_6_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_ac_6_0_case[0] <= 0
 mar_constraint_I_ac_6_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_ac_6_0_case[0] <= 0
 mar_constraint_I_ac_6_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_ac_6_0_case[1] <= 0
 mar_constraint_I_ac_6_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_ac_6_0_case[1] <= 0
 mar_constraint_I_ac_6_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_ac_6_0_case[1] <= 0
 row_selection_on_off_rule1_I_pp_9: - 2 indicator_I_pp_9
   + c_mar_row_I_pp_9_r[3] + c_mar_row_I_pp_9_r[2] <= 0
 row_selection_on_off_rule2_I_pp_9: - 2 io_detector_I
   + c_mar_row_I_pp_9_r[3] + c_mar_row_I_pp_9_r[2] <= 0
 row_selection_on_off_rule3_I_pp_9: - indicator_I_pp_9 - io_detector_I
   + c_mar_row_I_pp_9_r[3] + c_mar_row_I_pp_9_r[2] >= -1
 case_selection_on_off_rule1_I_pp_9_3: - c_mar_row_I_pp_9_r[3]
   + c_mar_row_I_pp_9_3_case[0] <= 0
 case_selection_on_off_rule2_I_pp_9_3: - c_mar_row_I_pp_9_r[3]
   + c_mar_row_I_pp_9_3_case[0] >= 0
 mar_constraint_I_pp_9_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_pp_9_3_case[0] <= 0
 mar_constraint_I_pp_9_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_pp_9_3_case[0] <= 0
 mar_constraint_I_pp_9_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_pp_9_3_case[0] <= 0
 case_selection_on_off_rule1_I_pp_9_2: - c_mar_row_I_pp_9_r[2]
   + c_mar_row_I_pp_9_2_case[0] <= 0
 case_selection_on_off_rule2_I_pp_9_2: - c_mar_row_I_pp_9_r[2]
   + c_mar_row_I_pp_9_2_case[0] >= 0
 mar_constraint_I_pp_9_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_pp_9_2_case[0] <= 0
 mar_constraint_I_pp_9_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_pp_9_2_case[0] <= 0
 mar_constraint_I_pp_9_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_pp_9_2_case[0] <= 0
 row_selection_on_off_rule1_I_nn_9: - 2 indicator_I_nn_9
   + c_mar_row_I_nn_9_r[1] + c_mar_row_I_nn_9_r[0] <= 0
 row_selection_on_off_rule2_I_nn_9: - 2 io_detector_I
   + c_mar_row_I_nn_9_r[1] + c_mar_row_I_nn_9_r[0] <= 0
 row_selection_on_off_rule3_I_nn_9: - indicator_I_nn_9 - io_detector_I
   + c_mar_row_I_nn_9_r[1] + c_mar_row_I_nn_9_r[0] >= -1
 case_selection_on_off_rule1_I_nn_9_1: - c_mar_row_I_nn_9_r[1]
   + c_mar_row_I_nn_9_1_case[0] <= 0
 case_selection_on_off_rule2_I_nn_9_1: - c_mar_row_I_nn_9_r[1]
   + c_mar_row_I_nn_9_1_case[0] >= 0
 mar_constraint_I_nn_9_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_nn_9_1_case[0] <= 0
 mar_constraint_I_nn_9_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_nn_9_1_case[0] <= 0
 mar_constraint_I_nn_9_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_nn_9_1_case[0] <= 0
 case_selection_on_off_rule1_I_nn_9_0: - c_mar_row_I_nn_9_r[0]
   + c_mar_row_I_nn_9_0_case[0] <= 0
 case_selection_on_off_rule2_I_nn_9_0: - c_mar_row_I_nn_9_r[0]
   + c_mar_row_I_nn_9_0_case[0] >= 0
 mar_constraint_I_nn_9_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_nn_9_0_case[0] <= 0
 mar_constraint_I_nn_9_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_nn_9_0_case[0] <= 0
 mar_constraint_I_nn_9_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_nn_9_0_case[0] <= 0
 row_selection_on_off_rule1_I_ac_9: - 4 indicator_I_ac_9
   + c_mar_row_I_ac_9_r[3] + c_mar_row_I_ac_9_r[2] + c_mar_row_I_ac_9_r[1]
   + c_mar_row_I_ac_9_r[0] <= 0
 row_selection_on_off_rule2_I_ac_9: - 4 io_detector_I
   + c_mar_row_I_ac_9_r[3] + c_mar_row_I_ac_9_r[2] + c_mar_row_I_ac_9_r[1]
   + c_mar_row_I_ac_9_r[0] <= 0
 row_selection_on_off_rule3_I_ac_9: - indicator_I_ac_9 - io_detector_I
   + c_mar_row_I_ac_9_r[3] + c_mar_row_I_ac_9_r[2] + c_mar_row_I_ac_9_r[1]
   + c_mar_row_I_ac_9_r[0] >= -1
 case_selection_on_off_rule1_I_ac_9_3: - c_mar_row_I_ac_9_r[3]
   + c_mar_row_I_ac_9_3_case[0] <= 0
 case_selection_on_off_rule2_I_ac_9_3: - c_mar_row_I_ac_9_r[3]
   + c_mar_row_I_ac_9_3_case[0] >= 0
 mar_constraint_I_ac_9_3_left_edge: - t_I_c_r[0,3]
   + c_mar_row_I_ac_9_3_case[0] <= 0
 mar_constraint_I_ac_9_3_real_metal: - t_I_c_r[1,3]
   + c_mar_row_I_ac_9_3_case[0] <= 0
 mar_constraint_I_ac_9_3_right_edge: - t_I_c_r[2,3]
   + c_mar_row_I_ac_9_3_case[0] <= 0
 case_selection_on_off_rule1_I_ac_9_2: - c_mar_row_I_ac_9_r[2]
   + c_mar_row_I_ac_9_2_case[0] <= 0
 case_selection_on_off_rule2_I_ac_9_2: - c_mar_row_I_ac_9_r[2]
   + c_mar_row_I_ac_9_2_case[0] >= 0
 mar_constraint_I_ac_9_2_left_edge: - t_I_c_r[0,2]
   + c_mar_row_I_ac_9_2_case[0] <= 0
 mar_constraint_I_ac_9_2_real_metal: - t_I_c_r[1,2]
   + c_mar_row_I_ac_9_2_case[0] <= 0
 mar_constraint_I_ac_9_2_right_edge: - t_I_c_r[2,2]
   + c_mar_row_I_ac_9_2_case[0] <= 0
 case_selection_on_off_rule1_I_ac_9_1: - c_mar_row_I_ac_9_r[1]
   + c_mar_row_I_ac_9_1_case[0] <= 0
 case_selection_on_off_rule2_I_ac_9_1: - c_mar_row_I_ac_9_r[1]
   + c_mar_row_I_ac_9_1_case[0] >= 0
 mar_constraint_I_ac_9_1_left_edge: - t_I_c_r[0,1]
   + c_mar_row_I_ac_9_1_case[0] <= 0
 mar_constraint_I_ac_9_1_real_metal: - t_I_c_r[1,1]
   + c_mar_row_I_ac_9_1_case[0] <= 0
 mar_constraint_I_ac_9_1_right_edge: - t_I_c_r[2,1]
   + c_mar_row_I_ac_9_1_case[0] <= 0
 case_selection_on_off_rule1_I_ac_9_0: - c_mar_row_I_ac_9_r[0]
   + c_mar_row_I_ac_9_0_case[0] <= 0
 case_selection_on_off_rule2_I_ac_9_0: - c_mar_row_I_ac_9_r[0]
   + c_mar_row_I_ac_9_0_case[0] >= 0
 mar_constraint_I_ac_9_0_left_edge: - t_I_c_r[0,0]
   + c_mar_row_I_ac_9_0_case[0] <= 0
 mar_constraint_I_ac_9_0_real_metal: - t_I_c_r[1,0]
   + c_mar_row_I_ac_9_0_case[0] <= 0
 mar_constraint_I_ac_9_0_right_edge: - t_I_c_r[2,0]
   + c_mar_row_I_ac_9_0_case[0] <= 0
 global_zero_constraint_I_pv_3_pv_4_3: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_3_pv_4_3 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_3_pv_4_3: min_indicator_I
   + 3 y_I_edge_pv_3_pv_4_3 <= 4
 active_c_ge_max_bbox_min_bbox_I_pv_3_pv_4_3: - max_bbox_I
   + 3 y_I_edge_pv_3_pv_4_3 <= 2
 edge_flow_ub_I_pv_3_pv_4_3: - 2 y_I_edge_pv_3_pv_4_3
   + f_I_edge_pv_3_pv_4_3 <= 0
 edge_flow_lb_I_pv_3_pv_4_3: 2 y_I_edge_pv_3_pv_4_3 + f_I_edge_pv_3_pv_4_3
   >= 0
 global_zero_constraint_I_pv_3_pv_4_2: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_3_pv_4_2 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_3_pv_4_2: min_indicator_I
   + 3 y_I_edge_pv_3_pv_4_2 <= 4
 active_c_ge_max_bbox_min_bbox_I_pv_3_pv_4_2: - max_bbox_I
   + 3 y_I_edge_pv_3_pv_4_2 <= 2
 edge_flow_ub_I_pv_3_pv_4_2: - 2 y_I_edge_pv_3_pv_4_2
   + f_I_edge_pv_3_pv_4_2 <= 0
 edge_flow_lb_I_pv_3_pv_4_2: 2 y_I_edge_pv_3_pv_4_2 + f_I_edge_pv_3_pv_4_2
   >= 0
 global_zero_constraint_I_nv_3_nv_4_1: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_3_nv_4_1 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_3_nv_4_1: min_indicator_I
   + 3 y_I_edge_nv_3_nv_4_1 <= 4
 active_c_ge_max_bbox_min_bbox_I_nv_3_nv_4_1: - max_bbox_I
   + 3 y_I_edge_nv_3_nv_4_1 <= 2
 edge_flow_ub_I_nv_3_nv_4_1: - 2 y_I_edge_nv_3_nv_4_1
   + f_I_edge_nv_3_nv_4_1 <= 0
 edge_flow_lb_I_nv_3_nv_4_1: 2 y_I_edge_nv_3_nv_4_1 + f_I_edge_nv_3_nv_4_1
   >= 0
 global_zero_constraint_I_nv_3_nv_4_0: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_3_nv_4_0 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_3_nv_4_0: min_indicator_I
   + 3 y_I_edge_nv_3_nv_4_0 <= 4
 active_c_ge_max_bbox_min_bbox_I_nv_3_nv_4_0: - max_bbox_I
   + 3 y_I_edge_nv_3_nv_4_0 <= 2
 edge_flow_ub_I_nv_3_nv_4_0: - 2 y_I_edge_nv_3_nv_4_0
   + f_I_edge_nv_3_nv_4_0 <= 0
 edge_flow_lb_I_nv_3_nv_4_0: 2 y_I_edge_nv_3_nv_4_0 + f_I_edge_nv_3_nv_4_0
   >= 0
 global_zero_constraint_I_pv_4_pv_6_3: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_4_pv_6_3 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_4_pv_6_3: min_indicator_I
   + 3 y_I_edge_pv_4_pv_6_3 <= 4
 active_c_ge_max_bbox_min_bbox_I_pv_4_pv_6_3: - max_bbox_I
   + 3 y_I_edge_pv_4_pv_6_3 <= 2
 edge_flow_ub_I_pv_4_pv_6_3: - 2 y_I_edge_pv_4_pv_6_3
   + f_I_edge_pv_4_pv_6_3 <= 0
 edge_flow_lb_I_pv_4_pv_6_3: 2 y_I_edge_pv_4_pv_6_3 + f_I_edge_pv_4_pv_6_3
   >= 0
 global_zero_constraint_I_pv_4_pv_6_2: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_4_pv_6_2 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_4_pv_6_2: min_indicator_I
   + 3 y_I_edge_pv_4_pv_6_2 <= 4
 active_c_ge_max_bbox_min_bbox_I_pv_4_pv_6_2: - max_bbox_I
   + 3 y_I_edge_pv_4_pv_6_2 <= 2
 edge_flow_ub_I_pv_4_pv_6_2: - 2 y_I_edge_pv_4_pv_6_2
   + f_I_edge_pv_4_pv_6_2 <= 0
 edge_flow_lb_I_pv_4_pv_6_2: 2 y_I_edge_pv_4_pv_6_2 + f_I_edge_pv_4_pv_6_2
   >= 0
 global_zero_constraint_I_nv_4_nv_6_1: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_4_nv_6_1 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_4_nv_6_1: min_indicator_I
   + 3 y_I_edge_nv_4_nv_6_1 <= 4
 active_c_ge_max_bbox_min_bbox_I_nv_4_nv_6_1: - max_bbox_I
   + 3 y_I_edge_nv_4_nv_6_1 <= 2
 edge_flow_ub_I_nv_4_nv_6_1: - 2 y_I_edge_nv_4_nv_6_1
   + f_I_edge_nv_4_nv_6_1 <= 0
 edge_flow_lb_I_nv_4_nv_6_1: 2 y_I_edge_nv_4_nv_6_1 + f_I_edge_nv_4_nv_6_1
   >= 0
 global_zero_constraint_I_nv_4_nv_6_0: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_4_nv_6_0 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_4_nv_6_0: min_indicator_I
   + 3 y_I_edge_nv_4_nv_6_0 <= 4
 active_c_ge_max_bbox_min_bbox_I_nv_4_nv_6_0: - max_bbox_I
   + 3 y_I_edge_nv_4_nv_6_0 <= 2
 edge_flow_ub_I_nv_4_nv_6_0: - 2 y_I_edge_nv_4_nv_6_0
   + f_I_edge_nv_4_nv_6_0 <= 0
 edge_flow_lb_I_nv_4_nv_6_0: 2 y_I_edge_nv_4_nv_6_0 + f_I_edge_nv_4_nv_6_0
   >= 0
 global_zero_constraint_I_pv_6_pv_8_3: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_6_pv_8_3 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_6_pv_8_3: min_indicator_I
   + 3 y_I_edge_pv_6_pv_8_3 <= 5
 active_c_ge_max_bbox_min_bbox_I_pv_6_pv_8_3: - max_bbox_I
   + 3 y_I_edge_pv_6_pv_8_3 <= 1
 edge_flow_ub_I_pv_6_pv_8_3: - 2 y_I_edge_pv_6_pv_8_3
   + f_I_edge_pv_6_pv_8_3 <= 0
 edge_flow_lb_I_pv_6_pv_8_3: 2 y_I_edge_pv_6_pv_8_3 + f_I_edge_pv_6_pv_8_3
   >= 0
 global_zero_constraint_I_pv_6_pv_8_2: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_6_pv_8_2 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_6_pv_8_2: min_indicator_I
   + 3 y_I_edge_pv_6_pv_8_2 <= 5
 active_c_ge_max_bbox_min_bbox_I_pv_6_pv_8_2: - max_bbox_I
   + 3 y_I_edge_pv_6_pv_8_2 <= 1
 edge_flow_ub_I_pv_6_pv_8_2: - 2 y_I_edge_pv_6_pv_8_2
   + f_I_edge_pv_6_pv_8_2 <= 0
 edge_flow_lb_I_pv_6_pv_8_2: 2 y_I_edge_pv_6_pv_8_2 + f_I_edge_pv_6_pv_8_2
   >= 0
 global_zero_constraint_I_nv_6_nv_8_1: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_6_nv_8_1 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_6_nv_8_1: min_indicator_I
   + 3 y_I_edge_nv_6_nv_8_1 <= 5
 active_c_ge_max_bbox_min_bbox_I_nv_6_nv_8_1: - max_bbox_I
   + 3 y_I_edge_nv_6_nv_8_1 <= 1
 edge_flow_ub_I_nv_6_nv_8_1: - 2 y_I_edge_nv_6_nv_8_1
   + f_I_edge_nv_6_nv_8_1 <= 0
 edge_flow_lb_I_nv_6_nv_8_1: 2 y_I_edge_nv_6_nv_8_1 + f_I_edge_nv_6_nv_8_1
   >= 0
 global_zero_constraint_I_nv_6_nv_8_0: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_6_nv_8_0 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_6_nv_8_0: min_indicator_I
   + 3 y_I_edge_nv_6_nv_8_0 <= 5
 active_c_ge_max_bbox_min_bbox_I_nv_6_nv_8_0: - max_bbox_I
   + 3 y_I_edge_nv_6_nv_8_0 <= 1
 edge_flow_ub_I_nv_6_nv_8_0: - 2 y_I_edge_nv_6_nv_8_0
   + f_I_edge_nv_6_nv_8_0 <= 0
 edge_flow_lb_I_nv_6_nv_8_0: 2 y_I_edge_nv_6_nv_8_0 + f_I_edge_nv_6_nv_8_0
   >= 0
 global_zero_constraint_I_pv_8_pv_9_3: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_8_pv_9_3 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_8_pv_9_3: min_indicator_I
   + 3 y_I_edge_pv_8_pv_9_3 <= 5
 active_c_ge_max_bbox_min_bbox_I_pv_8_pv_9_3: - max_bbox_I
   + 3 y_I_edge_pv_8_pv_9_3 <= 1
 edge_flow_ub_I_pv_8_pv_9_3: - 2 y_I_edge_pv_8_pv_9_3
   + f_I_edge_pv_8_pv_9_3 <= 0
 edge_flow_lb_I_pv_8_pv_9_3: 2 y_I_edge_pv_8_pv_9_3 + f_I_edge_pv_8_pv_9_3
   >= 0
 global_zero_constraint_I_pv_8_pv_9_2: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_pv_8_pv_9_2 <= -1
 active_c_ge_min_indicator_min_bbox_I_pv_8_pv_9_2: min_indicator_I
   + 3 y_I_edge_pv_8_pv_9_2 <= 5
 active_c_ge_max_bbox_min_bbox_I_pv_8_pv_9_2: - max_bbox_I
   + 3 y_I_edge_pv_8_pv_9_2 <= 1
 edge_flow_ub_I_pv_8_pv_9_2: - 2 y_I_edge_pv_8_pv_9_2
   + f_I_edge_pv_8_pv_9_2 <= 0
 edge_flow_lb_I_pv_8_pv_9_2: 2 y_I_edge_pv_8_pv_9_2 + f_I_edge_pv_8_pv_9_2
   >= 0
 global_zero_constraint_I_nv_8_nv_9_1: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_8_nv_9_1 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_8_nv_9_1: min_indicator_I
   + 3 y_I_edge_nv_8_nv_9_1 <= 5
 active_c_ge_max_bbox_min_bbox_I_nv_8_nv_9_1: - max_bbox_I
   + 3 y_I_edge_nv_8_nv_9_1 <= 1
 edge_flow_ub_I_nv_8_nv_9_1: - 2 y_I_edge_nv_8_nv_9_1
   + f_I_edge_nv_8_nv_9_1 <= 0
 edge_flow_lb_I_nv_8_nv_9_1: 2 y_I_edge_nv_8_nv_9_1 + f_I_edge_nv_8_nv_9_1
   >= 0
 global_zero_constraint_I_nv_8_nv_9_0: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_nv_8_nv_9_0 <= -1
 active_c_ge_min_indicator_min_bbox_I_nv_8_nv_9_0: min_indicator_I
   + 3 y_I_edge_nv_8_nv_9_0 <= 5
 active_c_ge_max_bbox_min_bbox_I_nv_8_nv_9_0: - max_bbox_I
   + 3 y_I_edge_nv_8_nv_9_0 <= 1
 edge_flow_ub_I_nv_8_nv_9_0: - 2 y_I_edge_nv_8_nv_9_0
   + f_I_edge_nv_8_nv_9_0 <= 0
 edge_flow_lb_I_nv_8_nv_9_0: 2 y_I_edge_nv_8_nv_9_0 + f_I_edge_nv_8_nv_9_0
   >= 0
 global_zero_constraint_I_m1_4_pv_4_ve: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_via_enable_m1_4_pv_4
   <= -1
 active_c_ge_min_indicator_min_one_I_m1_4_pv_4_ve: min_indicator_I
   + 3 y_I_edge_via_enable_m1_4_pv_4 <= 4
 active_c_ge_max_bbox_min_bbox_I_m1_4_pv_4_ve: - max_bbox_I
   + 3 y_I_edge_via_enable_m1_4_pv_4 <= 2
 edge_flow_ub_I_m1_4_pv_4_ve: - 2 y_I_edge_via_enable_m1_4_pv_4
   + f_I_edge_via_enable_m1_4_pv_4 <= 0
 edge_flow_lb_I_m1_4_pv_4_ve: 2 y_I_edge_via_enable_m1_4_pv_4
   + f_I_edge_via_enable_m1_4_pv_4 >= 0
 global_zero_constraint_I_m1_4_nv_4_ve: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_via_enable_m1_4_nv_4
   <= -1
 active_c_ge_min_indicator_min_one_I_m1_4_nv_4_ve: min_indicator_I
   + 3 y_I_edge_via_enable_m1_4_nv_4 <= 4
 active_c_ge_max_bbox_min_bbox_I_m1_4_nv_4_ve: - max_bbox_I
   + 3 y_I_edge_via_enable_m1_4_nv_4 <= 2
 edge_flow_ub_I_m1_4_nv_4_ve: - 2 y_I_edge_via_enable_m1_4_nv_4
   + f_I_edge_via_enable_m1_4_nv_4 <= 0
 edge_flow_lb_I_m1_4_nv_4_ve: 2 y_I_edge_via_enable_m1_4_nv_4
   + f_I_edge_via_enable_m1_4_nv_4 >= 0
 global_zero_constraint_I_m1_4_m1_8_7: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_m1_4_m1_8_r_7 <= -1
 active_c_ge_min_indicator_min_one_I_m1_4_m1_8_7: min_indicator_I
   + 3 y_I_edge_m1_4_m1_8_r_7 <= 5
 active_c_ge_max_bbox_min_bbox_I_m1_4_m1_8_7: - max_bbox_I
   + 3 y_I_edge_m1_4_m1_8_r_7 <= 1
 edge_flow_ub_I_m1_4_m1_8_7: - 2 y_I_edge_m1_4_m1_8_r_7
   + f_I_edge_m1_4_m1_8_r_7 <= 0
 edge_flow_lb_I_m1_4_m1_8_7: 2 y_I_edge_m1_4_m1_8_r_7
   + f_I_edge_m1_4_m1_8_r_7 >= 0
 global_zero_constraint_I_m1_4_m1_8_6: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_m1_4_m1_8_r_6 <= -1
 active_c_ge_min_indicator_min_one_I_m1_4_m1_8_6: min_indicator_I
   + 3 y_I_edge_m1_4_m1_8_r_6 <= 5
 active_c_ge_max_bbox_min_bbox_I_m1_4_m1_8_6: - max_bbox_I
   + 3 y_I_edge_m1_4_m1_8_r_6 <= 1
 edge_flow_ub_I_m1_4_m1_8_6: - 2 y_I_edge_m1_4_m1_8_r_6
   + f_I_edge_m1_4_m1_8_r_6 <= 0
 edge_flow_lb_I_m1_4_m1_8_6: 2 y_I_edge_m1_4_m1_8_r_6
   + f_I_edge_m1_4_m1_8_r_6 >= 0
 global_zero_constraint_I_m1_4_m1_8_5: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_m1_4_m1_8_r_5 <= -1
 active_c_ge_min_indicator_min_one_I_m1_4_m1_8_5: min_indicator_I
   + 3 y_I_edge_m1_4_m1_8_r_5 <= 5
 active_c_ge_max_bbox_min_bbox_I_m1_4_m1_8_5: - max_bbox_I
   + 3 y_I_edge_m1_4_m1_8_r_5 <= 1
 edge_flow_ub_I_m1_4_m1_8_5: - 2 y_I_edge_m1_4_m1_8_r_5
   + f_I_edge_m1_4_m1_8_r_5 <= 0
 edge_flow_lb_I_m1_4_m1_8_5: 2 y_I_edge_m1_4_m1_8_r_5
   + f_I_edge_m1_4_m1_8_r_5 >= 0
 global_zero_constraint_I_m1_4_m1_8_4: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_m1_4_m1_8_r_4 <= -1
 active_c_ge_min_indicator_min_one_I_m1_4_m1_8_4: min_indicator_I
   + 3 y_I_edge_m1_4_m1_8_r_4 <= 5
 active_c_ge_max_bbox_min_bbox_I_m1_4_m1_8_4: - max_bbox_I
   + 3 y_I_edge_m1_4_m1_8_r_4 <= 1
 edge_flow_ub_I_m1_4_m1_8_4: - 2 y_I_edge_m1_4_m1_8_r_4
   + f_I_edge_m1_4_m1_8_r_4 <= 0
 edge_flow_lb_I_m1_4_m1_8_4: 2 y_I_edge_m1_4_m1_8_r_4
   + f_I_edge_m1_4_m1_8_r_4 >= 0
 global_zero_constraint_I_m1_8_pv_8_ve: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_via_enable_m1_8_pv_8
   <= -1
 active_c_ge_min_indicator_min_one_I_m1_8_pv_8_ve: min_indicator_I
   + 3 y_I_edge_via_enable_m1_8_pv_8 <= 5
 active_c_ge_max_bbox_min_bbox_I_m1_8_pv_8_ve: - max_bbox_I
   + 3 y_I_edge_via_enable_m1_8_pv_8 <= 1
 edge_flow_ub_I_m1_8_pv_8_ve: - 2 y_I_edge_via_enable_m1_8_pv_8
   + f_I_edge_via_enable_m1_8_pv_8 <= 0
 edge_flow_lb_I_m1_8_pv_8_ve: 2 y_I_edge_via_enable_m1_8_pv_8
   + f_I_edge_via_enable_m1_8_pv_8 >= 0
 global_zero_constraint_I_m1_8_nv_8_ve: - indicator_I_pp_3
   - indicator_I_nn_3 - indicator_I_ac_3 - indicator_I_pp_6
   - indicator_I_nn_6 - indicator_I_ac_6 - indicator_I_pp_9
   - indicator_I_nn_9 - indicator_I_ac_9 + y_I_edge_via_enable_m1_8_nv_8
   <= -1
 active_c_ge_min_indicator_min_one_I_m1_8_nv_8_ve: min_indicator_I
   + 3 y_I_edge_via_enable_m1_8_nv_8 <= 5
 active_c_ge_max_bbox_min_bbox_I_m1_8_nv_8_ve: - max_bbox_I
   + 3 y_I_edge_via_enable_m1_8_nv_8 <= 1
 edge_flow_ub_I_m1_8_nv_8_ve: - 2 y_I_edge_via_enable_m1_8_nv_8
   + f_I_edge_via_enable_m1_8_nv_8 <= 0
 edge_flow_lb_I_m1_8_nv_8_ve: 2 y_I_edge_via_enable_m1_8_nv_8
   + f_I_edge_via_enable_m1_8_nv_8 >= 0
 via_enable_I_pv_9_pv_4: - v_I_v[0] + y_I_edge_via_enable_m1_4_pv_4 <= 0
 via_enable_I_pv_9_nv_4: - v_I_v[0] + y_I_edge_via_enable_m1_4_nv_4 <= 0
 via_enable_I_pv_9_pv_8: - v_I_v[1] + y_I_edge_via_enable_m1_8_pv_8 <= 0
 via_enable_I_pv_9_nv_8: - v_I_v[1] + y_I_edge_via_enable_m1_8_nv_8 <= 0
 t_activation_I_pv_3_pv_4_0_3: t_I_c_r[0,3] - y_I_edge_pv_3_pv_4_3 >= 0
 t_activation_I_pv_3_pv_4_1_3: t_I_c_r[1,3] - y_I_edge_pv_3_pv_4_3 >= 0
 logical_constraint_I_pv_3_pv_4_j_index_3: - t_eol_c_r[2,3] - t_I_c_r[2,3]
   + y_I_edge_pv_3_pv_4_3 <= 0
 t_activation_I_pv_3_pv_4_0_2: t_I_c_r[0,2] - y_I_edge_pv_3_pv_4_2 >= 0
 t_activation_I_pv_3_pv_4_1_2: t_I_c_r[1,2] - y_I_edge_pv_3_pv_4_2 >= 0
 logical_constraint_I_pv_3_pv_4_j_index_2: - t_eol_c_r[2,2] - t_I_c_r[2,2]
   + y_I_edge_pv_3_pv_4_2 <= 0
 t_activation_I_nv_3_nv_4_0_1: t_I_c_r[0,1] - y_I_edge_nv_3_nv_4_1 >= 0
 t_activation_I_nv_3_nv_4_1_1: t_I_c_r[1,1] - y_I_edge_nv_3_nv_4_1 >= 0
 logical_constraint_I_nv_3_nv_4_j_index_1: - t_eol_c_r[2,1] - t_I_c_r[2,1]
   + y_I_edge_nv_3_nv_4_1 <= 0
 t_activation_I_nv_3_nv_4_0_0: t_I_c_r[0,0] - y_I_edge_nv_3_nv_4_0 >= 0
 t_activation_I_nv_3_nv_4_1_0: t_I_c_r[1,0] - y_I_edge_nv_3_nv_4_0 >= 0
 logical_constraint_I_nv_3_nv_4_j_index_0: - t_eol_c_r[2,0] - t_I_c_r[2,0]
   + y_I_edge_nv_3_nv_4_0 <= 0
 t_activation_I_pv_4_pv_6_0_3: t_I_c_r[0,3] - y_I_edge_pv_4_pv_6_3 >= 0
 t_activation_I_pv_4_pv_6_1_3: t_I_c_r[1,3] - y_I_edge_pv_4_pv_6_3 >= 0
 logical_constraint_I_pv_4_pv_6_j_index_3: - t_eol_c_r[2,3] - t_I_c_r[2,3]
   + y_I_edge_pv_4_pv_6_3 <= 0
 t_activation_I_pv_4_pv_6_0_2: t_I_c_r[0,2] - y_I_edge_pv_4_pv_6_2 >= 0
 t_activation_I_pv_4_pv_6_1_2: t_I_c_r[1,2] - y_I_edge_pv_4_pv_6_2 >= 0
 logical_constraint_I_pv_4_pv_6_j_index_2: - t_eol_c_r[2,2] - t_I_c_r[2,2]
   + y_I_edge_pv_4_pv_6_2 <= 0
 t_activation_I_nv_4_nv_6_0_1: t_I_c_r[0,1] - y_I_edge_nv_4_nv_6_1 >= 0
 t_activation_I_nv_4_nv_6_1_1: t_I_c_r[1,1] - y_I_edge_nv_4_nv_6_1 >= 0
 logical_constraint_I_nv_4_nv_6_j_index_1: - t_eol_c_r[2,1] - t_I_c_r[2,1]
   + y_I_edge_nv_4_nv_6_1 <= 0
 t_activation_I_nv_4_nv_6_0_0: t_I_c_r[0,0] - y_I_edge_nv_4_nv_6_0 >= 0
 t_activation_I_nv_4_nv_6_1_0: t_I_c_r[1,0] - y_I_edge_nv_4_nv_6_0 >= 0
 logical_constraint_I_nv_4_nv_6_j_index_0: - t_eol_c_r[2,0] - t_I_c_r[2,0]
   + y_I_edge_nv_4_nv_6_0 <= 0
 t_activation_I_pv_6_pv_8_1_3: t_I_c_r[1,3] - y_I_edge_pv_6_pv_8_3 >= 0
 t_activation_I_pv_6_pv_8_2_3: t_I_c_r[2,3] - y_I_edge_pv_6_pv_8_3 >= 0
 logical_constraint_I_pv_6_pv_8_i_index_minus_1_3: - t_eol_c_r[0,3]
   - t_I_c_r[0,3] + y_I_edge_pv_6_pv_8_3 <= 0
 t_activation_I_pv_6_pv_8_1_2: t_I_c_r[1,2] - y_I_edge_pv_6_pv_8_2 >= 0
 t_activation_I_pv_6_pv_8_2_2: t_I_c_r[2,2] - y_I_edge_pv_6_pv_8_2 >= 0
 logical_constraint_I_pv_6_pv_8_i_index_minus_1_2: - t_eol_c_r[0,2]
   - t_I_c_r[0,2] + y_I_edge_pv_6_pv_8_2 <= 0
 t_activation_I_nv_6_nv_8_1_1: t_I_c_r[1,1] - y_I_edge_nv_6_nv_8_1 >= 0
 t_activation_I_nv_6_nv_8_2_1: t_I_c_r[2,1] - y_I_edge_nv_6_nv_8_1 >= 0
 logical_constraint_I_nv_6_nv_8_i_index_minus_1_1: - t_eol_c_r[0,1]
   - t_I_c_r[0,1] + y_I_edge_nv_6_nv_8_1 <= 0
 t_activation_I_nv_6_nv_8_1_0: t_I_c_r[1,0] - y_I_edge_nv_6_nv_8_0 >= 0
 t_activation_I_nv_6_nv_8_2_0: t_I_c_r[2,0] - y_I_edge_nv_6_nv_8_0 >= 0
 logical_constraint_I_nv_6_nv_8_i_index_minus_1_0: - t_eol_c_r[0,0]
   - t_I_c_r[0,0] + y_I_edge_nv_6_nv_8_0 <= 0
 t_activation_I_pv_8_pv_9_1_3: t_I_c_r[1,3] - y_I_edge_pv_8_pv_9_3 >= 0
 t_activation_I_pv_8_pv_9_2_3: t_I_c_r[2,3] - y_I_edge_pv_8_pv_9_3 >= 0
 logical_constraint_I_pv_8_pv_9_i_index_minus_1_3: - t_eol_c_r[0,3]
   - t_I_c_r[0,3] + y_I_edge_pv_8_pv_9_3 <= 0
 t_activation_I_pv_8_pv_9_1_2: t_I_c_r[1,2] - y_I_edge_pv_8_pv_9_2 >= 0
 t_activation_I_pv_8_pv_9_2_2: t_I_c_r[2,2] - y_I_edge_pv_8_pv_9_2 >= 0
 logical_constraint_I_pv_8_pv_9_i_index_minus_1_2: - t_eol_c_r[0,2]
   - t_I_c_r[0,2] + y_I_edge_pv_8_pv_9_2 <= 0
 t_activation_I_nv_8_nv_9_1_1: t_I_c_r[1,1] - y_I_edge_nv_8_nv_9_1 >= 0
 t_activation_I_nv_8_nv_9_2_1: t_I_c_r[2,1] - y_I_edge_nv_8_nv_9_1 >= 0
 logical_constraint_I_nv_8_nv_9_i_index_minus_1_1: - t_eol_c_r[0,1]
   - t_I_c_r[0,1] + y_I_edge_nv_8_nv_9_1 <= 0
 t_activation_I_nv_8_nv_9_1_0: t_I_c_r[1,0] - y_I_edge_nv_8_nv_9_0 >= 0
 t_activation_I_nv_8_nv_9_2_0: t_I_c_r[2,0] - y_I_edge_nv_8_nv_9_0 >= 0
 logical_constraint_I_nv_8_nv_9_i_index_minus_1_0: - t_eol_c_r[0,0]
   - t_I_c_r[0,0] + y_I_edge_nv_8_nv_9_0 <= 0
 t_activation_I_m1_4_m1_8_0_7: ut_I_c_r[0,7] - y_I_edge_m1_4_m1_8_r_7 >= 0
 t_activation_I_m1_4_m1_8_1_7: ut_I_c_r[1,7] - y_I_edge_m1_4_m1_8_r_7 >= 0
 t_activation_I_m1_4_m1_8_2_7: ut_I_c_r[2,7] - y_I_edge_m1_4_m1_8_r_7 >= 0
 t_activation_I_m1_4_m1_8_0_6: ut_I_c_r[0,6] - y_I_edge_m1_4_m1_8_r_6 >= 0
 t_activation_I_m1_4_m1_8_1_6: ut_I_c_r[1,6] - y_I_edge_m1_4_m1_8_r_6 >= 0
 t_activation_I_m1_4_m1_8_2_6: ut_I_c_r[2,6] - y_I_edge_m1_4_m1_8_r_6 >= 0
 t_activation_I_m1_4_m1_8_0_5: ut_I_c_r[0,5] - y_I_edge_m1_4_m1_8_r_5 >= 0
 t_activation_I_m1_4_m1_8_1_5: ut_I_c_r[1,5] - y_I_edge_m1_4_m1_8_r_5 >= 0
 t_activation_I_m1_4_m1_8_2_5: ut_I_c_r[2,5] - y_I_edge_m1_4_m1_8_r_5 >= 0
 t_activation_I_m1_4_m1_8_0_4: ut_I_c_r[0,4] - y_I_edge_m1_4_m1_8_r_4 >= 0
 t_activation_I_m1_4_m1_8_1_4: ut_I_c_r[1,4] - y_I_edge_m1_4_m1_8_r_4 >= 0
 t_activation_I_m1_4_m1_8_2_4: ut_I_c_r[2,4] - y_I_edge_m1_4_m1_8_r_4 >= 0
 flow_conservation_I_ac_3: f_I_edge_connector_pv_3_ac_3_co
   + f_I_edge_connector_nv_3_ac_3_co - cap_I_ac_3 = 0
 flow_conservation_I_nn_3: f_I_edge_connector_nv_3_nn_3_co - cap_I_nn_3
   = 0
 middle_node_I_nv_3: cap_I_nv_3 = 0
 flow_conservation_I_nv_3: - f_I_edge_connector_nv_3_nn_3_co
   - f_I_edge_connector_nv_3_ac_3_co - f_I_edge_nv_3_nv_4_1
   - f_I_edge_nv_3_nv_4_0 - cap_I_nv_3 = 0
 flow_conservation_I_pp_3: f_I_edge_connector_pv_3_pp_3_co - cap_I_pp_3
   = 0
 middle_node_I_pv_3: cap_I_pv_3 = 0
 flow_conservation_I_pv_3: - f_I_edge_connector_pv_3_pp_3_co
   - f_I_edge_connector_pv_3_ac_3_co - f_I_edge_pv_3_pv_4_3
   - f_I_edge_pv_3_pv_4_2 - cap_I_pv_3 = 0
 middle_node_I_m1_4: cap_I_m1_4 = 0
 flow_conservation_I_m1_4: - f_I_edge_via_enable_m1_4_pv_4
   - f_I_edge_via_enable_m1_4_nv_4 - f_I_edge_m1_4_m1_8_r_7
   - f_I_edge_m1_4_m1_8_r_6 - f_I_edge_m1_4_m1_8_r_5
   - f_I_edge_m1_4_m1_8_r_4 - cap_I_m1_4 = 0
 middle_node_I_nv_4: cap_I_nv_4 = 0
 flow_conservation_I_nv_4: f_I_edge_nv_3_nv_4_1 + f_I_edge_nv_3_nv_4_0
   - f_I_edge_nv_4_nv_6_1 - f_I_edge_nv_4_nv_6_0
   + f_I_edge_via_enable_m1_4_nv_4 - cap_I_nv_4 = 0
 middle_node_I_pv_4: cap_I_pv_4 = 0
 flow_conservation_I_pv_4: f_I_edge_pv_3_pv_4_3 + f_I_edge_pv_3_pv_4_2
   - f_I_edge_pv_4_pv_6_3 - f_I_edge_pv_4_pv_6_2
   + f_I_edge_via_enable_m1_4_pv_4 - cap_I_pv_4 = 0
 flow_conservation_I_ac_6: f_I_edge_connector_pv_6_ac_6_co
   + f_I_edge_connector_nv_6_ac_6_co - cap_I_ac_6 = 0
 flow_conservation_I_nn_6: f_I_edge_connector_nv_6_nn_6_co - cap_I_nn_6
   = 0
 middle_node_I_nv_6: cap_I_nv_6 = 0
 flow_conservation_I_nv_6: - f_I_edge_connector_nv_6_nn_6_co
   - f_I_edge_connector_nv_6_ac_6_co + f_I_edge_nv_4_nv_6_1
   + f_I_edge_nv_4_nv_6_0 - f_I_edge_nv_6_nv_8_1 - f_I_edge_nv_6_nv_8_0
   - cap_I_nv_6 = 0
 flow_conservation_I_pp_6: f_I_edge_connector_pv_6_pp_6_co - cap_I_pp_6
   = 0
 middle_node_I_pv_6: cap_I_pv_6 = 0
 flow_conservation_I_pv_6: - f_I_edge_connector_pv_6_pp_6_co
   - f_I_edge_connector_pv_6_ac_6_co + f_I_edge_pv_4_pv_6_3
   + f_I_edge_pv_4_pv_6_2 - f_I_edge_pv_6_pv_8_3 - f_I_edge_pv_6_pv_8_2
   - cap_I_pv_6 = 0
 middle_node_I_m1_8: cap_I_m1_8 = 0
 flow_conservation_I_m1_8: f_I_edge_m1_4_m1_8_r_7 + f_I_edge_m1_4_m1_8_r_6
   + f_I_edge_m1_4_m1_8_r_5 + f_I_edge_m1_4_m1_8_r_4
   - f_I_edge_via_enable_m1_8_pv_8 - f_I_edge_via_enable_m1_8_nv_8
   - cap_I_m1_8 = 0
 middle_node_I_nv_8: cap_I_nv_8 = 0
 flow_conservation_I_nv_8: f_I_edge_nv_6_nv_8_1 + f_I_edge_nv_6_nv_8_0
   - f_I_edge_nv_8_nv_9_1 - f_I_edge_nv_8_nv_9_0
   + f_I_edge_via_enable_m1_8_nv_8 - cap_I_nv_8 = 0
 middle_node_I_pv_8: cap_I_pv_8 = 0
 flow_conservation_I_pv_8: f_I_edge_pv_6_pv_8_3 + f_I_edge_pv_6_pv_8_2
   - f_I_edge_pv_8_pv_9_3 - f_I_edge_pv_8_pv_9_2
   + f_I_edge_via_enable_m1_8_pv_8 - cap_I_pv_8 = 0
 flow_conservation_I_ac_9: f_I_edge_connector_pv_9_ac_9_co
   + f_I_edge_connector_nv_9_ac_9_co - cap_I_ac_9 = 0
 flow_conservation_I_nn_9: f_I_edge_connector_nv_9_nn_9_co - cap_I_nn_9
   = 0
 middle_node_I_nv_9: cap_I_nv_9 = 0
 flow_conservation_I_nv_9: - f_I_edge_connector_nv_9_nn_9_co
   - f_I_edge_connector_nv_9_ac_9_co + f_I_edge_nv_8_nv_9_1
   + f_I_edge_nv_8_nv_9_0 - cap_I_nv_9 = 0
 flow_conservation_I_pp_9: f_I_edge_connector_pv_9_pp_9_co - cap_I_pp_9
   = 0
 middle_node_I_pv_9: cap_I_pv_9 = 0
 flow_conservation_I_pv_9: - f_I_edge_connector_pv_9_pp_9_co
   - f_I_edge_connector_pv_9_ac_9_co + f_I_edge_pv_8_pv_9_3
   + f_I_edge_pv_8_pv_9_2 - cap_I_pv_9 = 0
 via_conflict_0: v_ZN_v[0] + v_I_v[0] <= 1
 via_conflict_1: v_ZN_v[1] + v_I_v[1] <= 1
 row_selection_conflict_pv_3_pv_4_3: y_ZN_edge_pv_3_pv_4_3
   + y_I_edge_pv_3_pv_4_3 <= 1
 row_selection_conflict_pv_3_pv_4_2: y_ZN_edge_pv_3_pv_4_2
   + y_I_edge_pv_3_pv_4_2 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_pv_3_pv_4:
   y_ZN_edge_pv_3_pv_4_3 + y_ZN_edge_pv_3_pv_4_2 <= 1
 consecutive_row_usage_conflict_for_one_net_I_pv_3_pv_4:
   y_I_edge_pv_3_pv_4_3 + y_I_edge_pv_3_pv_4_2 <= 1
 row_selection_conflict_nv_3_nv_4_1: y_ZN_edge_nv_3_nv_4_1
   + y_I_edge_nv_3_nv_4_1 <= 1
 row_selection_conflict_nv_3_nv_4_0: y_ZN_edge_nv_3_nv_4_0
   + y_I_edge_nv_3_nv_4_0 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_nv_3_nv_4:
   y_ZN_edge_nv_3_nv_4_1 + y_ZN_edge_nv_3_nv_4_0 <= 1
 consecutive_row_usage_conflict_for_one_net_I_nv_3_nv_4:
   y_I_edge_nv_3_nv_4_1 + y_I_edge_nv_3_nv_4_0 <= 1
 row_selection_conflict_pv_4_pv_6_3: y_ZN_edge_pv_4_pv_6_3
   + y_I_edge_pv_4_pv_6_3 <= 1
 row_selection_conflict_pv_4_pv_6_2: y_ZN_edge_pv_4_pv_6_2
   + y_I_edge_pv_4_pv_6_2 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_pv_4_pv_6:
   y_ZN_edge_pv_4_pv_6_3 + y_ZN_edge_pv_4_pv_6_2 <= 1
 consecutive_row_usage_conflict_for_one_net_I_pv_4_pv_6:
   y_I_edge_pv_4_pv_6_3 + y_I_edge_pv_4_pv_6_2 <= 1
 row_selection_conflict_nv_4_nv_6_1: y_ZN_edge_nv_4_nv_6_1
   + y_I_edge_nv_4_nv_6_1 <= 1
 row_selection_conflict_nv_4_nv_6_0: y_ZN_edge_nv_4_nv_6_0
   + y_I_edge_nv_4_nv_6_0 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_nv_4_nv_6:
   y_ZN_edge_nv_4_nv_6_1 + y_ZN_edge_nv_4_nv_6_0 <= 1
 consecutive_row_usage_conflict_for_one_net_I_nv_4_nv_6:
   y_I_edge_nv_4_nv_6_1 + y_I_edge_nv_4_nv_6_0 <= 1
 row_selection_conflict_pv_6_pv_8_3: y_ZN_edge_pv_6_pv_8_3
   + y_I_edge_pv_6_pv_8_3 <= 1
 row_selection_conflict_pv_6_pv_8_2: y_ZN_edge_pv_6_pv_8_2
   + y_I_edge_pv_6_pv_8_2 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_pv_6_pv_8:
   y_ZN_edge_pv_6_pv_8_3 + y_ZN_edge_pv_6_pv_8_2 <= 1
 consecutive_row_usage_conflict_for_one_net_I_pv_6_pv_8:
   y_I_edge_pv_6_pv_8_3 + y_I_edge_pv_6_pv_8_2 <= 1
 row_selection_conflict_nv_6_nv_8_1: y_ZN_edge_nv_6_nv_8_1
   + y_I_edge_nv_6_nv_8_1 <= 1
 row_selection_conflict_nv_6_nv_8_0: y_ZN_edge_nv_6_nv_8_0
   + y_I_edge_nv_6_nv_8_0 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_nv_6_nv_8:
   y_ZN_edge_nv_6_nv_8_1 + y_ZN_edge_nv_6_nv_8_0 <= 1
 consecutive_row_usage_conflict_for_one_net_I_nv_6_nv_8:
   y_I_edge_nv_6_nv_8_1 + y_I_edge_nv_6_nv_8_0 <= 1
 row_selection_conflict_pv_8_pv_9_3: y_ZN_edge_pv_8_pv_9_3
   + y_I_edge_pv_8_pv_9_3 <= 1
 row_selection_conflict_pv_8_pv_9_2: y_ZN_edge_pv_8_pv_9_2
   + y_I_edge_pv_8_pv_9_2 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_pv_8_pv_9:
   y_ZN_edge_pv_8_pv_9_3 + y_ZN_edge_pv_8_pv_9_2 <= 1
 consecutive_row_usage_conflict_for_one_net_I_pv_8_pv_9:
   y_I_edge_pv_8_pv_9_3 + y_I_edge_pv_8_pv_9_2 <= 1
 row_selection_conflict_nv_8_nv_9_1: y_ZN_edge_nv_8_nv_9_1
   + y_I_edge_nv_8_nv_9_1 <= 1
 row_selection_conflict_nv_8_nv_9_0: y_ZN_edge_nv_8_nv_9_0
   + y_I_edge_nv_8_nv_9_0 <= 1
 consecutive_row_usage_conflict_for_one_net_ZN_nv_8_nv_9:
   y_ZN_edge_nv_8_nv_9_1 + y_ZN_edge_nv_8_nv_9_0 <= 1
 consecutive_row_usage_conflict_for_one_net_I_nv_8_nv_9:
   y_I_edge_nv_8_nv_9_1 + y_I_edge_nv_8_nv_9_0 <= 1
 track_cost_0_3: t_c_0_3 - t_ZN_c_r[0,3] - t_I_c_r[0,3] = 0
 max_track_0_3: t_c_0_3 + t_eol_c_r[0,3] <= 1
 track_cost_0_2: t_c_0_2 - t_ZN_c_r[0,2] - t_I_c_r[0,2] = 0
 max_track_0_2: t_c_0_2 + t_eol_c_r[0,2] <= 1
 track_cost_0_1: t_c_0_1 - t_ZN_c_r[0,1] - t_I_c_r[0,1] = 0
 max_track_0_1: t_c_0_1 + t_eol_c_r[0,1] <= 1
 track_cost_0_0: t_c_0_0 - t_ZN_c_r[0,0] - t_I_c_r[0,0] = 0
 max_track_0_0: t_c_0_0 + t_eol_c_r[0,0] <= 1
 uppertrack_cost_0_7: ut_c_0_7 - ut_ZN_c_r[0,7] - ut_I_c_r[0,7] = 0
 max_uppertrack_0_7: ut_c_0_7 + ut_eol_c_r[0,7] <= 1
 uppertrack_cost_0_6: ut_c_0_6 - ut_ZN_c_r[0,6] - ut_I_c_r[0,6] = 0
 max_uppertrack_0_6: ut_c_0_6 + ut_eol_c_r[0,6] <= 1
 uppertrack_cost_0_5: ut_c_0_5 - ut_ZN_c_r[0,5] - ut_I_c_r[0,5] = 0
 max_uppertrack_0_5: ut_c_0_5 + ut_eol_c_r[0,5] <= 1
 uppertrack_cost_0_4: ut_c_0_4 - ut_ZN_c_r[0,4] - ut_I_c_r[0,4] = 0
 max_uppertrack_0_4: ut_c_0_4 + ut_eol_c_r[0,4] <= 1
 track_cost_1_3: t_c_1_3 - t_ZN_c_r[1,3] - t_I_c_r[1,3] = 0
 max_track_1_3: t_c_1_3 + t_eol_c_r[1,3] <= 1
 track_cost_1_2: t_c_1_2 - t_ZN_c_r[1,2] - t_I_c_r[1,2] = 0
 max_track_1_2: t_c_1_2 + t_eol_c_r[1,2] <= 1
 track_cost_1_1: t_c_1_1 - t_ZN_c_r[1,1] - t_I_c_r[1,1] = 0
 max_track_1_1: t_c_1_1 + t_eol_c_r[1,1] <= 1
 track_cost_1_0: t_c_1_0 - t_ZN_c_r[1,0] - t_I_c_r[1,0] = 0
 max_track_1_0: t_c_1_0 + t_eol_c_r[1,0] <= 1
 uppertrack_cost_1_7: ut_c_1_7 - ut_ZN_c_r[1,7] - ut_I_c_r[1,7] = 0
 max_uppertrack_1_7: ut_c_1_7 + ut_eol_c_r[1,7] <= 1
 uppertrack_cost_1_6: ut_c_1_6 - ut_ZN_c_r[1,6] - ut_I_c_r[1,6] = 0
 max_uppertrack_1_6: ut_c_1_6 + ut_eol_c_r[1,6] <= 1
 uppertrack_cost_1_5: ut_c_1_5 - ut_ZN_c_r[1,5] - ut_I_c_r[1,5] = 0
 max_uppertrack_1_5: ut_c_1_5 + ut_eol_c_r[1,5] <= 1
 uppertrack_cost_1_4: ut_c_1_4 - ut_ZN_c_r[1,4] - ut_I_c_r[1,4] = 0
 max_uppertrack_1_4: ut_c_1_4 + ut_eol_c_r[1,4] <= 1
 track_cost_2_3: t_c_2_3 - t_ZN_c_r[2,3] - t_I_c_r[2,3] = 0
 max_track_2_3: t_c_2_3 + t_eol_c_r[2,3] <= 1
 track_cost_2_2: t_c_2_2 - t_ZN_c_r[2,2] - t_I_c_r[2,2] = 0
 max_track_2_2: t_c_2_2 + t_eol_c_r[2,2] <= 1
 track_cost_2_1: t_c_2_1 - t_ZN_c_r[2,1] - t_I_c_r[2,1] = 0
 max_track_2_1: t_c_2_1 + t_eol_c_r[2,1] <= 1
 track_cost_2_0: t_c_2_0 - t_ZN_c_r[2,0] - t_I_c_r[2,0] = 0
 max_track_2_0: t_c_2_0 + t_eol_c_r[2,0] <= 1
 uppertrack_cost_2_7: ut_c_2_7 - ut_ZN_c_r[2,7] - ut_I_c_r[2,7] = 0
 max_uppertrack_2_7: ut_c_2_7 + ut_eol_c_r[2,7] <= 1
 uppertrack_cost_2_6: ut_c_2_6 - ut_ZN_c_r[2,6] - ut_I_c_r[2,6] = 0
 max_uppertrack_2_6: ut_c_2_6 + ut_eol_c_r[2,6] <= 1
 uppertrack_cost_2_5: ut_c_2_5 - ut_ZN_c_r[2,5] - ut_I_c_r[2,5] = 0
 max_uppertrack_2_5: ut_c_2_5 + ut_eol_c_r[2,5] <= 1
 uppertrack_cost_2_4: ut_c_2_4 - ut_ZN_c_r[2,4] - ut_I_c_r[2,4] = 0
 max_uppertrack_2_4: ut_c_2_4 + ut_eol_c_r[2,4] <= 1
 via_used_binary_upper: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I <= 21
 via_used_binary_lower: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I >= 2
 cond_via_1_3_I: cond_col1_row3_netI - one_pin_net_bin_I <= 0
 cond_pinmetal_1_3_I: - t_I_c_r[0,3] - t_I_c_r[1,3] - t_I_c_r[2,3]
   + cond_col1_row3_netI <= 0
 pin_is_there1_pinmetal_1_3_I: - t_I_c_r[0,3] - t_I_c_r[1,3] - t_I_c_r[2,3]
   + pin_is_there_3_I <= 0
 pin_is_there2_pinmetal_1_3_I: - 0.3333333333333333 t_I_c_r[0,3]
   - 0.3333333333333333 t_I_c_r[1,3] - 0.3333333333333333 t_I_c_r[2,3]
   + pin_is_there_3_I >= 0
 cond_upper_1_3_I: t_ZN_c_r[0,3] + t_ZN_c_r[1,3] + t_ZN_c_r[2,3]
   + 20 cond_col1_row3_netI <= 20
 cond_lower_1_3_I: t_ZN_c_r[0,3] + t_ZN_c_r[1,3] + t_ZN_c_r[2,3]
   + cond_col1_row3_netI - one_pin_net_bin_I - pin_is_there_3_I >= -1
 via_used_binary_upper: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN <= 21
 via_used_binary_lower: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN >= 2
 cond_via_1_3_ZN: cond_col1_row3_netZN - one_pin_net_bin_ZN <= 0
 cond_pinmetal_1_3_ZN: - t_ZN_c_r[0,3] - t_ZN_c_r[1,3] - t_ZN_c_r[2,3]
   + cond_col1_row3_netZN <= 0
 pin_is_there1_pinmetal_1_3_ZN: - t_ZN_c_r[0,3] - t_ZN_c_r[1,3]
   - t_ZN_c_r[2,3] + pin_is_there_3_ZN <= 0
 pin_is_there2_pinmetal_1_3_ZN: - 0.3333333333333333 t_ZN_c_r[0,3]
   - 0.3333333333333333 t_ZN_c_r[1,3] - 0.3333333333333333 t_ZN_c_r[2,3]
   + pin_is_there_3_ZN >= 0
 cond_upper_1_3_ZN: t_I_c_r[0,3] + t_I_c_r[1,3] + t_I_c_r[2,3]
   + 20 cond_col1_row3_netZN <= 20
 cond_lower_1_3_ZN: t_I_c_r[0,3] + t_I_c_r[1,3] + t_I_c_r[2,3]
   + cond_col1_row3_netZN - one_pin_net_bin_ZN - pin_is_there_3_ZN >= -1
 via_used_binary_upper: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I <= 21
 via_used_binary_lower: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I >= 2
 cond_via_1_2_I: cond_col1_row2_netI - one_pin_net_bin_I <= 0
 cond_pinmetal_1_2_I: - t_I_c_r[0,2] - t_I_c_r[1,2] - t_I_c_r[2,2]
   + cond_col1_row2_netI <= 0
 pin_is_there1_pinmetal_1_2_I: - t_I_c_r[0,2] - t_I_c_r[1,2] - t_I_c_r[2,2]
   + pin_is_there_2_I <= 0
 pin_is_there2_pinmetal_1_2_I: - 0.3333333333333333 t_I_c_r[0,2]
   - 0.3333333333333333 t_I_c_r[1,2] - 0.3333333333333333 t_I_c_r[2,2]
   + pin_is_there_2_I >= 0
 cond_upper_1_2_I: t_ZN_c_r[0,2] + t_ZN_c_r[1,2] + t_ZN_c_r[2,2]
   + 20 cond_col1_row2_netI <= 20
 cond_lower_1_2_I: t_ZN_c_r[0,2] + t_ZN_c_r[1,2] + t_ZN_c_r[2,2]
   + cond_col1_row2_netI - one_pin_net_bin_I - pin_is_there_2_I >= -1
 via_used_binary_upper: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN <= 21
 via_used_binary_lower: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN >= 2
 cond_via_1_2_ZN: cond_col1_row2_netZN - one_pin_net_bin_ZN <= 0
 cond_pinmetal_1_2_ZN: - t_ZN_c_r[0,2] - t_ZN_c_r[1,2] - t_ZN_c_r[2,2]
   + cond_col1_row2_netZN <= 0
 pin_is_there1_pinmetal_1_2_ZN: - t_ZN_c_r[0,2] - t_ZN_c_r[1,2]
   - t_ZN_c_r[2,2] + pin_is_there_2_ZN <= 0
 pin_is_there2_pinmetal_1_2_ZN: - 0.3333333333333333 t_ZN_c_r[0,2]
   - 0.3333333333333333 t_ZN_c_r[1,2] - 0.3333333333333333 t_ZN_c_r[2,2]
   + pin_is_there_2_ZN >= 0
 cond_upper_1_2_ZN: t_I_c_r[0,2] + t_I_c_r[1,2] + t_I_c_r[2,2]
   + 20 cond_col1_row2_netZN <= 20
 cond_lower_1_2_ZN: t_I_c_r[0,2] + t_I_c_r[1,2] + t_I_c_r[2,2]
   + cond_col1_row2_netZN - one_pin_net_bin_ZN - pin_is_there_2_ZN >= -1
 via_used_binary_upper: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I <= 21
 via_used_binary_lower: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I >= 2
 cond_via_1_1_I: cond_col1_row1_netI - one_pin_net_bin_I <= 0
 cond_pinmetal_1_1_I: - t_I_c_r[0,1] - t_I_c_r[1,1] - t_I_c_r[2,1]
   + cond_col1_row1_netI <= 0
 pin_is_there1_pinmetal_1_1_I: - t_I_c_r[0,1] - t_I_c_r[1,1] - t_I_c_r[2,1]
   + pin_is_there_1_I <= 0
 pin_is_there2_pinmetal_1_1_I: - 0.3333333333333333 t_I_c_r[0,1]
   - 0.3333333333333333 t_I_c_r[1,1] - 0.3333333333333333 t_I_c_r[2,1]
   + pin_is_there_1_I >= 0
 cond_upper_1_1_I: t_ZN_c_r[0,1] + t_ZN_c_r[1,1] + t_ZN_c_r[2,1]
   + 20 cond_col1_row1_netI <= 20
 cond_lower_1_1_I: t_ZN_c_r[0,1] + t_ZN_c_r[1,1] + t_ZN_c_r[2,1]
   + cond_col1_row1_netI - one_pin_net_bin_I - pin_is_there_1_I >= -1
 via_used_binary_upper: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN <= 21
 via_used_binary_lower: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN >= 2
 cond_via_1_1_ZN: cond_col1_row1_netZN - one_pin_net_bin_ZN <= 0
 cond_pinmetal_1_1_ZN: - t_ZN_c_r[0,1] - t_ZN_c_r[1,1] - t_ZN_c_r[2,1]
   + cond_col1_row1_netZN <= 0
 pin_is_there1_pinmetal_1_1_ZN: - t_ZN_c_r[0,1] - t_ZN_c_r[1,1]
   - t_ZN_c_r[2,1] + pin_is_there_1_ZN <= 0
 pin_is_there2_pinmetal_1_1_ZN: - 0.3333333333333333 t_ZN_c_r[0,1]
   - 0.3333333333333333 t_ZN_c_r[1,1] - 0.3333333333333333 t_ZN_c_r[2,1]
   + pin_is_there_1_ZN >= 0
 cond_upper_1_1_ZN: t_I_c_r[0,1] + t_I_c_r[1,1] + t_I_c_r[2,1]
   + 20 cond_col1_row1_netZN <= 20
 cond_lower_1_1_ZN: t_I_c_r[0,1] + t_I_c_r[1,1] + t_I_c_r[2,1]
   + cond_col1_row1_netZN - one_pin_net_bin_ZN - pin_is_there_1_ZN >= -1
 via_used_binary_upper: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I <= 21
 via_used_binary_lower: indicator_I_pp_3 + indicator_I_nn_3
   + indicator_I_ac_3 + indicator_I_pp_6 + indicator_I_nn_6
   + indicator_I_ac_6 + indicator_I_pp_9 + indicator_I_nn_9
   + indicator_I_ac_9 + 20 one_pin_net_bin_I >= 2
 cond_via_1_0_I: cond_col1_row0_netI - one_pin_net_bin_I <= 0
 cond_pinmetal_1_0_I: - t_I_c_r[0,0] - t_I_c_r[1,0] - t_I_c_r[2,0]
   + cond_col1_row0_netI <= 0
 pin_is_there1_pinmetal_1_0_I: - t_I_c_r[0,0] - t_I_c_r[1,0] - t_I_c_r[2,0]
   + pin_is_there_0_I <= 0
 pin_is_there2_pinmetal_1_0_I: - 0.3333333333333333 t_I_c_r[0,0]
   - 0.3333333333333333 t_I_c_r[1,0] - 0.3333333333333333 t_I_c_r[2,0]
   + pin_is_there_0_I >= 0
 cond_upper_1_0_I: t_ZN_c_r[0,0] + t_ZN_c_r[1,0] + t_ZN_c_r[2,0]
   + 20 cond_col1_row0_netI <= 20
 cond_lower_1_0_I: t_ZN_c_r[0,0] + t_ZN_c_r[1,0] + t_ZN_c_r[2,0]
   + cond_col1_row0_netI - one_pin_net_bin_I - pin_is_there_0_I >= -1
 via_used_binary_upper: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN <= 21
 via_used_binary_lower: indicator_ZN_pp_3 + indicator_ZN_nn_3
   + indicator_ZN_ac_3 + indicator_ZN_pp_6 + indicator_ZN_nn_6
   + indicator_ZN_ac_6 + indicator_ZN_pp_9 + indicator_ZN_nn_9
   + indicator_ZN_ac_9 + 20 one_pin_net_bin_ZN >= 2
 cond_via_1_0_ZN: cond_col1_row0_netZN - one_pin_net_bin_ZN <= 0
 cond_pinmetal_1_0_ZN: - t_ZN_c_r[0,0] - t_ZN_c_r[1,0] - t_ZN_c_r[2,0]
   + cond_col1_row0_netZN <= 0
 pin_is_there1_pinmetal_1_0_ZN: - t_ZN_c_r[0,0] - t_ZN_c_r[1,0]
   - t_ZN_c_r[2,0] + pin_is_there_0_ZN <= 0
 pin_is_there2_pinmetal_1_0_ZN: - 0.3333333333333333 t_ZN_c_r[0,0]
   - 0.3333333333333333 t_ZN_c_r[1,0] - 0.3333333333333333 t_ZN_c_r[2,0]
   + pin_is_there_0_ZN >= 0
 cond_upper_1_0_ZN: t_I_c_r[0,0] + t_I_c_r[1,0] + t_I_c_r[2,0]
   + 20 cond_col1_row0_netZN <= 20
 cond_lower_1_0_ZN: t_I_c_r[0,0] + t_I_c_r[1,0] + t_I_c_r[2,0]
   + cond_col1_row0_netZN - one_pin_net_bin_ZN - pin_is_there_0_ZN >= -1
 reward_make_for_1: p_e_r_1 - cond_col1_row3_netI - cond_col1_row3_netZN
   - cond_col1_row2_netI - cond_col1_row2_netZN - cond_col1_row1_netI
   - cond_col1_row1_netZN - cond_col1_row0_netI - cond_col1_row0_netZN = 0
 z_le_net1_1_I_3: - c_mar_row_I_ac_6_r[3] + z_1_I_ZN_3_0 <= 0
 z_le_net2_1_ZN_0: - c_mar_row_ZN_ac_9_r[0] + z_1_I_ZN_3_0 <= 0
 z_ge_1_I_ZN_3_0: - c_mar_row_ZN_ac_9_r[0] - c_mar_row_I_ac_6_r[3]
   + z_1_I_ZN_3_0 >= -1
 z_le_net1_1_I_0: - c_mar_row_I_ac_6_r[0] + z_1_I_ZN_0_3 <= 0
 z_le_net2_1_ZN_3: - c_mar_row_ZN_ac_9_r[3] + z_1_I_ZN_0_3 <= 0
 z_ge_1_I_ZN_0_3: - c_mar_row_ZN_ac_9_r[3] - c_mar_row_I_ac_6_r[0]
   + z_1_I_ZN_0_3 >= -1
 z_le_net1_1_ZN_3: - c_mar_row_ZN_ac_6_r[3] + z_1_ZN_I_3_0 <= 0
 z_le_net2_1_I_0: - c_mar_row_I_ac_9_r[0] + z_1_ZN_I_3_0 <= 0
 z_ge_1_ZN_I_3_0: - c_mar_row_ZN_ac_6_r[3] - c_mar_row_I_ac_9_r[0]
   + z_1_ZN_I_3_0 >= -1
 z_le_net1_1_ZN_0: - c_mar_row_ZN_ac_6_r[0] + z_1_ZN_I_0_3 <= 0
 z_le_net2_1_I_3: - c_mar_row_I_ac_9_r[3] + z_1_ZN_I_0_3 <= 0
 z_ge_1_ZN_I_0_3: - c_mar_row_ZN_ac_6_r[0] - c_mar_row_I_ac_9_r[3]
   + z_1_ZN_I_0_3 >= -1
 o_m_p_constr1_7: o_m_p_7 <= 0
 o_m_p_constr1_6: o_m_p_6 <= 0
 o_m_p_constr1_5: o_m_p_5 <= 0
 o_m_p_constr1_4: o_m_p_4 <= 0
 uppertrack_cost_0: ut_c_0 - ut_c_0_7 - ut_c_0_6 - ut_c_0_5 - ut_c_0_4 = 0
 track_cost_0: t_c_0 - t_c_0_3 - t_c_0_2 - t_c_0_1 - t_c_0_0 = 0
 max_track_0: t_c_0 <= 4
 uppertrack_cost_1: ut_c_1 - ut_c_1_7 - ut_c_1_6 - ut_c_1_5 - ut_c_1_4 = 0
 track_cost_1: t_c_1 - t_c_1_3 - t_c_1_2 - t_c_1_1 - t_c_1_0 = 0
 max_track_1: t_c_1 <= 4
 uppertrack_cost_2: ut_c_2 - ut_c_2_7 - ut_c_2_6 - ut_c_2_5 - ut_c_2_4 = 0
 track_cost_2: t_c_2 - t_c_2_3 - t_c_2_2 - t_c_2_1 - t_c_2_0 = 0
 max_track_2: t_c_2 <= 4
 t_definition_root_ZN_ac_3: root_node_ZN_ac_3 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_ac_3 = 1
 t_definition_non_root_ZN_ac_3: root_node_ZN_ac_3 = 0 ->
   - indicator_ZN_ac_3 + cap_ZN_ac_3 = 0
 t_definition_root_ZN_nn_3: root_node_ZN_nn_3 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_nn_3 = 1
 t_definition_non_root_ZN_nn_3: root_node_ZN_nn_3 = 0 ->
   - indicator_ZN_nn_3 + cap_ZN_nn_3 = 0
 t_definition_root_ZN_pp_3: root_node_ZN_pp_3 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_pp_3 = 1
 t_definition_non_root_ZN_pp_3: root_node_ZN_pp_3 = 0 ->
   - indicator_ZN_pp_3 + cap_ZN_pp_3 = 0
 t_definition_root_ZN_ac_6: root_node_ZN_ac_6 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_ac_6 = 1
 t_definition_non_root_ZN_ac_6: root_node_ZN_ac_6 = 0 ->
   - indicator_ZN_ac_6 + cap_ZN_ac_6 = 0
 t_definition_root_ZN_nn_6: root_node_ZN_nn_6 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_nn_6 = 1
 t_definition_non_root_ZN_nn_6: root_node_ZN_nn_6 = 0 ->
   - indicator_ZN_nn_6 + cap_ZN_nn_6 = 0
 t_definition_root_ZN_pp_6: root_node_ZN_pp_6 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_pp_6 = 1
 t_definition_non_root_ZN_pp_6: root_node_ZN_pp_6 = 0 ->
   - indicator_ZN_pp_6 + cap_ZN_pp_6 = 0
 t_definition_root_ZN_ac_9: root_node_ZN_ac_9 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_ac_9 = 1
 t_definition_non_root_ZN_ac_9: root_node_ZN_ac_9 = 0 ->
   - indicator_ZN_ac_9 + cap_ZN_ac_9 = 0
 t_definition_root_ZN_nn_9: root_node_ZN_nn_9 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_nn_9 = 1
 t_definition_non_root_ZN_nn_9: root_node_ZN_nn_9 = 0 ->
   - indicator_ZN_nn_9 + cap_ZN_nn_9 = 0
 t_definition_root_ZN_pp_9: root_node_ZN_pp_9 = 1 -> indicator_ZN_pp_3
   + indicator_ZN_nn_3 + indicator_ZN_ac_3 + indicator_ZN_pp_6
   + indicator_ZN_nn_6 + indicator_ZN_ac_6 + indicator_ZN_pp_9
   + indicator_ZN_nn_9 + indicator_ZN_ac_9 + cap_ZN_pp_9 = 1
 t_definition_non_root_ZN_pp_9: root_node_ZN_pp_9 = 0 ->
   - indicator_ZN_pp_9 + cap_ZN_pp_9 = 0
 t_definition_root_I_ac_3: root_node_I_ac_3 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_ac_3 = 1
 t_definition_non_root_I_ac_3: root_node_I_ac_3 = 0 -> - indicator_I_ac_3
   + cap_I_ac_3 = 0
 t_definition_root_I_nn_3: root_node_I_nn_3 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_nn_3 = 1
 t_definition_non_root_I_nn_3: root_node_I_nn_3 = 0 -> - indicator_I_nn_3
   + cap_I_nn_3 = 0
 t_definition_root_I_pp_3: root_node_I_pp_3 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_pp_3 = 1
 t_definition_non_root_I_pp_3: root_node_I_pp_3 = 0 -> - indicator_I_pp_3
   + cap_I_pp_3 = 0
 t_definition_root_I_ac_6: root_node_I_ac_6 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_ac_6 = 1
 t_definition_non_root_I_ac_6: root_node_I_ac_6 = 0 -> - indicator_I_ac_6
   + cap_I_ac_6 = 0
 t_definition_root_I_nn_6: root_node_I_nn_6 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_nn_6 = 1
 t_definition_non_root_I_nn_6: root_node_I_nn_6 = 0 -> - indicator_I_nn_6
   + cap_I_nn_6 = 0
 t_definition_root_I_pp_6: root_node_I_pp_6 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_pp_6 = 1
 t_definition_non_root_I_pp_6: root_node_I_pp_6 = 0 -> - indicator_I_pp_6
   + cap_I_pp_6 = 0
 t_definition_root_I_ac_9: root_node_I_ac_9 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_ac_9 = 1
 t_definition_non_root_I_ac_9: root_node_I_ac_9 = 0 -> - indicator_I_ac_9
   + cap_I_ac_9 = 0
 t_definition_root_I_nn_9: root_node_I_nn_9 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_nn_9 = 1
 t_definition_non_root_I_nn_9: root_node_I_nn_9 = 0 -> - indicator_I_nn_9
   + cap_I_nn_9 = 0
 t_definition_root_I_pp_9: root_node_I_pp_9 = 1 -> indicator_I_pp_3
   + indicator_I_nn_3 + indicator_I_ac_3 + indicator_I_pp_6
   + indicator_I_nn_6 + indicator_I_ac_6 + indicator_I_pp_9
   + indicator_I_nn_9 + indicator_I_ac_9 + cap_I_pp_9 = 1
 t_definition_non_root_I_pp_9: root_node_I_pp_9 = 0 -> - indicator_I_pp_9
   + cap_I_pp_9 = 0
Bounds
 min_indicator_ZN <= 2
 max_bbox_ZN <= 2
 -1 <= f_ZN_edge_connector_pv_3_pp_3_co <= 1
 -1 <= f_ZN_edge_connector_pv_3_ac_3_co <= 1
 -1 <= f_ZN_edge_connector_nv_3_nn_3_co <= 1
 -1 <= f_ZN_edge_connector_nv_3_ac_3_co <= 1
 -1 <= f_ZN_edge_connector_pv_6_pp_6_co <= 1
 -1 <= f_ZN_edge_connector_pv_6_ac_6_co <= 1
 -1 <= f_ZN_edge_connector_nv_6_nn_6_co <= 1
 -1 <= f_ZN_edge_connector_nv_6_ac_6_co <= 1
 -1 <= f_ZN_edge_connector_pv_9_pp_9_co <= 1
 -1 <= f_ZN_edge_connector_pv_9_ac_9_co <= 1
 -1 <= f_ZN_edge_connector_nv_9_nn_9_co <= 1
 -1 <= f_ZN_edge_connector_nv_9_ac_9_co <= 1
 -1 <= f_ZN_edge_pv_3_pv_4_3 <= 1
 -1 <= f_ZN_edge_pv_3_pv_4_2 <= 1
 -1 <= f_ZN_edge_nv_3_nv_4_1 <= 1
 -1 <= f_ZN_edge_nv_3_nv_4_0 <= 1
 -1 <= f_ZN_edge_pv_4_pv_6_3 <= 1
 -1 <= f_ZN_edge_pv_4_pv_6_2 <= 1
 -1 <= f_ZN_edge_nv_4_nv_6_1 <= 1
 -1 <= f_ZN_edge_nv_4_nv_6_0 <= 1
 -1 <= f_ZN_edge_pv_6_pv_8_3 <= 1
 -1 <= f_ZN_edge_pv_6_pv_8_2 <= 1
 -1 <= f_ZN_edge_nv_6_nv_8_1 <= 1
 -1 <= f_ZN_edge_nv_6_nv_8_0 <= 1
 -1 <= f_ZN_edge_pv_8_pv_9_3 <= 1
 -1 <= f_ZN_edge_pv_8_pv_9_2 <= 1
 -1 <= f_ZN_edge_nv_8_nv_9_1 <= 1
 -1 <= f_ZN_edge_nv_8_nv_9_0 <= 1
 -1 <= f_ZN_edge_via_enable_m1_4_pv_4 <= 1
 -1 <= f_ZN_edge_via_enable_m1_4_nv_4 <= 1
 -1 <= f_ZN_edge_m1_4_m1_8_r_7 <= 1
 -1 <= f_ZN_edge_m1_4_m1_8_r_6 <= 1
 -1 <= f_ZN_edge_m1_4_m1_8_r_5 <= 1
 -1 <= f_ZN_edge_m1_4_m1_8_r_4 <= 1
 -1 <= f_ZN_edge_via_enable_m1_8_pv_8 <= 1
 -1 <= f_ZN_edge_via_enable_m1_8_nv_8 <= 1
 -1 <= cap_ZN_ac_3 <= 1
 -1 <= cap_ZN_nn_3 <= 1
 -1 <= cap_ZN_nv_3 <= 1
 -1 <= cap_ZN_pp_3 <= 1
 -1 <= cap_ZN_pv_3 <= 1
 -1 <= cap_ZN_m1_4 <= 1
 -1 <= cap_ZN_nv_4 <= 1
 -1 <= cap_ZN_pv_4 <= 1
 -1 <= cap_ZN_ac_6 <= 1
 -1 <= cap_ZN_nn_6 <= 1
 -1 <= cap_ZN_nv_6 <= 1
 -1 <= cap_ZN_pp_6 <= 1
 -1 <= cap_ZN_pv_6 <= 1
 -1 <= cap_ZN_m1_8 <= 1
 -1 <= cap_ZN_nv_8 <= 1
 -1 <= cap_ZN_pv_8 <= 1
 -1 <= cap_ZN_ac_9 <= 1
 -1 <= cap_ZN_nn_9 <= 1
 -1 <= cap_ZN_nv_9 <= 1
 -1 <= cap_ZN_pp_9 <= 1
 -1 <= cap_ZN_pv_9 <= 1
 min_indicator_I <= 2
 max_bbox_I <= 2
 -2 <= f_I_edge_connector_pv_3_pp_3_co <= 2
 -2 <= f_I_edge_connector_pv_3_ac_3_co <= 2
 -2 <= f_I_edge_connector_nv_3_nn_3_co <= 2
 -2 <= f_I_edge_connector_nv_3_ac_3_co <= 2
 -2 <= f_I_edge_connector_pv_6_pp_6_co <= 2
 -2 <= f_I_edge_connector_pv_6_ac_6_co <= 2
 -2 <= f_I_edge_connector_nv_6_nn_6_co <= 2
 -2 <= f_I_edge_connector_nv_6_ac_6_co <= 2
 -2 <= f_I_edge_connector_pv_9_pp_9_co <= 2
 -2 <= f_I_edge_connector_pv_9_ac_9_co <= 2
 -2 <= f_I_edge_connector_nv_9_nn_9_co <= 2
 -2 <= f_I_edge_connector_nv_9_ac_9_co <= 2
 -2 <= f_I_edge_pv_3_pv_4_3 <= 2
 -2 <= f_I_edge_pv_3_pv_4_2 <= 2
 -2 <= f_I_edge_nv_3_nv_4_1 <= 2
 -2 <= f_I_edge_nv_3_nv_4_0 <= 2
 -2 <= f_I_edge_pv_4_pv_6_3 <= 2
 -2 <= f_I_edge_pv_4_pv_6_2 <= 2
 -2 <= f_I_edge_nv_4_nv_6_1 <= 2
 -2 <= f_I_edge_nv_4_nv_6_0 <= 2
 -2 <= f_I_edge_pv_6_pv_8_3 <= 2
 -2 <= f_I_edge_pv_6_pv_8_2 <= 2
 -2 <= f_I_edge_nv_6_nv_8_1 <= 2
 -2 <= f_I_edge_nv_6_nv_8_0 <= 2
 -2 <= f_I_edge_pv_8_pv_9_3 <= 2
 -2 <= f_I_edge_pv_8_pv_9_2 <= 2
 -2 <= f_I_edge_nv_8_nv_9_1 <= 2
 -2 <= f_I_edge_nv_8_nv_9_0 <= 2
 -2 <= f_I_edge_via_enable_m1_4_pv_4 <= 2
 -2 <= f_I_edge_via_enable_m1_4_nv_4 <= 2
 -2 <= f_I_edge_m1_4_m1_8_r_7 <= 2
 -2 <= f_I_edge_m1_4_m1_8_r_6 <= 2
 -2 <= f_I_edge_m1_4_m1_8_r_5 <= 2
 -2 <= f_I_edge_m1_4_m1_8_r_4 <= 2
 -2 <= f_I_edge_via_enable_m1_8_pv_8 <= 2
 -2 <= f_I_edge_via_enable_m1_8_nv_8 <= 2
 -2 <= cap_I_ac_3 <= 1
 -2 <= cap_I_nn_3 <= 1
 -2 <= cap_I_nv_3 <= 1
 -2 <= cap_I_pp_3 <= 1
 -2 <= cap_I_pv_3 <= 1
 -2 <= cap_I_m1_4 <= 1
 -2 <= cap_I_nv_4 <= 1
 -2 <= cap_I_pv_4 <= 1
 -2 <= cap_I_ac_6 <= 1
 -2 <= cap_I_nn_6 <= 1
 -2 <= cap_I_nv_6 <= 1
 -2 <= cap_I_pp_6 <= 1
 -2 <= cap_I_pv_6 <= 1
 -2 <= cap_I_m1_8 <= 1
 -2 <= cap_I_nv_8 <= 1
 -2 <= cap_I_pv_8 <= 1
 -2 <= cap_I_ac_9 <= 1
 -2 <= cap_I_nn_9 <= 1
 -2 <= cap_I_nv_9 <= 1
 -2 <= cap_I_pp_9 <= 1
 -2 <= cap_I_pv_9 <= 1
Binaries
 c_top_MM1_c1_o0 c_top_MM1_c1_o1 pmos_net_ZN_c0 pmos_net_dummy_c0
 pmos_net_I_c0 pmos_net_VDD_c0 pmos_net_ZN_c1 pmos_net_dummy_c1
 pmos_net_I_c1 pmos_net_VDD_c1 pmos_net_ZN_c2 pmos_net_dummy_c2
 pmos_net_I_c2 pmos_net_VDD_c2 c_bot_MM0_c1_o0 c_bot_MM0_c1_o1
 nmos_net_ZN_c0 nmos_net_dummy_c0 nmos_net_I_c0 nmos_net_VSS_c0
 nmos_net_ZN_c1 nmos_net_dummy_c1 nmos_net_I_c1 nmos_net_VSS_c1
 nmos_net_ZN_c2 nmos_net_dummy_c2 nmos_net_I_c2 nmos_net_VSS_c2 misalign_c1
 temp_misalign_c1 dummayallign_c1 dummy_or_misalign_c1 temp_misalign_net_c1
 temp_misalign_net_c1 a_net_ZN_col1_left a_net_I_col1_left
 b_net_ZN_col1_left b_net_I_col1_left a_net_ZN_col1_right
 a_net_I_col1_right b_net_ZN_col1_right b_net_I_col1_right a_VSS_col1_final
 b_VSS_col1_final e_net_ZN_col1 left_ZN_exist_1 right_ZN_exist_1
 e_net_I_col1 left_I_exist_1 right_I_exist_1 t_eol_c_r[0,3] t_eol_c_r[0,2]
 t_eol_c_r[0,1] t_eol_c_r[0,0] t_eol_c_r[1,3] t_eol_c_r[1,2] t_eol_c_r[1,1]
 t_eol_c_r[1,0] t_eol_c_r[2,3] t_eol_c_r[2,2] t_eol_c_r[2,1] t_eol_c_r[2,0]
 ut_eol_c_r[0,7] ut_eol_c_r[0,6] ut_eol_c_r[0,5] ut_eol_c_r[0,4]
 ut_eol_c_r[1,7] ut_eol_c_r[1,6] ut_eol_c_r[1,5] ut_eol_c_r[1,4]
 ut_eol_c_r[2,7] ut_eol_c_r[2,6] ut_eol_c_r[2,5] ut_eol_c_r[2,4]
 t_ZN_c_r[0,3] t_ZN_c_r[0,2] t_ZN_c_r[0,1] t_ZN_c_r[0,0] t_ZN_c_r[1,3]
 t_ZN_c_r[1,2] t_ZN_c_r[1,1] t_ZN_c_r[1,0] t_ZN_c_r[2,3] t_ZN_c_r[2,2]
 t_ZN_c_r[2,1] t_ZN_c_r[2,0] v_ZN_v[0] v_ZN_v[1] ut_ZN_c_r[0,7]
 ut_ZN_c_r[0,6] ut_ZN_c_r[0,5] ut_ZN_c_r[0,4] ut_ZN_c_r[1,7] ut_ZN_c_r[1,6]
 ut_ZN_c_r[1,5] ut_ZN_c_r[1,4] ut_ZN_c_r[2,7] ut_ZN_c_r[2,6] ut_ZN_c_r[2,5]
 ut_ZN_c_r[2,4] indicator_ZN_pp_3 indicator_ZN_nn_3 indicator_ZN_ac_3
 root_node_ZN_pp_3 root_node_ZN_nn_3 root_node_ZN_ac_3
 max_indicator_ZN_pp_3 max_indicator_ZN_nn_3 max_indicator_ZN_ac_3
 indicator_ZN_pp_6 indicator_ZN_nn_6 indicator_ZN_ac_6 root_node_ZN_pp_6
 root_node_ZN_nn_6 root_node_ZN_ac_6 max_indicator_ZN_pp_6
 max_indicator_ZN_nn_6 max_indicator_ZN_ac_6 indicator_ZN_pp_9
 indicator_ZN_nn_9 indicator_ZN_ac_9 root_node_ZN_pp_9 root_node_ZN_nn_9
 root_node_ZN_ac_9 max_indicator_ZN_pp_9 max_indicator_ZN_nn_9
 max_indicator_ZN_ac_9 io_detector_ZN y_ZN_edge_connector_pv_3_pp_3_co
 y_ZN_edge_connector_pv_3_ac_3_co y_ZN_edge_connector_nv_3_nn_3_co
 y_ZN_edge_connector_nv_3_ac_3_co y_ZN_edge_connector_pv_6_pp_6_co
 y_ZN_edge_connector_pv_6_ac_6_co y_ZN_edge_connector_nv_6_nn_6_co
 y_ZN_edge_connector_nv_6_ac_6_co y_ZN_edge_connector_pv_9_pp_9_co
 y_ZN_edge_connector_pv_9_ac_9_co y_ZN_edge_connector_nv_9_nn_9_co
 y_ZN_edge_connector_nv_9_ac_9_co c_mar_row_ZN_pp_3_r[3]
 c_mar_row_ZN_pp_3_r[2] c_mar_row_ZN_pp_3_3_case[0]
 c_mar_row_ZN_pp_3_2_case[0] c_mar_row_ZN_nn_3_r[1] c_mar_row_ZN_nn_3_r[0]
 c_mar_row_ZN_nn_3_1_case[0] c_mar_row_ZN_nn_3_0_case[0]
 c_mar_row_ZN_ac_3_r[3] c_mar_row_ZN_ac_3_r[2] c_mar_row_ZN_ac_3_r[1]
 c_mar_row_ZN_ac_3_r[0] c_mar_row_ZN_ac_3_3_case[0]
 c_mar_row_ZN_ac_3_2_case[0] c_mar_row_ZN_ac_3_1_case[0]
 c_mar_row_ZN_ac_3_0_case[0] c_mar_row_ZN_pp_6_r[3] c_mar_row_ZN_pp_6_r[2]
 c_mar_row_ZN_pp_6_3_case[0] c_mar_row_ZN_pp_6_3_case[1]
 c_mar_row_ZN_pp_6_2_case[0] c_mar_row_ZN_pp_6_2_case[1]
 c_mar_row_ZN_nn_6_r[1] c_mar_row_ZN_nn_6_r[0] c_mar_row_ZN_nn_6_1_case[0]
 c_mar_row_ZN_nn_6_1_case[1] c_mar_row_ZN_nn_6_0_case[0]
 c_mar_row_ZN_nn_6_0_case[1] c_mar_row_ZN_ac_6_r[3] c_mar_row_ZN_ac_6_r[2]
 c_mar_row_ZN_ac_6_r[1] c_mar_row_ZN_ac_6_r[0] c_mar_row_ZN_ac_6_3_case[0]
 c_mar_row_ZN_ac_6_3_case[1] c_mar_row_ZN_ac_6_2_case[0]
 c_mar_row_ZN_ac_6_2_case[1] c_mar_row_ZN_ac_6_1_case[0]
 c_mar_row_ZN_ac_6_1_case[1] c_mar_row_ZN_ac_6_0_case[0]
 c_mar_row_ZN_ac_6_0_case[1] c_mar_row_ZN_pp_9_r[3] c_mar_row_ZN_pp_9_r[2]
 c_mar_row_ZN_pp_9_3_case[0] c_mar_row_ZN_pp_9_2_case[0]
 c_mar_row_ZN_nn_9_r[1] c_mar_row_ZN_nn_9_r[0] c_mar_row_ZN_nn_9_1_case[0]
 c_mar_row_ZN_nn_9_0_case[0] c_mar_row_ZN_ac_9_r[3] c_mar_row_ZN_ac_9_r[2]
 c_mar_row_ZN_ac_9_r[1] c_mar_row_ZN_ac_9_r[0] c_mar_row_ZN_ac_9_3_case[0]
 c_mar_row_ZN_ac_9_2_case[0] c_mar_row_ZN_ac_9_1_case[0]
 c_mar_row_ZN_ac_9_0_case[0] y_ZN_edge_pv_3_pv_4_3 y_ZN_edge_pv_3_pv_4_2
 y_ZN_edge_nv_3_nv_4_1 y_ZN_edge_nv_3_nv_4_0 y_ZN_edge_pv_4_pv_6_3
 y_ZN_edge_pv_4_pv_6_2 y_ZN_edge_nv_4_nv_6_1 y_ZN_edge_nv_4_nv_6_0
 y_ZN_edge_pv_6_pv_8_3 y_ZN_edge_pv_6_pv_8_2 y_ZN_edge_nv_6_nv_8_1
 y_ZN_edge_nv_6_nv_8_0 y_ZN_edge_pv_8_pv_9_3 y_ZN_edge_pv_8_pv_9_2
 y_ZN_edge_nv_8_nv_9_1 y_ZN_edge_nv_8_nv_9_0 y_ZN_edge_via_enable_m1_4_pv_4
 y_ZN_edge_via_enable_m1_4_nv_4 y_ZN_edge_m1_4_m1_8_r_7
 y_ZN_edge_m1_4_m1_8_r_6 y_ZN_edge_m1_4_m1_8_r_5 y_ZN_edge_m1_4_m1_8_r_4
 y_ZN_edge_via_enable_m1_8_pv_8 y_ZN_edge_via_enable_m1_8_nv_8 t_I_c_r[0,3]
 t_I_c_r[0,2] t_I_c_r[0,1] t_I_c_r[0,0] t_I_c_r[1,3] t_I_c_r[1,2]
 t_I_c_r[1,1] t_I_c_r[1,0] t_I_c_r[2,3] t_I_c_r[2,2] t_I_c_r[2,1]
 t_I_c_r[2,0] v_I_v[0] v_I_v[1] ut_I_c_r[0,7] ut_I_c_r[0,6] ut_I_c_r[0,5]
 ut_I_c_r[0,4] ut_I_c_r[1,7] ut_I_c_r[1,6] ut_I_c_r[1,5] ut_I_c_r[1,4]
 ut_I_c_r[2,7] ut_I_c_r[2,6] ut_I_c_r[2,5] ut_I_c_r[2,4] indicator_I_pp_3
 indicator_I_nn_3 indicator_I_ac_3 root_node_I_pp_3 root_node_I_nn_3
 root_node_I_ac_3 max_indicator_I_pp_3 max_indicator_I_nn_3
 max_indicator_I_ac_3 indicator_I_pp_6 indicator_I_nn_6 indicator_I_ac_6
 root_node_I_pp_6 root_node_I_nn_6 root_node_I_ac_6 max_indicator_I_pp_6
 max_indicator_I_nn_6 max_indicator_I_ac_6 indicator_I_pp_9
 indicator_I_nn_9 indicator_I_ac_9 root_node_I_pp_9 root_node_I_nn_9
 root_node_I_ac_9 max_indicator_I_pp_9 max_indicator_I_nn_9
 max_indicator_I_ac_9 io_detector_I y_I_edge_connector_pv_3_pp_3_co
 y_I_edge_connector_pv_3_ac_3_co y_I_edge_connector_nv_3_nn_3_co
 y_I_edge_connector_nv_3_ac_3_co y_I_edge_connector_pv_6_pp_6_co
 y_I_edge_connector_pv_6_ac_6_co y_I_edge_connector_nv_6_nn_6_co
 y_I_edge_connector_nv_6_ac_6_co y_I_edge_connector_pv_9_pp_9_co
 y_I_edge_connector_pv_9_ac_9_co y_I_edge_connector_nv_9_nn_9_co
 y_I_edge_connector_nv_9_ac_9_co c_mar_row_I_pp_3_r[3]
 c_mar_row_I_pp_3_r[2] c_mar_row_I_pp_3_3_case[0]
 c_mar_row_I_pp_3_2_case[0] c_mar_row_I_nn_3_r[1] c_mar_row_I_nn_3_r[0]
 c_mar_row_I_nn_3_1_case[0] c_mar_row_I_nn_3_0_case[0]
 c_mar_row_I_ac_3_r[3] c_mar_row_I_ac_3_r[2] c_mar_row_I_ac_3_r[1]
 c_mar_row_I_ac_3_r[0] c_mar_row_I_ac_3_3_case[0]
 c_mar_row_I_ac_3_2_case[0] c_mar_row_I_ac_3_1_case[0]
 c_mar_row_I_ac_3_0_case[0] c_mar_row_I_pp_6_r[3] c_mar_row_I_pp_6_r[2]
 c_mar_row_I_pp_6_3_case[0] c_mar_row_I_pp_6_3_case[1]
 c_mar_row_I_pp_6_2_case[0] c_mar_row_I_pp_6_2_case[1]
 c_mar_row_I_nn_6_r[1] c_mar_row_I_nn_6_r[0] c_mar_row_I_nn_6_1_case[0]
 c_mar_row_I_nn_6_1_case[1] c_mar_row_I_nn_6_0_case[0]
 c_mar_row_I_nn_6_0_case[1] c_mar_row_I_ac_6_r[3] c_mar_row_I_ac_6_r[2]
 c_mar_row_I_ac_6_r[1] c_mar_row_I_ac_6_r[0] c_mar_row_I_ac_6_3_case[0]
 c_mar_row_I_ac_6_3_case[1] c_mar_row_I_ac_6_2_case[0]
 c_mar_row_I_ac_6_2_case[1] c_mar_row_I_ac_6_1_case[0]
 c_mar_row_I_ac_6_1_case[1] c_mar_row_I_ac_6_0_case[0]
 c_mar_row_I_ac_6_0_case[1] c_mar_row_I_pp_9_r[3] c_mar_row_I_pp_9_r[2]
 c_mar_row_I_pp_9_3_case[0] c_mar_row_I_pp_9_2_case[0]
 c_mar_row_I_nn_9_r[1] c_mar_row_I_nn_9_r[0] c_mar_row_I_nn_9_1_case[0]
 c_mar_row_I_nn_9_0_case[0] c_mar_row_I_ac_9_r[3] c_mar_row_I_ac_9_r[2]
 c_mar_row_I_ac_9_r[1] c_mar_row_I_ac_9_r[0] c_mar_row_I_ac_9_3_case[0]
 c_mar_row_I_ac_9_2_case[0] c_mar_row_I_ac_9_1_case[0]
 c_mar_row_I_ac_9_0_case[0] y_I_edge_pv_3_pv_4_3 y_I_edge_pv_3_pv_4_2
 y_I_edge_nv_3_nv_4_1 y_I_edge_nv_3_nv_4_0 y_I_edge_pv_4_pv_6_3
 y_I_edge_pv_4_pv_6_2 y_I_edge_nv_4_nv_6_1 y_I_edge_nv_4_nv_6_0
 y_I_edge_pv_6_pv_8_3 y_I_edge_pv_6_pv_8_2 y_I_edge_nv_6_nv_8_1
 y_I_edge_nv_6_nv_8_0 y_I_edge_pv_8_pv_9_3 y_I_edge_pv_8_pv_9_2
 y_I_edge_nv_8_nv_9_1 y_I_edge_nv_8_nv_9_0 y_I_edge_via_enable_m1_4_pv_4
 y_I_edge_via_enable_m1_4_nv_4 y_I_edge_m1_4_m1_8_r_7
 y_I_edge_m1_4_m1_8_r_6 y_I_edge_m1_4_m1_8_r_5 y_I_edge_m1_4_m1_8_r_4
 y_I_edge_via_enable_m1_8_pv_8 y_I_edge_via_enable_m1_8_nv_8 l_e_1
 cond_col1_row3_netI one_pin_net_bin_I pin_is_there_3_I
 cond_col1_row3_netZN one_pin_net_bin_ZN pin_is_there_3_ZN
 cond_col1_row2_netI one_pin_net_bin_I pin_is_there_2_I
 cond_col1_row2_netZN one_pin_net_bin_ZN pin_is_there_2_ZN
 cond_col1_row1_netI one_pin_net_bin_I pin_is_there_1_I
 cond_col1_row1_netZN one_pin_net_bin_ZN pin_is_there_1_ZN
 cond_col1_row0_netI one_pin_net_bin_I pin_is_there_0_I
 cond_col1_row0_netZN one_pin_net_bin_ZN pin_is_there_0_ZN z_1_I_ZN_3_0
 z_1_I_ZN_0_3 z_1_ZN_I_3_0 z_1_ZN_I_0_3 o_m_p_7 o_m_p_6 o_m_p_5 o_m_p_4
Generals
 t_c_0 ut_c_0 t_c_0_3 t_c_0_2 t_c_0_1 t_c_0_0 ut_c_0_7 ut_c_0_6 ut_c_0_5
 ut_c_0_4 t_c_1 ut_c_1 t_c_1_3 t_c_1_2 t_c_1_1 t_c_1_0 ut_c_1_7 ut_c_1_6
 ut_c_1_5 ut_c_1_4 t_c_2 ut_c_2 t_c_2_3 t_c_2_2 t_c_2_1 t_c_2_0 ut_c_2_7
 ut_c_2_6 ut_c_2_5 ut_c_2_4 min_indicator_ZN max_bbox_ZN
 f_ZN_edge_connector_pv_3_pp_3_co f_ZN_edge_connector_pv_3_ac_3_co
 f_ZN_edge_connector_nv_3_nn_3_co f_ZN_edge_connector_nv_3_ac_3_co
 f_ZN_edge_connector_pv_6_pp_6_co f_ZN_edge_connector_pv_6_ac_6_co
 f_ZN_edge_connector_nv_6_nn_6_co f_ZN_edge_connector_nv_6_ac_6_co
 f_ZN_edge_connector_pv_9_pp_9_co f_ZN_edge_connector_pv_9_ac_9_co
 f_ZN_edge_connector_nv_9_nn_9_co f_ZN_edge_connector_nv_9_ac_9_co
 f_ZN_edge_pv_3_pv_4_3 f_ZN_edge_pv_3_pv_4_2 f_ZN_edge_nv_3_nv_4_1
 f_ZN_edge_nv_3_nv_4_0 f_ZN_edge_pv_4_pv_6_3 f_ZN_edge_pv_4_pv_6_2
 f_ZN_edge_nv_4_nv_6_1 f_ZN_edge_nv_4_nv_6_0 f_ZN_edge_pv_6_pv_8_3
 f_ZN_edge_pv_6_pv_8_2 f_ZN_edge_nv_6_nv_8_1 f_ZN_edge_nv_6_nv_8_0
 f_ZN_edge_pv_8_pv_9_3 f_ZN_edge_pv_8_pv_9_2 f_ZN_edge_nv_8_nv_9_1
 f_ZN_edge_nv_8_nv_9_0 f_ZN_edge_via_enable_m1_4_pv_4
 f_ZN_edge_via_enable_m1_4_nv_4 f_ZN_edge_m1_4_m1_8_r_7
 f_ZN_edge_m1_4_m1_8_r_6 f_ZN_edge_m1_4_m1_8_r_5 f_ZN_edge_m1_4_m1_8_r_4
 f_ZN_edge_via_enable_m1_8_pv_8 f_ZN_edge_via_enable_m1_8_nv_8 cap_ZN_ac_3
 cap_ZN_nn_3 cap_ZN_nv_3 cap_ZN_pp_3 cap_ZN_pv_3 cap_ZN_m1_4 cap_ZN_nv_4
 cap_ZN_pv_4 cap_ZN_ac_6 cap_ZN_nn_6 cap_ZN_nv_6 cap_ZN_pp_6 cap_ZN_pv_6
 cap_ZN_m1_8 cap_ZN_nv_8 cap_ZN_pv_8 cap_ZN_ac_9 cap_ZN_nn_9 cap_ZN_nv_9
 cap_ZN_pp_9 cap_ZN_pv_9 min_indicator_I max_bbox_I
 f_I_edge_connector_pv_3_pp_3_co f_I_edge_connector_pv_3_ac_3_co
 f_I_edge_connector_nv_3_nn_3_co f_I_edge_connector_nv_3_ac_3_co
 f_I_edge_connector_pv_6_pp_6_co f_I_edge_connector_pv_6_ac_6_co
 f_I_edge_connector_nv_6_nn_6_co f_I_edge_connector_nv_6_ac_6_co
 f_I_edge_connector_pv_9_pp_9_co f_I_edge_connector_pv_9_ac_9_co
 f_I_edge_connector_nv_9_nn_9_co f_I_edge_connector_nv_9_ac_9_co
 f_I_edge_pv_3_pv_4_3 f_I_edge_pv_3_pv_4_2 f_I_edge_nv_3_nv_4_1
 f_I_edge_nv_3_nv_4_0 f_I_edge_pv_4_pv_6_3 f_I_edge_pv_4_pv_6_2
 f_I_edge_nv_4_nv_6_1 f_I_edge_nv_4_nv_6_0 f_I_edge_pv_6_pv_8_3
 f_I_edge_pv_6_pv_8_2 f_I_edge_nv_6_nv_8_1 f_I_edge_nv_6_nv_8_0
 f_I_edge_pv_8_pv_9_3 f_I_edge_pv_8_pv_9_2 f_I_edge_nv_8_nv_9_1
 f_I_edge_nv_8_nv_9_0 f_I_edge_via_enable_m1_4_pv_4
 f_I_edge_via_enable_m1_4_nv_4 f_I_edge_m1_4_m1_8_r_7
 f_I_edge_m1_4_m1_8_r_6 f_I_edge_m1_4_m1_8_r_5 f_I_edge_m1_4_m1_8_r_4
 f_I_edge_via_enable_m1_8_pv_8 f_I_edge_via_enable_m1_8_nv_8 cap_I_ac_3
 cap_I_nn_3 cap_I_nv_3 cap_I_pp_3 cap_I_pv_3 cap_I_m1_4 cap_I_nv_4
 cap_I_pv_4 cap_I_ac_6 cap_I_nn_6 cap_I_nv_6 cap_I_pp_6 cap_I_pv_6
 cap_I_m1_8 cap_I_nv_8 cap_I_pv_8 cap_I_ac_9 cap_I_nn_9 cap_I_nv_9
 cap_I_pp_9 cap_I_pv_9 p_e_r_1
End
