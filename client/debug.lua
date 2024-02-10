if Debug then
    function SpawnTestNPC()
        local model = "a_m_m_skater_01" -- Adjust this to your NPC model
        functions_LoadModel(model)
        ped = CreatePed(4, model, GetEntityCoords(PlayerPedId()), true, true, true)
        --TaskSetBlockingOfNonTemporaryEvents(ped, true)
        return ped
    end

    RegisterCommand('testnpc', function(source, args, rawCommand)
        SpawnTestNPC()
    end)
end
