function callbacks_isInDuty()
    if duty then
        return duty
    else
        duty = lib.callback.await("ludaro-pd-npc:isInDuty", false)
    end
end

function callbacks_getPedData(ped)
    name, age, gender, job, licenses, items, weapons, illegalstuff = lib.callback.await("ludaro-pd-npc:getAllNPCData",
        false, ped)
    if name == nil or name == functions_Locale("notknown") then
        isfemale = IsPedMale(ped)
        isfemale = not isfemale
        name = names_getRandomName(isfemale)
        TriggerServerEvent("ludaro-pd-npc:SetNPCName", ped, name)
    end
    if age == nil or age == functions_Locale("notknown") then
        age = math.random(18, 70)
        TriggerServerEvent("ludaro-pd-npc:SetNPCAge", ped, age)
    end
    if gender == nil or gender == functions_Locale("notknown") then
        if not IsPedMale(ped) then
            gender = "♂️"
        else
            gender = "♀️"
        end
        TriggerServerEvent("ludaro-pd-npc:SetNPCGender", ped, gender)
    end
    if job == nil or job == functions_Locale("notknown") then
        job = getRandomJob()
        TriggerServerEvent("ludaro-pd-npc:SetNPCJob", ped, job)
    end
    if licenses == nil or licenses == functions_Locale("notknown") then
        licenses = { "driving" }
        TriggerServerEvent("ludaro-pd-npc:SetNPCLicenses", ped, licenses)
    end
    return name, age, gender, job, licenses, items, weapons, illegalstuff
end

function callbacks_illegaldata(ped)
    netId = NetworkGetNetworkIdFromEntity(ped)
    local illegaldata = lib.callback.await("ludaro-pd-npc:getIllegalNPCData", false, netId)
    return illegaldata
end

function callbacks_getPedItems(ped)
    local items = lib.callback.await("ludaro-pd-npc:getNPCItems", false, ped)
    return items
end

function callbacks_getPedWeapons(ped)
    local weapons = lib.callback.await("ludaro-pd-npc:getNPCWeapons", false, ped)
    return weapons
end
