function ShowNotification(source, msg, type)
    if Config.Notify['QBCore'] then
        TriggerClientEvent(Config.Core .. ':Notify', source, msg, type)
    elseif Config.Notify['okokNotify'] then
        TriggerClientEvent('okokNotify:Alert', source, Config.OkOkNotifyTitle, msg, 5000, type)
    elseif Config.Notify['pNotify'] then
        TriggerClientEvent("pNotify:SendNotification", source, {
            text = msg,
            type = type,
            timeout = 5000,
            layout = Config.pNotifyLayout
        })
    end
end
