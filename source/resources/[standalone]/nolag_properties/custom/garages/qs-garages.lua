--[[ 
    Within this section, you'll discover the setup details for the chosen garage.
    If your system isn't listed here, feel free to reach out to the garage creator
    and request the inclusion of its exports in any of these files. Alternatively,
    you can utilize these files to generate your own configuration, which would greatly
    benefit our community.
]]

if Config.Garage ~= "qs-garages" then
    return
end


Config.Functions["OpenGarageMenu"] = {
    type = "outside", -- inside or outside
    fixedZ = true,
    maxPerProperty = 1, -- The maximum amount of garage menu's per property
    radius = 2.0, -- The radius of the interaction
    requireKeys = true, -- If the player needs to have keys to interact with the interaction
    label = "Garage Menu",
    onExit = function(property)
        TriggerEvent('qs-garages:setHouseGarage', 0, false)
    end,
    onEnter = function(property)
        if property.metadata.lockdown and Config.PoliceLockdown.DisableGarage then
            -- Framework.Notify({
            --     description = locale("property_under_police_lockdown"),
            --     type = "error"
            -- })
            return
        end
        TriggerEvent('qs-garages:setHouseGarage', property.id, property:hasKey())
    end,
    onCreate = function (property, point)
        TriggerEvent("qs-garages:addHouseGarage", property.id, {
            takeVehicle = {
                x = point.x,
                y = point.y,
                z = point.z
            },
            label = property.label,
        })
    end
}