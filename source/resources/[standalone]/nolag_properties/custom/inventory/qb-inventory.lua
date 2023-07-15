--[[ 
    Provided below is the stash configuration, allowing you to make
    adjustments or create your own. If your inventory is not included,
    you have the option to request the creator to generate a file based
    on this example and include it.
]]

if Config.Inventory ~= "qb-inventory" then
    return
end

Config.Functions["OpenInventory"] = {
    type = "inside", -- inside or outside
    maxPerProperty = 1, -- The maximum amount of inventory menu's per property
    radius = 1.0, -- The radius of the interaction
    label = "Inventory",
    icon = "fas fa-box-open",
    onSelect = function(property)
        if property.metadata.lockdown and Config.PoliceLockdown.DisableInventory then
            Framework.Notify({
                description = locale("property_under_police_lockdown"),
                type = "error"
            })
            return
        end
        local slots, weight = property:GetInventoryData()
        local others = {
            maxweight = weight,
            slots = slots
        }
        TriggerServerEvent("inventory:server:OpenInventory", "stash", 'Housing_' .. property.id, others)
        TriggerEvent("inventory:client:SetCurrentStash", 'Housing_' .. property.id)
    end,
}