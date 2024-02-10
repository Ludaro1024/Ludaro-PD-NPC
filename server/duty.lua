function server_duty_SetDuty(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob().name
    if tableContains(Config.Policejobs, job) or Debug == true then
        duty = server_duty_GetDuty(source)
        if duty == false then
            shared_Server_SetDuty(source, true)
            xPlayer.triggerEvent('ludaro-pd-npc:Notify', functions_Locale('onduty'))
        else
            shared_Server_SetDuty(source, false)
            xPlayer.triggerEvent('ludaro-pd-npc:Notify', functions_Locale('offduty'))
        end
    else
        xPlayer.triggerEvent('ludaro-pd-npc:Notify', functions_Locale('notpolice'))
    end
end

function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function server_duty_GetDuty(source)
    return shared_Server_GetDuty(source) or shared_Server_SetDuty(source, false)
end

-- RegisterCommand(Config.Commands.ChangeDuty, function(source, args, rawCommand)
--     server_duty_SetDuty(source)
-- end, false)
