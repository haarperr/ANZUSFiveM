Database.PlayerOutfits = {}

function Database.PlayerOutfits.GetAllByCitizenID(citizenid)
  return MySQL.query.await("SELECT * FROM character_outfits WHERE citizenid = ?", { citizenid })
end

function Database.PlayerOutfits.GetByID(id)
  return MySQL.single.await("SELECT * FROM character_outfits WHERE id = ?", { id })
end

function Database.PlayerOutfits.GetByOutfit(name, citizenid) -- for validate duplicate name before insert
  return MySQL.single.await("SELECT * FROM character_outfits WHERE outfitname = ? AND citizenid = ?", { name, citizenid })
end

function Database.PlayerOutfits.Add(citizenID, outfitName, model, components, props)
  return MySQL.insert.await("INSERT INTO character_outfits (citizenid, outfitname, model, components, props) VALUES (?, ?, ?, ?, ?)", {
    citizenID,
    outfitName,
    model,
    components,
    props
  })
end

function Database.PlayerOutfits.Update(outfitID, model, components, props)
  return MySQL.update.await("UPDATE character_outfits SET model = ?, components = ?, props = ? WHERE id = ?", {
    model,
    components,
    props,
    outfitID
  })
end

function Database.PlayerOutfits.DeleteByID(id)
  MySQL.query.await("DELETE FROM character_outfits WHERE id = ?", { id })
end
