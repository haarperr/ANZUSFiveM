local QBCore = exports['qb-core']:GetCoreObject()
local isMelting = false
local canTake = false
local meltTime
local meltedItem = {}

CreateThread(function()
  for _, v in pairs(Config.PawnLocation) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, 431)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 5)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Lang:t('info.title'))
    EndTextCommandSetBlipName(blip)
  end
end)

CreateThread(function()
  lib.requestModel(Config.Ped)

  local options = {
    {
      name = 'PawnShop',
      onSelect = OpenMenu,
      icon = 'fas fa-ring',
      label = 'PawnShop',
      distance = 1.5
    }
  }

  for _, v in pairs(Config.PawnLocation) do
    local ped = CreatePed(0, Config.Ped, v.x, v.y, v.z - 1, v.w, false, true)

    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports.ox_target:addLocalEntity({ ped }, options)
  end
end)

function OpenMenu()
  if Config.UseTimes then
    if GetClockHours() >= Config.TimeOpen and GetClockHours() <= Config.TimeClosed then
      local pawnShop = {
        {
          title = Lang:t('info.sell'),
          description = Lang:t('info.sell_pawn'),
          event = 'qb-pawnshop:client:openPawn',
          onSelect = function()
            OpenPawn({ items = Config.PawnItems })
          end
        }
      }
      if not isMelting then
        pawnShop[#pawnShop + 1] = {
          title = Lang:t('info.melt'),
          description = Lang:t('info.melt_pawn'),
          onSelect = function()
            OpenMelt({ items = Config.MeltingItems })
          end
        }
      end
      if canTake then
        pawnShop[#pawnShop + 1] = {
          title = Lang:t('info.melt_pickup'),
          serverEvent = 'qb-pawnshop:server:pickupMelted',
          args = {
            items = meltedItem
          }
        }
      end
      lib.registerContext({
        id = 'open_pawnShop',
        title = Lang:t('info.title'),
        options = pawnShop
      })
      lib.showContext('open_pawnShop')
    else
      QBCore.Functions.Notify(Lang:t('info.pawn_closed', { value = Config.TimeOpen, value2 = Config.TimeClosed }))
    end
  else
    local pawnShop = {
      {
        title = Lang:t('info.sell'),
        description = Lang:t('info.sell_pawn'),
        event = 'qb-pawnshop:client:openPawn',
        onSelect = function()
          OpenPawn({ items = Config.PawnItems })
        end
      }
    }
    if not isMelting then
      pawnShop[#pawnShop + 1] = {
        title = Lang:t('info.melt'),
        description = Lang:t('info.melt_pawn'),
        onSelect = function()
          OpenMelt({ items = Config.MeltingItems })
        end
      }
    end
    if canTake then
      pawnShop[#pawnShop + 1] = {
        title = Lang:t('info.melt_pickup'),
        serverEvent = 'qb-pawnshop:server:pickupMelted',
        args = {
          items = meltedItem
        }
      }
    end
    lib.registerContext({
      id = 'open_pawnShop',
      title = Lang:t('info.title'),
      options = pawnShop
    })
    lib.showContext('open_pawnShop')
  end
end

function OpenPawn(data)
  local inventory = exports.ox_inventory:GetPlayerItems()
  local pawnMenu = {}

  for _, v in pairs(inventory) do
    for i = 1, #data.items do
      if v.name == data.items[i].item then
        pawnMenu[#pawnMenu + 1] = {
          title = v.label,
          description = Lang:t('info.sell_items', { value = data.items[i].price }),
          onSelect = function()
            PawnItems({
              label = v.label,
              price = data.items[i].price,
              name = v.name,
              amount = v.count
            })
          end,
        }
      end
    end
  end
  lib.registerContext({
    id = 'open_pawnMenu',
    menu = 'open_pawnShop',
    title = Lang:t('info.title'),
    options = pawnMenu
  })
  lib.showContext('open_pawnMenu')
end

function OpenMelt(data)
  local inventory = exports.ox_inventory:GetPlayerItems()
  local PlyInv = inventory
  local meltMenu = {}

  for _, v in pairs(PlyInv) do
    for i = 1, #data.items do
      if v.name == data.items[i].item then
        meltMenu[#meltMenu + 1] = {
          title = v.label,
          description = Lang:t('info.melt_item', { value = v.label }),
          event = 'qb-pawnshop:client:meltItems',
          args = {
            label = v.label,
            reward = data.items[i].rewards,
            name = v.name,
            amount = v.count,
            time = data.items[i].meltTime
          }
        }
      end
    end
  end
  lib.registerContext({
    id = 'open_meltMenu',
    menu = 'open_pawnShop',
    title = Lang:t('info.title'),
    options = meltMenu
  })
  lib.showContext('open_meltMenu')
end

function PawnItems(item)
  local sellingItem = lib.inputDialog(Lang:t('info.title'), {
    {
      type = 'number',
      label = 'amount',
      placeholder = Lang:t('info.max', { value = item.amount })
    }
  })
  if sellingItem then
    if not sellingItem[1] or sellingItem[1] <= 0 then return end
    TriggerServerEvent('qb-pawnshop:server:sellPawnItems', item.name, sellingItem[1], item.price)
  else
    QBCore.Functions.Notify(Lang:t('error.negative'), 'error')
  end
end

RegisterNetEvent('qb-pawnshop:client:meltItems', function(item)
  local meltingItem = lib.inputDialog(Lang:t('info.melt'), {
    {
      type = 'number',
      label = 'amount',
      placeholder = Lang:t('info.max', { value = item.amount })
    }
  })
  if meltingItem then
    if not meltingItem[1] or meltingItem[1] <= 0 then return end
    TriggerServerEvent('qb-pawnshop:server:meltItemRemove', item.name, meltingItem[1], item)
  else
    QBCore.Functions.Notify(Lang:t('error.no_melt'), 'error')
  end
end)

RegisterNetEvent('qb-pawnshop:client:startMelting', function(item, meltingAmount, meltTimees)
  if not isMelting then
    isMelting = true
    meltTime = meltTimees
    meltedItem = {}
    CreateThread(function()
      while isMelting do
        if LocalPlayer.state.isLoggedIn then
          meltTime = meltTime - 1
          if meltTime <= 0 then
            canTake = true
            isMelting = false
            table.insert(meltedItem, { item = item, amount = meltingAmount })
            if Config.SendMeltingEmail then
              TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = Lang:t('info.title'),
                subject = Lang:t('info.subject'),
                message = Lang:t('info.message'),
                button = {}
              })
            else
              QBCore.Functions.Notify(Lang:t('info.message'), 'success')
            end
          end
        else
          break
        end
        Wait(1000)
      end
    end)
  end
end)

RegisterNetEvent('qb-pawnshop:client:resetPickup', function()
  canTake = false
end)
