--[[ 
    Greetings, esteemed developer! If you're reading this, you're probably curious about the functioning of this
    automated insertion system. It's incredibly straightforward. Just follow the same syntax as the provided examples
    to populate your furniture and append the insertFurniture function at the conclusion of this document.
    This process will enable you to add individual items or groups to the Furnitures table.

    Furthermore, you have the option to enhance the visibility of your furniture by incorporating a distinct color!
]]

if GetResourceState('PataValaentinesDay_props') ~= 'started' then
    return
end

CreateThread(function()
    local Pata_valentinesday_decals = {
        {
            ["object"] = "pata_valentine2", ["price"] = 50, ["label"] = "Pata Valentine 02", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "pata_valentine2", ["price"] = 50, ["label"] = "Pata Valentine 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine3", ["price"] = 50, ["label"] = "Pata Valentine 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine4", ["price"] = 50, ["label"] = "Pata Valentine 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine6", ["price"] = 50, ["label"] = "Pata Valentine 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine7", ["price"] = 50, ["label"] = "Pata Valentine 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine8", ["price"] = 50, ["label"] = "Pata Valentine 08", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine9", ["price"] = 50, ["label"] = "Pata Valentine 09", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine10", ["price"] = 50, ["label"] = "Pata Valentine 10", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine11", ["price"] = 50, ["label"] = "Pata Valentine 11", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine12", ["price"] = 50, ["label"] = "Pata Valentine 12", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "pata_valentine13", ["price"] = 50, ["label"] = "Pata Valentine 13", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    local Pata_valentinesday_beds = {
        {
            ["object"] = "pata_valentine5", ["price"] = 1600, ["label"] = "Pata Valentine 05", ["background"] = "rgba(162, 16, 230, 0.17)",
        }
    } 

    local Pata_valentinesday_showers = {
        {
            ["object"] = "pata_valentine", ["price"] = 1600, ["label"] = "Pata Valentine 01", ["background"] = "rgba(162, 16, 230, 0.17)",
        }
    } 

    insertFurniture(FurnitureConfig.Furniture.decals, Pata_valentinesday_decals)
    insertFurniture(FurnitureConfig.Furniture.beds, Pata_valentinesday_beds)
    insertFurniture(FurnitureConfig.Furniture.showers, Pata_valentinesday_showers)
end)