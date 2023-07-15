
RegisterNetEvent("snipe-menu:server:toggleReports", function()
    local src = source
    if not hideNoti[src] then
        hideNoti[src] = true
        ShowNotification(src, "You will no longer get report notifications", "error")
    else
        hideNoti[src] = nil
        ShowNotification(src, "You will now get report notifications", "success")
    end
end)