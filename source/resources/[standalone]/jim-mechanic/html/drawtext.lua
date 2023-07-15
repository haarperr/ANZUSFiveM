local function hideText()
    SendNUIMessage({
        action = 'HIDE_TEXT',
    })
end

local function drawText(text, position)
    if type(position) ~= "string" then position = "left" end

    SendNUIMessage({
        action = 'DRAW_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

local function changeText(text, position)
    if type(position) ~= "string" then position = "left" end

    SendNUIMessage({
        action = 'CHANGE_TEXT',
        data = {
            text = text,
            position = position
        }
    })
end

RegisterNetEvent('jim-mechanic:client:DrawText', function(text, position) drawText(text, position) end)
RegisterNetEvent('jim-mechanic:client:ChangeText', function(text, position) changeText(text, position) end)
RegisterNetEvent('jim-mechanic:client:HideText', function() hideText() end)