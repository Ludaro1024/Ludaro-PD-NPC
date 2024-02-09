function selectmenu_OpenSelectMenu(ped, vehicle)
    if DoesEntityExist(ped) then
        name, age, gender, job = callbacks_getPedData(ped)
        playerPed = PlayerPedId()
        mainmenu = NativeUI.CreateMenu(functions_Locale("select_ped"), functions_Locale("select_ped_desc"))
        PlayPedAmbientSpeechNative(ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
        TaskLookAtEntity(ped, playerPed, -1, 2048, 3)
        TaskTurnPedToFaceEntity(ped, playerPed, -1)


        mainmenu.OnMenuClosed = function(sender, item, index)
            functions_cleanupPed(ped)
        end
        _menuPool:Add(mainmenu)
        nativeui_RefreshIndex()

        info = _menuPool:AddSubMenu(mainmenu, functions_Locale("info"))
        info.Item:RightLabel("→→")
        nativeui_RefreshIndex()

        nameitem = NativeUI.CreateItem(functions_Locale("name"), "")
        nameitem:RightLabel(name)
        genderitem = NativeUI.CreateItem(functions_Locale("gender"), "")
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

        info:AddItem(name)
        info:AddItem(gender)
        info:AddItem(age)
        info:AddItem(job)

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

        carry = NativeUI.CreateItem(functions_Locale("carry"), "")
        carry.Activated = function(sender, item)
            interaction_carry(ped)
        end

        searchthrough = NativeUI.CreateItem(functions_Locale("searchthrough"), "")
        searchthrough.Activated = function(sender, item)
            interaction_searchthrough(ped)
        end

        putincar = NativeUI.CreateItem(functions_Locale("putincar"), "")
        putincar.Activated = function(sender, item)
            interaction_putincar(ped)
        end



        cuff:AddItem(cuffhard)
        cuff:AddItem(cuffsoft)
        cuff:AddItem(uncuff)
        movement:AddItem(drag)
        movement:AddItem(carry)
        movement:AddItem(followme)
        movement:AddItem(searchthrough)



        if DoesEntityExist(vehicle) then
            vehiclemenu = _menuPool:AddSubMenu(mainmenu, functions_Locale("vehicle"))
            vehiclemenu.Item:RightLabel("→→")
            nativeui_RefreshIndex()
        end




        nativeui_RefreshIndex()
    else
        shared_Notify(functions_Locale("ped_not_exist"))
        return
    end
end

function interactions_cuff(ped)
    if not IsPedCuffed(ped) then
        SetEnableHandcuffs(ped, true)
    else
        SetEnableHandcuffs(ped, false)
    end
end

dragged = false

function interactions_drag(ped)
    if not IsPedInAnyVehicle(ped, false) then
        if not dragged then
            dragged = true
            TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
            AttachEntityToEntity(ped, PlayerPedId(), 0, 0, 0, 0, 0, 0, 0, false, false, false, false, 2, true)
        else
            DetachEntity(ped, true, true)
            ClearPedTasks(PlayerPedId())
            dragged = false
        end
    else
        shared_Notify(functions_Locale("ped_in_vehicle"))
    end
end

function interactions_followme(ped)
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
            if seat ~= -1 then
                if dragged then
                    DetachEntity(ped, true, true)
                    ClearPedTasks(PlayerPedId())
                    dragged = false
                end
                TaskEnterVehicle(ped, vehicle, -1, seat, 1.0, 1, 0)
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
    for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
        if IsVehicleSeatFree(vehicle, i) then
            return i
        end
    end
    return -1
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
