local db = require 'server.db'

-- When a player is loaded, check if they are a premium member and randomize their custom plates and phone numbers
RegisterNetEvent("QBCore:Server:OnPlayerLoaded", function()
  local source = source
  local Player = QBCore.Functions.GetPlayer(source)
  if not Player then return end

  local id = Player.PlayerData.citizenid

  -- If the player is not premium, randomize their custom plates
  local isPremiumPlate = Player.PlayerData.premium >= ConfigServer.PlatePremiumLevel
  if not isPremiumPlate then
    local vehicles = db.getPlayerCustomPlates(id)
    for i = 1, #vehicles do
      local oldPlate = vehicles[i].plate

      local newPlate = AG.GeneratePlate()


      lib.logger(Player.PlayerData.source, 'OnPlayerLoaded',
        ('Randomizing custom plate (%s) to %s'):format(vehicles[i].plate, newPlate))

      db.updatePlate(oldPlate, newPlate, id)
    end
  end

  -- If the player is not premium, randomize their custom phone number
  local isPremiumNumber = Player.PlayerData.premium >= ConfigServer.PhonePremiumLevel
  if not isPremiumNumber then
    local number = db.getPlayerCustomNumbers(id)
    if number then
      print("Randomizing phone number for " .. id .. " '" .. number.phone_number .. "'")

      local oldNumber = number.phone_number

      ::generateNumber::
      local newNumber = '(222) ' .. QBCore.Shared.RandomInt(4)

      -- Check the number is not already in use
      if db.isNumberInUse(newNumber) then goto generateNumber end

      -- Update the number
      db.updateNumber(newNumber, id)

      lib.logger(Player.PlayerData.source, 'OnPlayerLoaded',
        ('Randomizing custom phone number (%s) to %s'):format(oldNumber, newNumber))

      -- Reload the players phone
      exports.npwd:unloadPlayer(source)
      exports.npwd:newPlayer({
        source = source,
        phoneNumber = newNumber,
        identifier = Player.PlayerData.citizenid,
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname
      })
    end
  end
end)
