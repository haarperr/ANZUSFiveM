--[[ 
    Greetings, esteemed developer! If you're reading this, you're probably curious about the functioning of this
    automated insertion system. It's incredibly straightforward. Just follow the same syntax as the provided examples
    to populate your furniture and append the insertFurniture function at the conclusion of this document.
    This process will enable you to add individual items or groups to the Furnitures table.

    Furthermore, you have the option to enhance the visibility of your furniture by incorporating a distinct color!
]]

if GetResourceState('lunaticstudio_props') ~= 'started' then
    return
end


CreateThread(function()
    local lunaticstudio_promo001_beds = {
        {
            ["object"] = "ls_quasar_bed1_a", ["price"] = 1450, ["label"] = "Quasar Bed A", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_bed1_a", ["price"] = 1450, ["label"] = "Quasar Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_b", ["price"] = 1450, ["label"] = "Quasar White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_c", ["price"] = 1450, ["label"] = "Quasar Black/white", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_d", ["price"] = 1450, ["label"] = "Quasar White/Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_e", ["price"] = 1450, ["label"] = "Quasar Green/White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_f", ["price"] = 1450, ["label"] = "Quasar Red/White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_g", ["price"] = 1450, ["label"] = "Quasar Blue/White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed1_h", ["price"] = 1450, ["label"] = "Quasar Gray/White", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        },
        {
            ["object"] = "ls_quasar_bed2_a", ["price"] = 1450, ["label"] = "Quasar Bed B", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_bed2_a", ["price"] = 1450, ["label"] = "Quasar Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_b", ["price"] = 1450, ["label"] = "Quasar Green", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_c", ["price"] = 1450, ["label"] = "Quasar Red", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_d", ["price"] = 1450, ["label"] = "Quasar Nude", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_e", ["price"] = 1450, ["label"] = "Quasar Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_f", ["price"] = 1450, ["label"] = "Quasar White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_g", ["price"] = 1450, ["label"] = "Quasar Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_bed2_h", ["price"] = 1450, ["label"] = "Quasar Green", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        }
    }

    local lunaticstudio_promo001_sideboards = {
        {
            ["object"] = "ls_quasar_endt1_a", ["price"] = 1450, ["label"] = "Quasar End Table", ["background"] = "rgba(16, 169, 230, 0.17)",
            ["group_items"] = {
				{ ["object"] = "ls_quasar_endt1_a", ["price"] = 1450, ["label"] = "Quasar End Table Green Navy", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_b", ["price"] = 1450, ["label"] = "Quasar End Table Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_c", ["price"] = 1450, ["label"] = "Quasar End Table Light Green", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_d", ["price"] = 1450, ["label"] = "Quasar End Table Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_e", ["price"] = 1450, ["label"] = "Quasar End Table Nude", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_f", ["price"] = 1450, ["label"] = "Quasar End Table Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_g", ["price"] = 1450, ["label"] = "Quasar End Table Red", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_h", ["price"] = 1450, ["label"] = "Quasar End Table Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_endt1_i", ["price"] = 1450, ["label"] = "Quasar End Table White", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        },
        {
            ["object"] = "ls_quasar_book1_a", ["price"] = 1450, ["label"] = "Quasar Bookshelf", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_book1_a", ["price"] = 1450, ["label"] = "Quasar BookShelf Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_b", ["price"] = 1450, ["label"] = "Quasar BookShelf Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_c", ["price"] = 1450, ["label"] = "Quasar BookShelf White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_d", ["price"] = 1450, ["label"] = "Quasar BookShelf Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_e", ["price"] = 1450, ["label"] = "Quasar BookShelf Nude", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_f", ["price"] = 1450, ["label"] = "Quasar BookShelf Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_g", ["price"] = 1450, ["label"] = "Quasar BookShelf Green Navy", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_h", ["price"] = 1450, ["label"] = "Quasar BookShelf Green Light", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_book1_i", ["price"] = 1450, ["label"] = "Quasar BookShelf Red", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        },
    }

    local lunaticstudio_promo001_tables = {
        {
            ["object"] = "ls_quasar_ctal1_a", ["price"] = 1450, ["label"] = "Quasar Coffee Table", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_ctal1_a", ["price"] = 1450, ["label"] = "Quasar Coffee Table Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_b", ["price"] = 1450, ["label"] = "Quasar Coffee Table Green Navy", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_c", ["price"] = 1450, ["label"] = "Quasar Coffee Table Green Light", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_d", ["price"] = 1450, ["label"] = "Quasar Coffee Table Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_e", ["price"] = 1450, ["label"] = "Quasar Coffee Table Red", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_f", ["price"] = 1450, ["label"] = "Quasar Coffee Table Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_g", ["price"] = 1450, ["label"] = "Quasar Coffee Table White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_h", ["price"] = 1450, ["label"] = "Quasar Coffee Table Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ctal1_i", ["price"] = 1450, ["label"] = "Quasar Coffee Table Nude", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        }
    }

    local lunaticstudio_promo001_sofas = {
        {
            ["object"] = "ls_quasar_lsea1_a", ["price"] = 1450, ["label"] = "Quasar Love Seat Left", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_lsea1_a", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Nude", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_b", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_c", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_d", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_e", ["price"] = 1450, ["label"] = "Quasar Love Seat Left White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_f", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Green", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_g", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_h", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Red", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea1_i", ["price"] = 1450, ["label"] = "Quasar Love Seat Left Green Navy", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        },
        {
            ["object"] = "ls_quasar_lsea2_a", ["price"] = 1450, ["label"] = "Quasar Love Seat Right", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_lsea2_a", ["price"] = 1450, ["label"] = "Quasar Love Seat Right white", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_b", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Green", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_c", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_d", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_e", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_f", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Nude", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_g", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_h", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Green Navy", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_lsea2_i", ["price"] = 1450, ["label"] = "Quasar Love Seat Right Red", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        }
    }

    local lunaticstudio_promo001_electronics = {
        {
            ["object"] = "ls_quasar_ster1_a", ["price"] = 1450, ["label"] = "Quasar Stereo", ["background"] = "rgba(16, 169, 230, 0.17)",
			["group_items"] = {
				{ ["object"] = "ls_quasar_ster1_a", ["price"] = 1450, ["label"] = "Quasar Stereo Black", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_b", ["price"] = 1450, ["label"] = "Quasar Stereo Brown", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_c", ["price"] = 1450, ["label"] = "Quasar Stereo White", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_d", ["price"] = 1450, ["label"] = "Quasar Stereo Green", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_e", ["price"] = 1450, ["label"] = "Quasar Stereo Blue", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_f", ["price"] = 1450, ["label"] = "Quasar Stereo Nude", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_g", ["price"] = 1450, ["label"] = "Quasar Stereo Gray", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_h", ["price"] = 1450, ["label"] = "Quasar Stereo Red", ["background"] = "rgba(16, 169, 230, 0.17)" },
				{ ["object"] = "ls_quasar_ster1_i", ["price"] = 1450, ["label"] = "Quasar Stereo Green Navy", ["background"] = "rgba(16, 169, 230, 0.17)" }
			}
        }
    }

    insertFurniture(FurnitureConfig.Furniture.beds, lunaticstudio_promo001_beds)
    insertFurniture(FurnitureConfig.Furniture.sideboards, lunaticstudio_promo001_sideboards)
    insertFurniture(FurnitureConfig.Furniture.tables, lunaticstudio_promo001_tables)
    insertFurniture(FurnitureConfig.Furniture.sofas, lunaticstudio_promo001_sofas)
    insertFurniture(FurnitureConfig.Furniture.electronics, lunaticstudio_promo001_electronics)
end)