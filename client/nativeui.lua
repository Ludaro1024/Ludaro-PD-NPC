_menuPool = NativeUI.CreatePool()

local asgoodjob = false

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    local findJob = false

    for k, v in pairs(Config.Policejobs) do
        if v == PlayerData.job.name then
            hasgoodjob = true
            findJob = true
        end
    end

    if not findJob then
        hasgoodjob = false
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    local findJob = false

    for k, v in pairs(Config.Policejobs) do
        if v == PlayerData.job.name then
            hasgoodjob = true
            findJob = true
        end
    end

    if not findJob then
        hasgoodjob = false
    end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if _menuPool:IsAnyMenuOpen() then
            _menuPool:ProcessMenus()
        else
            Citizen.Wait(150) -- this small line
        end
    end
end)
function nativeui_CreateTimerBar(seconds, name)
    if isActive == true then
        return
    end
    local startTime = GetGameTimer() -- Get the start time in milliseconds
    isActive = true -- Flag to control thread execution

    -- Create a new timer bar with the specified name
    local timerbar = NativeUI.CreateTimerBarProgress(name, nil, nil, 10, 30)
    timerbar:SetPercentage(0)

    -- Thread to draw and increment the timer bar
    local thread = CreateThread(function()
        while isActive do
            Wait(0) -- Wait for the next frame
            local elapsedTime = GetGameTimer() - startTime
            local newPercentage = (elapsedTime / (seconds * 1000)) * 100
            newPercentage = math.min(newPercentage, 100) -- Ensure the percentage does not exceed 100

            if newPercentage >= 100 then
                isActive = false
            end

            timerbar:SetPercentage(newPercentage)
            timerbar:Draw(0) -- Draw the timer bar
        end
    end)

    -- Define the Stop method
    function timerbar:Stop()
        isActive = false
        TerminateThread(thread)
        Wait(1000)
    end

    function timerbar:Active()
        return isActive
    end

    return timerbar
end

function nativeui_setRightLabel(item, label)
    if item and label then
        item:RightLabel(functions_Locale(label))
    end
end

function nativeui_RefreshIndex()
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
end

local timerbar = nil
local timerCompleted = false

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if hasgoodjob then
            sleep = 0

            if IsControlPressed(0, Config.Controls.SelectPed) and callbacks_isInDuty() then
                if timerbar == nil then
                    timerbar = nativeui_CreateTimerBar(0.5, functions_Locale('selecting'))
                    timerCompleted = false
                end
            else
                if timerbar ~= nil then
                    if timerbar:Active() then
                        timerbar:Stop()
                        timerbar = nil
                    end
                end
            end

            if timerbar ~= nil then
                if not timerbar:Active() and not timerCompleted then
                    if timerbar:GetPercentage() >= 98 then
                        timerCompleted = true
                        functions_selectPed()
                    end
                    timerbar = nil
                end
            end
        end
        Wait(sleep)
    end
end)
