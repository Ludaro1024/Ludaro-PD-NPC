function functions_IsPedAnPedestrian(ped)
    return IsPedHuman(ped)
end

function functions_Locale(msg, variable)
    if variable then
        configvariable = Config.Locales[Config.Locale][msg]
        msg = string.format(configvariable, variable)
        return msg
    else
        return Config.Locales[Config.Locale][msg] or msg
    end
end

function functions_LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(0)
    end
end

local markerthread = nil
local markernpc = nil

function functions_resetNPC(npc)
    PlayPedAmbientSpeechNative(ped, "GENERIC_BYE", "SPEECH_PARAMS_FORCE")
    TaskTurnPedToFaceEntity(ped, playerPed, -1)
    ClearPedTasksImmediately(npc)
    ResetPedMovementClipset(npc, 0)
    SetPedAsNoLongerNeeded(npc)
    TaskWanderStandard(npc, 10.0, 10)
end

function functions_selectPed()
    if markerthread ~= nil then
        TerminateThread(markerthread)
        markerthread = nil
    end

    local playerPed    = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestPed   = nil
    local minDistance  = math.huge

    for ped in functions_enumaratePeds() do
        if ped ~= playerPed and IsPedHuman(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) then
            local pedCoords = GetEntityCoords(ped)
            local dist = #(playerCoords - pedCoords)

            if dist < minDistance then
                minDistance = dist
                closestPed = ped
            end
        end
    end

    if closestPed and minDistance < 10.0 then
        markernpc = closestPed
        drawmarker = true
        markerthread = CreateThread(function()
            while drawmarker do
                local headcoords = GetPedBoneCoords(markernpc, 31086, 0, 0, 0)
                DrawMarker(32, headcoords.x, headcoords.y, headcoords.z + 0.5, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255,
                    0,
                    255, 0, 0, 0, 0)
                Wait(0)
                dist = #(GetEntityCoords(markernpc) - GetEntityCoords(PlayerPedId()))
                if dist >= 10.0 or IsEntityDead(markernpc) then
                    functions_disableMarker()
                    _menuPool:CloseAllMenus()
                    functions_resetNPC(markernpc)
                end
            end
        end)
    else
        shared_Notify("Kein NPC in der Nähe")
    end
end

function functions_getMarkerPed()
    return markernpc
end

function functions_disableMarker()
    drawmarker = false
    if markerthread ~= nil then
        TerminateThread(markerthread)
        markerthread = nil
    end
    markernpc = nil
end

function functions_enumaratePeds()
    return coroutine.wrap(function()
        local ped = FindFirstPed()
        local success
        repeat
            coroutine.yield(ped)
            success, ped = FindNextPed()
        until not success
        EndFindPed()
    end)
end

function functions_cleanupPed(ped)
    functions_disableMarker()
    if ped then
        functions_resetNPC(ped)
    end
end

function functions_showSubTitle(msg, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

function functions_getNearestNPC()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local closestPed = nil
    local minDistance = math.huge

    for ped in functions_enumaratePeds() do
        if ped ~= playerPed and IsPedHuman(ped) and not IsPedAPlayer(ped) and not IsEntityDead(ped) then
            local pedPos = GetEntityCoords(ped)
            local dist = #(playerPos - pedPos)

            if dist < minDistance then
                minDistance = dist
                closestPed = ped
            end
        end
    end

    return closestPed, minDistance
end

function functions_givePedToJail(ped, reward, penalty)
    netId = NetworkGetNetworkIdFromEntity(ped)
    name, age, gender, job, licenses, items, weapons, illegalstuff = callbacks_getPedData(netId) -- was to tired to create a new callback, will fix this later, sorry
    if #illegalstuff.weapons or #illegalstuff.items >= 1 then
        isfaulty = true
    else
        isfaulty = false
    end
    if isfaulty == false then
        shared_Notify(functions_Locale("ped_jailed_faulty"))
        shared_Functions_Penalty(penalty)
    else
        shared_Notify(functions_Locale("ped_jailed_reward", reward))
        shared_Functions_Reward(reward)
        functions_disableMarker()
        DeletePed(ped)
    end -- add cooldown
end

RegisterCommand(Config.Commands.ChangeDuty, function(source, args, rawCommand)
    TriggerServerEvent("ludaro-pd-npc:setduty")
end, false)
RegisterKeyMapping(Config.Commands.ChangeDuty, functions_Locale("keymap_duty"), "keyboard",
    Config.Controls.ChangeDuty)
