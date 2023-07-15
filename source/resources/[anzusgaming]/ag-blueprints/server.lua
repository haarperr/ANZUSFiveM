local QBCore = exports['qb-core']:GetCoreObject()
local encryption = { 'VAR' }

local function UnlockBlueprint(source, blueprint)
  local player = QBCore.Functions.GetPlayer(source)

  local metadata = player.PlayerData.metadata.blueprints

  metadata[#metadata + 1] = blueprint

  player.Functions.SetMetaData('blueprints', metadata)
  player.Functions.Save()
end

function GiveBlueprint(source, blueprint)
  exports.ox_inventory:AddItem(source, 'blueprintpaper', 1, {
    blueprint = blueprint,
    encrypted = true,
    encryption = encryption[1]
  })
end

exports('GiveBlueprint', GiveBlueprint)

QBCore.Functions.CreateUseableItem('blueprintpaper', function(source, item)
  if not item.metadata.encrypted then return end

  if item.metadata.encryption == 'VAR' then
    TriggerClientEvent('ag-blueprints:client:Hack', source, item)
  end
end)

RegisterNetEvent('ag-blueprints:server:Hack', function(item)
  local src = source
  if not item then return end
  if not item.metadata.blueprint and not item.metadata.encrypted and not item.metadata.encryption then return end
  exports.ox_inventory:RemoveItem(src, item.name, 1, item.metadata, item.slot)

  UnlockBlueprint(src, item.metadata.blueprint)
end)

-- onNet(ServerEvents.HACK, (hack: string, item: Item) => {
--     if (!hack) return;
--     if (!item || !item.info) return;
--     if (!item.info.blueprint && !item.info.encrpyted && !item.info.encryption) return;

--     UnlockBlueprint(global.source, item.info.blueprint);
-- });
