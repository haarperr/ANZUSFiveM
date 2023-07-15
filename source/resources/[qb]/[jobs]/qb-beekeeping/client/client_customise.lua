
local BeeHiveProps = {`beehive_closed`, `beehive_open`}

exports[Config.Target]:AddTargetModel(BeeHiveProps, {
    options = {
        {
            event = "qb-beekeeping:client:OpenOptions",
            icon = "fas fa-circle",
            label =  "Beehive",
        },
    },
    distance = 1.0
})

function ShowNotification(msg, type)
    if Config.Notify['QBCore'] then
        QBCore.Functions.Notify(msg, type)
    elseif Config.Notify['okokNotify'] then
        exports['okokNotify']:Alert(Config.OkOkNotifyTitle, msg, 5000, type)
    elseif Config.Notify['pNotify'] then
        exports.pNotify:SendNotification({text = msg, type = type, layout = Config.pNotifyLayout, timeout = 5000})
    end
end