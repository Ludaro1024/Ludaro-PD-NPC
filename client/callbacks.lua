function callbacks_isInDuty()
    if duty then
        return duty
    else
        duty = lib.callback.await("ludaro-pd-npc:isInDuty", false)
    end
end

function callbacks_getPedData(ped)
    name, age, gender, job, licenses = lib.callback.await("ludaro-pd-npc:getAllNPCData", false, ped)
    if name == nil then
        name = names_getRandomName(not IsPedMale(ped))
        TriggerServerEvent("ludaro-pd-npc:SetNPCName", ped, name)
    end
    if age == nil then
        age = math.random(18, 70)
        TriggerServerEvent("ludaro-pd-npc:SetNPCAge", ped, age)
    end
    if gender == nil then
        if IsPedMale(ped) then
            gender = "♂️"
        else
            gender = "♀️"
        end
    end
    if job == nil then
        job = functions_Locale("notknown")
        TriggerServerEvent("ludaro-pd-npc:SetNPCJob", ped, job)
    end
    if licenses == nil then
        licenses = { "driving" }
        TriggerServerEvent("ludaro-pd-npc:SetNPCLicenses", ped, licenses)
    end
    return name, age, gender, job, licenses
end
