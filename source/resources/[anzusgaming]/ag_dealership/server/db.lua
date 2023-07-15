local MySQL = MySQL
local db = {}

---@param class number
function db.getVehicles(class)
  return MySQL.query.await('SELECT `price`, `stock`, `name`, `model`, `image` FROM `dealership_vehicles` WHERE `class` = ? AND `stock` > 0', { class })
end

---@param model string
function db.getVehicle(model)
  return MySQL.single.await('SELECT * from `dealership_vehicles` WHERE `model` = ?', { model })
end

---@param model string
---@param amount number
function db.removeStock(model, amount)
  return MySQL.update.await('UPDATE `dealership_vehicles` SET `stock` = `stock` - ? WHERE `model` = ?', { amount, model })
end

return db
