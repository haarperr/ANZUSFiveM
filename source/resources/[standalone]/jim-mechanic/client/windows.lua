--========================================================== Windows
RegisterNetEvent('jim-mechanic:client:Windows:Apply', function(data)
  local vehicle = getClosest(GetEntityCoords(PlayerPedId()))
  pushVehicle(vehicle)
  lookVeh(vehicle)
  if lockedCar(vehicle) then return end
  if GetVehicleWindowTint(vehicle) == tonumber(data.mod) then
    triggerNotify(nil, data.name .. Loc[Config.Lan]["common"].already, "error")
    TriggerEvent('jim-mechanic:client:Windows:Check')
  elseif GetVehicleWindowTint(vehicle) ~= tonumber(data.mod) then
    time = math.random(3000, 5000)
    TriggerEvent('animations:client:EmoteCommandStart', { "maid" })
    QBCore.Functions.Progressbar("drink_something", Loc[Config.Lan]["common"].installing .. data.name .. "..", time, false, true,
      { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = false, },
      {}, {}, {}, function()
        SetVehicleModKit(vehicle, 0)
        qblog("`tint_supplies - " .. QBCore.Shared.Items["tint_supplies"].label .. " - " .. data.name .. "` changed [**" .. trim(GetVehicleNumberPlateText(vehicle)) .. "**]")
        SetVehicleWindowTint(vehicle, tonumber(data.mod))

        if Config.CosmeticRemoval then
          toggleItem(false, "tint_supplies")
        else
          TriggerEvent('jim-mechanic:client:Windows:Check')
        end
        triggerNotify(nil, Loc[Config.Lan]["windows"].installed, "success")
        emptyHands(PlayerPedId(), true)
      end, function() -- Cancel
        triggerNotify(nil, Loc[Config.Lan]["windows"].failed, "error")
        emptyHands(PlayerPedId(), true)
      end, "tint_supplies")
  end
end)

RegisterNetEvent('jim-mechanic:client:Windows:Check', function()
  if Config.CosmeticsJob then if not jobChecks() then return end end
  if not locationChecks() then return end
  if not inCar() then return end
  if not nearPoint(GetEntityCoords(PlayerPedId())) then return end
  local vehicle = nil
  if not IsPedInAnyVehicle(PlayerPedId(), false) then
    vehicle = getClosest(GetEntityCoords(PlayerPedId()))
    pushVehicle(vehicle)
    lookVeh(vehicle)
  end
  if lockedCar(vehicle) then return end
  if Config.isVehicleOwned and not IsVehicleOwned(trim(GetVehicleNumberPlateText(vehicle))) then
    triggerNotify(nil, Loc[Config.Lan]["common"].owned, "error")
    return
  end
  if DoesEntityExist(vehicle) then
    if GetVehicleWindowTint(vehicle) == 0 then applied1 = Loc[Config.Lan]["common"].current else applied1 = "" end
    if GetVehicleWindowTint(vehicle) == 4 then applied2 = Loc[Config.Lan]["common"].current else applied2 = "" end
    if GetVehicleWindowTint(vehicle) == 5 then applied3 = Loc[Config.Lan]["common"].current else applied3 = "" end
    if GetVehicleWindowTint(vehicle) == 3 then applied4 = Loc[Config.Lan]["common"].current else applied4 = "" end
    if GetVehicleWindowTint(vehicle) == 2 then applied5 = Loc[Config.Lan]["common"].current else applied5 = "" end
    if GetVehicleWindowTint(vehicle) == 1 then applied6 = Loc[Config.Lan]["common"].current else applied6 = "" end

    exports['qb-menu']:openMenu({
      { icon = "tint_supplies", header = searchCar(vehicle) .. Loc[Config.Lan]["windows"].menuheader, txt = "", isMenuHeader = true },
      {
        icon = "fas fa-circle-xmark",
        header = "",
        txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""),
        params = {
          event = "jim-mechanic:client:Menu:Close" }
      },
      {
        header = Loc[Config.Lan]["windows"].label1,
        txt = applied1,
        params = {
          event = "jim-mechanic:client:Windows:Apply",
          args = { mod = 0, name = Loc[Config.Lan]["windows"].label1 }
        }
      },
      {
        header = Loc[Config.Lan]["windows"].label2,
        txt = applied2,
        params = {
          event = "jim-mechanic:client:Windows:Apply",
          args = { mod = 4, name = Loc[Config.Lan]["windows"].label2 }
        }
      },
      {
        header = Loc[Config.Lan]["windows"].label3,
        txt = applied3,
        params = {
          event = "jim-mechanic:client:Windows:Apply",
          args = { mod = 5, name = Loc[Config.Lan]["windows"].label3 }
        }
      },
      {
        header = Loc[Config.Lan]["windows"].label4,
        txt = applied4,
        params = {
          event = "jim-mechanic:client:Windows:Apply",
          args = { mod = 3, name = Loc[Config.Lan]["windows"].label4 }
        }
      },
      {
        header = Loc[Config.Lan]["windows"].label5,
        txt = applied5,
        params = {
          event = "jim-mechanic:client:Windows:Apply",
          args = { mod = 2, name = Loc[Config.Lan]["windows"].label5 }
        }
      },
      {
        header = Loc[Config.Lan]["windows"].label6,
        txt = applied6,
        params = {
          event = "jim-mechanic:client:Windows:Apply",
          args = { mod = 1, name = Loc[Config.Lan]["windows"].label6 }
        }
      },
    })
  end
end)
