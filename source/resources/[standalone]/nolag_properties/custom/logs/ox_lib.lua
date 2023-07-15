--[[
    Provided below is the log configuration, allowing you to make adjustments or create your own.
    If your log sources are not included, you have the option to request the creator to generate
    a file based on this example and include it.
]]

if Config.Logs ~= "ox_lib" then return end

Logs = {
  CreateProperty = function(playerId, propertyId, propertyType, propertyLabel, propertyPrice)
    lib.logger(playerId, "CreateProperty", locale("logs_created_property", playerId, propertyId, propertyType, propertyLabel, propertyPrice))
  end,
  DeleteProperty = function(playerId, propertyId, propertyType, propertyLabel)
    lib.logger(playerId, "DeleteProperty", locale("logs_deleted_property", playerId, propertyId, propertyType, propertyLabel))
  end,
  CreateBuilding = function(playerId, buildingId, buildingLabel, buildingCoords)
    lib.logger(playerId, "CreateBuilding", locale("logs_created_building", playerId, buildingId, buildingLabel, buildingCoords))
  end,
  DeleteBuilding = function(playerId, buildingId, buildingLabel, buildingCoords)
    lib.logger(playerId, "DeleteBuilding", locale("logs_deleted_building", playerId, buildingId, buildingLabel, buildingCoords))
  end,
  BuyProperty = function(playerId, propertyId, propertyPrice, propertyLabel)
    lib.logger(playerId, "BuyProperty", locale("logs_bought_property", playerId, propertyId, propertyPrice, propertyLabel))
  end,
  SellProperty = function(playerId, propertyId)
    lib.logger(playerId, "SellProperty", locale("logs_sold_property", playerId, propertyId))
  end,
  AddKeyHolder = function(playerId, propertyId, targetId)
    lib.logger(playerId, "AddKeyHolder", locale("logs_added_keyholder", playerId, propertyId, targetId))
  end,
  RemoveKeyHolder = function(playerId, propertyId, targetId)
    lib.logger(playerId, "RemoveKeyHolder", locale("logs_removed_keyholder", playerId, propertyId, targetId))
  end,
  AddDoor = function(playerId, propertyId, doorId)
    lib.logger(playerId, "AddDoor", locale("logs_added_door", playerId, propertyId, doorId))
  end,
  RemoveDoor = function(playerId, propertyId, doorId)
    lib.logger(playerId, "RemoveDoor", locale("logs_removed_door", playerId, propertyId, doorId))
  end,
}
