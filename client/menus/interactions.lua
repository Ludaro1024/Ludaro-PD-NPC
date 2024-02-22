function selectmenu_OpenSelectMenu(ped, vehicle)
    if DoesEntityExist(ped) == 1 or DoesEntityExist(ped) == true then
        playerPed = PlayerPedId()
        netId = NetworkGetNetworkIdFromEntity(ped)
        name, age, gender, job, licenses, items, weapons, illegalstuff = callbacks_getPedData(netId)

        playerPed = PlayerPedId()
        mainmenu = NativeUI.CreateMenu(functions_Locale("select_ped"), functions_Locale("select_ped_desc"))
        if cuffed == false then
            PlayPedAmbientSpeechNative(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
            TaskLookAtCoord(ped, GetEntityCoords(playerPed), 10000, 2048, 3)
            TaskTurnPedToFaceCoord(ped, GetEntityCoords(playerPed), 10000)
            TaskStandStill(ped, 10000)
        end
        _menuPool:Add(mainmenu)
        _menuPool:RefreshIndex()
        _menuPool:MouseControlsEnabled(false)
        _menuPool:MouseEdgeEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
        mainmenu:Visible(true)

        mainmenu.OnMenuClosed = function(sender, item, index)
            if cuffed == false then
                PlayPedAmbientSpeechNative(ped, "GENERIC_BYE", "SPEECH_PARAMS_FORCE")
                TaskTurnPedToFaceEntity(ped, playerPed, -1)
                ClearPedTasksImmediately(ped)
                ResetPedMovementClipset(ped, 0)
                SetPedAsNoLongerNeeded(ped)
                TaskWanderStandard(ped, 10.0, 10)
            end
        end
        nativeui_RefreshIndex()

        info = _menuPool:AddSubMenu(mainmenu, functions_Locale("info"))
        info.Item:RightLabel("→→")
        nativeui_RefreshIndex()

        nameitem = NativeUI.CreateItem(functions_Locale("name"), "")
        nameitem:RightLabel(name)
        genderitem = NativeUI.CreateItem(functions_Locale("gender"), "")
        if IsPedMale(ped) then
            gender = "♂️"
        else
            gender = "♀️"
        end
        print(gender)
        print(IsPedMale(ped))
        genderitem:RightLabel(gender)
        ageitem = NativeUI.CreateItem(functions_Locale("age"), "")
        ageitem:RightLabel(age)
        jobitem = NativeUI.CreateItem(functions_Locale("job"), "")
        jobitem:RightLabel(job)
        -- Define setter functions
        function interactions_setName(newName)
            name = newName
            nameitem:SetRightLabel(name)
        end

        function interactions_setGender(newGender)
            gender = newGender
            genderitem:SetRightLabel(gender)
        end

        function interactions_setAge(newAge)
            age = newAge
            ageitem:SetRightLabel(age)
        end

        function interactions_setJob(newJob)
            job = newJob
            jobitem:SetRightLabel(job)
        end

        info.SubMenu:AddItem(nameitem)
        info.SubMenu:AddItem(genderitem)
        info.SubMenu:AddItem(ageitem)
        info.SubMenu:AddItem(jobitem)

        -- talk = _menuPool:AddSubMenu(mainmenu, functions_Locale("talk"))
        -- talk.Item:RightLabel("→→")
        -- nativeui_RefreshIndex()

        -- basic = _menuPool:AddSubMenu(talk.SubMenu, functions_Locale("basic"))
        -- basic.Item:RightLabel("→→")

        -- nativeui_RefreshIndex()

        -- greet = NativeUI.CreateItem(functions_Locale("greet"), "")
        -- greet.Activated = function(sender, item)
        --     PlayPedAmbientSpeechNative(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
        -- end

        -- insult = NativeUI.CreateItem(functions_Locale("insult"), "")
        -- insult.Activated = function(sender, item)
        --     PlayPedAmbientSpeechNative(ped, "GENERIC_INSULT_HIGH", "SPEECH_PARAMS_FORCE")
        -- end




        inventory = _menuPool:AddSubMenu(mainmenu, functions_Locale("inventory"))
        inventory.Item:RightLabel("→→")
        nativeui_RefreshIndex()

        itemsmenu = _menuPool:AddSubMenu(inventory.SubMenu, functions_Locale("items"))
        itemsmenu.Item:RightLabel("→→")
        nativeui_RefreshIndex()

        weaponsmenu = _menuPool:AddSubMenu(inventory.SubMenu, functions_Locale("weapons"))
        weaponsmenu.Item:RightLabel("→→")
        nativeui_RefreshIndex()

        for k, v in pairs(items) do
            item = NativeUI.CreateItem(v.label, "")
            itemsmenu.SubMenu:AddItem(item)
            if Config.ShowIllegalItems then
                if v.illegal then
                    item:RightLabel("~r~" .. functions_Locale("illegal"))
                else
                    item:RightLabel("~g~" .. functions_Locale("legal"))
                end
            end
        end

        for k, v in pairs(weapons) do
            if v.label and v.name then
                weapon = NativeUI.CreateItem(v.label, "")
                weaponsmenu.SubMenu:AddItem(weapon)
                if Config.ShowIllegalWeapons then
                    if v.illegal then
                        weapon:RightLabel("~r~" .. functions_Locale("illegal"))
                    else
                        weapon:RightLabel("~g~" .. functions_Locale("legal"))
                    end
                end
            end
        end




        actions = _menuPool:AddSubMenu(mainmenu, functions_Locale("actions"))

        cuff = NativeUI.CreateItem(functions_Locale("cuff"), "")
        cuff.Activated = function(sender, item)
            interactions_cuff(ped)
        end

        movement = _menuPool:AddSubMenu(actions.SubMenu, functions_Locale("movement"))
        movement.Item:RightLabel("→→")
        nativeui_RefreshIndex()

        drag = NativeUI.CreateItem(functions_Locale("drag"), "")
        drag.Activated = function(sender, item)
            interactions_drag(ped)
        end

        -- carry = NativeUI.CreateItem(functions_Locale("carry"), "")
        -- carry.Activated = function(sender, item)
        --     interaction_carry(ped)
        -- end

        followme = NativeUI.CreateItem(functions_Locale("followme"), "")
        followme.Activated = function(sender, item)
            interactions_followme(ped)
        end


        putincar = NativeUI.CreateItem(functions_Locale("putincar"), "")
        putincar.Activated = function(sender, item)
            interaction_putincar(ped)
        end
        putoutcar = NativeUI.CreateItem(functions_Locale("putoutcar"), "")
        putoutcar.Activated = function(sender, item)
            interaction_putoutcar(ped)
        end
        movement.SubMenu:AddItem(drag)
        -- movement.SubMenu:AddItem(carry)
        movement.SubMenu:AddItem(followme)
        movement.SubMenu:AddItem(putincar)
        movement.SubMenu:AddItem(putoutcar)
        movement.SubMenu:AddItem(cuff)



        if DoesEntityExist(vehicle) then
            vehiclemenu = _menuPool:AddSubMenu(mainmenu, functions_Locale("vehicle"))
            vehiclemenu.Item:RightLabel("→→")
            nativeui_RefreshIndex()
        end



        deletemarker = NativeUI.CreateItem(functions_Locale("deletemarker"), "")
        deletemarker.Activated = function(sender, item)
            functions_disableMarker()
        end
        nativeui_RefreshIndex()
    else
        shared_Notify(functions_Locale("ped_not_exist"))
        return
    end
end

function interactions_searchthrough(ped, searchmenu)

end

function interaction_putoutcar(ped)
    if IsPedInAnyVehicle(ped, false) then
        FreezeEntityPosition(ped, false)
        TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 64)
        repeat Wait(0) until not IsPedInAnyVehicle(ped, false)
        FreezeEntityPosition(ped, true)
    else
        shared_Notify(functions_Locale("ped_not_in_vehicle"))
    end
end

function loadanimdict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function cuffAnimation(ped)
    Citizen.CreateThread(function()
        playercoords = GetEntityCoords(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerheading = GetEntityHeading(PlayerPedId())
        local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
        SetEntityCoords(ped, x, y, z)
        SetEntityHeading(ped, playerheading)
        Citizen.Wait(250)
        loadanimdict('mp_arrest_paired')
        TaskPlayAnim(ped, 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
        Citizen.Wait(3760)
        loadanimdict('mp_arresting')
        TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
        TaskStandStill(ped, 10000)
        cuffed = true
    end)
    loadanimdict('mp_arrest_paired')
    TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750, 2, 0, 0, 0, 0)
    Citizen.Wait(3000)
    SetCurrentPedWeapon(ped, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
end

function uncuffAnimation(ped)
    Citizen.CreateThread(function()
        playercoords = GetEntityCoords(PlayerPedId())
        playerlocation = GetEntityForwardVector(PlayerPedId())
        playerheading = GetEntityHeading(PlayerPedId())
        local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
        SetEntityCoords(ped, x, y, z)
        SetEntityHeading(ped, playerheading)
        Citizen.Wait(250)
        loadanimdict('mp_arresting')
        TaskPlayAnim(ped, 'mp_arresting', 'b_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
        Citizen.Wait(5500)
        cuffed = false
        ClearPedTasks(ped)
    end)
    Citizen.Wait(250)
    loadanimdict('mp_arresting')
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
    Citizen.Wait(5500)
    ClearPedTasks(PlayerPedId())
end

function interactions_cuff(ped)
    if not IsPedCuffed(ped) then
        cuffAnimation(ped)
        FreezeEntityPosition(ped, true)
        SetEnableHandcuffs(ped, true)
    else
        uncuffAnimation(ped)
        FreezeEntityPosition(ped, false)
        SetEnableHandcuffs(ped, false)
    end
end

dragged = false

function interactions_drag(ped)
    if not IsPedInAnyVehicle(ped, false) then
        if not cuffed then
            shared_Notify(functions_Locale("ped_needs_cuffed"))
            return
        end
        if not dragged then
            FreezeEntityPosition(ped, false)
            dragged = true
            AttachEntityToEntity(ped, PlayerPedId(), 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false,
                2, true)
        else
            DetachEntity(ped, true, true)
            ClearPedTasks(PlayerPedId())
            dragged = false
            FreezeEntityPosition(ped, true)
        end
    else
        shared_Notify(functions_Locale("ped_in_vehicle"))
    end
end

function interactions_followme(ped)
    FreezeEntityPosition(ped, false)
    if not IsPedInAnyVehicle(ped, false) then
        TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0, 0, 0, 5, -1, 0.5, 1, true)
    else
        shared_Notify(functions_Locale("ped_in_vehicle"))
    end
end

function interaction_putincar(ped)
    if not IsPedInAnyVehicle(ped, false) then
        local vehicle = functions_GetClosestVehicle()
        if DoesEntityExist(vehicle) then
            local seat = GetEmptySeat(vehicle)
            print(GetEmptySeat(vehicle))
            if seat ~= -1 then
                if dragged then
                    DetachEntity(ped, true, true)
                    ClearPedTasks(PlayerPedId())
                    dragged = false
                end
                TaskEnterVehicle(ped, vehicle, -1, seat, 1.0, 1, 0)
                FreezeEntityPosition(ped, false)
                repeat Wait(0) until IsPedInVehicle(ped, vehicle, false)
                FreezeEntityPosition(ped, true)
            else
                shared_Notify(functions_Locale("no_empty_seat"))
            end
        else
            shared_Notify(functions_Locale("no_vehicle"))
        end
    else
        shared_Notify(functions_Locale("ped_in_vehicle"))
    end
end

function GetEmptySeat(vehicle)
    if IsVehicleSeatFree(vehicle , 1 ) then 
        return 1 
    elseif IsVehicleSeatFree(vehicle , 2 ) then 
        return 2 
    elseif IsVehicleSeatFree(vehicle , 0 ) then
        return 0  
    end
    return nil
end

function runAway(ped)
    local pos = GetEntityCoords(ped)
    local playerPos = GetEntityCoords(PlayerPedId())
    local x = pos.x - playerPos.x
    local y = pos.y - playerPos.y
    local z = pos.z - playerPos.z
    local distance = math.sqrt(x * x + y * y + z * z)
    if distance < 10 then
        TaskGoToCoordAnyMeans(ped, pos.x + 5, pos.y + 5, pos.z, 1.0, 0, 0, 786603, 0xbf800000)
    end
end

function functions_GetClosestVehicle()
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local entityWorld = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    local rayHandle = StartShapeTestRay(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, playerPed,
        0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        ped = functions_getMarkerPed()
        if cuffed then
            ClearPedTasksImmediately(ped)
            loadanimdict('mp_arresting')
            TaskPlayAnim(ped, 'mp_arresting', 'b_uncuff', 8.0, -8, -1, 2, 0, 0, 0, 0)
            cuffed = false
        end
        if dragged then
            interactions_drag(functions_getMarkerPed())
        end
        functions_disableMarker()
    end
end)

RegisterCommand(Config.Commands.OpenInteractionMenu, function(source, args, rawCommand)
    nearestped = functions_getMarkerPed()
    selectmenu_OpenSelectMenu(nearestped, nil)
end)

RegisterKeyMapping(Config.Commands.OpenInteractionMenu, functions_Locale("open_interactions_menu"), "keyboard",
    Config.Controls.OpenInteractionsMenu)



function stopdrag()
    DetachEntity(PlayerPedId(), true, true)
    DetachEntity(dragstatus.ped, true, true)
    dragstatus.ped = nil
    dragstatus.isDragged = false
end
