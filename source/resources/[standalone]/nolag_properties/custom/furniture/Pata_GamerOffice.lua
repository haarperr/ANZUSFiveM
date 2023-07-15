--[[ 
    Greetings, esteemed developer! If you're reading this, you're probably curious about the functioning of this
    automated insertion system. It's incredibly straightforward. Just follow the same syntax as the provided examples
    to populate your furniture and append the insertFurniture function at the conclusion of this document.
    This process will enable you to add individual items or groups to the Furnitures table.

    Furthermore, you have the option to enhance the visibility of your furniture by incorporating a distinct color!
]]

if GetResourceState('PataGamerOffice_props') ~= 'started' then
    return
end


CreateThread(function()
    local Pata_GamerOffice_electronics = {
        {
            ["object"] = "pata_office1", ["price"] = 700, ["label"] = "Pata Gamer 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_office1", ["price"] = 900, ["label"] = "Pata Gamer 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office2", ["price"] = 900, ["label"] = "Pata Gamer 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office4", ["price"] = 900, ["label"] = "Pata Gamer 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office5", ["price"] = 900, ["label"] = "Pata Gamer 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office7", ["price"] = 900, ["label"] = "Pata Gamer 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office9", ["price"] = 900, ["label"] = "Pata Gamer 09", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    local Pata_GamerOffice_chairs = {
        {
            ["object"] = "pata_office3", ["price"] = 700, ["label"] = "Pata Gamer 03", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_office3", ["price"] = 900, ["label"] = "Pata Gamer 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office6", ["price"] = 900, ["label"] = "Pata Gamer 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    local Pata_GamerOffice_lamps = {
        {
            ["object"] = "pata_office8", ["price"] = 900, ["label"] = "Pata Gamer 08", ["background"] = "rgba(162, 16, 230, 0.17)",
        }
    }

    local Pata_GamerOffice_tables = {
        {
            ["object"] = "pata_office10", ["price"] = 900, ["label"] = "Pata Gamer 10", ["background"] = "rgba(162, 16, 230, 0.17)",
        }
    }

    local Pata_GamerOffice_walldecoration = {
        {
            ["object"] = "pata_office11", ["price"] = 700, ["label"] = "Pata Gamer 11", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_office11", ["price"] = 900, ["label"] = "Pata Gamer 11", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_office12", ["price"] = 900, ["label"] = "Pata Gamer 12", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    insertFurniture(FurnitureConfig.Furniture.electronics, Pata_GamerOffice_electronics)
    insertFurniture(FurnitureConfig.Furniture.chairs, Pata_GamerOffice_chairs)
    insertFurniture(FurnitureConfig.Furniture.lamps, Pata_GamerOffice_lamps)
    insertFurniture(FurnitureConfig.Furniture.tables, Pata_GamerOffice_tables)
    insertFurniture(FurnitureConfig.Furniture.walldecoration, Pata_GamerOffice_walldecoration)
end)