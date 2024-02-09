function SpawnTestNPC()
    local model = "a_m_m_skater_01" -- Adjust this to your NPC model
    functions_LoadModel(model)
    ped = CreatePed(4, model, GetEntityCoords(PlayerPedId()), 0, 0, 0)
    --TaskSetBlockingOfNonTemporaryEvents(ped, true)
end

RegisterCommand('testnpc', function(source, args, rawCommand)
    SpawnTestNPC()
end)
