shared_Notify = function(msg)
    ESX.ShowNotification(msg)
end

shared_Server_GetDuty = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.getMeta('duty')
end

shared_Server_SetDuty = function(source, value)
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setMeta('duty', value)
    return shared_Server_GetDuty(source)
end

shared_ShowHelpNotify = function(msg)
    ESX.ShowHelpNotification(msg)
end