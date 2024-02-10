shared_Notify = function(msg)
    ESX.ShowNotification(msg)
end

shared_Server_GetDuty = function(source)
    return Player(source).state.duty
end

shared_Server_SetDuty = function(source, value)
    Player(source).state.duty = value
    return shared_Server_GetDuty(source)
end

shared_ShowHelpNotify = function(msg)
    ESX.ShowHelpNotification(msg)
end

shared_Functions_Penalty = function(penalty)
    TriggerServerEvent("ludaro-pd-npc:penalty", penalty)
end

shared_Functions_Reward = function(reward)
    TriggerServerEvent("ludaro-pd-npc:reward", reward)
end