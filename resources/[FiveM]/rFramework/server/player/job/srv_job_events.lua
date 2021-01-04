
RegisterNetEvent("rF:ChangePlayerJob")
AddEventHandler("rF:ChangePlayerJob", function(tokenToCheck, job)
    if CheckToken(tokenToCheck, source) then
        ChangePlayerJob(source, job)
    end
end)


RegisterNetEvent("rF:ChangeOtherPlayerJob")
AddEventHandler("rF:ChangeOtherPlayerJob", function(tokenToCheck, id, job, grade)
    if CheckToken(tokenToCheck, source) then
        ChangePlayerJob(id, job, grade)
    end
end)


RegisterNetEvent("rF:ChangePlayerJobGrade")
AddEventHandler("rF:ChangePlayerJobGrade", function(tokenToCheck, id, grade)
    if CheckToken(tokenToCheck, source) then
        ChangePlayerJobGrade(id, grade)
    end
end)

RegisterNetEvent("rF:ResetPlayerJob")
AddEventHandler("rF:ResetPlayerJob", function(tokenToCheck, id)
    if CheckToken(tokenToCheck, source) then
        ResetPlayerJob(id)
    end
end)



RegisterNetEvent("rF:GetPlayerJob")
AddEventHandler("rF:GetPlayerJob", function()
    local job, grade = GetPlayerJob(source)
    TriggerServerEvent("rF:JobRefresh", source, job, grade)
    TriggerClientEvent("rF:job", id, job)
end)