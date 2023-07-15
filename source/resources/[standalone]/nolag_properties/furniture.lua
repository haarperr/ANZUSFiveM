-- Please read documentation: https://dolutattoo.github.io/docs/category/furniture
FurnitureConfig = {}

-- Use freecam to place furniture
FurnitureConfig.FreeCam = false

-- The key to open the menu
FurnitureConfig.openMenuKey = 'F3'

FurnitureConfig.Furniture = {
	["sofas"] = {
		["label"] = "Sofas",
		["items"] = {
			{ ["object"] = "apa_mp_h_stn_sofacorn_01", ["price"] = 1450, ["label"] = "STN Sofacorn",
				["group_items"] = {
				    { ["object"] = "apa_mp_h_stn_sofacorn_01", ["price"] = 1450, ["label"] = "STN Sofacorn White Grey" },
					{ ["object"] = "apa_mp_h_stn_sofacorn_05", ["price"] = 1450, ["label"] = "STN Sofacorn Light Blue" },
					{ ["object"] = "apa_mp_h_stn_sofacorn_06", ["price"] = 1450, ["label"] = "STN Sofacorn Green" },
					{ ["object"] = "apa_mp_h_stn_sofacorn_07", ["price"] = 1450, ["label"] = "STN Sofacorn Dark Blue" },
					{ ["object"] = "apa_mp_h_stn_sofacorn_08", ["price"] = 1450, ["label"] = "STN Sofacorn Light Grey" },
					{ ["object"] = "apa_mp_h_stn_sofacorn_09", ["price"] = 1450, ["label"] = "STN Sofacorn Dark Grey" },
					{ ["object"] = "apa_mp_h_stn_sofacorn_10", ["price"] = 1450, ["label"] = "STN Sofacorn White" }
				}
			},
			{ ["object"] = "apa_mp_h_stn_sofa2seat_02", ["price"] = 980, ["label"] = "Sofa 2 Seat",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_stn_sofa2seat_02", ["price"] = 980, ["label"] = "Sofa 2 Seat Modern" },
					{ ["object"] = "hei_heist_stn_sofa2seat_03", ["price"] = 980, ["label"] = "Sofa 2 Seat Old" },
					{ ["object"] = "hei_heist_stn_sofa2seat_06", ["price"] = 980, ["label"] = "Sofa 2 Seat New" }
				}
			},
			{ ["object"] = "hei_heist_stn_sofacorn_05", ["price"] = 1980, ["label"] = "Sofa corn 05",
				["group_items"] = {
					{ ["object"] = "hei_heist_stn_sofacorn_05", ["price"] = 1980, ["label"] = "Sofa corn 05" },
					{ ["object"] = "hei_heist_stn_sofacorn_06", ["price"] = 1980, ["label"] = "Sofa corn 06" },
				}
			},
			{ ["object"] = "apa_mp_h_stn_sofa_daybed_01", ["price"] = 750, ["label"] = "Daybed",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_stn_sofa_daybed_01", ["price"] = 750, ["label"] = "Daybed Brown" },
					{ ["object"] = "apa_mp_h_stn_sofa_daybed_02", ["price"] = 750, ["label"] = "Daybed Black" }
				}
			},
			{ ["object"] = "apa_mp_h_yacht_sofa_01", ["price"] = 1750, ["label"] = "Yacht Sofa",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_yacht_sofa_01", ["price"] = 1750, ["label"] = "Yacht Sofa White" },
					{ ["object"] = "apa_mp_h_yacht_sofa_02", ["price"] = 980, ["label"] = "Yacht Sofa Brown" },
					{ ["object"] = "p_yacht_sofa_01_s", ["price"] = 750, ["label"] = "Yacht Sofa Outdoor" }
				}
			},
			{ ["object"] = "prop_yaught_sofa_01", ["price"] = 750, ["label"] = "Yaught Sofa Yellow",
				["group_items"] = {
					{ ["object"] = "prop_yaught_sofa_01", ["price"] = 550, ["label"] = "Yaught Sofa Yellow" },
					{ ["object"] = "p_yacht_sofa_01_s", ["price"] = 550, ["label"] = "Yaught Sofa Green" },
				}
			},
			{ ["object"] = "ex_mp_h_off_sofa_003", ["price"] = 850, ["label"] = "Off Sofa",
				["group_items"] = {
					{ ["object"] = "ex_mp_h_off_sofa_003", ["price"] = 850, ["label"] = "Off Sofa Blue" },
					{ ["object"] = "ex_mp_h_off_sofa_01", ["price"] = 850, ["label"] = "Off Sofa White" },
					{ ["object"] = "ex_mp_h_off_sofa_02", ["price"] = 850, ["label"] = "Off Sofa Black" }
				}
			},
			{ ["object"] = "hei_heist_stn_sofa3seat_01", ["price"] = 1100, ["label"] = "Sofa 3 Seat",
				["group_items"] = {
					{ ["object"] = "hei_heist_stn_sofa3seat_01", ["price"] = 1100, ["label"] = "Sofa 3 Seat Light Grey" },
					{ ["object"] = "hei_heist_stn_sofa3seat_02", ["price"] = 1100, ["label"] = "Sofa 3 Seat cream color" },
					{ ["object"] = "hei_heist_stn_sofa3seat_06", ["price"] = 1100, ["label"] = "Sofa 3 Seat Dark grey" }
				}
			},
			{ ["object"] = "prop_t_sofa", ["price"] = 1100, ["label"] = "T Sofa",
				["group_items"] = {
					{ ["object"] = "prop_t_sofa", ["price"] = 1100, ["label"] = "T Sofa" },
					{ ["object"] = "prop_t_sofa_02", ["price"] = 1100, ["label"] = "T Sofa" }
				}
			},
			{ ["object"] = "v_tre_sofa_mess_b_s", ["price"] = 100, ["label"] = "Tre Sofa Okay",
				["group_items"] = {
					{ ["object"] = "v_tre_sofa_mess_b_s", ["price"] = 100, ["label"] = "Tre Sofa Okay" },
					{ ["object"] = "v_tre_sofa_mess_c_s", ["price"] = 20, ["label"] = "Tre Sofa Mess" }
				}
			},
			{ ["object"] = "xm_lab_sofa_01", ["price"] = 1200, ["label"] = "Tre Sofa",
				["group_items"] = {
					{ ["object"] = "xm_lab_sofa_01", ["price"] = 1200, ["label"] = "Tre Sofa White" },
					{ ["object"] = "xm_lab_sofa_02", ["price"] = 1200, ["label"] = "Tre Sofa Black" }
				}
			},
			{ ["object"] = "prop_bench_01a", ["price"] = 200, ["label"] = "Exterior bench",
			["group_items"] = {
				{ ["object"] = "prop_bench_01a", ["price"] = 200, ["label"] = "Bench 01a" },
				{ ["object"] = "prop_bench_01b", ["price"] = 200, ["label"] = "Bench 01b" },
				{ ["object"] = "prop_bench_01c", ["price"] = 200, ["label"] = "Bench 01c" },
				{ ["object"] = "prop_bench_02", ["price"] = 200, ["label"] = "Bench 02" },
				{ ["object"] = "prop_bench_03", ["price"] = 200, ["label"] = "Bench 03" },
				{ ["object"] = "prop_bench_04", ["price"] = 200, ["label"] = "Bench 04" },
				{ ["object"] = "prop_bench_05", ["price"] = 200, ["label"] = "Bench 05" },
				{ ["object"] = "prop_bench_08", ["price"] = 200, ["label"] = "Bench 08" },
				{ ["object"] = "prop_bench_10", ["price"] = 200, ["label"] = "Bench 10" },
				{ ["object"] = "prop_bench_11", ["price"] = 200, ["label"] = "Bench 11" },
			}
		},
			{ ["object"] = "bkr_prop_clubhouse_sofa_01a", ["price"] = 650, ["label"] = "Clubhouse Sofa" },
			{ ["object"] = "imp_prop_impexp_sofabed_01a", ["price"] = 500, ["label"] = "Sofabed" },
			{ ["object"] = "p_res_sofa_l_s", ["price"] = 1000, ["label"] = "Res Sofa" },
			{ ["object"] = "p_v_med_p_sofa_s", ["price"] = 870, ["label"] = "Med Sofa" },
			{ ["object"] = "gr_dlc_gr_yacht_props_lounger", ["price"] = 870, ["label"] = "Yacht lounger" },
			{ ["object"] = "p_lev_sofa_s", ["price"] = 1370, ["label"] = "Lev sofa" },
		}
	},

	["plants"] = {
		["label"] = "Plants",
		["items"] = {
			{ ["object"] = "prop_plant_int_02a", ["price"] = 160, ["label"] = "Plant Int 02a",
				["group_items"] = {
					{ ["object"] = "prop_plant_int_02a", ["price"] = 160, ["label"] = "Plant Int 02a" },
					{ ["object"] = "prop_plant_int_02b", ["price"] = 160, ["label"] = "Plant Int 02b" },
					{ ["object"] = "prop_plant_int_05a", ["price"] = 160, ["label"] = "Plant Int 05a" },
					{ ["object"] = "prop_plant_int_05b", ["price"] = 160, ["label"] = "Plant Int 05b" },
					{ ["object"] = "prop_plant_int_06a", ["price"] = 160, ["label"] = "Plant Int 06a" },
					{ ["object"] = "prop_plant_int_06b", ["price"] = 160, ["label"] = "Plant Int 06b" }
				}
			},
			{ ["object"] = "prop_pot_plant_02a", ["price"] = 250, ["label"] = "Pot Plant 02a",
				["group_items"] = {
					{ ["object"] = "prop_pot_plant_02a", ["price"] = 250, ["label"] = "Pot Plant 02a" },
					{ ["object"] = "prop_pot_plant_02b", ["price"] = 250, ["label"] = "Pot Plant 02b" },
					{ ["object"] = "prop_pot_plant_02c", ["price"] = 250, ["label"] = "Pot Plant 02c" },
					{ ["object"] = "prop_pot_plant_02d", ["price"] = 250, ["label"] = "Pot Plant 02d" },
					{ ["object"] = "prop_pot_plant_03a", ["price"] = 250, ["label"] = "Pot Plant 03a" },
				}
			},
			{ ["object"] = "p_int_jewel_plant_01", ["price"] = 450, ["label"] = "Jewel Plant",
				["group_items"] = {
					{ ["object"] = "p_int_jewel_plant_01", ["price"] = 450, ["label"] = "Jewel Plant 01" },
					{ ["object"] = "p_int_jewel_plant_02", ["price"] = 450, ["label"] = "Jewel Plant 02" }
				}
			},
			{ ["object"] = "vw_prop_casino_art_plant_01a", ["price"] = 300, ["label"] = "Art Plant",
				["group_items"] = {
					{ ["object"] = "vw_prop_casino_art_plant_01a", ["price"] = 300, ["label"] = "Art Plant 01a" },
					{ ["object"] = "vw_prop_casino_art_plant_02a", ["price"] = 300, ["label"] = "Art Plant 02a" },
					{ ["object"] = "vw_prop_casino_art_plant_03a", ["price"] = 300, ["label"] = "Art Plant 03a" },
					{ ["object"] = "vw_prop_casino_art_plant_04a", ["price"] = 300, ["label"] = "Art Plant 04a" },
					{ ["object"] = "vw_prop_casino_art_plant_05a", ["price"] = 300, ["label"] = "Art Plant 05a" },
					{ ["object"] = "vw_prop_casino_art_plant_06a", ["price"] = 300, ["label"] = "Art Plant 06a" },
					{ ["object"] = "vw_prop_casino_art_plant_07a", ["price"] = 300, ["label"] = "Art Plant 07a" },
					{ ["object"] = "vw_prop_casino_art_plant_08a", ["price"] = 300, ["label"] = "Art Plant 08a" },
					{ ["object"] = "vw_prop_casino_art_plant_09a", ["price"] = 300, ["label"] = "Art Plant 09a" },
					{ ["object"] = "vw_prop_casino_art_plant_10a", ["price"] = 300, ["label"] = "Art Plant 10a" },
					{ ["object"] = "vw_prop_casino_art_plant_11a", ["price"] = 300, ["label"] = "Art Plant 11a" },
					{ ["object"] = "vw_prop_casino_art_plant_12a", ["price"] = 300, ["label"] = "Art Plant 12a" }
				}
			},
			{ ["object"] = "bkr_prop_weed_bucket_01a", ["price"] = 450, ["label"] = "Weed care",
				["group_items"] = {
					{ ["object"] = "bkr_prop_weed_bucket_01a", ["price"] = 450, ["label"] = "Weed bucket 01a" },
					{ ["object"] = "bkr_prop_weed_bucket_01b", ["price"] = 450, ["label"] = "Weed bucket 01b" },
					{ ["object"] = "bkr_prop_weed_bucket_01c", ["price"] = 450, ["label"] = "Weed bucket 01c" },
					{ ["object"] = "bkr_prop_weed_bucket_01d", ["price"] = 450, ["label"] = "Weed bucket 01d" },
					{ ["object"] = "bkr_prop_weed_bucket_open_01a", ["price"] = 450, ["label"] = "Weed bucket open" },
					{ ["object"] = "bkr_prop_weed_plantpot_stack_01b", ["price"] = 550, ["label"] = "Bucket stack 01b" },
					{ ["object"] = "bkr_prop_weed_plantpot_stack_01c", ["price"] = 550, ["label"] = "Bucket stack 01c" },
					{ ["object"] = "bkr_prop_weed_fan_ceiling_01a", ["price"] = 450, ["label"] = "Weed Fan 01a" },
				}
			},
			{ ["object"] = "apa_mp_h_acc_plant_palm_01", ["price"] = 90, ["label"] = "Palm" },
			{ ["object"] = "apa_mp_h_acc_plant_tall_01", ["price"] = 120, ["label"] = "Tall" },
			{ ["object"] = "ch_prop_ch_planter_01", ["price"] = 120, ["label"] = "Planter" },
			{ ["object"] = "prop_fbibombplant", ["price"] = 185, ["label"] = "FBI Bomb plant" },
		}
	},

	["bushes"] = {
		["label"] = "Bushes",
		["items"] = {
			{ ["object"] = "prop_bush_med_03", ["price"] = 150, ["label"] = "Bush med 03" },
			{ ["object"] = "prop_bush_med_05", ["price"] = 150, ["label"] = "Bush med 05" },
			{ ["object"] = "prop_bush_med_06", ["price"] = 150, ["label"] = "Bush med 06" },
			{ ["object"] = "prop_bush_lrg_01d", ["price"] = 150, ["label"] = "Bush lrg 01d" },
			{ ["object"] = "prop_bush_lrg_03", ["price"] = 150, ["label"] = "Bush lrg 03" },
			{ ["object"] = "prop_bush_lrg_01c", ["price"] = 190, ["label"] = "Bush lrg 01c" },
			{ ["object"] = "prop_bush_lrg_01c_cr", ["price"] = 190, ["label"] = "Bush lrg 01c" },
			{ ["object"] = "prop_bush_lrg_01e_cr2", ["price"] = 190, ["label"] = "Bush lrg 01e" },
			{ ["object"] = "prop_bush_ivy_01_1m", ["price"] = 123, ["label"] = "Bush ivy 01" },
			{ ["object"] = "prop_bush_ivy_02_2m", ["price"] = 133, ["label"] = "Bush ivy 02" },
			{ ["object"] = "prop_bush_ivy_02_pot", ["price"] = 120, ["label"] = "Bush ivy 02 pot" },
			{ ["object"] = "prop_bush_ivy_01_r", ["price"] = 100, ["label"] = "Bush ivy 01 r" },
			{ ["object"] = "prop_bush_ivy_01_bk", ["price"] = 180, ["label"] = "Bush ivy 01 bk" },
			{ ["object"] = "prop_bush_neat_06", ["price"] = 190, ["label"] = "Bush neat 06" },
			{ ["object"] = "prop_bush_neat_07", ["price"] = 300, ["label"] = "Bush neat 07" },
			{ ["object"] = "prop_bush_neat_01", ["price"] = 312, ["label"] = "Bush neat 01" },
			{ ["object"] = "prop_bush_neat_08", ["price"] = 290, ["label"] = "Bush neat 08" },
			{ ["object"] = "prop_bush_neat_02", ["price"] = 170, ["label"] = "Bush neat 02" },
			{ ["object"] = "prop_bush_neat_05", ["price"] = 170, ["label"] = "Bush neat 05" },
			{ ["object"] = "prop_bush_dead_02", ["price"] = 170, ["label"] = "Bush dead 02" },
			{ ["object"] = "prop_bush_grape_01", ["price"] = 170, ["label"] = "Bush grape 01" },
			{ ["object"] = "prop_coral_bush_01", ["price"] = 170, ["label"] = "Bush coral 01" },
			{ ["object"] = "prop_snow_bush_04", ["price"] = 300, ["label"] = "Bush snow 04" },
			{ ["object"] = "prop_snow_bush_03", ["price"] = 500, ["label"] = "Bush snow 03" },
			{ ["object"] = "prop_snow_bush_02_a", ["price"] = 500, ["label"] = "Bush snow 02a" },
			{ ["object"] = "prop_snow_bush_02_b", ["price"] = 500, ["label"] = "Bush snow 02b" },

			{ ["object"] = "prop_bush_ornament_01", ["price"] = 1200, ["label"] = "Ornament bush 01",
				["group_items"] = {
					{ ["object"] = "prop_bush_ornament_01", ["price"] = 1200, ["label"] = "Ornament bush 01" },
					{ ["object"] = "prop_bush_ornament_02", ["price"] = 1200, ["label"] = "Ornament bush 02" },
					{ ["object"] = "prop_bush_ornament_04", ["price"] = 1200, ["label"] = "Ornament bush 04" },
					{ ["object"] = "prop_bush_ornament_03", ["price"] = 1200, ["label"] = "Ornament bush 03" },
				}
			},
		}
	},

	["large-bushes"] = {
		["label"] = "Large Bushes",
		["items"] = {
			{ ["object"] = "prop_bush_neat_04", ["price"] = 900, ["label"] = "Bush neat 04" },
			{ ["object"] = "prop_bush_neat_03", ["price"] = 900, ["label"] = "Bush neat 03" },
		}
	},

	["trees"] = {
		["label"] = "Trees",
		["items"] = {
			{ ["object"] = "prop_joshua_tree_02c", ["price"] = 1500, ["label"] = "Tree Joshua 02c",
				["group_items"] = {
					{ ["object"] = "prop_joshua_tree_02c", ["price"] = 1500, ["label"] = "Tree Joshua 02c" },
					{ ["object"] = "prop_joshua_tree_01b", ["price"] = 1500, ["label"] = "Tree Joshua 01b" },
					{ ["object"] = "prop_joshua_tree_02d", ["price"] = 1500, ["label"] = "Tree Joshua 02b" },
					{ ["object"] = "prop_joshua_tree_01a", ["price"] = 1500, ["label"] = "Tree Joshua 01a" },
					{ ["object"] = "prop_joshua_tree_01e", ["price"] = 1500, ["label"] = "Tree Joshua 01e" },
					{ ["object"] = "prop_joshua_tree_01d", ["price"] = 1500, ["label"] = "Tree Joshua 01b" },
					{ ["object"] = "prop_joshua_tree_01c", ["price"] = 1500, ["label"] = "Tree Joshua 01c" },
					{ ["object"] = "prop_joshua_tree_02b", ["price"] = 1500, ["label"] = "Tree Joshua 02b" },
					{ ["object"] = "prop_joshua_tree_02b", ["price"] = 1500, ["label"] = "Tree Joshua 02b" },
				}
			},

			{ ["object"] = "prop_snow_tree_03_h", ["price"] = 3600, ["label"] = "Snow tree 03",
				["group_items"] = {
					{ ["object"] = "prop_snow_tree_03_h", ["price"] = 3600, ["label"] = "Snow tree 03" },
					{ ["object"] = "prop_snow_tree_04_f", ["price"] = 3600, ["label"] = "Snow tree 04" },
					{ ["object"] = "prop_snow_tree_03_i", ["price"] = 3600, ["label"] = "Snow tree 03i" },
					{ ["object"] = "prop_xmas_tree_int", ["price"] = 1200, ["label"] = "Snow xmas int" },
				}
			},

			{ ["object"] = "test_tree_cedar_trunk_001", ["price"] = 1500, ["label"] = "Tree cedar 01",
				["group_items"] = {
					{ ["object"] = "test_tree_cedar_trunk_001", ["price"] = 1500, ["label"] = "Tree cedar 01" },
					{ ["object"] = "prop_tree_cedar_s_01", ["price"] = 1500, ["label"] = "Tree cedar 01" },
					{ ["object"] = "prop_tree_cedar_s_04", ["price"] = 1500, ["label"] = "Tree cedar 04s" },
					{ ["object"] = "prop_tree_cedar_04", ["price"] = 1500, ["label"] = "Tree cedar 04" },
				}
			},

			{ ["object"] = "prop_tree_fallen_01", ["price"] = 1500, ["label"] = "Tree fallen 01" },
			{ ["object"] = "test_tree_forest_trunk_04", ["price"] = 1500, ["label"] = "Tree forest 04" },
			{ ["object"] = "prop_tree_olive_01", ["price"] = 1500, ["label"] = "Tree olive 01" },
			{ ["object"] = "prop_tree_olive_creator", ["price"] = 1500, ["label"] = "Tree olive cr" },
			{ ["object"] = "prop_tree_eucalip_01", ["price"] = 1500, ["label"] = "Tree eucalip 01" },
			{ ["object"] = "prop_tree_stump_01", ["price"] = 1500, ["label"] = "Tree stump 01" },
			{ ["object"] = "prop_tree_eng_oak_creator", ["price"] = 1500, ["label"] = "Tree eng oak cr" },
			{ ["object"] = "prop_tree_eng_oak_01", ["price"] = 1500, ["label"] = "Tree eng oak 01" },
			{ ["object"] = "prop_tree_maple_02", ["price"] = 1500, ["label"] = "Tree maple 02" },
			{ ["object"] = "prop_tree_lficus_06", ["price"] = 1500, ["label"] = "Tree lficus 06" },
			{ ["object"] = "prop_tree_birch_04", ["price"] = 1500, ["label"] = "Tree birch 04" },
			{ ["object"] = "prop_tree_mquite_01", ["price"] = 1500, ["label"] = "Tree mquite 01" },
			{ ["object"] = "test_tree_forest_trunk_base_01", ["price"] = 1500, ["label"] = "xxxxxxxxx" },
			{ ["object"] = "prop_tree_jacada_02", ["price"] = 1500, ["label"] = "Tree Jacada 02" },
			{ ["object"] = "prop_tree_log_02", ["price"] = 1500, ["label"] = "Tree log 02" },
			{ ["object"] = "prop_tree_cypress_01", ["price"] = 1500, ["label"] = "Tree cypress 01" },
			{ ["object"] = "prop_tree_birch_05", ["price"] = 1500, ["label"] = "Tree birch 05" },
			{ ["object"] = "prop_prop_tree_02", ["price"] = 1500, ["label"] = "Tree 02" },
		}
	},

	["carpets"] = {
		["label"] = "Carpets",
		["items"] = {
			{ ["object"] = "hei_heist_acc_rugwooll_01", ["price"] = 300, ["label"] = "Rugwooll",
				["group_items"] = {
					{ ["object"] = "hei_heist_acc_rugwooll_01", ["price"] = 300, ["label"] = "Rugwooll 01" },
					{ ["object"] = "hei_heist_acc_rugwooll_02", ["price"] = 300, ["label"] = "Rugwooll 02" },
					{ ["object"] = "hei_heist_acc_rugwooll_03", ["price"] = 300, ["label"] = "Rugwooll 03" },
				}
			},
			{ ["object"] = "apa_mp_h_acc_rugwoolm_01", ["price"] = 300, ["label"] = "Rugwoolm",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_acc_rugwoolm_01", ["price"] = 300, ["label"] = "Rugwoolm 01" },
					{ ["object"] = "apa_mp_h_acc_rugwoolm_02", ["price"] = 300, ["label"] = "Rugwoolm 02" },
					{ ["object"] = "apa_mp_h_acc_rugwoolm_03", ["price"] = 300, ["label"] = "Rugwoolm 03" },
					{ ["object"] = "apa_mp_h_acc_rugwoolm_04", ["price"] = 300, ["label"] = "Rugwoolm 04" }
				}
			},
			{ ["object"] = "apa_mp_h_acc_rugwools_01", ["price"] = 300, ["label"] = "Rugwools",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_acc_rugwools_01", ["price"] = 300, ["label"] = "Rugwools 01" },
					{ ["object"] = "apa_mp_h_acc_rugwools_03", ["price"] = 300, ["label"] = "Rugwools 03" }
				}
			},
			{ ["object"] = "prop_yoga_mat_01", ["price"] = 50, ["label"] = "Yoga Mat",
				["group_items"] = {
					{ ["object"] = "prop_yoga_mat_01", ["price"] = 50, ["label"] = "Yoga Mat 01" },
					{ ["object"] = "prop_yoga_mat_02", ["price"] = 50, ["label"] = "Yoga Mat 02" },
					{ ["object"] = "prop_yoga_mat_03", ["price"] = 50, ["label"] = "Yoga Mat 03" },
					{ ["object"] = "p_yoga_mat_01_s", ["price"] = 50, ["label"] = "Yoga Mat 01s" }
				}
			},
			{ ["object"] = "hei_heist_acc_rughidel_01", ["price"] = 300, ["label"] = "Rug Hidel" },
		}
	},

	["beds"] = {
		["label"] = "Beds",
		["items"] = {
			{ ["object"] = "v_res_d_bed", ["price"] = 700, ["label"] = "Bed 1" },
			{ ["object"] = "v_res_lestersbed", ["price"] = 700, ["label"] = "Bed 2" },
			{ ["object"] = "v_res_mbbed", ["price"] = 700, ["label"] = "MB Bed" },
			{ ["object"] = "v_res_mdbed", ["price"] = 700, ["label"] = "MD Bed" },
			{ ["object"] = "v_res_msonbed", ["price"] = 700, ["label"] = "Bed 3" },
			{ ["object"] = "v_res_tre_bed1", ["price"] = 700, ["label"] = "Bed 4" },
			{ ["object"] = "v_res_tre_bed2", ["price"] = 700, ["label"] = "T Bed" },
			{ ["object"] = "v_res_tt_bed", ["price"] = 700, ["label"] = "TT Bed" },
			{ ["object"] = "apa_mp_h_bed_with_table_02", ["price"] = 5000, ["label"] = "fancy bed" },
			{ ["object"] = "apa_mp_h_bed_wide_05", ["price"] = 5000, ["label"] = "red bed" },
			{ ["object"] = "apa_mp_h_bed_double_08", ["price"] = 3000, ["label"] = "square bed" },
			{ ["object"] = "apa_mp_h_bed_double_09", ["price"] = 3000, ["label"] = "modern bed" },
			{ ["object"] = "apa_mp_h_yacht_bed_01", ["price"] = 5000, ["label"] = "california king" },
			{ ["object"] = "apa_mp_h_yacht_bed_02", ["price"] = 5000, ["label"] = "california king 2" },
			{ ["object"] = "bkr_prop_biker_campbed_01", ["price"] = 100, ["label"] = "camp bed" },
			{ ["object"] = "ex_prop_exec_bed_01", ["price"] = 700, ["label"] = "small bed" },
			{ ["object"] = "gr_prop_bunker_bed_01", ["price"] = 700, ["label"] = "klein bed 2" },
			{ ["object"] = "p_mbbed_s", ["price"] = 700, ["label"] = "Bed 5" },
			{ ["object"] = "gr_prop_gr_campbed_01", ["price"] = 700, ["label"] = "Campbed 01" },
			{ ["object"] = "prop_beach_lilo_02", ["price"] = 100, ["label"] = "Bearch lilo 02",
				["group_items"] = {
					{ ["object"] = "prop_beach_lilo_02", ["price"] = 100, ["label"] = "Bearch lilo 02" },
					{ ["object"] = "prop_beach_lilo_01", ["price"] = 100, ["label"] = "Bearch lilo 01" }
				}
			},
		}
	},


	["tables"] = {
		["label"] = "Tables",
		["items"] = {
			{ ["object"] = "apa_mp_h_din_table_01", ["price"] = 1450, ["label"] = "Din Table",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_din_table_01", ["price"] = 1450, ["label"] = "Din Table 01" },
					{ ["object"] = "apa_mp_h_din_table_04", ["price"] = 1450, ["label"] = "Din Table 04" },
					{ ["object"] = "apa_mp_h_din_table_05", ["price"] = 1450, ["label"] = "Din Table 05" },
					{ ["object"] = "apa_mp_h_din_table_06", ["price"] = 1450, ["label"] = "Din Table 06" },
					{ ["object"] = "apa_mp_h_din_table_11", ["price"] = 1450, ["label"] = "Din Table 11" },
					{ ["object"] = "hei_heist_din_table_04", ["price"] = 1450, ["label"] = "Hei Din Table 04" },
					{ ["object"] = "hei_heist_din_table_06", ["price"] = 1450, ["label"] = "Hei Din Table 06" },
					{ ["object"] = "hei_heist_din_table_07", ["price"] = 1450, ["label"] = "Hei Din Table 07" }
				}
			},
			{ ["object"] = "apa_mp_h_yacht_coffee_table_01", ["price"] = 400, ["label"] = "Coffe Table",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_yacht_coffee_table_01", ["price"] = 400, ["label"] = "Coffe Table 01" },
					{ ["object"] = "apa_mp_h_yacht_coffee_table_02", ["price"] = 400, ["label"] = "Coffe Table 02" },
					{ ["object"] = "prop_fbi3_coffee_table", ["price"] = 400, ["label"] = "FBI Coffe Table" },
					{ ["object"] = "prop_t_coffe_table", ["price"] = 400, ["label"] = "T Coffe Table" }
				}
			},
			{ ["object"] = "apa_mp_h_yacht_side_table_01", ["price"] = 200, ["label"] = "Side Table",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_yacht_side_table_01", ["price"] = 200, ["label"] = "Side Table 01" },
					{ ["object"] = "apa_mp_h_yacht_side_table_02", ["price"] = 200, ["label"] = "Side Table 02" }
				}
			},
			{ ["object"] = "ba_prop_int_edgy_table_01", ["price"] = 300, ["label"] = "Edgy Table",
				["group_items"] = {
					{ ["object"] = "ba_prop_int_edgy_table_01", ["price"] = 300, ["label"] = "Edgy Table 01" },
					{ ["object"] = "ba_prop_int_edgy_table_02", ["price"] = 300, ["label"] = "Edgy Table 02" }
				}
			},
			{ ["object"] = "bkr_prop_weed_table_01a", ["price"] = 1300, ["label"] = "Drug Table",
				["group_items"] = {
					{ ["object"] = "bkr_prop_weed_table_01a", ["price"] = 1300, ["label"] = "Edgy Table 01a" },
					{ ["object"] = "bkr_prop_weed_table_01b", ["price"] = 1300, ["label"] = "Edgy Table 01b" },
					{ ["object"] = "bkr_prop_coke_table01a", ["price"] = 1300, ["label"] = "Coke Table" },
					{ ["object"] = "bkr_prop_meth_table01a", ["price"] = 1300, ["label"] = "Meth Table" }
				}
			},
			{ ["object"] = "gr_dlc_gr_yacht_props_table_01", ["price"] = 1100, ["label"] = "Yacht Table",
				["group_items"] = {
					{ ["object"] = "gr_dlc_gr_yacht_props_table_01", ["price"] = 1100, ["label"] = "Yacht Table 01" },
					{ ["object"] = "gr_dlc_gr_yacht_props_table_02", ["price"] = 1100, ["label"] = "Yacht Table 02" },
					{ ["object"] = "gr_dlc_gr_yacht_props_table_03", ["price"] = 1100, ["label"] = "Yacht Table 03" }
				}
			},
			{ ["object"] = "prop_pooltable_02", ["price"] = 120, ["label"] = "Pool Table",
				["group_items"] = {
					{ ["object"] = "prop_pooltable_02", ["price"] = 120, ["label"] = "Pool Table 02" },
					{ ["object"] = "prop_pooltable_3b", ["price"] = 120, ["label"] = "Pool Table 3b" }
				}
			},
			{ ["object"] = "prop_table_02", ["price"] = 120, ["label"] = "Table",
				["group_items"] = {
					{ ["object"] = "prop_table_02", ["price"] = 120, ["label"] = "Table 02" },
					{ ["object"] = "prop_table_04", ["price"] = 120, ["label"] = "Table 03" },
					{ ["object"] = "prop_table_05", ["price"] = 120, ["label"] = "Table 04" },
					{ ["object"] = "prop_table_06", ["price"] = 120, ["label"] = "Table 05" },
					{ ["object"] = "prop_table_07", ["price"] = 120, ["label"] = "Table 06" },
					{ ["object"] = "prop_table_08", ["price"] = 120, ["label"] = "Table 07" }
				}
			},
			{ ["object"] = "prop_table_02", ["price"] = 1400, ["label"] = "Crystal Tables",
				["group_items"] = {
					{ ["object"] = "prop_table_02", ["price"] = 1400, ["label"] = "Crystal Table" },
					{ ["object"] = "apa_mp_h_str_sideboards_02", ["price"] = 450, ["label"] = "Sideboard Crystal" },
					{ ["object"] = "apa_mp_h_tab_sidelrg_07", ["price"] = 450, ["label"] = "Side Crystal 07" },
					{ ["object"] = "apa_mp_h_tab_sidesml_01", ["price"] = 350, ["label"] = "Side Crystal 01" },
					{ ["object"] = "apa_mp_h_tab_sidesml_02", ["price"] = 350, ["label"] = "Side Crystal 02" },
				}
			},
			{ ["object"] = "bkr_prop_coke_pallet_01a", ["price"] = 50, ["label"] = "Pallets" },
			{ ["object"] = "bkr_prop_crate_set_01a", ["price"] = 50, ["label"] = "Crates 01a" },
			{ ["object"] = "prop_table_tennis", ["price"] = 300, ["label"] = "Tennis Table" },
			{ ["object"] = "prop_ven_market_table1", ["price"] = 150, ["label"] = "Market Table" },
			{ ["object"] = "ba_prop_int_glam_table", ["price"] = 300, ["label"] = "Glam Table" },
			{ ["object"] = "ba_prop_int_trad_table", ["price"] = 300, ["label"] = "Trad Table" },
			{ ["object"] = "ex_prop_ex_console_table_01", ["price"] = 500, ["label"] = "Console Table" },
			{ ["object"] = "prop_patio_lounger1_table", ["price"] = 800, ["label"] = "Lounger Table" },
			{ ["object"] = "apa_mp_h_tab_coffee_08", ["price"] = 1900, ["label"] = "Elegant Table" },
			{ ["object"] = "ex_mp_h_din_table_05", ["price"] = 1900, ["label"] = "Din Table 05" },
			{ ["object"] = "hei_heist_stn_benchshort", ["price"] = 1200, ["label"] = "Benchshort" },
		}
	},

	["walldecoration"] = {
		["label"] = "Walldecoration",
		["items"] = {
			{ ["object"] = "ch_prop_vault_painting_01a", ["price"] = 180, ["label"] = "Vault Painting",
				["group_items"] = {
					{ ["object"] = "ch_prop_vault_painting_01a", ["price"] = 180, ["label"] = "Vault Painting 01a" },
					{ ["object"] = "ch_prop_vault_painting_01b", ["price"] = 180, ["label"] = "Vault Painting 01b" },
					{ ["object"] = "ch_prop_vault_painting_01c", ["price"] = 180, ["label"] = "Vault Painting 01c" },
					{ ["object"] = "ch_prop_vault_painting_01d", ["price"] = 180, ["label"] = "Vault Painting 01d" },
					{ ["object"] = "ch_prop_vault_painting_01e", ["price"] = 180, ["label"] = "Vault Painting 01e" },
					{ ["object"] = "ch_prop_vault_painting_01f", ["price"] = 180, ["label"] = "Vault Painting 01f" },
					{ ["object"] = "ch_prop_vault_painting_01g", ["price"] = 180, ["label"] = "Vault Painting 01g" },
					{ ["object"] = "ch_prop_vault_painting_01h", ["price"] = 180, ["label"] = "Vault Painting 01h" },
					{ ["object"] = "ch_prop_vault_painting_01i", ["price"] = 180, ["label"] = "Vault Painting 01i" },
					{ ["object"] = "ch_prop_vault_painting_01j", ["price"] = 180, ["label"] = "Vault Painting 01j" }
				}
			},
			{ ["object"] = "ex_office_swag_paintings01", ["price"] = 350, ["label"] = "SWAG Painting",
				["group_items"] = {
					{ ["object"] = "ex_office_swag_paintings01", ["price"] = 350, ["label"] = "SWAG Painting 01" },
					{ ["object"] = "ex_office_swag_paintings02", ["price"] = 350, ["label"] = "SWAG Painting 02" },
					{ ["object"] = "ex_office_swag_paintings03", ["price"] = 350, ["label"] = "SWAG Painting 03" }
				}
			},
			{ ["object"] = "apa_mp_h_acc_artwalll_01", ["price"] = 350, ["label"] = "Art Painting",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_acc_artwalll_01", ["price"] = 350, ["label"] = "Art Painting MP 01" },
					{ ["object"] = "apa_mp_h_acc_artwalll_02", ["price"] = 350, ["label"] = "Art Painting MP 02" },
					{ ["object"] = "apa_mp_h_acc_artwalll_03", ["price"] = 350, ["label"] = "Art Painting MP 03" },
					{ ["object"] = "apa_p_h_acc_artwalll_01", ["price"] = 350, ["label"] = "Art Painting P 01" },
					{ ["object"] = "apa_p_h_acc_artwalll_02", ["price"] = 350, ["label"] = "Art Painting P 02" },
					{ ["object"] = "apa_p_h_acc_artwalll_03", ["price"] = 350, ["label"] = "Art Painting P 03" },
					{ ["object"] = "apa_p_h_acc_artwalll_04", ["price"] = 350, ["label"] = "Art Painting P 04" },
					{ ["object"] = "apa_p_h_acc_artwallm_01", ["price"] = 350, ["label"] = "Art Painting PH 01" }
				}
			},
			{ ["object"] = "apa_p_h_acc_artwalls_03", ["price"] = 1850, ["label"] = "Artwalls",
				["group_items"] = {
					{ ["object"] = "apa_p_h_acc_artwalls_03", ["price"] = 1850, ["label"] = "Artwalls 03" },
					{ ["object"] = "apa_p_h_acc_artwalls_04", ["price"] = 1850, ["label"] = "Artwalls 04" }
				}
			},
			{ ["object"] = "ch_prop_ch_wallart_01a", ["price"] = 650, ["label"] = "Wallarts",
				["group_items"] = {
					{ ["object"] = "ch_prop_ch_wallart_01a", ["price"] = 650, ["label"] = "Wallarts 01a" },
					{ ["object"] = "ch_prop_ch_wallart_02a", ["price"] = 650, ["label"] = "Wallarts 02a" },
					{ ["object"] = "ch_prop_ch_wallart_03a", ["price"] = 650, ["label"] = "Wallarts 03a" },
					{ ["object"] = "ch_prop_ch_wallart_04a", ["price"] = 650, ["label"] = "Wallarts 04a" },
					{ ["object"] = "ch_prop_ch_wallart_05a", ["price"] = 650, ["label"] = "Wallarts 05a" },
					{ ["object"] = "ch_prop_ch_wallart_06a", ["price"] = 650, ["label"] = "Wallarts 06a" },
					{ ["object"] = "ch_prop_ch_wallart_07a", ["price"] = 650, ["label"] = "Wallarts 07a" },
					{ ["object"] = "ch_prop_ch_wallart_08a", ["price"] = 650, ["label"] = "Wallarts 08a" },
					{ ["object"] = "ch_prop_ch_wallart_09a", ["price"] = 650, ["label"] = "Wallarts 09a" },
					{ ["object"] = "vw_prop_vw_wallart_01a", ["price"] = 650, ["label"] = "Wallarts VW 01a" },
					{ ["object"] = "vw_prop_vw_wallart_02a", ["price"] = 650, ["label"] = "Wallarts VW 02a" },
					{ ["object"] = "vw_prop_vw_wallart_03a", ["price"] = 650, ["label"] = "Wallarts VW 03a" },
					{ ["object"] = "vw_prop_vw_wallart_04a", ["price"] = 650, ["label"] = "Wallarts VW 04a" },
					{ ["object"] = "vw_prop_vw_wallart_05a", ["price"] = 650, ["label"] = "Wallarts VW 05a" },
					{ ["object"] = "vw_prop_vw_wallart_06a", ["price"] = 650, ["label"] = "Wallarts VW 06a" },
					{ ["object"] = "vw_prop_vw_wallart_07a", ["price"] = 650, ["label"] = "Wallarts VW 07a" },
					{ ["object"] = "vw_prop_vw_wallart_08a", ["price"] = 650, ["label"] = "Wallarts VW 08a" },
					{ ["object"] = "vw_prop_vw_wallart_09a", ["price"] = 650, ["label"] = "Wallarts VW 09a" },
					{ ["object"] = "vw_prop_vw_wallart_100a", ["price"] = 650, ["label"] = "Wallarts VW 100a" },
					{ ["object"] = "vw_prop_vw_wallart_101a", ["price"] = 650, ["label"] = "Wallarts VW 101a" },
					{ ["object"] = "vw_prop_vw_wallart_102a", ["price"] = 650, ["label"] = "Wallarts VW 102a" },
					{ ["object"] = "vw_prop_vw_wallart_103a", ["price"] = 650, ["label"] = "Wallarts VW 103a" },
					{ ["object"] = "vw_prop_vw_wallart_104a", ["price"] = 650, ["label"] = "Wallarts VW 104a" },
					{ ["object"] = "vw_prop_vw_wallart_105a", ["price"] = 650, ["label"] = "Wallarts VW 105a" },
					{ ["object"] = "vw_prop_vw_wallart_106a", ["price"] = 650, ["label"] = "Wallarts VW 106a" },
					{ ["object"] = "vw_prop_vw_wallart_107a", ["price"] = 650, ["label"] = "Wallarts VW 107a" },
					{ ["object"] = "vw_prop_vw_wallart_108a", ["price"] = 650, ["label"] = "Wallarts VW 108a" },
					{ ["object"] = "vw_prop_vw_wallart_109a", ["price"] = 650, ["label"] = "Wallarts 109a" },
					{ ["object"] = "vw_prop_vw_wallart_10a", ["price"] = 650, ["label"] = "Wallarts VW 10a" },
					{ ["object"] = "vw_prop_vw_wallart_110a", ["price"] = 650, ["label"] = "Wallarts VW 110a" },
					{ ["object"] = "vw_prop_vw_wallart_111a", ["price"] = 650, ["label"] = "Wallarts VW 111a" },
					{ ["object"] = "vw_prop_vw_wallart_112a", ["price"] = 650, ["label"] = "Wallarts VW 112a" },
					{ ["object"] = "vw_prop_vw_wallart_113a", ["price"] = 650, ["label"] = "Wallarts VW 113a" },
					{ ["object"] = "vw_prop_vw_wallart_114a", ["price"] = 650, ["label"] = "Wallarts VW 114a" },
					{ ["object"] = "vw_prop_vw_wallart_115a", ["price"] = 650, ["label"] = "Wallarts VW 115a" },
					{ ["object"] = "vw_prop_vw_wallart_116a", ["price"] = 650, ["label"] = "Wallarts VW 116a" },
					{ ["object"] = "vw_prop_vw_wallart_117a", ["price"] = 650, ["label"] = "Wallarts VW 117a" },
					{ ["object"] = "vw_prop_vw_wallart_118a", ["price"] = 650, ["label"] = "Wallarts VW 118a" },
					{ ["object"] = "vw_prop_vw_wallart_11a", ["price"] = 650, ["label"] = "Wallarts VW 11a" },
					{ ["object"] = "vw_prop_vw_wallart_123a", ["price"] = 650, ["label"] = "Wallarts VW 123a" },
					{ ["object"] = "vw_prop_vw_wallart_124a", ["price"] = 650, ["label"] = "Wallarts VW 124a" },
					{ ["object"] = "vw_prop_vw_wallart_125a", ["price"] = 650, ["label"] = "Wallarts VW 125a" },
					{ ["object"] = "vw_prop_vw_wallart_126a", ["price"] = 650, ["label"] = "Wallarts VW 126a" },
					{ ["object"] = "vw_prop_vw_wallart_127a", ["price"] = 650, ["label"] = "Wallarts VW 127a" },
					{ ["object"] = "vw_prop_vw_wallart_128a", ["price"] = 650, ["label"] = "Wallarts VW 128a" },
					{ ["object"] = "vw_prop_vw_wallart_129a", ["price"] = 650, ["label"] = "Wallarts VW 129a" },
					{ ["object"] = "vw_prop_vw_wallart_12a", ["price"] = 650, ["label"] = "Wallarts VW 12a" },
					{ ["object"] = "vw_prop_vw_wallart_130a", ["price"] = 650, ["label"] = "Wallarts VW 130a" },
					{ ["object"] = "vw_prop_vw_wallart_131a", ["price"] = 650, ["label"] = "Wallarts VW 131a" },
					{ ["object"] = "vw_prop_vw_wallart_132a", ["price"] = 650, ["label"] = "Wallarts VW 132a" },
					{ ["object"] = "vw_prop_vw_wallart_133a", ["price"] = 650, ["label"] = "Wallarts VW 133a" },
					{ ["object"] = "vw_prop_vw_wallart_134a", ["price"] = 650, ["label"] = "Wallarts VW 134a" },
					{ ["object"] = "vw_prop_vw_wallart_135a", ["price"] = 650, ["label"] = "Wallarts VW 135a" },
					{ ["object"] = "vw_prop_vw_wallart_136a", ["price"] = 650, ["label"] = "Wallarts VW 136a" },
					{ ["object"] = "vw_prop_vw_wallart_137a", ["price"] = 650, ["label"] = "Wallarts VW 137a" },
					{ ["object"] = "vw_prop_vw_wallart_138a", ["price"] = 650, ["label"] = "Wallarts VW 138a" },
					{ ["object"] = "vw_prop_vw_wallart_139a", ["price"] = 650, ["label"] = "Wallarts VW 139a" },
					{ ["object"] = "vw_prop_vw_wallart_140a", ["price"] = 650, ["label"] = "Wallarts VW 140a" },
					{ ["object"] = "vw_prop_vw_wallart_141a", ["price"] = 650, ["label"] = "Wallarts VW 141a" },
					{ ["object"] = "vw_prop_vw_wallart_142a", ["price"] = 650, ["label"] = "Wallarts VW 142a" },
					{ ["object"] = "vw_prop_vw_wallart_143a", ["price"] = 650, ["label"] = "Wallarts VW 143a" },
					{ ["object"] = "vw_prop_vw_wallart_144a", ["price"] = 650, ["label"] = "Wallarts VW 144a" },
					{ ["object"] = "vw_prop_vw_wallart_145a", ["price"] = 650, ["label"] = "Wallarts VW 145a" },
					{ ["object"] = "vw_prop_vw_wallart_146a", ["price"] = 650, ["label"] = "Wallarts VW 146a" },
					{ ["object"] = "vw_prop_vw_wallart_147a", ["price"] = 650, ["label"] = "Wallarts VW 147a" },
					{ ["object"] = "vw_prop_vw_wallart_14a", ["price"] = 650, ["label"] = "Wallarts VW 14a" },
					{ ["object"] = "vw_prop_vw_wallart_150a", ["price"] = 650, ["label"] = "Wallarts VW 150a" },
					{ ["object"] = "vw_prop_vw_wallart_151a", ["price"] = 650, ["label"] = "Wallarts VW 151a" },
					{ ["object"] = "vw_prop_vw_wallart_151b", ["price"] = 650, ["label"] = "Wallarts VW 151b" },
					{ ["object"] = "vw_prop_vw_wallart_151c", ["price"] = 650, ["label"] = "Wallarts VW 151c" },
					{ ["object"] = "vw_prop_vw_wallart_151d", ["price"] = 650, ["label"] = "Wallarts VW 151d" },
					{ ["object"] = "vw_prop_vw_wallart_151e", ["price"] = 650, ["label"] = "Wallarts VW 151e" },
					{ ["object"] = "vw_prop_vw_wallart_151f", ["price"] = 650, ["label"] = "Wallarts VW 151f" },
					{ ["object"] = "vw_prop_vw_wallart_152a", ["price"] = 650, ["label"] = "Wallarts VW 152a" },
					{ ["object"] = "vw_prop_vw_wallart_153a", ["price"] = 650, ["label"] = "Wallarts VW 153a" },
					{ ["object"] = "vw_prop_vw_wallart_154a", ["price"] = 650, ["label"] = "Wallarts VW 154a" },
					{ ["object"] = "vw_prop_vw_wallart_155a", ["price"] = 650, ["label"] = "Wallarts VW 155a" },
					{ ["object"] = "vw_prop_vw_wallart_156a", ["price"] = 650, ["label"] = "Wallarts VW 156a" },
					{ ["object"] = "vw_prop_vw_wallart_157a", ["price"] = 650, ["label"] = "Wallarts VW 157a" },
					{ ["object"] = "vw_prop_vw_wallart_158a", ["price"] = 650, ["label"] = "Wallarts VW 158a" },
					{ ["object"] = "vw_prop_vw_wallart_159a", ["price"] = 650, ["label"] = "Wallarts VW 159a" },
					{ ["object"] = "vw_prop_vw_wallart_15a", ["price"] = 650, ["label"] = "Wallarts VW 15a" },
					{ ["object"] = "vw_prop_vw_wallart_160a", ["price"] = 650, ["label"] = "Wallarts VW 160a" },
					{ ["object"] = "vw_prop_vw_wallart_161a", ["price"] = 650, ["label"] = "Wallarts VW 161a" },
					{ ["object"] = "vw_prop_vw_wallart_162a", ["price"] = 650, ["label"] = "Wallarts VW 162a" },
					{ ["object"] = "vw_prop_vw_wallart_163a", ["price"] = 650, ["label"] = "Wallarts VW 163a" },
					{ ["object"] = "vw_prop_vw_wallart_164a", ["price"] = 650, ["label"] = "Wallarts VW 164a" },
					{ ["object"] = "vw_prop_vw_wallart_165a", ["price"] = 650, ["label"] = "Wallarts VW 165a" },
					{ ["object"] = "vw_prop_vw_wallart_166a", ["price"] = 650, ["label"] = "Wallarts VW 166a" },
					{ ["object"] = "vw_prop_vw_wallart_167a", ["price"] = 650, ["label"] = "Wallarts VW 167a" },
					{ ["object"] = "vw_prop_vw_wallart_168a", ["price"] = 650, ["label"] = "Wallarts VW 168a" },
					{ ["object"] = "vw_prop_vw_wallart_169a", ["price"] = 650, ["label"] = "Wallarts VW 169a" },
					{ ["object"] = "vw_prop_vw_wallart_16a", ["price"] = 650, ["label"] = "Wallarts VW 16a" },
					{ ["object"] = "vw_prop_vw_wallart_170a", ["price"] = 650, ["label"] = "Wallarts VW 170a" },
					{ ["object"] = "vw_prop_vw_wallart_171a", ["price"] = 650, ["label"] = "Wallarts VW 171a" },
					{ ["object"] = "vw_prop_vw_wallart_172a", ["price"] = 650, ["label"] = "Wallarts VW 172a" },
					{ ["object"] = "vw_prop_vw_wallart_173a", ["price"] = 650, ["label"] = "Wallarts VW 173a" },
					{ ["object"] = "vw_prop_vw_wallart_174a", ["price"] = 650, ["label"] = "Wallarts VW 174a" },
					{ ["object"] = "vw_prop_vw_wallart_17a", ["price"] = 650, ["label"] = "Wallarts VW 17a" },
					{ ["object"] = "vw_prop_vw_wallart_18a", ["price"] = 650, ["label"] = "Wallarts VW 18a" },
					{ ["object"] = "vw_prop_vw_wallart_19a", ["price"] = 650, ["label"] = "Wallarts VW 19a" },
					{ ["object"] = "vw_prop_vw_wallart_20a", ["price"] = 650, ["label"] = "Wallarts VW 20a" },
					{ ["object"] = "vw_prop_vw_wallart_21a", ["price"] = 650, ["label"] = "Wallarts VW 21a" },
					{ ["object"] = "vw_prop_vw_wallart_22a", ["price"] = 650, ["label"] = "Wallarts VW 22a" },
					{ ["object"] = "vw_prop_vw_wallart_23a", ["price"] = 650, ["label"] = "Wallarts VW 23a" },
					{ ["object"] = "vw_prop_vw_wallart_24a", ["price"] = 650, ["label"] = "Wallarts VW 24a" },
					{ ["object"] = "vw_prop_vw_wallart_25a", ["price"] = 650, ["label"] = "Wallarts VW 25a" },
					{ ["object"] = "vw_prop_vw_wallart_26a", ["price"] = 650, ["label"] = "Wallarts VW 26a" },
					{ ["object"] = "vw_prop_vw_wallart_28a", ["price"] = 650, ["label"] = "Wallarts VW 28a" },
					{ ["object"] = "vw_prop_vw_wallart_29a", ["price"] = 650, ["label"] = "Wallarts VW 29a" },
					{ ["object"] = "vw_prop_vw_wallart_30a", ["price"] = 650, ["label"] = "Wallarts VW 30a" },
					{ ["object"] = "vw_prop_vw_wallart_31a", ["price"] = 650, ["label"] = "Wallarts VW 31a" },
					{ ["object"] = "vw_prop_vw_wallart_32a", ["price"] = 650, ["label"] = "Wallarts VW 32a" },
					{ ["object"] = "vw_prop_vw_wallart_33a", ["price"] = 650, ["label"] = "Wallarts VW 33a" },
					{ ["object"] = "vw_prop_vw_wallart_34a", ["price"] = 650, ["label"] = "Wallarts VW 34a" },
					{ ["object"] = "vw_prop_vw_wallart_35a", ["price"] = 650, ["label"] = "Wallarts VW 35a" },
					{ ["object"] = "vw_prop_vw_wallart_36a", ["price"] = 650, ["label"] = "Wallarts VW 36a" },
					{ ["object"] = "vw_prop_vw_wallart_37a", ["price"] = 650, ["label"] = "Wallarts VW 37a" },
					{ ["object"] = "vw_prop_vw_wallart_38a", ["price"] = 650, ["label"] = "Wallarts VW 38a" },
					{ ["object"] = "vw_prop_vw_wallart_39a", ["price"] = 650, ["label"] = "Wallarts VW 39a" },
					{ ["object"] = "vw_prop_vw_wallart_40a", ["price"] = 650, ["label"] = "Wallarts VW 40a" },
					{ ["object"] = "vw_prop_vw_wallart_41a", ["price"] = 650, ["label"] = "Wallarts VW 41a" },
					{ ["object"] = "vw_prop_vw_wallart_42a", ["price"] = 650, ["label"] = "Wallarts VW 42a" },
					{ ["object"] = "vw_prop_vw_wallart_43a", ["price"] = 650, ["label"] = "Wallarts VW 43a" },
					{ ["object"] = "vw_prop_vw_wallart_44a", ["price"] = 650, ["label"] = "Wallarts VW 44a" },
					{ ["object"] = "vw_prop_vw_wallart_46a", ["price"] = 650, ["label"] = "Wallarts VW 46a" },
					{ ["object"] = "vw_prop_vw_wallart_47a", ["price"] = 650, ["label"] = "Wallarts VW 47a" },
					{ ["object"] = "vw_prop_vw_wallart_48a", ["price"] = 650, ["label"] = "Wallarts VW 48a" },
					{ ["object"] = "vw_prop_vw_wallart_49a", ["price"] = 650, ["label"] = "Wallarts VW 49a" },
					{ ["object"] = "vw_prop_vw_wallart_50a", ["price"] = 650, ["label"] = "Wallarts VW 50a" },
					{ ["object"] = "vw_prop_vw_wallart_51a", ["price"] = 650, ["label"] = "Wallarts VW 51a" },
					{ ["object"] = "vw_prop_vw_wallart_52a", ["price"] = 650, ["label"] = "Wallarts VW 52a" },
					{ ["object"] = "vw_prop_vw_wallart_53a", ["price"] = 650, ["label"] = "Wallarts VW 53a" },
					{ ["object"] = "vw_prop_vw_wallart_54a_01a", ["price"] = 650, ["label"] = "Wallarts VW 54a" },
					{ ["object"] = "vw_prop_vw_wallart_55a", ["price"] = 650, ["label"] = "Wallarts VW 55a" },
					{ ["object"] = "vw_prop_vw_wallart_56a", ["price"] = 650, ["label"] = "Wallarts VW 56a" },
					{ ["object"] = "vw_prop_vw_wallart_57a", ["price"] = 650, ["label"] = "Wallarts VW 57a" },
					{ ["object"] = "vw_prop_vw_wallart_58a", ["price"] = 650, ["label"] = "Wallarts VW 58a" },
					{ ["object"] = "vw_prop_vw_wallart_59a", ["price"] = 650, ["label"] = "Wallarts VW 59a" },
					{ ["object"] = "vw_prop_vw_wallart_60a", ["price"] = 650, ["label"] = "Wallarts VW 60a" },
					{ ["object"] = "vw_prop_vw_wallart_61a", ["price"] = 650, ["label"] = "Wallarts VW 61a" },
					{ ["object"] = "vw_prop_vw_wallart_62a", ["price"] = 650, ["label"] = "Wallarts VW 62a" },
					{ ["object"] = "vw_prop_vw_wallart_63a", ["price"] = 650, ["label"] = "Wallarts VW 63a" },
					{ ["object"] = "vw_prop_vw_wallart_64a", ["price"] = 650, ["label"] = "Wallarts VW 64a" },
					{ ["object"] = "vw_prop_vw_wallart_65a", ["price"] = 650, ["label"] = "Wallarts VW 65a" },
					{ ["object"] = "vw_prop_vw_wallart_66a", ["price"] = 650, ["label"] = "Wallarts VW 66a" },
					{ ["object"] = "vw_prop_vw_wallart_67a", ["price"] = 650, ["label"] = "Wallarts VW 67a" },
					{ ["object"] = "vw_prop_vw_wallart_68a", ["price"] = 650, ["label"] = "Wallarts VW 68a" },
					{ ["object"] = "vw_prop_vw_wallart_69a", ["price"] = 650, ["label"] = "Wallarts VW 69a" },
					{ ["object"] = "vw_prop_vw_wallart_70a", ["price"] = 650, ["label"] = "Wallarts VW 70a" },
					{ ["object"] = "vw_prop_vw_wallart_71a", ["price"] = 650, ["label"] = "Wallarts VW 71a" },
					{ ["object"] = "vw_prop_vw_wallart_72a", ["price"] = 650, ["label"] = "Wallarts VW 72a" },
					{ ["object"] = "vw_prop_vw_wallart_73a", ["price"] = 650, ["label"] = "Wallarts VW 73a" },
					{ ["object"] = "vw_prop_vw_wallart_74a", ["price"] = 650, ["label"] = "Wallarts VW 74a" },
					{ ["object"] = "vw_prop_vw_wallart_75a", ["price"] = 650, ["label"] = "Wallarts VW 75a" },
					{ ["object"] = "vw_prop_vw_wallart_76a", ["price"] = 650, ["label"] = "Wallarts VW 76a" },
					{ ["object"] = "vw_prop_vw_wallart_77a", ["price"] = 650, ["label"] = "Wallarts VW 77a" },
					{ ["object"] = "vw_prop_vw_wallart_78a", ["price"] = 650, ["label"] = "Wallarts VW 78a" },
					{ ["object"] = "vw_prop_vw_wallart_79a", ["price"] = 650, ["label"] = "Wallarts VW 79a" },
					{ ["object"] = "vw_prop_vw_wallart_80a", ["price"] = 650, ["label"] = "Wallarts VW 80a" },
					{ ["object"] = "vw_prop_vw_wallart_81a", ["price"] = 650, ["label"] = "Wallarts VW 81a" },
					{ ["object"] = "vw_prop_vw_wallart_82a", ["price"] = 650, ["label"] = "Wallarts VW 82a" },
					{ ["object"] = "vw_prop_vw_wallart_83a", ["price"] = 650, ["label"] = "Wallarts VW 83a" },
					{ ["object"] = "vw_prop_vw_wallart_84a", ["price"] = 650, ["label"] = "Wallarts VW 84a" },
					{ ["object"] = "vw_prop_vw_wallart_85a", ["price"] = 650, ["label"] = "Wallarts VW 85a" },
					{ ["object"] = "vw_prop_vw_wallart_86a", ["price"] = 650, ["label"] = "Wallarts VW 86a" },
					{ ["object"] = "vw_prop_vw_wallart_87a", ["price"] = 650, ["label"] = "Wallarts VW 87a" },
					{ ["object"] = "vw_prop_vw_wallart_88a", ["price"] = 650, ["label"] = "Wallarts VW 88a" },
					{ ["object"] = "vw_prop_vw_wallart_89a", ["price"] = 650, ["label"] = "Wallarts VW 89a" },
					{ ["object"] = "vw_prop_vw_wallart_90a", ["price"] = 650, ["label"] = "Wallarts VW 90a" },
					{ ["object"] = "vw_prop_vw_wallart_91a", ["price"] = 650, ["label"] = "Wallarts VW 91a" },
					{ ["object"] = "vw_prop_vw_wallart_92a", ["price"] = 650, ["label"] = "Wallarts VW 92a" },
					{ ["object"] = "vw_prop_vw_wallart_93a", ["price"] = 650, ["label"] = "Wallarts VW 93a" },
					{ ["object"] = "vw_prop_vw_wallart_94a", ["price"] = 650, ["label"] = "Wallarts VW 94a" },
					{ ["object"] = "vw_prop_vw_wallart_95a", ["price"] = 650, ["label"] = "Wallarts VW 95a" },
					{ ["object"] = "vw_prop_vw_wallart_96a", ["price"] = 650, ["label"] = "Wallarts VW 96a" },
					{ ["object"] = "vw_prop_vw_wallart_97a", ["price"] = 650, ["label"] = "Wallarts VW 97a" },
					{ ["object"] = "vw_prop_vw_wallart_98a", ["price"] = 650, ["label"] = "Wallarts VW 98a" },
					{ ["object"] = "vw_prop_vw_wallart_99a", ["price"] = 650, ["label"] = "Wallarts VW 99a" }
				}
			},
			{ ["object"] = "apa_prop_flag_argentina", ["price"] = 150, ["label"] = "Country flags",
				["group_items"] = {
					{ ["object"] = "apa_prop_flag_argentina", ["price"] = 150, ["label"] = "Argentina flag" },
					{ ["object"] = "apa_prop_flag_australia", ["price"] = 150, ["label"] = "Australia flag" },
					{ ["object"] = "apa_prop_flag_austria", ["price"] = 150, ["label"] = "Austria flag" },
					{ ["object"] = "apa_prop_flag_belgium", ["price"] = 150, ["label"] = "Belgium flag" },
					{ ["object"] = "apa_prop_flag_brazil", ["price"] = 150, ["label"] = "Brasil flag" },
					{ ["object"] = "apa_prop_flag_china", ["price"] = 150, ["label"] = "China flag" },
					{ ["object"] = "apa_prop_flag_england", ["price"] = 150, ["label"] = "England flag" },
					{ ["object"] = "apa_prop_flag_czechrep", ["price"] = 150, ["label"] = "Czechrep flag" },
					{ ["object"] = "apa_prop_flag_croatia", ["price"] = 150, ["label"] = "Croatia flag" },
					{ ["object"] = "apa_prop_flag_denmark", ["price"] = 150, ["label"] = "Denmark flag" },
					{ ["object"] = "apa_prop_flag_eu_yt", ["price"] = 150, ["label"] = "EU flag" },
					{ ["object"] = "apa_prop_flag_finland", ["price"] = 150, ["label"] = "Finland flag" },
					{ ["object"] = "apa_prop_flag_german_yt", ["price"] = 150, ["label"] = "German flag" },
					{ ["object"] = "apa_prop_flag_hungary", ["price"] = 150, ["label"] = "Hungary flag" },
					{ ["object"] = "apa_prop_flag_spain", ["price"] = 150, ["label"] = "Spain flag" },
					{ ["object"] = "apa_prop_flag_us_yt", ["price"] = 150, ["label"] = "US flag" },
					{ ["object"] = "apa_prop_flag_southkorea", ["price"] = 150, ["label"] = "Korea flag" },
					{ ["object"] = "apa_prop_flag_script", ["price"] = 150, ["label"] = "Black flag" },
					{ ["object"] = "apa_prop_flag_russia_yt", ["price"] = 150, ["label"] = "Russia flag" },
					{ ["object"] = "apa_prop_flag_puertorico", ["price"] = 150, ["label"] = "Puerto Rico flag" },
				}
			},
			{ ["object"] = "gr_prop_gr_sign_01a", ["price"] = 350, ["label"] = "Exterior sign",
				["group_items"] = {
					{ ["object"] = "gr_prop_gr_sign_01a", ["price"] = 350, ["label"] = "Sign 01a" },
					{ ["object"] = "gr_prop_gr_sign_01b", ["price"] = 350, ["label"] = "Sign 01b" },
					{ ["object"] = "gr_prop_gr_sign_01c", ["price"] = 350, ["label"] = "Sign 01c" },
					{ ["object"] = "gr_prop_gr_sign_01e", ["price"] = 350, ["label"] = "Sign 01e" },
				}
			},
			{ ["object"] = "gr_prop_gr_target_02a", ["price"] = 350, ["label"] = "Target 021",
				["group_items"] = {
					{ ["object"] = "gr_prop_gr_target_02a", ["price"] = 250, ["label"] = "Target 021" },
					{ ["object"] = "gr_prop_gr_target_02b", ["price"] = 250, ["label"] = "Target 02b" },
					{ ["object"] = "gr_prop_gr_target_04a", ["price"] = 450, ["label"] = "Target 04a" },
					{ ["object"] = "gr_prop_gr_target_04b", ["price"] = 450, ["label"] = "Target 02b" },
				}
			},
			{ ["object"] = "sm_prop_smug_wall_radio_01", ["price"] = 150, ["label"] = "Wall Radio" },
			{ ["object"] = "bkr_prop_biker_safedoor_01a", ["price"] = 150, ["label"] = "Safedoor" },
			{ ["object"] = "gr_prop_gr_target_02a", ["price"] = 250, ["label"] = "Target 021" },
			{ ["object"] = "gr_prop_gr_target_02b", ["price"] = 250, ["label"] = "Target 02b" },
		}
	},

	["electronics"] = {
		["label"] = "Electronics",
		["items"] = {
			{ ["object"] = "ex_office_swag_electronic", ["price"] = 500, ["label"] = "Swag Electronic",
				["group_items"] = {
					{ ["object"] = "ex_office_swag_electronic", ["price"] = 500, ["label"] = "Swag Electronic" },
					{ ["object"] = "ex_office_swag_electronic2", ["price"] = 500, ["label"] = "Swag Electronic 2" },
					{ ["object"] = "ex_office_swag_electronic3", ["price"] = 500, ["label"] = "Swag Electronic 3" }
				}
			},
			{ ["object"] = "ex_prop_ex_tv_flat_01", ["price"] = 1200, ["label"] = "TV",
				["group_items"] = {
					{ ["object"] = "ex_prop_ex_tv_flat_01", ["price"] = 1200, ["label"] = "TV EX Flat 01" },
					{ ["object"] = "gr_prop_gr_trailer_tv", ["price"] = 1200, ["label"] = "TV Trailer" },
					{ ["object"] = "prop_trev_tv_01", ["price"] = 700, ["label"] = "TV Trev" },
					{ ["object"] = "prop_tv_02", ["price"] = 320, ["label"] = "TV 02" },
					{ ["object"] = "prop_tv_03", ["price"] = 450, ["label"] = "TV 03" },
					{ ["object"] = "prop_tv_04", ["price"] = 120, ["label"] = "TV 04" },
					{ ["object"] = "prop_tv_05", ["price"] = 140, ["label"] = "TV 05" },
					{ ["object"] = "prop_tv_06", ["price"] = 480, ["label"] = "TV 06" },
					{ ["object"] = "prop_tv_07", ["price"] = 450, ["label"] = "TV 07" },
					{ ["object"] = "prop_tv_flat_01", ["price"] = 1600, ["label"] = "TV Flat 01" },
					{ ["object"] = "prop_tv_flat_02", ["price"] = 1500, ["label"] = "TV Flat 02" },
					{ ["object"] = "prop_tv_flat_02b", ["price"] = 1700, ["label"] = "TV Flat 02b" },
					{ ["object"] = "prop_tv_flat_03", ["price"] = 1300, ["label"] = "TV Flat 03" },
					{ ["object"] = "sm_prop_smug_tv_flat_01", ["price"] = 1600, ["label"] = "TV Smug" },
					{ ["object"] = "vw_prop_vw_cinema_tv_01", ["price"] = 1800, ["label"] = "TV Cinema" },
					{ ["object"] = "xm_prop_x17_tv_ceiling_01", ["price"] = 2000, ["label"] = "TV Ceiling" },
					{ ["object"] = "xm_prop_x17_tv_stand_01a", ["price"] = 2800, ["label"] = "TV Stand" },
				}
			},
			{ ["object"] = "apa_mp_h_str_avunits_01", ["price"] = 2200, ["label"] = "Exclusive TV",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_str_avunitm_01", ["price"] = 2200, ["label"] = "TV Sound 01" },
					{ ["object"] = "apa_mp_h_str_avunitm_03", ["price"] = 2200, ["label"] = "TV Sound 02" },
					{ ["object"] = "apa_mp_h_str_avunitl_04", ["price"] = 1500, ["label"] = "TV Sound Loot" },
					{ ["object"] = "apa_mp_h_str_avunitl_04", ["price"] = 1600, ["label"] = "TV Sound Loot" },
					{ ["object"] = "hei_heist_str_avunitl_03", ["price"] = 1600, ["label"] = "TV Sound 03" },
					{ ["object"] = "hei_heist_str_avunits_01", ["price"] = 1600, ["label"] = "TV Sound 01" },
					{ ["object"] = "apa_mp_h_str_avunitl_01_b", ["price"] = 6800, ["label"] = "TV Executive" },
					{ ["object"] = "hei_heist_str_avunitl_01", ["price"] = 6800, ["label"] = "TV Executive 01" },
				}
			},
			{ ["object"] = "prop_cs_cctv", ["price"] = 130, ["label"] = "CCTV",
				["group_items"] = {
					{ ["object"] = "prop_cs_cctv", ["price"] = 130, ["label"] = "CCTV" },
					{ ["object"] = "prop_cctv_cam_01b", ["price"] = 120, ["label"] = "CCTV Cam 01b" },
					{ ["object"] = "prop_cctv_cam_02a", ["price"] = 135, ["label"] = "CCTV Cam 02a" },
					{ ["object"] = "prop_cctv_cam_03a", ["price"] = 155, ["label"] = "CCTV Cam 03a" },
					{ ["object"] = "prop_cctv_cam_04a", ["price"] = 250, ["label"] = "CCTV Cam 04a" },
					{ ["object"] = "prop_cctv_cam_04b", ["price"] = 250, ["label"] = "CCTV Cam 04b" },
					{ ["object"] = "prop_cctv_cam_04c", ["price"] = 250, ["label"] = "CCTV Cam 04c" },
					{ ["object"] = "prop_cctv_cam_05a", ["price"] = 120, ["label"] = "CCTV Cam 05a" },
					{ ["object"] = "prop_cctv_cam_06a", ["price"] = 120, ["label"] = "CCTV Cam 06a" },
					{ ["object"] = "prop_cctv_cam_07a", ["price"] = 160, ["label"] = "CCTV Cam 07a" },
					{ ["object"] = "prop_cctv_pole_01a", ["price"] = 230, ["label"] = "CCTV Pole 01a" },
					{ ["object"] = "prop_cctv_pole_02", ["price"] = 480, ["label"] = "CCTV Pole 02" },
					{ ["object"] = "prop_cctv_pole_03", ["price"] = 500, ["label"] = "CCTV Pole 03" },
					{ ["object"] = "prop_cctv_pole_04", ["price"] = 450, ["label"] = "CCTV Pole 04" },
					{ ["object"] = "prop_cctv_01_sm", ["price"] = 800, ["label"] = "CCTV 01 SM" },
					{ ["object"] = "prop_cctv_02_sm", ["price"] = 800, ["label"] = "CCTV 02 SM" },
					{ ["object"] = "prop_cctv_unit_02", ["price"] = 1700, ["label"] = "CCTV Unit 02" },
					{ ["object"] = "prop_cctv_unit_04", ["price"] = 2500, ["label"] = "CCTV Unit 04" },
					{ ["object"] = "prop_cctv_unit_05", ["price"] = 3200, ["label"] = "CCTV Unit 05" },
					{ ["object"] = "prop_dest_cctv_02", ["price"] = 900, ["label"] = "CCTV Dest 02" },
					{ ["object"] = "prop_dest_cctv_03", ["price"] = 900, ["label"] = "CCTV Dest 03" },
					{ ["object"] = "prop_dest_cctv_03b", ["price"] = 900, ["label"] = "CCTV Dest 03b" }
				}
			},
			{ ["object"] = "ex_prop_tv_settop_remote", ["price"] = 10, ["label"] = "Remote",
				["group_items"] = {
					{ ["object"] = "ex_prop_tv_settop_remote", ["price"] = 10, ["label"] = "Remote TV" },
					{ ["object"] = "prop_cs_remote_01", ["price"] = 10, ["label"] = "Remote CS" },
					{ ["object"] = "v_res_tre_remote", ["price"] = 10, ["label"] = "Remote Tre" },
					{ ["object"] = "v_res_tt_tvremote", ["price"] = 10, ["label"] = "Remote TT" }
				}
			},
			{ ["object"] = "as_prop_as_laptop_01a", ["price"] = 300, ["label"] = "Laptop",
				["group_items"] = {
					{ ["object"] = "as_prop_as_laptop_01a", ["price"] = 300, ["label"] = "Laptop Open" },
					{ ["object"] = "ba_prop_battle_laptop_dj", ["price"] = 300, ["label"] = "Laptop Close" },
					{ ["object"] = "ch_prop_laptop_01a", ["price"] = 300, ["label"] = "Laptop Pixel Emporium" },
					{ ["object"] = "ex_prop_ex_laptop_01a", ["price"] = 300, ["label"] = "Laptop Ad-Hawk" },
					{ ["object"] = "gr_prop_gr_laptop_01c", ["price"] = 300, ["label"] = "Laptop Excel" },
					{ ["object"] = "hei_prop_hst_laptop", ["price"] = 300, ["label"] = "Laptop HD OFF" },
					{ ["object"] = "prop_laptop_jimmy", ["price"] = 300, ["label"] = "Laptop Jimmy" },
					{ ["object"] = "prop_laptop_lester", ["price"] = 300, ["label"] = "Laptop Lester" },
					{ ["object"] = "xm_prop_x17_laptop_avon", ["price"] = 300, ["label"] = "Laptop Avon" },
					{ ["object"] = "p_cs_laptop_02", ["price"] = 150, ["label"] = "Laptop Old Open OFF" },
					{ ["object"] = "p_cs_laptop_02_w", ["price"] = 150, ["label"] = "Laptop Special" },
					{ ["object"] = "p_laptop_02_s", ["price"] = 300, ["label"] = "Laptop Old Close" },
					{ ["object"] = "v_ind_ss_laptop", ["price"] = 150, ["label"] = "Laptop Ind" },
					{ ["object"] = "xm_prop_x17_laptop_agent14_01", ["price"] = 600, ["label"] = "Laptop Agent" },
					{ ["object"] = "xm_prop_x17_laptop_lester_01", ["price"] = 600, ["label"] = "Laptop Agent Lester" },
					{ ["object"] = "xm_prop_x17_laptop_mrsr", ["price"] = 300, ["label"] = "Laptop MRSR" }
				}
			},
			{ ["object"] = "ch_prop_ch_phone_ing_01a", ["price"] = 800, ["label"] = "Phone",
				["group_items"] = {
					{ ["object"] = "ch_prop_ch_phone_ing_01a", ["price"] = 800, ["label"] = "Phone 01a" },
					{ ["object"] = "ch_prop_ch_phone_ing_02a", ["price"] = 800, ["label"] = "Phone 02a" },
					{ ["object"] = "prop_npc_phone", ["price"] = 800, ["label"] = "Phone" },
					{ ["object"] = "prop_npc_phone_02", ["price"] = 800, ["label"] = "Phone 02" },
					{ ["object"] = "prop_phone_ing", ["price"] = 800, ["label"] = "Phone Ing" },
					{ ["object"] = "prop_phone_ing_02", ["price"] = 450, ["label"] = "Phone Ing 02" },
					{ ["object"] = "prop_player_phone_01", ["price"] = 800, ["label"] = "Phone Player 01" },
					{ ["object"] = "prop_player_phone_02", ["price"] = 800, ["label"] = "Phone Player 02" },
					{ ["object"] = "prop_prologue_phone", ["price"] = 300, ["label"] = "Phone Prologue" },
					{ ["object"] = "prop_v_m_phone_01", ["price"] = 50, ["label"] = "Phone VM" },
					{ ["object"] = "p_cs_cam_phone", ["price"] = 350, ["label"] = "Phone Cam" },

					{ ["object"] = "apa_mp_h_acc_phone_01", ["price"] = 80, ["label"] = "Phone Acc" },
					{ ["object"] = "hei_prop_hei_bank_phone_01", ["price"] = 110, ["label"] = "Phone Bank" },
					{ ["object"] = "prop_cs_phone_01", ["price"] = 110, ["label"] = "Phone CS" },
					{ ["object"] = "prop_off_phone_01", ["price"] = 130, ["label"] = "Phone Office" },
					{ ["object"] = "vw_prop_casino_phone_01a", ["price"] = 110, ["label"] = "Phone Casino" }
				}
			},
			{ ["object"] = "as_prop_as_speakerdock", ["price"] = 420, ["label"] = "Speaker",
				["group_items"] = {
					{ ["object"] = "as_prop_as_speakerdock", ["price"] = 420, ["label"] = "Speaker Dock" },
					{ ["object"] = "prop_mp3_dock", ["price"] = 350, ["label"] = "Speaker MP3 Dock" },
					{ ["object"] = "ba_prop_battle_club_speaker_array", ["price"] = 1800, ["label"] = "Speaker Array" },
					{ ["object"] = "ba_prop_battle_club_speaker_dj", ["price"] = 600, ["label"] = "Speaker DJ" },
					{ ["object"] = "ba_prop_battle_club_speaker_large", ["price"] = 900, ["label"] = "Speaker Large" },
					{ ["object"] = "ba_prop_battle_club_speaker_med", ["price"] = 800, ["label"] = "Speaker Med" },
					{ ["object"] = "ba_prop_battle_club_speaker_small", ["price"] = 650, ["label"] = "Speaker Small" },
					{ ["object"] = "prop_speaker_01", ["price"] = 320, ["label"] = "Speaker 01" },
					{ ["object"] = "prop_speaker_02", ["price"] = 300, ["label"] = "Speaker 02" },
					{ ["object"] = "prop_speaker_03", ["price"] = 300, ["label"] = "Speaker 03" },
					{ ["object"] = "prop_speaker_05", ["price"] = 300, ["label"] = "Speaker 05" },
					{ ["object"] = "prop_speaker_06", ["price"] = 350, ["label"] = "Speaker 06" },
					{ ["object"] = "prop_speaker_07", ["price"] = 650, ["label"] = "Speaker 07" },
					{ ["object"] = "prop_speaker_08", ["price"] = 450, ["label"] = "Speaker 08" },
					{ ["object"] = "v_res_pcspeaker", ["price"] = 80, ["label"] = "Speaker PC" }
				}
			},
			{ ["object"] = "hei_prop_heist_pc_01", ["price"] = 420, ["label"] = "PC",
				["group_items"] = {
					{ ["object"] = "hei_prop_heist_pc_01", ["price"] = 420, ["label"] = "PC 01" },
					{ ["object"] = "prop_dyn_pc", ["price"] = 120, ["label"] = "PC DYN" },
					{ ["object"] = "prop_dyn_pc_02", ["price"] = 500, ["label"] = "PC DYN 02" },
					{ ["object"] = "prop_pc_01a", ["price"] = 110, ["label"] = "PC 01a" },
					{ ["object"] = "prop_pc_02a", ["price"] = 250, ["label"] = "PC 02s" },
					{ ["object"] = "v_res_pctower", ["price"] = 300, ["label"] = "PC RES" }
				}
			},
			{ ["object"] = "prop_monitor_01c", ["price"] = 150, ["label"] = "Monitor 01c",
				["group_items"] = {
					{ ["object"] = "prop_monitor_01c", ["price"] = 150, ["label"] = "Monitor 01c" },
					{ ["object"] = "prop_monitor_01d", ["price"] = 150, ["label"] = "Monitor 01d" },
					{ ["object"] = "prop_monitor_02", ["price"] = 150, ["label"] = "Monitor 02" },
					{ ["object"] = "prop_monitor_03b", ["price"] = 150, ["label"] = "Monitor 03b" },
					{ ["object"] = "prop_trailer_monitor_01", ["price"] = 350, ["label"] = "Monitor Trailer" },
					{ ["object"] = "sm_prop_smug_monitor_01", ["price"] = 250, ["label"] = "Monitor Smug" },
					{ ["object"] = "v_res_monitor", ["price"] = 150, ["label"] = "Monitor Res" },
					{ ["object"] = "xm_prop_x17_screens_02a", ["price"] = 1600, ["label"] = "Monitor Ultra Wide" }
				}
			},
			{ ["object"] = "hei_prop_hei_cs_keyboard", ["price"] = 50, ["label"] = "Keyboard",
				["group_items"] = {
					{ ["object"] = "hei_prop_hei_cs_keyboard", ["price"] = 50, ["label"] = "Keyboard" },
					{ ["object"] = "prop_cs_keyboard_01", ["price"] = 50, ["label"] = "Keyboard 01" },
					{ ["object"] = "prop_keyboard_01a", ["price"] = 50, ["label"] = "Keyboard 01a" }
				}
			},
			{ ["object"] = "prop_mouse_01", ["price"] = 50, ["label"] = "Mouse",
				["group_items"] = {
					{ ["object"] = "prop_mouse_01", ["price"] = 50, ["label"] = "Mouse" },
					{ ["object"] = "prop_mouse_01b", ["price"] = 50, ["label"] = "Mouse 01b" },
					{ ["object"] = "v_res_mousemat", ["price"] = 80, ["label"] = "Mouse Mat" }
				}
			},
			{ ["object"] = "prop_printer_01", ["price"] = 350, ["label"] = "Printer",
				["group_items"] = {
					{ ["object"] = "prop_printer_01", ["price"] = 350, ["label"] = "Printer 01" },
					{ ["object"] = "prop_printer_02", ["price"] = 350, ["label"] = "Printer 02" },
					{ ["object"] = "v_res_printer", ["price"] = 350, ["label"] = "Printer Res" }
				}
			},
			{ ["object"] = "v_res_pcheadset", ["price"] = 120, ["label"] = "Headset",
				["group_items"] = {
					{ ["object"] = "v_res_pcheadset", ["price"] = 120, ["label"] = "Headset PC" },
					{ ["object"] = "prop_headset_01", ["price"] = 45, ["label"] = "Headset" },
					{ ["object"] = "vw_prop_vw_headset_01a", ["price"] = 80, ["label"] = "Headset" },
					{ ["object"] = "ba_prop_battle_headphones_dj", ["price"] = 180, ["label"] = "Headphones" }
				}
			},
			{ ["object"] = "prop_radio_01", ["price"] = 35, ["label"] = "Radio",
				["group_items"] = {
					{ ["object"] = "prop_radio_01", ["price"] = 35, ["label"] = "Radio 01" },
					{ ["object"] = "sm_prop_smug_wall_radio_01", ["price"] = 120, ["label"] = "Radio Wall" },
					{ ["object"] = "prop_boombox_01", ["price"] = 80, ["label"] = "BoomBox" }
				}
			},
			{ ["object"] = "prop_ing_camera_01", ["price"] = 120, ["label"] = "Camera",
				["group_items"] = {
					{ ["object"] = "prop_ing_camera_01", ["price"] = 120, ["label"] = "Camera 01" },
					{ ["object"] = "prop_pap_camera_01", ["price"] = 850, ["label"] = "Camera Large" },
				}
			},
			{ ["object"] = "hei_prop_dlc_tablet", ["price"] = 450, ["label"] = "Tablet",
				["group_items"] = {
					{ ["object"] = "hei_prop_dlc_tablet", ["price"] = 450, ["label"] = "Tablet" },
					{ ["object"] = "xm_prop_x17_tablet_01", ["price"] = 520, ["label"] = "Tablet HD" },
					{ ["object"] = "xs_prop_arena_tablet_drone_01", ["price"] = 600, ["label"] = "Tablet Argen Wars" }
				}
			},
			{ ["object"] = "v_ilev_mm_screen", ["price"] = 150, ["label"] = "Canvas",
				["group_items"] = {
					{ ["object"] = "v_ilev_mm_screen", ["price"] = 150, ["label"] = "Canvas" },
					{ ["object"] = "v_ilev_mm_screen2", ["price"] = 150, ["label"] = "Canvas 2" }
				}
			},
			{ ["object"] = "ch_prop_arcade_claw_01a", ["price"] = 1200, ["label"] = "Arcade",
				["group_items"] = {
					{ ["object"] = "ch_prop_arcade_claw_01a", ["price"] = 1500, ["label"] = "Arcade Claw" },
					{ ["object"] = "ch_prop_arcade_degenatron_01a", ["price"] = 1500, ["label"] = "Arcade Degenatron" },
					{ ["object"] = "ch_prop_arcade_fortune_01a", ["price"] = 1800, ["label"] = "Arcade Fortune" },
					{ ["object"] = "ch_prop_arcade_fortune_door_01a", ["price"] = 150, ["label"] = "Arcade Forutne Door" },
					{ ["object"] = "ch_prop_arcade_gun_01a", ["price"] = 2600, ["label"] = "Arcade Gun" },
					{ ["object"] = "ch_prop_arcade_invade_01a", ["price"] = 1400, ["label"] = "Arcade Invade" },
					{ ["object"] = "ch_prop_arcade_love_01a", ["price"] = 2800, ["label"] = "Arcade Love" },
					{ ["object"] = "ch_prop_arcade_monkey_01a", ["price"] = 1500, ["label"] = "Arcade Monkey" },
					{ ["object"] = "ch_prop_arcade_penetrator_01a", ["price"] = 1500, ["label"] = "Arcade Penetrator" },
					{ ["object"] = "ch_prop_arcade_race_01a", ["price"] = 4300, ["label"] = "Arcade Race 01a" },
					{ ["object"] = "ch_prop_arcade_race_01b", ["price"] = 4300, ["label"] = "Arcade Race 01b" },
					{ ["object"] = "ch_prop_arcade_space_01a", ["price"] = 1500, ["label"] = "Arcade Space" },
					{ ["object"] = "ch_prop_arcade_street_01a", ["price"] = 1500, ["label"] = "Arcade Street 01a" },
					{ ["object"] = "ch_prop_arcade_street_01a_off", ["price"] = 1500, ["label"] = "Arcade Street 01a off" },
					{ ["object"] = "ch_prop_arcade_street_01b", ["price"] = 1500, ["label"] = "Arcade Street 01b" },
					{ ["object"] = "ch_prop_arcade_street_01b_off", ["price"] = 1500, ["label"] = "Arcade Street 01b off" },
					{ ["object"] = "ch_prop_arcade_street_01c", ["price"] = 1500, ["label"] = "Arcade Street 01c" },
					{ ["object"] = "ch_prop_arcade_street_01c_off", ["price"] = 1500, ["label"] = "Arcade Street 01c off" },
					{ ["object"] = "ch_prop_arcade_street_01d", ["price"] = 1500, ["label"] = "Arcade Street 01d" },
					{ ["object"] = "ch_prop_arcade_street_01d_off", ["price"] = 1500, ["label"] = "Arcade Street 01d off" },
					{ ["object"] = "ch_prop_arcade_street_02b", ["price"] = 1500, ["label"] = "Arcade Street 02b" },
					{ ["object"] = "ch_prop_arcade_wizard_01a", ["price"] = 1500, ["label"] = "Arcade Wizard" },
					{ ["object"] = "prop_bball_arcade_01", ["price"] = 1500, ["label"] = "Arcade Ball" },
					{ ["object"] = "sum_prop_arcade_strength_01a", ["price"] = 1500, ["label"] = "Arcade Strength" },
					{ ["object"] = "sum_prop_arcade_strength_ham_01a", ["price"] = 150, ["label"] = "Arcade Strength Hammer" },
					{ ["object"] = "sum_prop_arcade_qub3d_01a", ["price"] = 1500, ["label"] = "Arcade Qub3D" }
				}
			},
			{ ["object"] = "ba_prop_battle_dj_deck_01a", ["price"] = 120, ["label"] = "DJ",
				["group_items"] = {
					{ ["object"] = "ba_prop_battle_dj_deck_01a", ["price"] = 120, ["label"] = "DJ Deck" },
					{ ["object"] = "ba_prop_battle_dj_kit_mixer", ["price"] = 350, ["label"] = "DJ Kit Mixer" },
					{ ["object"] = "ba_prop_battle_dj_mixer_01a", ["price"] = 450, ["label"] = "DJ Mixer 01a" },
					{ ["object"] = "ba_prop_battle_dj_mixer_01b", ["price"] = 800, ["label"] = "DJ Mixer 01b" },
					{ ["object"] = "ba_prop_battle_dj_mixer_01c", ["price"] = 450, ["label"] = "DJ Mixer 01c" },
					{ ["object"] = "ba_prop_battle_dj_mixer_01d", ["price"] = 380, ["label"] = "DJ Mixer 01d" },
					{ ["object"] = "ba_prop_battle_dj_mixer_01e", ["price"] = 420, ["label"] = "DJ Mixer 01e" },
					{ ["object"] = "ba_prop_battle_dj_stand", ["price"] = 1450, ["label"] = "DJ Stand" },
				}
			},
			{ ["object"] = "ba_prop_battle_drone_quad_static", ["price"] = 160, ["label"] = "Drone",
				["group_items"] = {
					{ ["object"] = "ba_prop_battle_drone_quad_static", ["price"] = 160, ["label"] = "Drone" },
					{ ["object"] = "ch_prop_casino_drone_broken01a", ["price"] = 160, ["label"] = "Drone" }
				}
			},
			{ ["object"] = "apa_p_apdlc_treadmill_s", ["price"] = 1260, ["label"] = "Treadmill S",
				["group_items"] = {
					{ ["object"] = "apa_p_apdlc_treadmill_s", ["price"] = 1260, ["label"] = "Treadmill S" },
					{ ["object"] = "apa_p_apdlc_crosstrainer_s", ["price"] = 2360, ["label"] = "Crosstrainer S" },
					{ ["object"] = "hei_heist_crosstrainer_s", ["price"] = 2360, ["label"] = "Crosstrainer S2" }
				}
			},
			{ ["object"] = "hei_prop_hei_bank_phone_01", ["price"] = 660, ["label"] = "Bank phone",
				["group_items"] = {
					{ ["object"] = "hei_prop_hei_bank_phone_01", ["price"] = 660, ["label"] = "Bank phone" },
					{ ["object"] = "hei_prop_carrier_phone_02", ["price"] = 300, ["label"] = "Retro phone" },
				}
			},
			{ ["object"] = "v_res_vacuum", ["price"] = 350, ["label"] = "Vacuum Cleaner" },
			{ ["object"] = "prop_microphone_02", ["price"] = 35, ["label"] = "Microphone" },
			{ ["object"] = "bkr_prop_weed_fan_ceiling_01a", ["price"] = 1450, ["label"] = "Big Fan 01a" },
			{ ["object"] = "bkr_prop_weed_fan_floor_01a", ["price"] = 450, ["label"] = "Fan 01a" },
			{ ["object"] = "bkr_prop_clubhouse_jukebox_01a", ["price"] = 800, ["label"] = "Jukebox 01a" },
			{ ["object"] = "bkr_prop_clubhouse_jukebox_01b", ["price"] = 920, ["label"] = "Jukebox 01b" },
			{ ["object"] = "bkr_prop_clubhouse_jukebox_02a", ["price"] = 1200, ["label"] = "Jukebox 02a" },
			{ ["object"] = "hei_prop_hei_carrier_disp_01", ["price"] = 700, ["label"] = "Carrier disp 01" },
			{ ["object"] = "prop_arcade_01", ["price"] = 900, ["label"] = "Arcade 01" },
		}
	},

	["fridges"] = {
		["label"] = "Fridges",
		["items"] = {
			{ ["object"] = "bkr_prop_prtmachine_dryer_spin", ["price"] = 600, ["label"] = "Money Wash" },
		}
	},

	["fridges"] = {
		["label"] = "Fridges",
		["items"] = {
			{ ["object"] = "ba_prop_battle_bar_beerfridge_01", ["price"] = 1300, ["label"] = "Beer Fridge",
				["group_items"] = {
					{ ["object"] = "ba_prop_battle_bar_beerfridge_01", ["price"] = 1300, ["label"] = "Beer Fridge" },
					{ ["object"] = "ba_prop_battle_bar_fridge_01", ["price"] = 1300, ["label"] = "Beer Fridge" },
					{ ["object"] = "prop_bar_fridge_01", ["price"] = 1300, ["label"] = "Beer Fridge" },
				}
			},
			{ ["object"] = "ba_prop_battle_bar_fridge_02", ["price"] = 1450, ["label"] = "Mini Fridge",
				["group_items"] = {
					{ ["object"] = "ba_prop_battle_bar_fridge_02", ["price"] = 1450, ["label"] = "Beer Fridge" },
					{ ["object"] = "prop_bar_fridge_03", ["price"] = 1100, ["label"] = "Beer Fridge" },
					{ ["object"] = "prop_bar_fridge_04", ["price"] = 1400, ["label"] = "Beer Fridge" }
				}
			},
			{ ["object"] = "v_ilev_mm_fridgeint", ["price"] = 900, ["label"] = "Fridge",
				["group_items"] = {
					{ ["object"] = "v_ilev_mm_fridgeint", ["price"] = 900, ["label"] = "Fridge Int" },
					{ ["object"] = "v_ilev_mm_fridge_l", ["price"] = 450, ["label"] = "Fridge L" },
					{ ["object"] = "v_ilev_mm_fridge_r", ["price"] = 450, ["label"] = "Fridge R" }
				}
			},
			{ ["object"] = "prop_fridge_01", ["price"] = 1100, ["label"] = "Fridge 01" },
			{ ["object"] = "prop_vend_fridge01", ["price"] = 900, ["label"] = "Fridge 03" },
			{ ["object"] = "v_res_fridgemoda", ["price"] = 1450, ["label"] = "Fridge Moda" },
			{ ["object"] = "v_res_fridgemodsml", ["price"] = 1350, ["label"] = "Fridge Modsml" },
			{ ["object"] = "bkr_prop_meth_chiller_01a", ["price"] = 2300, ["label"] = "Meth Fridge 01" },
		}
	},

	["sinks"] = {
		["label"] = "Sinks",
		["items"] = {
			{ ["object"] = "prop_bar_sink_01", ["price"] = 380, ["label"] = "Sink bar 01",
				["group_items"] = {
					{ ["object"] = "prop_ff_sink_02", ["price"] = 600, ["label"] = "Sink ff 02" },
					{ ["object"] = "prop_sink_04", ["price"] = 600, ["label"] = "Sink 04" },
				}
			},
			{ ["object"] = "prop_sink_02", ["price"] = 350, ["label"] = "Sink 01",
				["group_items"] = {
					{ ["object"] = "prop_sink_05", ["price"] = 250, ["label"] = "Sink 05" },
					{ ["object"] = "prop_ff_sink_01", ["price"] = 175, ["label"] = "Sink 06" },
				}
			},
			{ ["object"] = "prop_sink_06", ["price"] = 350, ["label"] = "Sink 02" },
			{ ["object"] = "v_res_mbsink", ["price"] = 350, ["label"] = "Sink MB" },
			{ ["object"] = "v_ilev_mm_faucet", ["price"] = 175, ["label"] = "Faucet" },
		}
	},

	["microwaves"] = {
		["label"] = "Microwaves",
		["items"] = {
			{ ["object"] = "prop_microwave_1", ["price"] = 200, ["label"] = "Microwaves 01" },
			{ ["object"] = "prop_micro_01", ["price"] = 120, ["label"] = "Microwave 01" },
			{ ["object"] = "prop_micro_02", ["price"] = 200, ["label"] = "Microwave 02" },
		}
	},

	["ovens"] = {
		["label"] = "Ovens",
		["items"] = {
			{ ["object"] = "prop_chip_fryer", ["price"] = 1300, ["label"] = "Chip`Fryer" },
			{ ["object"] = "prop_cooker_03", ["price"] = 2500, ["label"] = "Cooker" }
		}
	},

	["kitchendecs"] = {
		["label"] = "Kitchen Decs",
		["items"] = {
			{ ["object"] = "v_res_mknifeblock", ["price"] = 130, ["label"] = "Knifeblock",
				["group_items"] = {
					{ ["object"] = "v_res_mknifeblock", ["price"] = 130, ["label"] = "Knifeblock Wood" },
					{ ["object"] = "prop_knife_stand", ["price"] = 130, ["label"] = "Knifeblock Black" }
				}
			},
			{ ["object"] = "apa_mp_h_acc_coffeemachine_01", ["price"] = 250, ["label"] = "Coffee Machine",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_acc_coffeemachine_01", ["price"] = 250, ["label"] = "Coffee Machine" },
					{ ["object"] = "prop_coffee_mac_01", ["price"] = 1800, ["label"] = "Coffee Mac" },
					{ ["object"] = "prop_coffee_mac_02", ["price"] = 350, ["label"] = "Coffee Mac" },
					{ ["object"] = "xm_prop_x17_coffee_jug", ["price"] = 75, ["label"] = "Coffee Jug" }
				}
			},
			{ ["object"] = "prop_cs_kettle_01", ["price"] = 80, ["label"] = "Kettle",
				["group_items"] = {
					{ ["object"] = "prop_cs_kettle_01", ["price"] = 80, ["label"] = "Kettle 01" },
					{ ["object"] = "prop_kettle", ["price"] = 100, ["label"] = "Kettle" }
				}
			},
			{ ["object"] = "prop_kitch_pot_fry", ["price"] = 50, ["label"] = "Pot",
				["group_items"] = {
					{ ["object"] = "prop_kitch_pot_fry", ["price"] = 50, ["label"] = "Pot Fry" },
					{ ["object"] = "prop_kitch_pot_huge", ["price"] = 150, ["label"] = "Pot Huge" },
					{ ["object"] = "prop_kitch_pot_lrg", ["price"] = 80, ["label"] = "Pot LRG" },
					{ ["object"] = "prop_kitch_pot_lrg2", ["price"] = 80, ["label"] = "Pot LRG2" },
					{ ["object"] = "prop_pot_01", ["price"] = 90, ["label"] = "Pot 01" },
					{ ["object"] = "prop_pot_03", ["price"] = 80, ["label"] = "Pot 03" },
					{ ["object"] = "prop_pot_05", ["price"] = 70, ["label"] = "Pot 05" }
				}
			},
			{ ["object"] = "v_res_fa_chopbrd", ["price"] = 45, ["label"] = "Chopbord",
				["group_items"] = {
					{ ["object"] = "v_res_fa_chopbrd", ["price"] = 45, ["label"] = "Chopbord" },
					{ ["object"] = "v_res_mchopboard", ["price"] = 90, ["label"] = "Chopbord Knife" }
				}
			},
			{ ["object"] = "v_res_mkniferack", ["price"] = 180, ["label"] = "Knife Rack" },
			{ ["object"] = "v_res_mutensils", ["price"] = 75, ["label"] = "Mutensils" },
			{ ["object"] = "prop_kitch_juicer", ["price"] = 130, ["label"] = "Kitchen Juicer" },
			{ ["object"] = "v_res_tre_mixer", ["price"] = 110, ["label"] = "Oven Pizza" },
			{ ["object"] = "v_res_fa_sponge01", ["price"] = 10, ["label"] = "Sponge" },
			{ ["object"] = "bkr_prop_weed_scales_01a", ["price"] = 120, ["label"] = "Weed scales 01a" },
			{ ["object"] = "bkr_prop_weed_scales_01b", ["price"] = 120, ["label"] = "Weed scales 01b" },
		}
	},

	["chairs"] = {
		["label"] = "Chairs",
		["items"] = {
			{ ["object"] = "apa_mp_h_din_chair_04", ["price"] = 75, ["label"] = "Din Chair",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_din_chair_04", ["price"] = 75, ["label"] = "Din Chair 04" },
					{ ["object"] = "hei_heist_din_chair_01", ["price"] = 75, ["label"] = "Din Chair 01" },
					{ ["object"] = "hei_heist_din_chair_06", ["price"] = 75, ["label"] = "Din Chair 06" },
					{ ["object"] = "apa_mp_h_din_chair_08", ["price"] = 75, ["label"] = "Din Chair 08" },
					{ ["object"] = "apa_mp_h_din_chair_09", ["price"] = 80, ["label"] = "Din Chair 09" },
					{ ["object"] = "hei_heist_din_chair_09", ["price"] = 80, ["label"] = "Din Chair Heist 09" },
					{ ["object"] = "apa_mp_h_din_chair_12", ["price"] = 75, ["label"] = "Din Chair 12" },
					{ ["object"] = "hei_heist_din_chair_02", ["price"] = 75, ["label"] = "Din Chair 02" },
					{ ["object"] = "hei_heist_din_chair_05", ["price"] = 75, ["label"] = "Din Chair 05" },
					{ ["object"] = "p_dinechair_01_s", ["price"] = 75, ["label"] = "Din Chair 01s" },
				}
			},
			{ ["object"] = "prop_table_04_chr", ["price"] = 80, ["label"] = "Table Chair 04",
				["group_items"] = {
					{ ["object"] = "prop_table_04_chr", ["price"] = 80, ["label"] = "Table Chair 04" },
					{ ["object"] = "prop_table_05_chr", ["price"] = 80, ["label"] = "Table Chair 05" },
					{ ["object"] = "prop_table_06_chr", ["price"] = 80, ["label"] = "Table Chair 06" },
					{ ["object"] = "prop_table_08_chr", ["price"] = 80, ["label"] = "Table Chair 08" }
				}
			},
			{ ["object"] = "apa_mp_h_yacht_barstool_01", ["price"] = 90, ["label"] = "Bar Chair",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_yacht_barstool_01", ["price"] = 90, ["label"] = "Bar Chair 01" },
					{ ["object"] = "bkr_prop_biker_barstool_02", ["price"] = 90, ["label"] = "Bar Chair 02" },
					{ ["object"] = "bkr_prop_biker_barstool_03", ["price"] = 90, ["label"] = "Bar Chair 03" },
					{ ["object"] = "bkr_prop_biker_barstool_04", ["price"] = 90, ["label"] = "Bar Chair 04" }
				}
			},
			{ ["object"] = "apa_mp_h_stn_foot_stool_01", ["price"] = 185, ["label"] = "Foot Stool",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_stn_foot_stool_01", ["price"] = 185, ["label"] = "Foot Stool 01" },
					{ ["object"] = "apa_mp_h_stn_foot_stool_02", ["price"] = 185, ["label"] = "Foot Stool 02" }
				}
			},
			{ ["object"] = "apa_mp_h_stn_chairarm_01", ["price"] = 135, ["label"] = "Chair Arm",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_stn_chairarm_01", ["price"] = 135, ["label"] = "Chair Arm 01" },
					{ ["object"] = "apa_mp_h_stn_chairarm_02", ["price"] = 135, ["label"] = "Chair Arm 02" },
					{ ["object"] = "apa_mp_h_stn_chairarm_03", ["price"] = 135, ["label"] = "Chair Arm 03" },
					{ ["object"] = "apa_mp_h_stn_chairarm_09", ["price"] = 135, ["label"] = "Chair Arm 09" },
					{ ["object"] = "apa_mp_h_stn_chairarm_11", ["price"] = 135, ["label"] = "Chair Arm 11" },
					{ ["object"] = "apa_mp_h_stn_chairarm_12", ["price"] = 135, ["label"] = "Chair Arm 12" },
					{ ["object"] = "apa_mp_h_stn_chairarm_13", ["price"] = 135, ["label"] = "Chair Arm 13" },
					{ ["object"] = "apa_mp_h_stn_chairarm_23", ["price"] = 135, ["label"] = "Chair Arm 23" },
					{ ["object"] = "apa_mp_h_stn_chairarm_24", ["price"] = 135, ["label"] = "Chair Arm 24" },
					{ ["object"] = "apa_mp_h_stn_chairarm_25", ["price"] = 135, ["label"] = "Chair Arm 25" },
					{ ["object"] = "apa_mp_h_stn_chairarm_26", ["price"] = 135, ["label"] = "Chair Arm 26" },
					{ ["object"] = "ex_mp_h_stn_chairarm_03", ["price"] = 135, ["label"] = "Chair Arm STN 03" },
					{ ["object"] = "ex_mp_h_stn_chairarm_24", ["price"] = 135, ["label"] = "Chair Arm STN 24" },
					{ ["object"] = "hei_heist_stn_chairarm_01", ["price"] = 135, ["label"] = "Chair Arm STN 01" },
					{ ["object"] = "hei_heist_stn_chairarm_04", ["price"] = 135, ["label"] = "Chair Arm STN 04" },
					{ ["object"] = "hei_heist_stn_chairarm_06", ["price"] = 135, ["label"] = "Chair Arm STN 06" },
					{ ["object"] = "xm_lab_chairarm_11", ["price"] = 135, ["label"] = "Chair Arm Lab 11" },
					{ ["object"] = "xm_lab_chairarm_12", ["price"] = 160, ["label"] = "Chair Arm Lab 12" },
					{ ["object"] = "xm_mp_h_stn_chairarm_13", ["price"] = 135, ["label"] = "Chair Arm STN 13" }
				}
			},
			{ ["object"] = "apa_mp_h_yacht_armchair_01", ["price"] = 175, ["label"] = "Arm Chair",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_yacht_armchair_01", ["price"] = 175, ["label"] = "Arm Chair Yacht 01" },
					{ ["object"] = "apa_mp_h_yacht_armchair_03", ["price"] = 135, ["label"] = "Arm Chair Yacht 03" },
					{ ["object"] = "apa_mp_h_yacht_armchair_04", ["price"] = 175, ["label"] = "Arm Chair Yacht 04" },
					{ ["object"] = "bkr_prop_clubhouse_armchair_01a", ["price"] = 200, ["label"] = "Arm Chair 01a" },
					{ ["object"] = "prop_armchair_01", ["price"] = 135, ["label"] = "Arm Chair 01" },
					{ ["object"] = "p_armchair_01_s", ["price"] = 145, ["label"] = "Arm Chair 01s" }
				}
			},
			{ ["object"] = "ba_prop_battle_club_chair_01", ["price"] = 165, ["label"] = "Club Chair",
				["group_items"] = {
					{ ["object"] = "ba_prop_battle_club_chair_01", ["price"] = 175, ["label"] = "Club Chair 01" },
					{ ["object"] = "ba_prop_battle_club_chair_02", ["price"] = 135, ["label"] = "Club Chair 02" },
					{ ["object"] = "ba_prop_battle_club_chair_03", ["price"] = 175, ["label"] = "Club Chair 03" }
				}
			},
			{ ["object"] = "apa_mp_h_stn_chairstrip_01", ["price"] = 170, ["label"] = "Chair Strip",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_stn_chairstrip_01", ["price"] = 170, ["label"] = "Chair Strip STN 01" },
					{ ["object"] = "apa_mp_h_stn_chairstrip_02", ["price"] = 170, ["label"] = "Chair Strip STN 02" },
					{ ["object"] = "apa_mp_h_stn_chairstrip_03", ["price"] = 170, ["label"] = "Chair Strip STN 03" },
					{ ["object"] = "apa_mp_h_stn_chairstrip_04", ["price"] = 170, ["label"] = "Chair Strip STN 04" },
					{ ["object"] = "apa_mp_h_stn_chairstrip_05", ["price"] = 170, ["label"] = "Chair Strip STN 05" },
					{ ["object"] = "apa_mp_h_stn_chairstrip_07", ["price"] = 170, ["label"] = "Chair Strip STN 07" },
					{ ["object"] = "apa_mp_h_stn_chairstrip_08", ["price"] = 170, ["label"] = "Chair Strip STN 08" },
					{ ["object"] = "bkr_prop_biker_chairstrip_01", ["price"] = 120, ["label"] = "Chair Strip Biker 01" },
					{ ["object"] = "bkr_prop_biker_chairstrip_02", ["price"] = 80, ["label"] = "Chair Strip Biker 02" },
					{ ["object"] = "ex_mp_h_off_chairstrip_01", ["price"] = 170, ["label"] = "Chair Strip 01" }
				}
			},
			{ ["object"] = "ex_prop_offchair_exec_01", ["price"] = 185, ["label"] = "Office Chair",
				["group_items"] = {
					{ ["object"] = "ex_prop_offchair_exec_01", ["price"] = 185, ["label"] = "Office Chair 01" },
					{ ["object"] = "bkr_prop_clubhouse_offchair_01a", ["price"] = 25, ["label"] = "Office Chair 01a" },
					{ ["object"] = "ex_prop_offchair_exec_02", ["price"] = 185, ["label"] = "Office Chair 02" },
					{ ["object"] = "ex_prop_offchair_exec_03", ["price"] = 185, ["label"] = "Office Chair 03" },
					{ ["object"] = "ex_prop_offchair_exec_04", ["price"] = 185, ["label"] = "Office Chair 04" },
					{ ["object"] = "imp_prop_impexp_offchair_01a", ["price"] = 185, ["label"] = "Office Chair Impexp 01a" },
					{ ["object"] = "p_soloffchair_s", ["price"] = 185, ["label"] = "Office Chair S" }
				}
			},
			{ ["object"] = "prop_chair_01a", ["price"] = 125, ["label"] = "Prop Chair",
				["group_items"] = {
					{ ["object"] = "prop_chair_01a", ["price"] = 125, ["label"] = "Prop Chair 01a" },
					{ ["object"] = "prop_chair_01b", ["price"] = 125, ["label"] = "Prop Chair 01b" },
					{ ["object"] = "prop_chair_02", ["price"] = 125, ["label"] = "Prop Chair 02" },
					{ ["object"] = "prop_chair_03", ["price"] = 125, ["label"] = "Prop Chair 03" },
					{ ["object"] = "prop_chair_04a", ["price"] = 125, ["label"] = "Prop Chair 04a" },
					{ ["object"] = "prop_chair_04b", ["price"] = 125, ["label"] = "Prop Chair 04b" },
					{ ["object"] = "prop_chair_05", ["price"] = 125, ["label"] = "Prop Chair 05" },
					{ ["object"] = "prop_chair_06", ["price"] = 125, ["label"] = "Prop Chair 06" },
					{ ["object"] = "prop_chair_07", ["price"] = 125, ["label"] = "Prop Chair 07" },
					{ ["object"] = "prop_chair_08", ["price"] = 125, ["label"] = "Prop Chair 08" },
					{ ["object"] = "prop_chair_09", ["price"] = 125, ["label"] = "Prop Chair 09" },
					{ ["object"] = "prop_chair_10", ["price"] = 125, ["label"] = "Prop Chair 10" },
					{ ["object"] = "prop_chair_pile_01", ["price"] = 125, ["label"] = "Prop Chair Pile 01" }
				}
			},
			{ ["object"] = "apa_mp_h_stn_chairstool_12", ["price"] = 100, ["label"] = "Chair Stool" },
			{ ["object"] = "apa_mp_h_yacht_stool_01", ["price"] = 120, ["label"] = "Yacht Stool" },
			{ ["object"] = "ba_prop_int_edgy_stool", ["price"] = 110, ["label"] = "Edgy Stool" },
			{ ["object"] = "ba_prop_int_glam_stool", ["price"] = 110, ["label"] = "Glam Stool" },
			{ ["object"] = "ex_mp_h_off_easychair_01", ["price"] = 150, ["label"] = "Easy Chair" },
			{ ["object"] = "prop_chateau_chair_01", ["price"] = 110, ["label"] = "Chateau Chair" },
			{ ["object"] = "prop_clown_chair", ["price"] = 80, ["label"] = "Clown Chair" },
			{ ["object"] = "prop_direct_chair_01", ["price"] = 95, ["label"] = "Direct Chair" },
			{ ["object"] = "prop_wheelchair_01", ["price"] = 215, ["label"] = "Wheelchair" },
			{ ["object"] = "apa_mp_h_din_stool_04", ["price"] = 215, ["label"] = "Luxury stool" },
			{ ["object"] = "gr_prop_highendchair_gr_01a", ["price"] = 1215, ["label"] = "Gaming chair" }
		}
	},

	["trashcans"] = {
		["label"] = "Trashcans",
		["items"] = {
			{ ["object"] = "prop_bin_07a", ["price"] = 80, ["label"] = "Bin",
				["group_items"] = {
					{ ["object"] = "prop_bin_07a", ["price"] = 80, ["label"] = "Bin 07a" },
					{ ["object"] = "prop_bin_07b", ["price"] = 80, ["label"] = "Bin 07b" },
					{ ["object"] = "prop_bin_07c", ["price"] = 80, ["label"] = "Bin 07c" },
					{ ["object"] = "prop_bin_07d", ["price"] = 80, ["label"] = "Bin 07d" }
				}
			},
			{ ["object"] = "prop_bin_08a", ["price"] = 90, ["label"] = "Bin 08a",
				["group_items"] = {
					{ ["object"] = "prop_bin_08a", ["price"] = 90, ["label"] = "Bin 08a" },
					{ ["object"] = "prop_bin_08open", ["price"] = 90, ["label"] = "Bin 08open" }
				}
			},
			{ ["object"] = "prop_cs_bin_01", ["price"] = 90, ["label"] = "Bin 01",
				["group_items"] = {
					{ ["object"] = "prop_cs_bin_01", ["price"] = 90, ["label"] = "Bin 01" },
					{ ["object"] = "prop_cs_bin_01_skinned", ["price"] = 90, ["label"] = "Bin 01 Skinned" },
					{ ["object"] = "prop_cs_bin_03", ["price"] = 90, ["label"] = "Bin 03" }
				}
			},
			{ ["object"] = "hei_heist_kit_bin_01", ["price"] = 100, ["label"] = "Bin Kit" },
			{ ["object"] = "prop_bin_03a", ["price"] = 80, ["label"] = "Bin 03a" },
			{ ["object"] = "prop_bin_04a", ["price"] = 80, ["label"] = "Bin 04a" },
		}
	},

	["wardrobes"] = {
		["label"] = "Wardrobes",
		["items"] = {
			{ ["object"] = "ch_prop_ch_service_locker_01a", ["price"] = 200, ["label"] = "Locker Service",
				["group_items"] = {
					{ ["object"] = "ch_prop_ch_service_locker_01a", ["price"] = 200, ["label"] = "Locker Service 01a" },
					{ ["object"] = "ch_prop_ch_service_locker_02a", ["price"] = 200, ["label"] = "Locker Service 02a" },
				}
			},
			{ ["object"] = "apa_mp_h_str_shelffloorm_02", ["price"] = 900, ["label"] = "Huge shelves",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_str_shelffloorm_02", ["price"] = 200, ["label"] = "Huge shelve 02" },
					{ ["object"] = "apa_mp_h_str_shelffreel_01", ["price"] = 200, ["label"] = "Shelve white" },
				}
			},
			{ ["object"] = "bkr_prop_gunlocker_01a", ["price"] = 160, ["label"] = "Elegant Wall" },
			{ ["object"] = "apa_mp_h_str_shelfwallm_01", ["price"] = 160, ["label"] = "Shelve Wall" },
			{ ["object"] = "p_cs_locker_01_s", ["price"] = 80, ["label"] = "Locker" },
			{ ["object"] = "v_serv_cupboard_01", ["price"] = 160, ["label"] = "cupboard 01" },
		}
	},

	["mirrors"] = {
		["label"] = "Mirrors",
		["items"] = {
			{ ["object"] = "p_int_jewel_mirror", ["price"] = 280, ["label"] = "Jewel Mirror" },
			{ ["object"] = "v_ret_mirror", ["price"] = 160, ["label"] = "Mirror Ret" },
		}
	},

	["lamps"] = {
		["label"] = "Lamps",
		["items"] = {
			{ ["object"] = "apa_mp_h_floorlamp_a", ["price"] = 175, ["label"] = "Floor Lamp",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_floorlamp_a", ["price"] = 175, ["label"] = "Floor Lamp a" },
					{ ["object"] = "apa_mp_h_floorlamp_b", ["price"] = 175, ["label"] = "Floor Lamp b" },
					{ ["object"] = "apa_mp_h_floorlamp_c", ["price"] = 175, ["label"] = "Floor Lamp c" },
					{ ["object"] = "apa_mp_h_lit_floorlampnight_05", ["price"] = 175, ["label"] = "Floor Lamp 05" },
					{ ["object"] = "apa_mp_h_lit_floorlampnight_07", ["price"] = 175, ["label"] = "Floor Lamp 07" },
					{ ["object"] = "apa_mp_h_lit_floorlampnight_14", ["price"] = 175, ["label"] = "Floor Lamp 14" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_01", ["price"] = 175, ["label"] = "Floor Lamp 01" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_02", ["price"] = 175, ["label"] = "Floor Lamp 02" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_05", ["price"] = 175, ["label"] = "Floor Lamp 05" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_06", ["price"] = 175, ["label"] = "Floor Lamp 06" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_10", ["price"] = 175, ["label"] = "Floor Lamp 10" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_13", ["price"] = 175, ["label"] = "Floor Lamp 13" },
					{ ["object"] = "apa_mp_h_lit_floorlamp_17", ["price"] = 175, ["label"] = "Floor Lamp 17" },
					{ ["object"] = "hei_heist_lit_floorlamp_01", ["price"] = 175, ["label"] = "Floor Lamp Lit 01" },
					{ ["object"] = "hei_heist_lit_floorlamp_02", ["price"] = 175, ["label"] = "Floor Lamp Lit 02" },
					{ ["object"] = "hei_heist_lit_floorlamp_03", ["price"] = 175, ["label"] = "Floor Lamp Lit 03" },
					{ ["object"] = "hei_heist_lit_floorlamp_04", ["price"] = 175, ["label"] = "Floor Lamp Lit 04" },
				}
			},
			{ ["object"] = "apa_mp_h_lit_lamptablenight_16", ["price"] = 75, ["label"] = "Lamp Table",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_lit_lamptablenight_16", ["price"] = 75, ["label"] = "Lamp Table 16" },
					{ ["object"] = "apa_mp_h_lit_lamptablenight_24", ["price"] = 75, ["label"] = "Lamp Table 24" },
					{ ["object"] = "apa_mp_h_lit_lamptable_005", ["price"] = 75, ["label"] = "Lamp Table 005" },
					{ ["object"] = "apa_mp_h_lit_lamptable_02", ["price"] = 75, ["label"] = "Lamp Table 02" },
					{ ["object"] = "apa_mp_h_lit_lamptable_09", ["price"] = 75, ["label"] = "Lamp Table 09" },
					{ ["object"] = "apa_mp_h_lit_lamptable_14", ["price"] = 75, ["label"] = "Lamp Table 14" },
					{ ["object"] = "apa_mp_h_lit_lamptable_17", ["price"] = 75, ["label"] = "Lamp Table 17" },
					{ ["object"] = "apa_mp_h_lit_lamptable_21", ["price"] = 75, ["label"] = "Lamp Table 21" },
					{ ["object"] = "hei_heist_lit_lamptable_03", ["price"] = 75, ["label"] = "Lamp Table 03" },
					{ ["object"] = "hei_heist_lit_lamptable_04", ["price"] = 75, ["label"] = "Lamp Table 04" },
					{ ["object"] = "hei_heist_lit_lamptable_06", ["price"] = 75, ["label"] = "Lamp Table 06" }
				}
			},
			{ ["object"] = "ch_prop_ch_lamp_ceiling_01a", ["price"] = 120, ["label"] = "Lamp Ceiling",
				["group_items"] = {
					{ ["object"] = "ch_prop_ch_lamp_ceiling_01a", ["price"] = 120, ["label"] = "Lamp Ceiling 01a" },
					{ ["object"] = "ch_prop_ch_lamp_ceiling_04a", ["price"] = 120, ["label"] = "Lamp Ceiling 04a" },
					{ ["object"] = "ch_prop_ch_lamp_ceiling_g_01a", ["price"] = 120, ["label"] = "Lamp Ceiling 01a" },
					{ ["object"] = "ch_prop_ch_lamp_ceiling_g_01b", ["price"] = 120, ["label"] = "Lamp Ceiling 01b" },
					{ ["object"] = "ch_prop_ch_lamp_ceiling_w_01a", ["price"] = 120, ["label"] = "Lamp Ceiling 01a" },
					{ ["object"] = "ch_prop_ch_lamp_ceiling_w_01b", ["price"] = 120, ["label"] = "Lamp Ceiling 01b" },
					{ ["object"] = "xm_base_cia_lamp_ceiling_02a", ["price"] = 120, ["label"] = "Lamp Ceiling 02a" }
				}
			},
			{ ["object"] = "ch_prop_ch_tunnel_worklight", ["price"] = 85, ["label"] = "Lamp Tunnel Work" ,
				["group_items"] = {
					{ ["object"] = "ch_prop_ch_tunnel_worklight", ["price"] = 85, ["label"] = "Lamp Tunnel Work" },
					{ ["object"] = "prop_construcionlamp_01", ["price"] = 85, ["label"] = "Lamp Tunnel Construcion" },
				}
			},
			{ ["object"] = "v_ret_fh_walllighton", ["price"] = 120, ["label"] = "Walllighton",
				["group_items"] = {
					{ ["object"] = "v_ret_fh_walllighton", ["price"] = 120, ["label"] = "Walllighton On" },
					{ ["object"] = "v_ret_fh_walllightoff", ["price"] = 120, ["label"] = "Walllighton Off" }
				}
			},
			{ ["object"] = "hei_heist_lit_lightpendant_01", ["price"] = 60, ["label"] = "Light Pendant 01",
				["group_items"] = {
					{ ["object"] = "hei_heist_lit_lightpendant_01", ["price"] = 60, ["label"] = "Light Pendant 01" },
					{ ["object"] = "hei_heist_lit_lightpendant_02", ["price"] = 60, ["label"] = "Light Pendant 02" }
				}
			},
			{ ["object"] = "prop_wall_light_08a", ["price"] = 60, ["label"] = "Wall Lights",
				["group_items"] = {
					{ ["object"] = "prop_wall_light_08a", ["price"] = 60, ["label"] = "Wall Lights 08a" },
					{ ["object"] = "prop_wall_light_11", ["price"] = 130, ["label"] = "Wall Lights 11" },
					{ ["object"] = "prop_wall_light_12", ["price"] = 60, ["label"] = "Wall Lights 12" },
					{ ["object"] = "prop_wall_light_17b", ["price"] = 60, ["label"] = "Wall Lights 17b" },
					{ ["object"] = "prop_wall_light_18a", ["price"] = 60, ["label"] = "Wall Lights 18a" },
				}
			},
			{ ["object"] = "prop_beer_neon_01", ["price"] = 490, ["label"] = "Neon Beer",
				["group_items"] = {
					{ ["object"] = "prop_beer_neon_01", ["price"] = 490, ["label"] = "Neon Beer 01" },
					{ ["object"] = "prop_beer_neon_02", ["price"] = 340, ["label"] = "Neon Beer 02" },
					{ ["object"] = "prop_beer_neon_03", ["price"] = 340, ["label"] = "Neon Beer 03" },
					{ ["object"] = "prop_beer_neon_04", ["price"] = 340, ["label"] = "Neon Beer 04" }
				}
			},
			{ ["object"] = "apa_mp_h_lampbulb_multiple_a", ["price"] = 490, ["label"] = "Ceiling lamps",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_lampbulb_multiple_a", ["price"] = 490, ["label"] = "Ceiling lamp" },
				}
			},
			{ ["object"] = "vw_prop_casino_art_lampf_01a", ["price"] = 150, ["label"] = "Lamp Art" },
			{ ["object"] = "bkr_prop_fakeid_desklamp_01a", ["price"] = 80, ["label"] = "Desk Lamp" },
			{ ["object"] = "h4_prop_battle_lights_wall_l_b", ["price"] = 100, ["label"] = "Battle Light Wall" },
			{ ["object"] = "v_res_tre_lightfan", ["price"] = 220, ["label"] = "Fan Light Res" },
			{ ["object"] = "v_med_examlight", ["price"] = 1300, ["label"] = "Med Exam Light" },
			{ ["object"] = "apa_mp_h_floor_lamp_int_08", ["price"] = 800, ["label"] = "Floor lamp" },
		}
	},

	["toilets"] = {
		["label"] = "Toilets",
		["items"] = {
			{ ["object"] = "prop_toilet_01", ["price"] = 160, ["label"] = "Toilet 01" },
			{ ["object"] = "prop_toilet_02", ["price"] = 120, ["label"] = "Toilet 02" },
		}
	},

	["toilet-brushs"] = {
		["label"] = "Toilet Brushs",
		["items"] = {
			{ ["object"] = "prop_toilet_brush_01", ["price"] = 20, ["label"] = "Toilet Brush 01" }
		}
	},

	["toilet-papers"] = {
		["label"] = "Toilet Papers",
		["items"] = {
			{ ["object"] = "prop_toilet_roll_01", ["price"] = 10, ["label"] = "Toilet Papers 01" },
			{ ["object"] = "prop_toilet_roll_02", ["price"] = 20, ["label"] = "Toilet Papers 02" },
			{ ["object"] = "prop_toilet_roll_05", ["price"] = 50, ["label"] = "Toilet Papers 05" },
		}
	},

	["hand-towels"] = {
		["label"] = "Hand Towels",
		["items"] = {
			{ ["object"] = "prop_beach_towel_01", ["price"] = 10, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_beach_towel_02", ["price"] = 10, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_beach_towel_03", ["price"] = 10, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_beach_towel_04", ["price"] = 10, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_cs_beachtowel_01", ["price"] = 15, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_ftowel_01", ["price"] = 10, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_ftowel_07", ["price"] = 50, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_ftowel_08", ["price"] = 50, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_ftowel_10", ["price"] = 50, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_tint_towel", ["price"] = 15, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_tint_towels_01", ["price"] = 120, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_tint_towels_01b", ["price"] = 120, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_towel2_01", ["price"] = 15, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_towel2_02", ["price"] = 15, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_towel_01", ["price"] = 25, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_towel_rail_01", ["price"] = 50, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_towel_rail_02", ["price"] = 50, ["label"] = "Hand Towels" },
			{ ["object"] = "prop_towel_shelf_01", ["price"] = 250, ["label"] = "Hand Towels" },
			{ ["object"] = "p_shower_towel_s", ["price"] = 20, ["label"] = "Hand Towels" },
			{ ["object"] = "v_res_mbtowel", ["price"] = 20, ["label"] = "Hand Towels" },
			{ ["object"] = "v_res_mbtowelfld", ["price"] = 25, ["label"] = "Hand Towels" }
		}
	},

	["showers"] = {
		["label"] = "Showers",
		["items"] = {
			{ ["object"] = "apa_mp_h_bathtub_01", ["price"] = 590, ["label"] = "Shower" },
		}
	},

	["sideboards"] = {
		["label"] = "Sideboards",
		["items"] = {
			{ ["object"] = "apa_mp_h_str_sideboardl_06", ["price"] = 620, ["label"] = "Elegants Chest",
				["group_items"] = {
					{ ["object"] = "apa_mp_h_str_sideboardl_06", ["price"] = 620, ["label"] = "Sideboard 06" },
					{ ["object"] = "apa_mp_h_str_sideboardm_03", ["price"] = 560, ["label"] = "Sideboard 03" },
					{ ["object"] = "apa_mp_h_str_sideboardl_09", ["price"] = 420, ["label"] = "Sideboard 09" },
				}
			},
			{ ["object"] = "ex_prop_ex_toolchest_01", ["price"] = 620, ["label"] = "Mechanic chest",
				["group_items"] = {
					{ ["object"] = "ex_prop_ex_toolchest_01", ["price"] = 450, ["label"] = "Tool chest 01" },
					{ ["object"] = "gr_prop_gr_tool_chest_01a", ["price"] = 450, ["label"] = "Tool chest 01a" },
					{ ["object"] = "gr_prop_gr_tool_draw_01a", ["price"] = 450, ["label"] = "Tool draw 01a" },
					{ ["object"] = "gr_prop_gr_tool_draw_01b", ["price"] = 450, ["label"] = "Tool draw 01b" },
					{ ["object"] = "gr_prop_gr_tool_draw_01d", ["price"] = 450, ["label"] = "Tool draw 01d" },
				}
			},
			{ ["object"] = "apa_mp_h_bed_chestdrawer_02", ["price"] = 250, ["label"] = "Sideboard Chest" },
			{ ["object"] = "apa_mp_h_str_sideboardl_14", ["price"] = 350, ["label"] = "Sideboard 14" },
			{ ["object"] = "apa_mp_h_str_sideboardl_13", ["price"] = 450, ["label"] = "Sideboard 13" },
			{ ["object"] = "apa_mp_h_str_sideboardm_02", ["price"] = 450, ["label"] = "Sideboard Oak" },
			{ ["object"] = "apa_mp_h_str_sideboards_02", ["price"] = 450, ["label"] = "Sideboard Crystal" },
			{ ["object"] = "hei_heist_bed_chestdrawer_04", ["price"] = 450, ["label"] = "Sideboard Roble" },
			{ ["object"] = "hei_heist_str_sideboardl_04", ["price"] = 550, ["label"] = "Sideboard 04" },
			{ ["object"] = "hei_heist_str_sideboardl_02", ["price"] = 250, ["label"] = "Sideboard 02" },
			{ ["object"] = "p_v_43_safe_s", ["price"] = 750, ["label"] = "Safe 43" },
		}
	},

	["decals"] = {
		["label"] = "Decals",
		["items"] = {
			{ ["object"] = "vw_prop_vw_colle_pogo", ["price"] = 120, ["label"] = "Collectible Figures",
				["group_items"] = {
					{ ["object"] = "vw_prop_vw_colle_pogo", ["price"] = 120, ["label"] = "Space Monkey" },
					{ ["object"] = "vw_prop_vw_colle_alien", ["price"] = 120, ["label"] = "Alien" },
					{ ["object"] = "vw_prop_vw_colle_imporage", ["price"] = 120, ["label"] = "Impotent Rage" },
					{ ["object"] = "vw_prop_vw_colle_prbubble", ["price"] = 120, ["label"] = "Princess Bubblegum" },
					{ ["object"] = "vw_prop_vw_colle_rsrcomm", ["price"] = 120, ["label"] = "Space Ranger Commander" },
					{ ["object"] = "vw_prop_vw_colle_rsrgeneric", ["price"] = 120, ["label"] = "Space Ranger" },
					{ ["object"] = "vw_prop_vw_colle_beast", ["price"] = 120, ["label"] = "Beast" },
					{ ["object"] = "vw_prop_vw_colle_sasquatch", ["price"] = 120, ["label"] = "Sasquatch" }
				}
			},
			{ ["object"] = "v_res_tissues", ["price"] = 25, ["label"] = "Tissues",
				["group_items"] = {
					{ ["object"] = "v_res_tissues", ["price"] = 25, ["label"] = "Tissues" },
					{ ["object"] = "v_res_tt_tissues", ["price"] = 25, ["label"] = "Tissues TT" }
				}
			},
			{ ["object"] = "prop_cs_stock_book", ["price"] = 10, ["label"] = "Book",
				["group_items"] = {
					{ ["object"] = "prop_cs_stock_book", ["price"] = 10, ["label"] = "Book Cs Stock" },
					{ ["object"] = "vw_prop_book_stack_01a", ["price"] = 25, ["label"] = "Book 01a" },
					{ ["object"] = "vw_prop_book_stack_01b", ["price"] = 25, ["label"] = "Book 01b" },
					{ ["object"] = "vw_prop_book_stack_01c", ["price"] = 25, ["label"] = "Book 01c" },
					{ ["object"] = "vw_prop_book_stack_02a", ["price"] = 25, ["label"] = "Book 02a" },
					{ ["object"] = "vw_prop_book_stack_02b", ["price"] = 25, ["label"] = "Book 02b" },
					{ ["object"] = "vw_prop_book_stack_02c", ["price"] = 25, ["label"] = "Book 02c" },
					{ ["object"] = "vw_prop_book_stack_03a", ["price"] = 25, ["label"] = "Book 03a" },
					{ ["object"] = "vw_prop_book_stack_03b", ["price"] = 25, ["label"] = "Book 03b" },
					{ ["object"] = "vw_prop_book_stack_03c", ["price"] = 25, ["label"] = "Book 03c" }
				}
			},
			{ ["object"] = "prop_acc_guitar_01", ["price"] = 120, ["label"] = "Guitar",
				["group_items"] = {
					{ ["object"] = "prop_acc_guitar_01", ["price"] = 120, ["label"] = "Guitar ACC 01" },
					{ ["object"] = "prop_el_guitar_01", ["price"] = 280, ["label"] = "Guitar EL 01" },
					{ ["object"] = "prop_el_guitar_02", ["price"] = 280, ["label"] = "Guitar EL 02" },
					{ ["object"] = "prop_el_guitar_03", ["price"] = 280, ["label"] = "Guitar EL 03" },
					{ ["object"] = "vw_prop_casino_art_guitar_01a", ["price"] = 280, ["label"] = "Guitar Art" },
				}
			},
			{ ["object"] = "v_res_fa_candle02", ["price"] = 10, ["label"] = "Candle",
				["group_items"] = {
					{ ["object"] = "v_res_fa_candle02", ["price"] = 10, ["label"] = "Candle FA 02" },
					{ ["object"] = "v_res_fa_candle03", ["price"] = 10, ["label"] = "Candle FA 03" },
					{ ["object"] = "v_res_fa_candle04", ["price"] = 10, ["label"] = "Candle FA 04" },
					{ ["object"] = "v_prop_floatcandle", ["price"] = 15, ["label"] = "Candle Float" },
					{ ["object"] = "apa_mp_h_acc_candles_01", ["price"] = 20, ["label"] = "Candle ACC 01" },
					{ ["object"] = "apa_mp_h_acc_candles_02", ["price"] = 65, ["label"] = "Candle ACC 02" },
					{ ["object"] = "apa_mp_h_acc_candles_04", ["price"] = 20, ["label"] = "Candle ACC 04" },
					{ ["object"] = "apa_mp_h_acc_candles_05", ["price"] = 15, ["label"] = "Candle ACC 05" },
					{ ["object"] = "apa_mp_h_acc_candles_06", ["price"] = 25, ["label"] = "Candle ACC 06" }
				}
			},
			{ ["object"] = "v_ret_ml_chips1", ["price"] = 10, ["label"] = "Chips",
				["group_items"] = {
					{ ["object"] = "v_ret_ml_chips1", ["price"] = 10, ["label"] = "Chips 1" },
					{ ["object"] = "v_ret_ml_chips2", ["price"] = 10, ["label"] = "Chips 2" },
					{ ["object"] = "v_ret_ml_chips3", ["price"] = 10, ["label"] = "Chips 3" },
					{ ["object"] = "v_ret_ml_chips4", ["price"] = 10, ["label"] = "Chips 4" }
				}
			},
			{ ["object"] = "v_res_tt_cigs01", ["price"] = 10, ["label"] = "Smoke",
				["group_items"] = {
					{ ["object"] = "v_res_tt_cigs01", ["price"] = 10, ["label"] = "Cigs 01" },
					{ ["object"] = "p_cs_lighter_01", ["price"] = 5, ["label"] = "Lighter CS" },
					{ ["object"] = "v_res_tt_lighter", ["price"] = 10, ["label"] = "Lighter TT" },
					{ ["object"] = "ex_prop_exec_lighter_01", ["price"] = 10, ["label"] = "Lighter 01" },
					{ ["object"] = "lux_prop_lighter_luxe", ["price"] = 20, ["label"] = "Lighter Lux" },
					{ ["object"] = "v_res_mp_ashtraya", ["price"] = 10, ["label"] = "Ashtray" },
					{ ["object"] = "v_res_mp_ashtrayb", ["price"] = 10, ["label"] = "Ashtray" },
					{ ["object"] = "v_ret_fh_ashtray", ["price"] = 10, ["label"] = "Ashtray" },
					{ ["object"] = "prop_fib_ashtray_01", ["price"] = 10, ["label"] = "Ashtray" },
					{ ["object"] = "ex_prop_exec_ashtray_01", ["price"] = 20, ["label"] = "Ashtray" },
					{ ["object"] = "v_ret_ml_cigs", ["price"] = 10, ["label"] = "Cigs" },
					{ ["object"] = "v_ret_ml_cigs2", ["price"] = 10, ["label"] = "Cigs 2" },
					{ ["object"] = "v_ret_ml_cigs3", ["price"] = 10, ["label"] = "Cigs 3" },
					{ ["object"] = "v_ret_ml_cigs4", ["price"] = 10, ["label"] = "Cigs 4" },
					{ ["object"] = "v_ret_ml_cigs5", ["price"] = 10, ["label"] = "Cigs 5" },
					{ ["object"] = "v_ret_ml_cigs6", ["price"] = 10, ["label"] = "Cigs 6" },
					{ ["object"] = "prop_bong_01", ["price"] = 80, ["label"] = "Bong 01" },
				}
			},
			{ ["object"] = "prop_anim_cash_note", ["price"] = 10, ["label"] = "Cash",
				["group_items"] = {
					{ ["object"] = "prop_anim_cash_note", ["price"] = 10, ["label"] = "Cash Note" },
					{ ["object"] = "prop_anim_cash_pile_01", ["price"] = 10, ["label"] = "Cash Pile 01" },
					{ ["object"] = "prop_anim_cash_pile_02", ["price"] = 10, ["label"] = "Cash Pile 02" },
					{ ["object"] = "prop_cash_case_01", ["price"] = 50, ["label"] = "Cash Case 01" },
					{ ["object"] = "prop_cash_case_02", ["price"] = 50, ["label"] = "Cash Case 02" },
					{ ["object"] = "bkr_prop_bkr_cash_roll_01", ["price"] = 80, ["label"] = "Cash Roll 01" },
					{ ["object"] = "bkr_prop_bkr_cash_scatter_01", ["price"] = 20, ["label"] = "Cash Scatter 01" },
					{ ["object"] = "bkr_prop_bkr_cash_scatter_03", ["price"] = 20, ["label"] = "Cash Scatter 03" },
					{ ["object"] = "bkr_prop_bkr_cashpile_01", ["price"] = 80, ["label"] = "Cash BKR Pile 01" },
					{ ["object"] = "bkr_prop_bkr_cashpile_02", ["price"] = 80, ["label"] = "Cash BKR Pile 02" },
					{ ["object"] = "bkr_prop_bkr_cashpile_03", ["price"] = 80, ["label"] = "Cash BKR Pile 03" },
					{ ["object"] = "bkr_prop_bkr_cashpile_05", ["price"] = 80, ["label"] = "Cash BKR Pile 05" },
					{ ["object"] = "bkr_prop_bkr_cashpile_06", ["price"] = 80, ["label"] = "Cash BKR Pile 06" },
					{ ["object"] = "ex_prop_exec_cashpile", ["price"] = 80, ["label"] = "Cash Pile" },
					{ ["object"] = "hei_prop_cash_crate_half_full", ["price"] = 80, ["label"] = "Cash Crate Half Full" },
					{ ["object"] = "ch_prop_ch_cashtrolley_01a", ["price"] = 140, ["label"] = "Cash Trolley 01a" },
					{ ["object"] = "h4_prop_h4_cash_bag_01a", ["price"] = 80, ["label"] = "Cash Bag 01a" },
					{ ["object"] = "h4_prop_h4_cash_stack_01a", ["price"] = 80, ["label"] = "Cash Stach 01a" },
					{ ["object"] = "h4_prop_h4_cash_stack_02a", ["price"] = 80, ["label"] = "Cash Stack 02a" },
					{ ["object"] = "bkr_prop_money_pokerbucket", ["price"] = 80, ["label"] = "Cash Pokerbucket" },
					{ ["object"] = "bkr_prop_moneypack_01a", ["price"] = 80, ["label"] = "Cash Pack 01a" },
					{ ["object"] = "bkr_prop_moneypack_02a", ["price"] = 80, ["label"] = "Cash 02a" },
					{ ["object"] = "bkr_prop_moneypack_03a", ["price"] = 80, ["label"] = "Cash 03a" },
					{ ["object"] = "ex_prop_crate_money_bc", ["price"] = 580, ["label"] = "Cash BC" },
					{ ["object"] = "ex_prop_crate_money_sc", ["price"] = 580, ["label"] = "Cash SC" }
				}
			},
			{ ["object"] = "prop_weed_01", ["price"] = 50, ["label"] = "Weed",
				["group_items"] = {
					{ ["object"] = "prop_weed_01", ["price"] = 50, ["label"] = "Weed 01" },
					{ ["object"] = "prop_weed_02", ["price"] = 50, ["label"] = "Weed 02" },
					{ ["object"] = "prop_weed_block_01", ["price"] = 50, ["label"] = "Weed Block 01" },
					{ ["object"] = "prop_weed_bottle", ["price"] = 50, ["label"] = "Weed Bottle" },
					{ ["object"] = "prop_weed_pallet", ["price"] = 350, ["label"] = "Weed Pallet" },
					{ ["object"] = "h4_prop_h4_weed_stack_01a", ["price"] = 150, ["label"] = "Weed Stack 01a" },
					{ ["object"] = "bkr_prop_weed_table_01a", ["price"] = 320, ["label"] = "Weed Table 01a" },
					{ ["object"] = "bkr_prop_weed_spray_01a", ["price"] = 10, ["label"] = "Weed Spray 01a" },
					{ ["object"] = "bkr_prop_weed_scales_01b", ["price"] = 50, ["label"] = "Weed Scales 01b" },
					{ ["object"] = "bkr_prop_weed_scales_01a", ["price"] = 50, ["label"] = "Weed Scales 01a" },
					{ ["object"] = "bkr_prop_weed_plantpot_stack_01c", ["price"] = 50, ["label"] = "Weed Pot Stack 01c" },
					{ ["object"] = "bkr_prop_weed_plantpot_stack_01b", ["price"] = 50, ["label"] = "Weed Pot Stack 01b" },
					{ ["object"] = "bkr_prop_weed_plantpot_stack_01a", ["price"] = 50, ["label"] = "Weed Pot Stack 01a" },
					{ ["object"] = "bkr_prop_weed_med_01b", ["price"] = 50, ["label"] = "Weed MED 01b" },
					{ ["object"] = "bkr_prop_weed_med_01a", ["price"] = 50, ["label"] = "Weed MED 01a" },
					{ ["object"] = "bkr_prop_weed_lrg_01b", ["price"] = 50, ["label"] = "Weed LRG 01b" },
					{ ["object"] = "bkr_prop_weed_lrg_01a", ["price"] = 50, ["label"] = "Weed LRG 01a" },
					{ ["object"] = "bkr_prop_weed_fan_floor_01a", ["price"] = 50, ["label"] = "Weed Floor Fan 01a" },
					{ ["object"] = "bkr_prop_weed_fan_ceiling_01a", ["price"] = 50, ["label"] = "Weed Ceiling Fan 01a" },
					{ ["object"] = "bkr_prop_weed_drying_02a", ["price"] = 50, ["label"] = "Weed 02a" },
					{ ["object"] = "bkr_prop_weed_drying_01a", ["price"] = 50, ["label"] = "Weed 01a" },
					{ ["object"] = "bkr_prop_weed_dry_02b", ["price"] = 50, ["label"] = "Weed Dry 02b" },
					{ ["object"] = "bkr_prop_weed_dry_02a", ["price"] = 50, ["label"] = "Weed Dry 02a" },
					{ ["object"] = "bkr_prop_weed_dry_01a", ["price"] = 50, ["label"] = "Weed Dry 01a" },
					{ ["object"] = "bkr_prop_weed_bud_01a", ["price"] = 50, ["label"] = "Weed Bud 01a" },
					{ ["object"] = "bkr_prop_weed_bud_01b", ["price"] = 50, ["label"] = "Weed Bud 01b" },
					{ ["object"] = "bkr_prop_weed_bud_02a", ["price"] = 50, ["label"] = "Weed Bud 02a" },
					{ ["object"] = "bkr_prop_weed_bud_02b", ["price"] = 50, ["label"] = "Weed Bud 02b" },
					{ ["object"] = "bkr_prop_weed_bucket_open_01a", ["price"] = 50, ["label"] = "Weed Bucket Open 01a" },
					{ ["object"] = "bkr_prop_weed_bigbag_open_01a", ["price"] = 50, ["label"] = "Weed Bigbag Open 01a" },
					{ ["object"] = "bkr_prop_weed_bigbag_03a", ["price"] = 50, ["label"] = "Weed BigBag 03a" },
					{ ["object"] = "bkr_prop_weed_bigbag_02a", ["price"] = 50, ["label"] = "Weed BigBag 02a" },
					{ ["object"] = "bkr_prop_weed_bigbag_01a", ["price"] = 50, ["label"] = "Weed BigBag 01a" },
					{ ["object"] = "bkr_prop_weed_01_small_01c", ["price"] = 50, ["label"] = "Weed Small 01c" },
					{ ["object"] = "bkr_prop_weed_01_small_01b", ["price"] = 50, ["label"] = "Weed Small 01b" },
					{ ["object"] = "bkr_prop_weed_01_small_01a", ["price"] = 50, ["label"] = "Weed Small 01a" },
				}
			},
			{ ["object"] = "bkr_prop_meth_acetone", ["price"] = 50, ["label"] = "Meth",
				["group_items"] = {
					{ ["object"] = "bkr_prop_meth_acetone", ["price"] = 50, ["label"] = "Meth Acetone" },
					{ ["object"] = "bkr_prop_meth_ammonia", ["price"] = 50, ["label"] = "Meth Ammonia" },
					{ ["object"] = "bkr_prop_meth_hcacid", ["price"] = 50, ["label"] = "Meth Hcacid" },
					{ ["object"] = "bkr_prop_meth_lithium", ["price"] = 50, ["label"] = "Meth Lithium" },
					{ ["object"] = "bkr_prop_meth_openbag_01a", ["price"] = 50, ["label"] = "Meth OpenBag" },
					{ ["object"] = "bkr_prop_meth_phosphorus", ["price"] = 50, ["label"] = "Meth Phosphorus" },
					{ ["object"] = "bkr_prop_meth_sacid", ["price"] = 50, ["label"] = "Meth Sacid" },
					{ ["object"] = "bkr_prop_meth_scoop_01a", ["price"] = 50, ["label"] = "Meth Scoop 01a" },
					{ ["object"] = "bkr_prop_meth_smallbag_01a", ["price"] = 50, ["label"] = "Meth Smallbag 01a" },
					{ ["object"] = "bkr_prop_meth_smashedtray_01", ["price"] = 50, ["label"] = "Meth Smashed Tray 01a" },
					{ ["object"] = "bkr_prop_meth_smashedtray_01_frag_", ["price"] = 50, ["label"] = "Meth Smashed Tray 01 Frag" },
					{ ["object"] = "bkr_prop_meth_smashedtray_02", ["price"] = 50, ["label"] = "Meth Smashed Tray 02" },
					{ ["object"] = "bkr_prop_meth_sodium", ["price"] = 50, ["label"] = "Meth Sodium" },
					{ ["object"] = "bkr_prop_meth_table01a", ["price"] = 320, ["label"] = "Meth Table 01a" },
					{ ["object"] = "bkr_prop_meth_toulene", ["price"] = 50, ["label"] = "Meth Toulene" },
					{ ["object"] = "bkr_prop_meth_tray_01a", ["price"] = 50, ["label"] = "Meth Tray 01a" },
					{ ["object"] = "bkr_prop_meth_tray_01b", ["price"] = 50, ["label"] = "Meth Tray 01b" },
					{ ["object"] = "bkr_prop_meth_tray_02a", ["price"] = 50, ["label"] = "Meth Tray 02a" }
				}
			},
			{ ["object"] = "prop_coke_block_01", ["price"] = 50, ["label"] = "Coke",
				["group_items"] = {
					{ ["object"] = "prop_coke_block_01", ["price"] = 50, ["label"] = "Coke Block 01" },
					{ ["object"] = "prop_coke_block_half_a", ["price"] = 50, ["label"] = "Coke Block Half a" },
					{ ["object"] = "prop_coke_block_half_b", ["price"] = 50, ["label"] = "Coke Block Half B" },
					{ ["object"] = "ba_prop_battle_coke_block_01a", ["price"] = 50, ["label"] = "Coke Block 01a" },
					{ ["object"] = "bkr_prop_coke_bakingsoda", ["price"] = 50, ["label"] = "Coke Bakingsoda" },
					{ ["object"] = "bkr_prop_coke_bakingsoda_o", ["price"] = 50, ["label"] = "Coke Bakingsoda Open" },
					{ ["object"] = "bkr_prop_coke_bottle_01a", ["price"] = 50, ["label"] = "Coke Bottle 01a" },
					{ ["object"] = "bkr_prop_coke_box_01a", ["price"] = 50, ["label"] = "Coke Box 01a" },
					{ ["object"] = "bkr_prop_coke_cracktray_01", ["price"] = 50, ["label"] = "Coke Cracktry 01" },
					{ ["object"] = "bkr_prop_coke_cut_01", ["price"] = 50, ["label"] = "Coke Cut 01" },
					{ ["object"] = "bkr_prop_coke_cut_02", ["price"] = 50, ["label"] = "Coke Cut 02" },
					{ ["object"] = "bkr_prop_coke_cutblock_01", ["price"] = 50, ["label"] = "Coke Cutblock 01" },
					{ ["object"] = "bkr_prop_coke_dehydrator_01", ["price"] = 50, ["label"] = "Coke Degydrator 01" },
					{ ["object"] = "bkr_prop_coke_fullmetalbowl_02", ["price"] = 50, ["label"] = "Coke Fullmetalbowl 02" },
					{ ["object"] = "bkr_prop_coke_fullscoop_01a", ["price"] = 50, ["label"] = "Coke Fullscoop 01a" },
					{ ["object"] = "bkr_prop_coke_fullsieve_01a", ["price"] = 50, ["label"] = "Coke Fullsieve 01a" },
					{ ["object"] = "bkr_prop_coke_metalbowl_01", ["price"] = 50, ["label"] = "Coke Metalbowl 01" },
					{ ["object"] = "bkr_prop_coke_metalbowl_02", ["price"] = 50, ["label"] = "Coke Metalbowl 02" },
					{ ["object"] = "bkr_prop_coke_metalbowl_03", ["price"] = 50, ["label"] = "Coke Metalbowl 03" },
					{ ["object"] = "bkr_prop_coke_mixer_01", ["price"] = 50, ["label"] = "Coke Mixer 01" },
					{ ["object"] = "bkr_prop_coke_mold_01a", ["price"] = 50, ["label"] = "Coke Mold 01a" },
					{ ["object"] = "bkr_prop_coke_mold_02a", ["price"] = 50, ["label"] = "Coke Mold 02a" },
					{ ["object"] = "bkr_prop_coke_mortalpestle", ["price"] = 50, ["label"] = "Coke Mortalpestle" },
					{ ["object"] = "bkr_prop_coke_painkiller_01a", ["price"] = 50, ["label"] = "Coke Painkiller 01a" },
					{ ["object"] = "bkr_prop_coke_plasticbowl_01", ["price"] = 50, ["label"] = "Coke Plastic Bowl 01" },
					{ ["object"] = "bkr_prop_coke_powder_01", ["price"] = 50, ["label"] = "Coke Powder 01" },
					{ ["object"] = "bkr_prop_coke_powderbottle_01", ["price"] = 50, ["label"] = "Coke Powdered Bottle 01" },
					{ ["object"] = "bkr_prop_coke_powderbottle_02", ["price"] = 50, ["label"] = "Coke Powdered Bottle 02" },
					{ ["object"] = "bkr_prop_coke_powderedmilk", ["price"] = 50, ["label"] = "Coke Powdered Milk" },
					{ ["object"] = "bkr_prop_coke_powderedmilk_o", ["price"] = 50, ["label"] = "Coke Powdered Milk Open" },
					{ ["object"] = "bkr_prop_coke_press_01aa", ["price"] = 50, ["label"] = "Coke Press 01aa" },
					{ ["object"] = "bkr_prop_coke_press_01b", ["price"] = 50, ["label"] = "Coke Press 01b" },
					{ ["object"] = "bkr_prop_coke_scale_01", ["price"] = 50, ["label"] = "Coke Scale 01" },
					{ ["object"] = "bkr_prop_coke_scale_02", ["price"] = 50, ["label"] = "Coke Scale 02" },
					{ ["object"] = "bkr_prop_coke_scale_03", ["price"] = 50, ["label"] = "Coke Scale 03" },
					{ ["object"] = "bkr_prop_coke_spatula_04", ["price"] = 50, ["label"] = "Coke Spatula 04" },
					{ ["object"] = "bkr_prop_coke_spoon_01", ["price"] = 50, ["label"] = "Coke Spoon 01" },
					{ ["object"] = "bkr_prop_coke_testtubes", ["price"] = 50, ["label"] = "Coke Test Tubes" },
					{ ["object"] = "bkr_prop_coke_tin_01", ["price"] = 50, ["label"] = "Coke Tin 01" },
					{ ["object"] = "bkr_prop_coke_tub_01a", ["price"] = 50, ["label"] = "Coke Tub 01a" },
					{ ["object"] = "bkr_prop_coke_tube_01", ["price"] = 50, ["label"] = "Coke Tube 01" },
					{ ["object"] = "bkr_prop_coke_tube_02", ["price"] = 50, ["label"] = "Coke Tube 02" },
					{ ["object"] = "bkr_prop_coke_tube_03", ["price"] = 50, ["label"] = "Coke Tube 03" }
				}
			},
			{ ["object"] = "vw_prop_casino_art_bird_01a", ["price"] = 240, ["label"] = "Casino Art",
				["group_items"] = {
					{ ["object"] = "vw_prop_casino_art_bird_01a", ["price"] = 240, ["label"] = "Casino Art Bird 01a" },
					{ ["object"] = "vw_prop_casino_art_car_01a", ["price"] = 200, ["label"] = "Casino Art Car 01a" },
					{ ["object"] = "vw_prop_casino_art_car_02a", ["price"] = 200, ["label"] = "Casino Art Car 02a" },
					{ ["object"] = "vw_prop_casino_art_car_03a", ["price"] = 200, ["label"] = "Casino Art Car 03a" },
					{ ["object"] = "vw_prop_casino_art_car_04a", ["price"] = 200, ["label"] = "Casino Art Car 04a" },
					{ ["object"] = "vw_prop_casino_art_car_05a", ["price"] = 200, ["label"] = "Casino Art Car 05a" },
					{ ["object"] = "vw_prop_casino_art_car_06a", ["price"] = 200, ["label"] = "Casino Art Car 06a" },
					{ ["object"] = "vw_prop_casino_art_car_07a", ["price"] = 200, ["label"] = "Casino Art Car 07a" },
					{ ["object"] = "vw_prop_casino_art_car_08a", ["price"] = 200, ["label"] = "Casino Art Car 08a" },
					{ ["object"] = "vw_prop_casino_art_car_09a", ["price"] = 200, ["label"] = "Casino Art Car 09a" },
					{ ["object"] = "vw_prop_casino_art_car_10a", ["price"] = 200, ["label"] = "Casino Art Car 10a" },
					{ ["object"] = "vw_prop_casino_art_car_11a", ["price"] = 200, ["label"] = "Casino Art Car 11a" },
					{ ["object"] = "vw_prop_casino_art_car_12a", ["price"] = 200, ["label"] = "Casino Art Car 12a" },
					{ ["object"] = "vw_prop_casino_art_cherries_01a", ["price"] = 1850, ["label"] = "Casino Art Cherries 01a" },
					{ ["object"] = "vw_prop_casino_art_deer_01a", ["price"] = 1200, ["label"] = "Casino Art Deer 01a" },
					{ ["object"] = "vw_prop_casino_art_dog_01a", ["price"] = 650, ["label"] = "Casino Art Dog 01a" },
					{ ["object"] = "vw_prop_casino_art_egg_01a", ["price"] = 150, ["label"] = "Casino Art Egg 01a" },
					{ ["object"] = "vw_prop_casino_art_grenade_01a", ["price"] = 340, ["label"] = "Casino Art Grenade 01a" },
					{ ["object"] = "vw_prop_casino_art_grenade_01b", ["price"] = 340, ["label"] = "Casino Art Grenade 01b" },
					{ ["object"] = "vw_prop_casino_art_grenade_01c", ["price"] = 340, ["label"] = "Casino Art Grenade 01c" },
					{ ["object"] = "vw_prop_casino_art_grenade_01d", ["price"] = 340, ["label"] = "Casino Art Grenade 01d" },
					{ ["object"] = "vw_prop_casino_art_gun_01a", ["price"] = 2150, ["label"] = "Casino Art Gun 01a" },
					{ ["object"] = "vw_prop_casino_art_gun_02a", ["price"] = 4500, ["label"] = "Casino Art Gun 02a" },
					{ ["object"] = "vw_prop_casino_art_head_01a", ["price"] = 310, ["label"] = "Casino Art Head 01a" },
					{ ["object"] = "vw_prop_casino_art_head_01b", ["price"] = 310, ["label"] = "Casino Art Head 01b" },
					{ ["object"] = "vw_prop_casino_art_head_01c", ["price"] = 310, ["label"] = "Casino Art Head 01c" },
					{ ["object"] = "vw_prop_casino_art_head_01d", ["price"] = 310, ["label"] = "Casino Art Head 01d" },
					{ ["object"] = "vw_prop_casino_art_lollipop_01a", ["price"] = 1850, ["label"] = "Casino Art Lollipop 01a" },
					{ ["object"] = "vw_prop_casino_art_mod_01a", ["price"] = 1850, ["label"] = "Casino Art Mod 01a" },
					{ ["object"] = "vw_prop_casino_art_mod_02a", ["price"] = 350, ["label"] = "Casino Art Mod 02a" },
					{ ["object"] = "vw_prop_casino_art_mod_03a", ["price"] = 1730, ["label"] = "Casino Art Mod 03a" },
					{ ["object"] = "vw_prop_casino_art_mod_03a_a", ["price"] = 1730, ["label"] = "Casino Art Mod 03aa" },
					{ ["object"] = "vw_prop_casino_art_mod_03a_b", ["price"] = 1730, ["label"] = "Casino Art Mod 03ab" },
					{ ["object"] = "vw_prop_casino_art_mod_03a_c", ["price"] = 1730, ["label"] = "Casino Art Mod 03ac" },
					{ ["object"] = "vw_prop_casino_art_mod_03b", ["price"] = 1730, ["label"] = "Casino Art Mod 03b" },
					{ ["object"] = "vw_prop_casino_art_mod_03b_a", ["price"] = 1730, ["label"] = "Casino Art Mod 03ba" },
					{ ["object"] = "vw_prop_casino_art_mod_03b_b", ["price"] = 1730, ["label"] = "Casino Art Mod 03bb" },
					{ ["object"] = "vw_prop_casino_art_mod_03b_c", ["price"] = 1730, ["label"] = "Casino Art Mod 03bc" },
					{ ["object"] = "vw_prop_casino_art_mod_04a", ["price"] = 240, ["label"] = "Casino Art Mod 04a" },
					{ ["object"] = "vw_prop_casino_art_mod_04b", ["price"] = 240, ["label"] = "Casino Art Mod 04b" },
					{ ["object"] = "vw_prop_casino_art_mod_04c", ["price"] = 240, ["label"] = "Casino Art Mod 04c" },
					{ ["object"] = "vw_prop_casino_art_mod_05a", ["price"] = 480, ["label"] = "Casino Art Mod 05a" },
					{ ["object"] = "vw_prop_casino_art_mod_06a", ["price"] = 850, ["label"] = "Casino Art Mod 06a" },
					{ ["object"] = "vw_prop_casino_art_sh_01a", ["price"] = 490, ["label"] = "Casino Art SH 01a" },
					{ ["object"] = "vw_prop_casino_art_statue_04a", ["price"] = 1350, ["label"] = "Casino Art Statue 04a" },
					{ ["object"] = "vw_prop_casino_art_vase_01a", ["price"] = 680, ["label"] = "Casino Art Vase 01a" },
					{ ["object"] = "vw_prop_casino_art_vase_02a", ["price"] = 680, ["label"] = "Casino Art Vase 02a" },
					{ ["object"] = "vw_prop_casino_art_vase_03a", ["price"] = 680, ["label"] = "Casino Art Vase 03a" },
					{ ["object"] = "vw_prop_casino_art_vase_04a", ["price"] = 680, ["label"] = "Casino Art Vase 04a" },
					{ ["object"] = "vw_prop_casino_art_vase_05a", ["price"] = 680, ["label"] = "Casino Art Vase 05a" },
					{ ["object"] = "vw_prop_casino_art_vase_06a", ["price"] = 680, ["label"] = "Casino Art Vase 06a" },
					{ ["object"] = "vw_prop_casino_art_vase_07a", ["price"] = 680, ["label"] = "Casino Art Vase 07a" },
					{ ["object"] = "vw_prop_casino_art_vase_08a", ["price"] = 680, ["label"] = "Casino Art Vase 08a" },
					{ ["object"] = "vw_prop_casino_art_vase_09a", ["price"] = 680, ["label"] = "Casino Art Vase 09a" },
					{ ["object"] = "vw_prop_casino_art_vase_10a", ["price"] = 680, ["label"] = "Casino Art Vase 10a" },
					{ ["object"] = "vw_prop_casino_art_vase_11a", ["price"] = 680, ["label"] = "Casino Art Vase 11a" },
					{ ["object"] = "vw_prop_casino_art_vase_12a", ["price"] = 680, ["label"] = "Casino Art Vase 12a" },
					{ ["object"] = "vw_prop_art_football_01a", ["price"] = 1450, ["label"] = "Casino Art Vase 01a" },
					{ ["object"] = "vw_prop_art_mic_01a", ["price"] = 1450, ["label"] = "Casino Art Mic 01a" },
					{ ["object"] = "vw_prop_art_pug_01a", ["price"] = 870, ["label"] = "Casino Art Pug 01a" },
					{ ["object"] = "vw_prop_art_pug_01b", ["price"] = 870, ["label"] = "Casino Art Pug 01b" },
					{ ["object"] = "vw_prop_art_pug_02a", ["price"] = 870, ["label"] = "Casino Art Pug 02a" },
					{ ["object"] = "vw_prop_art_pug_02b", ["price"] = 870, ["label"] = "Casino Art Pug 02b" },
					{ ["object"] = "vw_prop_art_pug_03a", ["price"] = 870, ["label"] = "Casino Art Pug 03a" },
					{ ["object"] = "vw_prop_art_pug_03b", ["price"] = 870, ["label"] = "Casino Art Pug 03b" },
					{ ["object"] = "vw_prop_art_resin_balls_01a", ["price"] = 2450, ["label"] = "Casino Art Balls 01a" },
					{ ["object"] = "vw_prop_art_resin_guns_01a", ["price"] = 2450, ["label"] = "Casino Art Guns 01a" },
					{ ["object"] = "vw_prop_art_wall_segment_01a", ["price"] = 1700, ["label"] = "Casino Art Segment 01a" },
					{ ["object"] = "vw_prop_art_wall_segment_02a", ["price"] = 1700, ["label"] = "Casino Art Segment 02a" },
					{ ["object"] = "vw_prop_art_wall_segment_02b", ["price"] = 1700, ["label"] = "Casino Art Segment 02b" },
					{ ["object"] = "vw_prop_art_wall_segment_03a", ["price"] = 1700, ["label"] = "Casino Art Segment 03a" },
					{ ["object"] = "vw_prop_art_wings_01a", ["price"] = 4700, ["label"] = "Casino Art Wings 01a" },
					{ ["object"] = "vw_prop_art_wings_01b", ["price"] = 4700, ["label"] = "Casino Art Wings 01b" },
					{ ["object"] = "vw_prop_casino_art_basketball_01a", ["price"] = 630, ["label"] = "Casino Art Basketball 01a" },
					{ ["object"] = "vw_prop_casino_art_basketball_02a", ["price"] = 630, ["label"] = "Casino Art Basketball 02a" },
					{ ["object"] = "vw_prop_casino_art_absman_01a", ["price"] = 340, ["label"] = "Casino Art Absman 01a" },
					{ ["object"] = "vw_prop_casino_art_bottle_01a", ["price"] = 240, ["label"] = "Casino Art Bottle 01a" },
					{ ["object"] = "vw_prop_casino_art_bowling_01a", ["price"] = 240, ["label"] = "Casino Art Bowling 01a" },
					{ ["object"] = "vw_prop_casino_art_bowling_01b", ["price"] = 240, ["label"] = "Casino Art Bowling 01b" },
					{ ["object"] = "vw_prop_casino_art_bowling_02a", ["price"] = 240, ["label"] = "Casino Art Bowling 02a" },
					{ ["object"] = "vw_prop_casino_art_ego_01a", ["price"] = 350, ["label"] = "Casino Art EGO" },
					{ ["object"] = "vw_prop_casino_art_horse_01a", ["price"] = 240, ["label"] = "Casino Art Horse 01a" },
					{ ["object"] = "vw_prop_casino_art_horse_01b", ["price"] = 240, ["label"] = "Casino Art Horse 01b" },
					{ ["object"] = "vw_prop_casino_art_horse_01c", ["price"] = 240, ["label"] = "Casino Art Horse 01c" },
					{ ["object"] = "vw_prop_casino_art_panther_01a", ["price"] = 240, ["label"] = "Casino Art Panther 01a" },
					{ ["object"] = "vw_prop_casino_art_panther_01b", ["price"] = 240, ["label"] = "Casino Art Panther 01b" },
					{ ["object"] = "vw_prop_casino_art_panther_01c", ["price"] = 240, ["label"] = "Casino Art Panther 01c" },
					{ ["object"] = "vw_prop_casino_art_rocket_01a", ["price"] = 750, ["label"] = "Casino Art Rocket 01a" },
					{ ["object"] = "vw_prop_casino_art_v_01a", ["price"] = 840, ["label"] = "Casino Art V 01a" },
					{ ["object"] = "vw_prop_casino_art_v_01b", ["price"] = 420, ["label"] = "Casino Art V 01b" },
					{ ["object"] = "vw_prop_casino_art_statue_02a", ["price"] = 450, ["label"] = "Casino Art Statue 02a" },
					{ ["object"] = "vw_prop_casino_art_statue_01a", ["price"] = 450, ["label"] = "Casino Art Statue 01a" },
					{ ["object"] = "vw_prop_casino_art_concrete_01a", ["price"] = 240, ["label"] = "Casino Art Concrete 01" },
					{ ["object"] = "vw_prop_casino_art_console_01a", ["price"] = 240, ["label"] = "Casino Art Console 01a" },
					{ ["object"] = "vw_prop_casino_art_console_02a", ["price"] = 380, ["label"] = "Casino Art Console 02a" },
					{ ["object"] = "vw_prop_casino_art_miniature_05a", ["price"] = 450, ["label"] = "Casino Art Miniature 05a" },
					{ ["object"] = "vw_prop_casino_art_miniature_05b", ["price"] = 450, ["label"] = "Casino Art Miniature 05b" },
					{ ["object"] = "vw_prop_casino_art_miniature_05c", ["price"] = 450, ["label"] = "Casino Art Miniature 05c" },
					{ ["object"] = "vw_prop_casino_art_miniature_09a", ["price"] = 450, ["label"] = "Casino Art Miniature 09a" },
					{ ["object"] = "vw_prop_casino_art_miniature_09b", ["price"] = 450, ["label"] = "Casino Art Miniature 09b" },
					{ ["object"] = "vw_prop_casino_art_miniature_09c", ["price"] = 450, ["label"] = "Casino Art Miniature 09c" },
					{ ["object"] = "vw_prop_casino_art_sculpture_01a", ["price"] = 870, ["label"] = "Casino Art Sculpture 01a" },
					{ ["object"] = "vw_prop_casino_art_sculpture_02a", ["price"] = 870, ["label"] = "Casino Art Sculpture 02a" },
					{ ["object"] = "vw_prop_casino_art_sculpture_02b", ["price"] = 870, ["label"] = "Casino Art Sculpture 02b" },
					{ ["object"] = "vw_prop_casino_art_skull_01a", ["price"] = 450, ["label"] = "Casino Art Skull 01a" },
					{ ["object"] = "vw_prop_casino_art_skull_01b", ["price"] = 450, ["label"] = "Casino Art Skull 01b" },
					{ ["object"] = "vw_prop_casino_art_skull_02a", ["price"] = 450, ["label"] = "Casino Art Skull 02a" },
					{ ["object"] = "vw_prop_casino_art_skull_02b", ["price"] = 450, ["label"] = "Casino Art Skull 02b" },
					{ ["object"] = "vw_prop_casino_art_skull_03a", ["price"] = 450, ["label"] = "Casino Art Skull 03a" },
					{ ["object"] = "vw_prop_casino_art_skull_03b", ["price"] = 450, ["label"] = "Casino Art Skull 03b" }
				}
			},
			{ ["object"] = "prop_defilied_ragdoll_01", ["price"] = 5, ["label"] = "Defilied Ragdoll" },
			{ ["object"] = "prop_beware_dog_sign", ["price"] = 35, ["label"] = "Dog Sign" },
			{ ["object"] = "prop_t_telescope_01b", ["price"] = 475, ["label"] = "Telescope" },
			{ ["object"] = "vw_prop_vw_key_cabinet_01a", ["price"] = 150, ["label"] = "Key Cabinet" },
			{ ["object"] = "ex_office_citymodel_01", ["price"] = 150, ["label"] = "City model 01" },
		},
	},
}
