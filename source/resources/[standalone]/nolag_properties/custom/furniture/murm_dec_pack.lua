--[[ 
    Greetings, esteemed developer! If you're reading this, you're probably curious about the functioning of this
    automated insertion system. It's incredibly straightforward. Just follow the same syntax as the provided examples
    to populate your furniture and append the insertFurniture function at the conclusion of this document.
    This process will enable you to add individual items or groups to the Furnitures table.

    Furthermore, you have the option to enhance the visibility of your furniture by incorporating a distinct color!
]]

if GetResourceState('murm_dec_pack_props') ~= 'started' then
    return
end


CreateThread(function()
    local murm_dec_pack_sideboards = {
        {
            ["object"] = "gcom_dec_pack_bathcab", ["price"] = 500, ["label"] = "GCOM Bathcab", ["background"] = "rgba(199, 32, 55, 0.17)"
        },
        {
            ["object"] = "gcom_dec_pack_cabinet", ["price"] = 50, ["label"] = "GCOM Cabinet 01", ["background"] = "rgba(199, 32, 55, 0.17)"
        },
        {
            ["object"] = "gcom_dec_pack_cabinet_2", ["price"] = 50, ["label"] = "GCOM Cabinet 02", ["background"] = "rgba(199, 32, 55, 0.17)"
        },
        {
            ["object"] = "gcom_dec_pack_table_1", ["price"] = 50, ["label"] = "GCOM Table 01", ["background"] = "rgba(199, 32, 55, 0.17)"
        },
        {
            ["object"] = "murm_dec_pack_dresser", ["price"] = 50, ["label"] = "GCOM Dresser", ["background"] = "rgba(199, 32, 55, 0.17)"
        }
    }

    local murm_dec_pack_tables = {
        {
            ["object"] = "gcom_dec_pack_table_2", ["price"] = 50, ["label"] = "GCOM Table 02", ["background"] = "rgba(199, 32, 55, 0.17)"
        },
        {
            ["object"] = "murm_dec_pack_table", ["price"] = 50, ["label"] = "GCOM Table 01", ["background"] = "rgba(199, 32, 55, 0.17)"
        }
    }

    local murm_dec_pack_wardrobes = {
        {
            ["object"] = "gcom_dec_pack_wardrobe_1", ["price"] = 50, ["label"] = "GCOM Wardrobe 01", ["background"] = "rgba(199, 32, 55, 0.17)",
			["group_items"] = {
                { ["object"] = "gcom_dec_pack_wardrobe_1", ["price"] = 50, ["label"] = "GCOM Wardrobe 01", ["background"] = "rgba(199, 32, 55, 0.17)" },
                { ["object"] = "gcom_dec_pack_wardrobe_1", ["price"] = 50, ["label"] = "GCOM Wardrobe 02", ["background"] = "rgba(199, 32, 55, 0.17)" },
                { ["object"] = "gcom_dec_pack_wardrobe_2", ["price"] = 50, ["label"] = "GCOM Wardrobe 03", ["background"] = "rgba(199, 32, 55, 0.17)" },
                { ["object"] = "murm_dec_pack_cabinet", ["price"] = 50, ["label"] = "GCOM Cabinet", ["background"] = "rgba(199, 32, 55, 0.17)" },
			},
        },
        {
            ["object"] = "gcom_dec_pack_wall", ["price"] = 50, ["label"] = "GCOM Wall", ["background"] = "rgba(199, 32, 55, 0.17)"
        }
    }

    local murm_dec_pack_chairs = {
        {
            ["object"] = "murm_dec_pack_chair_1", ["price"] = 50, ["label"] = "GCOM Chair 01", ["background"] = "rgba(199, 32, 55, 0.17)"
        },
        {
            ["object"] = "murm_dec_pack_chair_2", ["price"] = 50, ["label"] = "GCOM Chair 02", ["background"] = "rgba(199, 32, 55, 0.17)"
        }
    }

    local murm_dec_pack_sofas = {
        {
            ["object"] = "murm_dec_pack_sofa", ["price"] = 50, ["label"] = "GCOM Sofa", ["background"] = "rgba(199, 32, 55, 0.17)"
        }
    }

    insertFurniture(FurnitureConfig.Furniture.tables, murm_dec_pack_tables)
    insertFurniture(FurnitureConfig.Furniture.sideboards, murm_dec_pack_sideboards)
    insertFurniture(FurnitureConfig.Furniture.wardrobes, murm_dec_pack_wardrobes)
    insertFurniture(FurnitureConfig.Furniture.chairs, murm_dec_pack_chairs)
    insertFurniture(FurnitureConfig.Furniture.sofas, murm_dec_pack_sofas)
end)