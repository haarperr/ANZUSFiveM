--[[ 
    Greetings, esteemed developer! If you're reading this, you're probably curious about the functioning of this
    automated insertion system. It's incredibly straightforward. Just follow the same syntax as the provided examples
    to populate your furniture and append the insertFurniture function at the conclusion of this document.
    This process will enable you to add individual items or groups to the Furnitures table.

    Furthermore, you have the option to enhance the visibility of your furniture by incorporating a distinct color!
]]

if GetResourceState('PataOfficeClassic_props') ~= 'started' then
    return
end

CreateThread(function()
    local Pata_OfficeClassic_decals = {
        {
            ["object"] = "pata_officeclassic10", ["price"] = 700, ["label"] = "Pata Office 10", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_officeclassic10", ["price"] = 900, ["label"] = "Pata Office 10", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic11", ["price"] = 900, ["label"] = "Pata Office 11", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic12", ["price"] = 900, ["label"] = "Pata Office 12", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic15", ["price"] = 900, ["label"] = "Pata Office 15", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic16", ["price"] = 900, ["label"] = "Pata Office 16", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    local Pata_OfficeClassic_chairs = {
        {
            ["object"] = "pata_officeclassic6", ["price"] = 700, ["label"] = "Pata Office 06", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_officeclassic6", ["price"] = 900, ["label"] = "Pata Office 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic7", ["price"] = 900, ["label"] = "Pata Office 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic9", ["price"] = 900, ["label"] = "Pata Office 09", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic21", ["price"] = 900, ["label"] = "Pata Office 21", ["background"] = "rgba(162, 16, 230, 0.17)" },


			}
        }
    }

    local Pata_OfficeClassic_sideboards = {
        {
            ["object"] = "pata_officeclassic4", ["price"] = 700, ["label"] = "Pata Office 04", ["background"] = "rgba(162, 16, 230, 0.17)",
            ["group_items"] = {
                { ["object"] = "pata_officeclassic4", ["price"] = 900, ["label"] = "Pata Office 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic5", ["price"] = 900, ["label"] = "Pata Office 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic13", ["price"] = 900, ["label"] = "Pata Office 13", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic17", ["price"] = 900, ["label"] = "Pata Office 17", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic18", ["price"] = 900, ["label"] = "Pata Office 18", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic19", ["price"] = 900, ["label"] = "Pata Office 19", ["background"] = "rgba(162, 16, 230, 0.17)" },
            }
        }
    }

    local Pata_OfficeClassic_tables = {
        {
            ["object"] = "pata_officeclassic1", ["price"] = 700, ["label"] = "Pata Office 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_officeclassic1", ["price"] = 900, ["label"] = "Pata Office 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic2", ["price"] = 900, ["label"] = "Pata Office 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic3", ["price"] = 900, ["label"] = "Pata Office 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    local Pata_valentinesday_trashcans = {
        {
            ["object"] = "pata_officeclassic23", ["price"] = 15, ["label"] = "Pata Office 23", ["background"] = "rgba(162, 16, 230, 0.17)"
        }
    } 

    local Pata_OfficeClassic_wardrobes = {
        {
            ["object"] = "pata_officeclassic14", ["price"] = 700, ["label"] = "Pata Office 14", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_officeclassic14", ["price"] = 900, ["label"] = "Pata Office 14", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic8", ["price"] = 900, ["label"] = "Pata Office 08", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic20", ["price"] = 900, ["label"] = "Pata Office 20", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_officeclassic22", ["price"] = 900, ["label"] = "Pata Office 22", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    insertFurniture(FurnitureConfig.Furniture.decals, Pata_OfficeClassic_decals)
    insertFurniture(FurnitureConfig.Furniture.chairs, Pata_OfficeClassic_chairs)
    insertFurniture(FurnitureConfig.Furniture.sideboards, Pata_OfficeClassic_sideboards)
    insertFurniture(FurnitureConfig.Furniture.trashcans, Pata_valentinesday_trashcans)
    insertFurniture(FurnitureConfig.Furniture.tables, Pata_OfficeClassic_tables)
    insertFurniture(FurnitureConfig.Furniture.wardrobes, Pata_OfficeClassic_wardrobes)
end)