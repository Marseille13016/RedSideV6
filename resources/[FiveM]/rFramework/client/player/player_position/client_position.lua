local firstspawn = 0
local loaded = false


local OldPos = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5*1000)
        local pPos = GetEntityCoords(GetPlayerPed(-1))
        if OldPos == nil then
            OldPos = pPos
        else
            local dst = GetDistanceBetweenCoords(pPos, OldPos, true)
            if dst >= 3.0 then
                OldPos = pPos
                TriggerServerEvent("rF:save_position", pPos.x, pPos.y, pPos.z)
            end
        end
    end
end)

function DebugClient(arg)
    if debug_print == true then
        print(arg)
    end
end

RegisterNetEvent('rF:notification')
AddEventHandler('rF:notification', function(alert)
    Notify(alert)
end)

RegisterNetEvent("rF:spawn_last_position")
AddEventHandler("rF:spawn_last_position", function(data, PosX, PosY, PosZ)
    if not loaded then
        if data == 0 then
            SetEntityCoords(GetPlayerPed(-1), PosX, PosY, PosZ, 1, 0, 0, 1)
            FreezeEntityPosition(GetPlayerPed(-1), true)
            Wait(2500)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            Citizen.Wait(10)
            Notify(_L("welcome"))
            PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0);
            loaded = true
            while not NetworkIsSessionStarted() do Wait(1000) end
            TriggerEvent("core:OpenIdentityCreator") -- Changer ça par votre skin creator
        else
            SetEntityCoords(GetPlayerPed(-1), PosX, PosY, PosZ, 1, 0, 0, 1)
            FreezeEntityPosition(GetPlayerPed(-1), true)
            Wait(2500)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            Notify(_L("welcome_back"))
            PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0);
            loaded = true
        end
        DebugClient(data)
        DebugClient(loaded)
    end
end)