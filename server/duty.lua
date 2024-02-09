function server_duty_SetDuty(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local job = xPlayer.getJob()
    if lib.table.contains(job, Config.Policejobs) or Debug == true then
        duty = server_duty_GetDuty(source)
        if duty == false then
            shared_Server_SetDuty(source, true)
            xPlayer.triggerEvent('ludaro-pd-npc:notify', functions_Locale('onduty'))
        else
            shared_Server_SetDuty(source, false)
            xPlayer.triggerEvent('ludaro-pd-npc:notify', functions_Locale('offduty'))
        end
    else
        xPlayer.triggerEvent('ludaro-pd-npc:notify', functions_Locale('notpolice'))
    end
end

function server_duty_GetDuty(source)
    return shared_Server_GetDuty(source) or shared_Server_SetDuty(source, false)
end

RegisterCommand('duty', function(source, args, rawCommand)
    server_duty_SetDuty(source)
end, false)
