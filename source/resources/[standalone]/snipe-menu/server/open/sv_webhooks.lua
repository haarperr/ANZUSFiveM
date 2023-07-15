local WebHooks = {
  ["exploit"] = "",
  ["triggered"] = "",
  ["report"] = "",
  ["transcript"] = "https://discord.com/api/webhooks/1062815284110561320/KJpc2CCW7An5wOjNKvKOr6K77ovb2x9Khk-bpk4ElM2kL-VjM9IngSJWFYzJAmZdfWRt"
}

function SendLogs(source, type, message)
  lib.logger(source, 'SendLogs', message, ('type:%s'):format(type))
  local colorcode = 5763719
  if type == "exploit" then
    colorcode = 16711680
  end
  local description = ""
  if source == 0 then
    description = "**" .. message .. "**"
  else
    description = "**" .. GetPlayerName(source) .. "** (" .. source .. ")\n" .. message
  end
  if type == "report" then
    description = "**" .. GetPlayerName(source) .. "** " .. message
  end
  local embedData = {
    {
      ["title"] = "Admin Menu Logs",
      ["color"] = colorcode,
      ["footer"] = {
        ["text"] = os.date("%c"),
      },
      ["description"] = description,
      ["author"] = {
        ["name"] = 'Snipe Admin Menu Logs',
      },
    }
  }
  if type == "transcript" then
    embedData[1].title = "Chat Transcript (Closed by " .. GetPlayerName(source) .. ")"
    embedData[1].footer.text = "Closed on " .. os.date("%c")
    embedData[1].description = message
    description = ""
  end
  PerformHttpRequest(WebHooks[type], function(err, text, headers) end, 'POST', json.encode({ username = "Snipe Logs", embeds = embedData }),
    { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("snipe-menu:server:sendLogs", function(type, message)
  if type == "exploit" then
    SendLogs(source, type, message)
  elseif type == "triggered" then
    SendLogs(source, type, message)
  end
end)
