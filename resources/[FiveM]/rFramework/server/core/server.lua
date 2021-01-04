Citizen.CreateThread(function()
    config = {
        player_money = framework._default_player_money,
        player_bank_balance = framework._default_player_bank_balance,
        player_dirty_money = framework._default_player_dirty_money,
		player_job = framework._default_player_job,
    }
end)



function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dumpinitializeinfo(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

RegisterServerEvent('rF:spawn') 
AddEventHandler('rF:spawn', function()
    TriggerClientEvent("rF:SendToken", source, token) -- Client side
    if IsAllowedToJoin(source) then
        local source = source
        local player = _player_get_identifier(source)
        local pCache = GetPlayerInfoToCache(source)
        InitSpawnPlayer(source)
        TriggerClientEvent('rF:initializeinfo', source, pCache.money, pCache.dirtyMoney, pCache.bankBalance, pCache.job, pCache.job_grade, pCache.skin, pCache.identity, pCache.cloths, pCache.group, pCache.vip, pCache.dead, pCache.uniqueId)
        AddToRequestCache(source)
    else
        DropPlayer(source, "Tu es déjà connecté au serveur avec ce compte Rockstar.")
    end
end) 

function IsAllowedToJoin(id)
    local license = _player_get_identifier(id)
    local players = GetPlayers()
    for k,v in pairs(players) do
        if tonumber(v) ~= tonumber(id) then
            local oLicense = _player_get_identifier(v)
            if license == oLicense then
                print("^1CONNEXION ERROR:^7 Someone tried to join the server with the same license than someone else.")
                return false
            end
        end
    end
    return true
end



PlayersData = {} -- Global for now, maybe turning it local later if not needed

local second = 1000
local minute = 60*second
Citizen.CreateThread(function()
    while true do
        SaveDynamicCache()
        Wait(3*minute)
    end
end)


AddEventHandler('playerDropped', function(reason)
    for k,v in pairs(PlayersData) do
        if v.ServerID == source then
            if framework._display_logs then
                print("Player "..v.ServerID.." ^1dropped^7, saving data.")
            end
            SendLog("```diff\n- ["..source.."] "..GetPlayerName(source).." raison: "..reason.."```", "connexion")
            SavePlayerCache(v.identifier, v)
        end
    end
end)


function SaveDynamicCache()
    local loop = 0
    for k,v in pairs(PlayersData) do
        loop = loop + 1
        if GetPlayerPing(v.ServerID) == 0 then -- If 0, that mean the player is not connected anymore (i suppose, need some test)
            if framework._display_logs then
                print("^1Removing ^7"..v.ServerID.." - "..loop.." from dynamic cache.")
            end
            PlayersData[v.ServerID] = nil
        else
            SavePlayerCache(v.identifier, v)
            Wait(500)
        end
    end
end


-- Call this to save user infos to database (identifier + cache table)
function SavePlayerCache(id, cache)
    local encodedInv = EncodeInventory(cache.inventory)
    local encodedIdentity = json.encode(cache.identity)
    local encodedCloth = json.encode(cache.cloths)
    if cache.job_grade == nil then cache.job_grade = 0 end
    MySQL.Async.execute("UPDATE player_account SET deadOrNot = @dead, player_position = @pos, player_skin = @skin, player_cloths = @cloths, player_identity = @identity, player_inv = @inv, player_money = @money, player_bank_balance = @bankBalance, player_dirty_money = @bankBalance, player_dirty_money = @dirtyMoney, player_job = @job, player_job_grade = @job_grade, player_group = @group WHERE player_identifier = @identifier", {
        ['@identifier'] = id,
        ['@inv'] = encodedInv,
        ['@money'] = cache.money,
        ['@bankBalance'] = cache.bankBalance,
        ['@dirtyMoney'] = cache.dirtyMoney,
        ['@job'] = cache.job,
        ['@job_grade'] = cache.job_grade,
        ['@group'] = cache.group,
        ['@pos'] = cache.pos,
        ['@skin'] = cache.skin,
        ['@cloths'] = encodedCloth,
        ['@identity'] = encodedIdentity,
        ['@dead'] = cache.dead,
    })

    if encodedIdentity == "[]" then
        MySQL.Async.execute("UPDATE player_account SET player_first_spawn = @player_first_spawn WHERE player_identifier = @id", { 
            ["@player_first_spawn"] = 'first_spawn', 
            ["@id"] = id, 
        })
    end
    
end


function DoesPlayerExisit(id)
    local player = _player_get_identifier(id)
    local info = MySQL.Sync.fetchAll("SELECT * FROM player_account WHERE player_identifier = @identifier", {
        ['@identifier'] = player
    })
    return info
end

-- Call this on player connexion
function GetPlayerInfoToCache(id)

    local player = DoesPlayerExisit(id)
    if player[1] == nil then
        creation_utilisateur(id)

        if framework._display_logs == true then
            print('' .. _L("new_user") .. '| '..GetPlayerName(id)..'')
        end

    end

    local player = _player_get_identifier(id)
    --table.insert(PlayersData, {ServerID = id})
    PlayersData[id] = {ServerID = id}

    local info = MySQL.Sync.fetchAll("SELECT * FROM player_account WHERE player_identifier = @identifier", {
        ['@identifier'] = player
    })
    
    PlayersData[id].uniqueId = info[1].id_unique
    PlayersData[id].ServerID = id
    PlayersData[id].identifier = player
    if info[1].player_inv ~= nil then
        PlayersData[id].inventory = DecodeInventory(info[1].player_inv)
    else
        PlayersData[id].inventory = {}
    end
    PlayersData[id].money = info[1].player_money
    PlayersData[id].bankBalance = info[1].player_bank_balance
    PlayersData[id].dirtyMoney = info[1].player_dirty_money
    PlayersData[id].dead = info[1].deadOrNot
    PlayersData[id].job = info[1].player_job
    PlayersData[id].job_grade = info[1].player_job_grade
    PlayersData[id].group = info[1].player_group
    PlayersData[id].pos = info[1].player_position
    PlayersData[id].skin = info[1].player_skin
    if info[1].vip ~= 0 then
        local status = CheckVipStatus(info[1].vip_time, player)
        if status then
            PlayersData[id].vip = info[1].vip 
        else
            PlayersData[id].vip = 0
        end
    else
        PlayersData[id].vip = 0
    end

    if info[1].player_cloths ~= nil then
        PlayersData[id].cloths = json.decode(info[1].player_cloths)
    else
        PlayersData[id].cloths = {}
    end

    if info[1].player_identity ~= nil then
        PlayersData[id].identity = json.decode(info[1].player_identity)
    else
        PlayersData[id].identity = {}
    end
    if framework._display_logs then
        print("^2Adding ^7["..id.."] "..GetPlayerName(id).." to dynamic cache.")
    end

    SendLog("```diff\n+ ["..id.."] "..GetPlayerName(id).." ID Unique: "..info[1].id_unique.."```", "connexion")

    local ids = GetPlayerIdentifiers(id)
    local msg = ""
    for k,v in pairs(ids) do
        msg = msg..v.."\n"
    end

    Citizen.CreateThread(function()
        if PlayersData[id].identity.nom ~= nil and PlayersData[id].identity.prenom ~= nil then
            SendLog("```\nPseudo steam: "..GetPlayerName(id).."\nID UNIQUE: "..info[1].id_unique.."\nRP NAME: "..PlayersData[id].identity.nom.." "..PlayersData[id].identity.prenom.."\nJob: "..PlayersData[id].job.."\nArgent: "..PlayersData[id].money.."\nBanque: "..PlayersData[id].bankBalance.."\nDirty Money: "..PlayersData[id].dirtyMoney.."\nIds:\n"..msg.."```", "connexion-extra")
        end
    end)
    return PlayersData[id]
end

function CheckVipStatus(time, id)
    --print(tonumber(time), os.time())
    if tonumber(time) < os.time() then
        MySQL.Async.execute("UPDATE player_account SET vip = @vip, vip_time = @vip WHERE player_identifier = @identifier", {
            ['@identifier'] = id,
            ['@vip'] = 0,
        })
        --print("^1 VIP RESET ^7")
        return false
    end
    --print("^2 CONNEXION AVEC VIP ^7")
    return true
end

function GetPlayerCache(id)
    return PlayersData[id]
end