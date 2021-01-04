

RegisterCommand("unban", function(source, args, rawCommand)
    if source ~= 0 then
        if PlayersData[source].group ~= "user" then
            if args[1] ~= nil then
                unban(args[1], source)
            else
                print("Aucun ban-id spécifié.")
            end
        else
            print("Staff only command.")
        end
    else
        if args[1] ~= nil then
            unban(args[1])
        else
            print("Aucun ban-id spécifié.")
        end
    end
end, false)



RegisterCommand("acofflineban", function(source, args, rawCommand)
    if source == 0 then
        if args[1] ~= nil then
            acofflineban(args[1])
        else
            print("Aucun id spécifié.")
        end
    else
        print("Console only command.")
    end
end, true)


RegisterCommand("offlineban", function(source, args, rawCommand)
    if PlayersData[source].group ~= "user" then
        if args[1] ~= nil then
            SendBan(args, source)
        end
    end
end, false)

function SendBan(args, source)
    local target    = tonumber(args[1])
    local duree     = tonumber(args[2])
    local reason    = table.concat(args, " ",3)
    offlineban(target, duree, reason, source)
end

RegisterCommand("goto", function(source, args, rawCommand)
    if PlayersData[source].group ~= "user" then
        if args[1] ~= nil then
            TriggerEvent("core:Goto", source, tonumber(args[1]))
        end
    end
end, false)

RegisterCommand("bring", function(source, args, rawCommand)
    if PlayersData[source].group ~= "user" then
        if args[1] ~= nil then
            TriggerEvent("core:Bring", source, tonumber(args[1]))
        end
    end
end, false)

RegisterCommand("revive", function(source, args, rawCommand)
    if PlayersData[source].group ~= "user" then
        if args[1] ~= nil then
            TriggerEvent("core:DeathStatus", tonumber(args[1]))
        else
            TriggerEvent("core:DeathStatus", source)
        end
    end
end, false)


RegisterCommand("ban", function(source, args, rawCommand)
    if source == 0 then
        local target = tonumber(args[1])
        local duree = tonumber(args[2])
        local reason = table.concat(args, " ",3)
        if target ~= nil then
            if duree == 0 then
                BanPlayer(target, reason, 0)
            else
                TempBanPlayer(target, reason, duree, 0)
            end
        else
            print("Aucun id spécifié.")
        end
    elseif PlayersCache[source].group ~= "user" then
        local target = tonumber(args[1])
        local duree = tonumber(args[2])
        local reason = table.concat(args, " ",3)
        if target ~= nil then
            if duree == 0 then
                BanPlayer(target, reason, source)
            else
                TempBanPlayer(target, reason, duree, source)
            end
        end
    end
end, true)


RegisterCommand("maintenance", function(source, args, rawCommand)
    if source == 0 then
        if args[1] ~= nil then
            AddToMaintenance(args[1])
        end
    end 
end, true)


RegisterCommand("kickall", function(source, args, rawCommand)
    if source == 0 then
        local players = GetPlayers()
        local count = 0
        print("^2Ready ^7to kick "..#players.." players !")
        for k,v in pairs(players) do
            Wait(150)
            count = count + 1
            print("^2Kicked ^7#"..count)
            DropPlayer(v, "Restart du serveur en cours, merci d'attendre une annonce pour te reconnecter pour éviter toute corruption de personnage.")
        end
    end
end, true)


RegisterNetEvent("rF:BanPlayer")
AddEventHandler("rF:BanPlayer", function(token, target, duree, reason)
    if CheckToken(token, source, "rF:BanPlayer") then
        local target = tonumber(target)
        local duree = tonumber(duree)

        if duree == 0 then
            BanPlayer(target, reason, source)
        else
            TempBanPlayer(target, reason, duree, source)
        end
    end
end)


RegisterNetEvent("rF:KickPlayer")
AddEventHandler("rF:KickPlayer", function(token, target, reason)
    if CheckToken(token, source, "rF:BanPlayer") then
        DropPlayer(target, reason)
    end
end)