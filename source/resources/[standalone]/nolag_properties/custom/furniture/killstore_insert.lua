--[[ 
    Greetings, esteemed developer! If you're reading this, you're probably curious about the functioning of this
    automated insertion system. It's incredibly straightforward. Just follow the same syntax as the provided examples
    to populate your furniture and append the insertFurniture function at the conclusion of this document.
    This process will enable you to add individual items or groups to the Furnitures table.

    Furthermore, you have the option to enhance the visibility of your furniture by incorporating a distinct color!
]]

if GetResourceState('KillstorexQuasar_props') ~= 'started' then
    return
end

CreateThread(function()
    insertFurnitureCategory("killstore", "Killstore")
    Wait(500)
end)

CreateThread(function()

    local killstore_anime = {
        {
            ["object"] = "ks_anime_shelf01", ["price"] = 150, ["label"] = "Anime Shelf 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_anime_shelf01", ["price"] = 150, ["label"] = "Anime Shelf 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_anime_shelf02", ["price"] = 150, ["label"] = "Anime Shelf 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_anime_shelf03", ["price"] = 150, ["label"] = "Anime Shelf 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_anime_shelf04", ["price"] = 150, ["label"] = "Anime Shelf 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_anime_shelf05", ["price"] = 150, ["label"] = "Anime Shelf 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    }

    local killstore_chair = {
        {
            ["object"] = "ks_gaming_chair01", ["price"] = 320, ["label"] = "Gaming Chair 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_gaming_chair01", ["price"] = 320, ["label"] = "Gaming Chair 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair02", ["price"] = 320, ["label"] = "Gaming Chair 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair03", ["price"] = 320, ["label"] = "Gaming Chair 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair04", ["price"] = 320, ["label"] = "Gaming Chair 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair05", ["price"] = 320, ["label"] = "Gaming Chair 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair06", ["price"] = 320, ["label"] = "Gaming Chair 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair07", ["price"] = 320, ["label"] = "Gaming Chair 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair08", ["price"] = 320, ["label"] = "Gaming Chair 08", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair09", ["price"] = 320, ["label"] = "Gaming Chair 09", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_chair10", ["price"] = 320, ["label"] = "Gaming Chair 10", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_deck = {
        {
            ["object"] = "ks_gaming_desk01", ["price"] = 320, ["label"] = "Gaming Deck 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_gaming_desk01", ["price"] = 320, ["label"] = "Gaming Deck 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk02", ["price"] = 320, ["label"] = "Gaming Deck 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk03", ["price"] = 320, ["label"] = "Gaming Deck 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk04", ["price"] = 320, ["label"] = "Gaming Deck 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk05", ["price"] = 320, ["label"] = "Gaming Deck 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk06", ["price"] = 320, ["label"] = "Gaming Deck 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk07", ["price"] = 320, ["label"] = "Gaming Deck 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_desk08", ["price"] = 320, ["label"] = "Gaming Deck 08", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_panels = {
        {
            ["object"] = "ks_gaming_panels01", ["price"] = 320, ["label"] = "Gaming Deck 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_gaming_panels01", ["price"] = 320, ["label"] = "Gaming Deck 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels02", ["price"] = 320, ["label"] = "Gaming Deck 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels03", ["price"] = 320, ["label"] = "Gaming Deck 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels04", ["price"] = 320, ["label"] = "Gaming Deck 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels05", ["price"] = 320, ["label"] = "Gaming Deck 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels06", ["price"] = 320, ["label"] = "Gaming Deck 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels07", ["price"] = 320, ["label"] = "Gaming Deck 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels08", ["price"] = 320, ["label"] = "Gaming Deck 08", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_gaming_panels09", ["price"] = 320, ["label"] = "Gaming Deck 09", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_bar = {
        {
            ["object"] = "ks_modern_bar01", ["price"] = 320, ["label"] = "Modern Bar 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_modern_bar01", ["price"] = 320, ["label"] = "Modern Bar 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_bar02", ["price"] = 320, ["label"] = "Modern Bar 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_bar03", ["price"] = 320, ["label"] = "Modern Bar 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_bar04", ["price"] = 320, ["label"] = "Modern Bar 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_bar05", ["price"] = 320, ["label"] = "Modern Bar 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_bar06", ["price"] = 320, ["label"] = "Modern Bar 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_dresser = {
        {
            ["object"] = "ks_modern_dresser01", ["price"] = 320, ["label"] = "Modern Dresser 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_modern_dresser01", ["price"] = 320, ["label"] = "Modern Dresser 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_dresser02", ["price"] = 320, ["label"] = "Modern Dresser 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_dresser03", ["price"] = 320, ["label"] = "Modern Dresser 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_dresser04", ["price"] = 320, ["label"] = "Modern Dresser 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_dresser05", ["price"] = 320, ["label"] = "Modern Dresser 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_dresser06", ["price"] = 320, ["label"] = "Modern Dresser 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_fireplace = {
        {
            ["object"] = "ks_modern_fireplace01", ["price"] = 320, ["label"] = "Modern Fireplace 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_modern_fireplace01", ["price"] = 320, ["label"] = "Modern Fireplace 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_fireplace02", ["price"] = 320, ["label"] = "Modern Fireplace 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_fireplace03", ["price"] = 320, ["label"] = "Modern Fireplace 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_puf = {
        {
            ["object"] = "ks_modern_puf01", ["price"] = 320, ["label"] = "Modern Puf 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_modern_puf01", ["price"] = 320, ["label"] = "Modern Puf 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_puf02", ["price"] = 320, ["label"] = "Modern Puf 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_puf03", ["price"] = 320, ["label"] = "Modern Puf 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_puf04", ["price"] = 320, ["label"] = "Modern Puf 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_puf05", ["price"] = 320, ["label"] = "Modern Puf 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_puf06", ["price"] = 320, ["label"] = "Modern Puf 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_wardrobe = {
        {
            ["object"] = "ks_modern_wardrobe00", ["price"] = 320, ["label"] = "Modern Wardrobe 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_modern_wardrobe01", ["price"] = 320, ["label"] = "Modern Wardrobe 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_wardrobe02", ["price"] = 320, ["label"] = "Modern Wardrobe 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_wardrobe03", ["price"] = 320, ["label"] = "Modern Wardrobe 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_modern_wardrobe04", ["price"] = 320, ["label"] = "Modern Wardrobe 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    local killstore_mirror = {
        {
            ["object"] = "ks_wave_mirror01", ["price"] = 320, ["label"] = "Modern Mirror 01", ["background"] = "rgba(162, 16, 230, 0.17)",
			["group_items"] = {
                { ["object"] = "ks_wave_mirror01", ["price"] = 320, ["label"] = "Modern Mirror 01", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror02", ["price"] = 320, ["label"] = "Modern Mirror 02", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror03", ["price"] = 320, ["label"] = "Modern Mirror 03", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror04", ["price"] = 320, ["label"] = "Modern Mirror 04", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror05", ["price"] = 320, ["label"] = "Modern Mirror 05", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror06", ["price"] = 320, ["label"] = "Modern Mirror 06", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror07", ["price"] = 320, ["label"] = "Modern Mirror 07", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror08", ["price"] = 320, ["label"] = "Modern Mirror 08", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror09", ["price"] = 320, ["label"] = "Modern Mirror 09", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror10", ["price"] = 320, ["label"] = "Modern Mirror 10", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror11", ["price"] = 320, ["label"] = "Modern Mirror 11", ["background"] = "rgba(162, 16, 230, 0.17)" },
                { ["object"] = "ks_wave_mirror12", ["price"] = 320, ["label"] = "Modern Mirror 12", ["background"] = "rgba(162, 16, 230, 0.17)" },
			}
        }
    } 

    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_anime)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_chair)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_deck)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_panels)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_bar)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_dresser)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_fireplace)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_puf)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_wardrobe)
    insertFurniture(FurnitureConfig.Furniture.killstore, killstore_mirror)
end)