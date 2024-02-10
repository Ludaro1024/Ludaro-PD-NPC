lib.callback.register('ludaro-pd-npc:isInDuty', function(source)
    return server_duty_GetDuty(source) or false
end)

lib.callback.register('ludaro-pd-npc:getNPCName', function(source, ped)
    return server_functions_getNPCName(ped)
end)

lib.callback.register('ludaro-pd-npc:getNPCGender', function(source, ped)
    return server_functions_getNPCGender(ped)
end)

lib.callback.register('ludaro-pd-npc:getNPCAge', function(source, ped)
    return server_functions_getNPCAge(ped)
end)

lib.callback.register('ludaro-pd-npc:getNPCJob', function(source, ped)
    return server_functions_getNPCJob(ped)
end)

lib.callback.register('ludaro-pd-npc:getNPCItems', function(source, ped)
    return server_functions_getNPCItems(ped)
end)

lib.callback.register('ludaro-pd-npc:getNPCWeapons', function(source, ped)
    return server_functions_getNPCWeapons(ped)
end)

lib.callback.register("ludaro-pd-npc:getIllegalNPCData", function(source, ped)
    items = server_functions_getNPCItems(ped)
    weapons = server_functions_getNPCWeapons(ped)
    for k, v in pairs(items) do
        for x, y in pairs(Config.IllegalItems) do
            if v == y then
                return true
            end
        end
    end

    if #weapons == 0 then
        return false
    else
        for k, v in pairs(weapons) do
            for x, y in pairs(Config.IllegalWeapons) do
                if v == y then
                    return true
                end
            end
        end
        if server_functions_getNPCLicenses(ped) then
            for k, v in pairs(server_functions_getNPCLicenses(ped)) do
                if v == "weapon" then
                    return false
                else
                    return true
                end
            end
        end
    end
end)


lib.callback.register('ludaro-pd-npc:getAllNPCData', function(source, ped, name)
    ped = NetworkGetEntityFromNetworkId(ped)
    local name = server_functions_getNPCName(ped) or functions_Locale("notknown")
    local age = server_functions_getNPCAge(ped) or functions_Locale("notknown")
    local gender = server_functions_getNPCGender(ped) or functions_Locale("notknown")
    local job = server_functions_getNPCJob(ped) or functions_Locale("notknown")
    local licenses = server_functions_getNPCLicenses(ped) or functions_Locale("notknown")
    local items = server_functions_getNPCItems(ped)
    local weapons = server_functions_getNPCWeapons(ped)
    local illegalstuff = server_function_getIllegalNPCData(ped)
    return name, age, gender, job, licenses, items, weapons, illegalstuff
end)
