for k, v in pairs(Config.PliceStations) do
    blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
    SetBlipSprite(blip, v.blip.id)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, v.blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.blip.label or k)
    EndTextCommandSetBlipName(blip)

    jailblip = AddBlipForCoord(v.jail.coords.x, v.jail.coords.y, v.jail.coords.z)
    SetBlipSprite(jailblip, v.jail.blip.id)
    SetBlipDisplay(jailblip, 4)
    SetBlipScale(jailblip, 0.8)
    SetBlipColour(jailblip, v.jail.blip.color)
    SetBlipAsShortRange(jailblip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(v.jail.blip.label or k)
    EndTextCommandSetBlipName(jailblip)

    Citizen.CreateThread(function()
        while true do
            Wait(0)
            local pos = GetEntityCoords(PlayerPedId())
            local distance = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
            if distance < 10 then
                DrawMarker(v.jail.marker.type, v.jail.coords.x, v.jail.coords.y, v.jail.coords.z, 0, 0, 0, 0, 0, 0,
                    v.jail.marker.scale.x, v.jail.marker.scale.y, v.jail.marker.scale.z, v.jail.marker.color.r,
                    v.jail.marker.color.g, v.jail.marker.color.b, v.jail.marker.color.a, 0, 0, 0, 0)
                if distance < 1.5 then
                    shared_ShowHelpNotify(functions_Locale("press_to_jail"), 0)
                    if IsControlJustPressed(0, 38) then
                        nearestnpc = functions_GetNearestNPC()
                        if nearestnpc then
                            GivePedToJail(functions_GetNearestNPC(), v.jail.reward)
                        else
                            shared_Notify(functions_Locale("no_npc"))
                        end
                    end
                end
            end
        end
    end) -- use ox lib zones maybe.. later
end
