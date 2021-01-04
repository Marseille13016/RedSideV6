

-- Change the job and call rF:JobRefresh with the new job in argument
function ChangePlayerJob(id, _job, _grade)
    local id = tonumber(id)
    if grade == nil then grade = 0 end
    PlayersData[id].job = _job
    PlayersData[id].job_grade = _grade
    TriggerClientEvent("rF:JobRefresh", id, PlayersData[id].job, PlayersData[id].job_grade)
    TriggerClientEvent("rF:job", id, _job)
end


function ResetPlayerJob(id)
    PlayersData[id].job = "Aucun"
    PlayersData[id].job_grade = 0
    TriggerClientEvent("rF:JobRefresh", id, PlayersData[id].job, PlayersData[id].job_grade)
    TriggerClientEvent("rF:job", id, job) 
end

function ChangePlayerJobGrade(id, grade)
    PlayersData[id].job_grade = grade
    TriggerClientEvent("rF:JobRefresh", id, PlayersData[id].job, PlayersData[id].job_grade)
    TriggerClientEvent("rF:job", id, job)
end


function GetPlayerJob(id)
    return PlayersData[id].job, PlayersData[id].job_grade
end
