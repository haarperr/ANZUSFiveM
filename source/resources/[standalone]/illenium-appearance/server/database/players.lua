Database.Players = {}

function Database.Players.GetAll()
  return MySQL.query.await("SELECT * FROM characters")
end
