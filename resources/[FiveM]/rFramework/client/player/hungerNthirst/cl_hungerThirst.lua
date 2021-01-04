

local hunger = 70
local thirst = 70



Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        if IsPedSprinting(pPed) then
            hunger = hunger - 0.025
            thirst = thirst - 0.055
        elseif IsPedRunning(pPed) then
            hunger = hunger - 0.015
            thirst = thirst - 0.035
        else
            hunger = hunger - 0.009
            thirst = thirst - 0.010
        end

        if hunger < 0 then
            hunger = 0
        end

        if thirst < 0 then
            thirst = 0
        end

        SendNUIMessage({
            thirst = thirst,
            hunger = hunger,
        })
        TriggerEvent("rF:UpdateStatus", thirst, hunger)
        Wait(1000)
    end
end)


function AddHunger(value)
    hunger = hunger + value
    if hunger > 100 then
        hunger = 100
    end
end

function RemoveHunger(value)
    hunger = hunger - value
end

RegisterNetEvent("rF:AddHunger")
AddEventHandler("rF:AddHunger", function(value)
    AddHunger(value)
end)

RegisterNetEvent("rF:RemoveHunger")
AddEventHandler("rF:RemoveHunger", function(value)
    RemoveHunger(value)
end)

function AddThirst(value)
    thirst = thirst + value
    if thirst > 100 then
        thirst = 100
    end
end

function RemoveThirst(value)
    thirst = thirst - value
end

RegisterNetEvent("rF:AddThirst")
AddEventHandler("rF:AddThirst", function(value)
    AddThirst(value)
end)

RegisterNetEvent("rF:RemoveThirst")
AddEventHandler("rF:RemoveThirst", function(value)
    RemoveThirst(value)
end)