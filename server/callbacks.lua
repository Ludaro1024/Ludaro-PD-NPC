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


lib.callback.register('ludaro-pd-npc:getAllNPCData', function(source, ped, name)
    local name = server_functions_getNPCName(ped) or functions_Locale("notknown")
    local age = server_functions_getNPCAge(ped) or functions_Locale("notknown")
    local gender = server_functions_getNPCGender(ped) or functions_Locale("notknown")
    local job = server_functions_getNPCJob(ped) or functions_Locale("notknown")
    local illegaldata = server_function_getIllegalNPCData(ped)
    return name, age, gender, job, illegaldata
end)
