RegisterServerEvent("ludaro-pd-npc:SetNPCName")
AddEventHandler("ludaro-pd-npc:SetNPCName", function(ped, name)
    server_functions_setNPCName(ped, name)
end)

RegisterServerEvent("ludaro-pd-npc:SetNPCGender")
AddEventHandler("ludaro-pd-npc:SetNPCGender", function(ped, name)
    server_functions_setNPCGender(ped, name)
end)

RegisterServerEvent("ludaro-pd-npc:SetNPCAge")
AddEventHandler("ludaro-pd-npc:SetNPCAge", function(ped, name)
    server_functions_setNPCAge(ped, name)
end)

RegisterServerEvent("ludaro-pd-npc:SetNPCJob")
AddEventHandler("ludaro-pd-npc:SetNPCJob", function(ped, name)
    server_functions_setNPCJob(ped, name)
end)

RegisterServerEvent("ludaro-pd-npc:SetNPCLicenses")
AddEventHandler("ludaro-pd-npc:SetNPCLicenes", function(ped, name)
    server_functions_setNPCLicenses(ped, name)
end)


RegisterServerEvent("ludaro-pd-npc:SetIllegalData")
AddEventHandler("ludaro-pd-npc:SetIllegalData", function(ped, name)
    server_functions_setIllegalData(ped, name)
end)
