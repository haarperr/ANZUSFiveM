--[[ 
    Within this section, you'll discover the setup details for the chosen garage.
    If your system isn't listed here, feel free to reach out to the garage creator
    and request the inclusion of its exports in any of these files. Alternatively,
    you can utilize these files to generate your own configuration, which would greatly
    benefit our community.
]]

if Config.Garage ~= "jg-advancedgarages" then
    return
end


Config.Functions["OpenGarageMenu"] = {
    type = "outside", -- inside or outside
    zone = true, -- If the interaction is a zone or ox_target
    fixedZ = true, -- If the interaction should be fixed on the z axis (Player's height)
    maxPerProperty = 1, -- The maximum amount of garage menu's per property
    radius = 2.0, -- The radius of the interaction
    requireKeys = true, -- If the player needs to have keys to interact with the interaction
    label = "Garage Menu",
    icon = "fas fa-car",
    onSelect = function(property)
        if property.metadata.lockdown and Config.PoliceLockdown.DisableGarage then
            Framework.Notify({
                description = locale("property_under_police_lockdown"),
                type = "error"
            })
            return
        end
        if cache.vehicle then
            TriggerEvent('jg-advancedgarages:client:InsertVehicle', property.id, true)
        else
            TriggerEvent('jg-advancedgarages:client:ShowHouseGarage:qs-housing', property.id)
        end
    end,
}