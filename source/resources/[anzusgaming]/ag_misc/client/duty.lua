local duty = { leo = 0 }

local function getDuty(job)
  return duty[job] or 0
end

exports('getDuty', getDuty)

RegisterNetEvent('police:SetCopCount', function(amount)
  duty.leo = amount
end)
