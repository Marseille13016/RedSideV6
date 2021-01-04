
-- Getter
function getIdentifiant(id)
    for _, v in pairs(id) do
        if string.find(v, "license") then
            return v
        end
    end
end

function _player_get_identifier(id)
    local identifiers = GetPlayerIdentifiers(id)
    local player = getIdentifiant(identifiers)
    return player
end

-- Export Config
function Config()
    return config
end

-- Sending back money / bank / dirty money
function _server_get_player_all_money(id)
    local player = _player_get_identifier(id)
    return PlayersData[player].money, PlayersData[player].bankBalance, PlayersData[player].dirtyMoney
end

function _server_refrech_player_money(id) -- not sure why we would need this ? Maybe if we make a change on the DB and the player is still connected ? Not sure.
    local player = _player_get_identifier(id)
    local info = MySQL.Sync.fetchAll("SELECT player_account.player_money, player_account.player_bank_balance, player_account.player_dirty_money FROM player_account WHERE player_identifier = @identifier", {
        ['@identifier'] = player
    })
    PlayersData[id].money = info[1].player_money
    PlayersData[id].bankBalance = info[1].player_bank_balance
    PlayersData[id].dirtyMoney = info[1].player_dirty_money
end

function creation_utilisateur(id)
    local player = _player_get_identifier(id)
    MySQL.Sync.execute("INSERT INTO `player_account` (`player_identifier`, `player_group`, `player_money`, `player_bank_balance`,`player_dirty_money`, `player_inv`, `player_job_grade`) VALUES (@identifier,'user', @money, @player_bank_balance, @dirtymoney, '{}', 0) ", {
        ['@identifier'] = player,
        ['@money'] = tonumber(config.player_money),
        ['@player_bank_balance'] = tonumber(config.player_bank_balance),
        ['@dirtymoney'] = tonumber(config.player_dirty_money)
    })
end

function GetPlayerAccounts(id)
    return PlayersData[id].money, PlayersData[id].bankBalance, PlayersData[id].dirtyMoney
end

RegisterNetEvent("rF:GetPlayerAccounts") 
AddEventHandler("rF:GetPlayerAccounts", function(tokenToCheck)
    if CheckToken(tokenToCheck, source, "GetPlayerAccounts") then
        local money, bank, dirty = GetPlayerAccounts(source)
        TriggerClientEvent("rF:SendPlayerAccounts", source, money, bank, dirty)
    end
end)


-- Setter 
function RemovePlayerMoney(tokenToCheck, id, rmv)
    if CheckToken(tokenToCheck, id, "RemovePlayerMoney") then
        local player = _player_get_identifier(id)
        PlayersData[id].money = tonumber(PlayersData[id].money - rmv)
        TriggerClientEvent('rF:rmvMoney', id, rmv)
    end
end

function RemovePlayerMoneyNoToken(id, rmv)
    local player = _player_get_identifier(id)
    PlayersData[id].money = tonumber(PlayersData[id].money - rmv)
    TriggerClientEvent('rF:rmvMoney', id, rmv)
end

RegisterNetEvent("rF:RemoveMoney")
AddEventHandler("rF:RemoveMoney", function(tokenToCheck, rmv)
    RemovePlayerMoney(tokenToCheck, source, rmv)
end)

function _player_add_money(tokenToCheck, id, add)
    if CheckToken(tokenToCheck, id, "_player_add_money") then
        local player = _player_get_identifier(id)
        PlayersData[id].money = tonumber(PlayersData[id].money + add)
        TriggerClientEvent('rF:addMoney', id, add)
        if tonumber(add) > 4500 then
            SendLog("@here Grosse transaction à vérifier de **["..id.."]** "..GetPlayerName(id).." - montant: **"..add.."$** job: "..PlayersData[id].job, "gross-transaction")
        end
    end
end

RegisterNetEvent("rF:AddMoney")
AddEventHandler("rF:AddMoney", function(tokenToCheck, add)
    if tonumber(add) > 600 then
        SendLog("Transaction louche à surveillé pour ["..source.."] "..GetPlayerName(source).."\nTransaction: "..add.."$\nJob: "..PlayersData[source].job.."\nID UNIQUE: "..PlayersData[source].uniqueId.."", "transaction-louche")
    end
    _player_add_money(tokenToCheck, source, add)
end) 

RegisterNetEvent("rF:AddMoneyStaff")
AddEventHandler("rF:AddMoneyStaff", function(tokenToCheck, add, id)
    _player_add_money(tokenToCheck, id, add)
    SendLog("Le staff **["..source.."]** "..GetPlayerName(source).." à donné **"..add.."**$ à **["..id.."]** "..GetPlayerName(id).."", "give-staff")
end)

RegisterNetEvent("rF:AddMoneyToPlayer")
AddEventHandler("rF:AddMoneyToPlayer", function(tokenToCheck, add, id)
    _player_add_money(tokenToCheck, id, add)
end)

function _player_add_bank_money(tokenToCheck, id, add)
    if CheckToken(tokenToCheck, id, "_player_add_bank_money") then
        local player = _player_get_identifier(id)
        PlayersData[id].bankBalance = tonumber(PlayersData[id].bankBalance + add)
        TriggerClientEvent('rF:addBank', id, add)
    end
end

RegisterNetEvent("rF:AddBankMoney")
AddEventHandler("rF:AddBankMoney", function(tokenToCheck, add)
    _player_add_bank_money(tokenToCheck, source, add)
end)

RegisterNetEvent("rF:AddBankMoneyStaff")
AddEventHandler("rF:AddBankMoneyStaff", function(tokenToCheck, add, id)
    _player_add_bank_money(tokenToCheck, id, add)
    SendLog("Le staff **["..source.."]** "..GetPlayerName(source).." à donné **"..add.."**$ (banque) à **["..id.."]** "..GetPlayerName(id).."", "give-staff")
end)

function _player_remove_bank_money(tokenToCheck, id, rmv)
    if CheckToken(tokenToCheck, id, "_player_remove_bank_money") then
        local player = _player_get_identifier(id)
        PlayersData[id].bankBalance = tonumber(PlayersData[id].bankBalance - rmv)
        TriggerClientEvent('rF:rmvBank', id, rmv)
    end
end

RegisterNetEvent("rF:RemoveBankMoney")
AddEventHandler("rF:RemoveBankMoney", function(tokenToCheck, rmv)
    _player_remove_bank_money(tokenToCheck, source, rmv)
end)

function _player_remove_dirty_money(tokenToCheck, id, add)
    if CheckToken(tokenToCheck, id, "_player_remove_dirty_money") then
        local player = _player_get_identifier(id)
        PlayersData[id].dirtyMoney = tonumber(PlayersData[id].dirtyMoney - add)
        TriggerClientEvent('rF:rmvDirtyMoney', id, add)
    end
end

RegisterNetEvent("rF:RemoveDirtyMoney")
AddEventHandler("rF:RemoveDirtyMoney", function(tokenToCheck, rmv)
    _player_remove_dirty_money(tokenToCheck, source, rmv)
end)




function _player_set_dirty_money(tokenToCheck, id, nb)
    if CheckToken(tokenToCheck, id, "_player_set_dirty_money") then
        PlayersData[id].dirtyMoney = tonumber(nb)
    end
end

RegisterNetEvent("rF:SetDirtyMoney")
AddEventHandler("rF:SetDirtyMoney", function(tokenToCheck, set)
    _player_set_dirty_money(tokenToCheck, source, set)
end)

function AddDirtyMoney(id, nb)
    PlayersData[id].dirtyMoney = PlayersData[id].dirtyMoney + tonumber(nb)
end

RegisterNetEvent("rF:GiveDirtyMoney")
AddEventHandler("rF:GiveDirtyMoney", function(tokenToCheck, set)
    if CheckToken(tokenToCheck, source, "AddDirtyMoney") then
        AddDirtyMoney(source, set)
    end
end)

RegisterNetEvent("rF:GiveDirtyMoneyToId")
AddEventHandler("rF:GiveDirtyMoneyToId", function(tokenToCheck, set, id)
    if CheckToken(tokenToCheck, source, "AddDirtyMoney") then
        AddDirtyMoney(id, set)
    end
end)

function _player_remove_money_for_bank(tokenToCheck, id, rmv)
    if CheckToken(tokenToCheck, id, "_player_remove_money_for_bank") then
        local player = _player_get_identifier(id)
        if PlayersData[id].money >= rmv then
            PlayersData[id].money = tonumber(PlayersData[id].money - rmv)
            PlayersData[id].bankBalance = tonumber(PlayersData[id].bankBalance + rmv)
            TriggerClientEvent("rF:MoneyToBank", id, tonumber(rmv))
        end
    end
end

RegisterNetEvent("rF:MoveMoneyToBank")
AddEventHandler("rF:MoveMoneyToBank", function(tokenToCheck, rmv)
    _player_remove_money_for_bank(tokenToCheck, source, rmv)
end)

function _player_remove_bank_for_money(tokenToCheck, id, rmv)
    if CheckToken(tokenToCheck, id, "_player_remove_bank_for_money") then
        local player = _player_get_identifier(id)
        if PlayersData[id].bankBalance >= rmv then
            PlayersData[id].money = tonumber(PlayersData[id].money + rmv)
            PlayersData[id].bankBalance = tonumber(PlayersData[id].bankBalance - rmv)
            TriggerClientEvent("rF:BankToMoney", id, tonumber(rmv))
        end
    end
end

RegisterNetEvent("rF:MoveMoneyFromBankToPlayer")
AddEventHandler("rF:MoveMoneyFromBankToPlayer", function(tokenToCheck, rmv)
    _player_remove_bank_for_money(tokenToCheck, source, rmv)
end)

function save_player_position(LastPosX, LastPosY, LastPosZ, LastPosH)
    TriggerEvent('rF:save_position', LastPosX, LastPosY, LastPosZ, LastPosH)
end

RegisterNetEvent("rF:GiveMoneyToPlayer")
AddEventHandler("rF:GiveMoneyToPlayer", function(tokenToCheck, target, money)
    if CheckToken(tokenToCheck, source, "GiveMoneyToPlayer") then
        GiveMoneyToPlayer(source, target, money)
    end
end)


function GiveMoneyToPlayer(source, target, _money)
    if PlayersData[source].money >= _money then
        PlayersData[source].money = PlayersData[source].money - _money
        TriggerClientEvent('rF:rmvMoney', source, _money)
        PlayersData[target].money = PlayersData[target].money + _money
        TriggerClientEvent('rF:addMoney', target, _money)
        if _money > 9500 then
            SendLog("@here Le joueur **"..source.." "..GetPlayerName(source).."** à donné un/une ".._money.."$ à **"..target.." "..GetPlayerName(target).."**", "money")
        else
            SendLog("Le joueur **"..source.." "..GetPlayerName(source).."** à donné un/une ".._money.."$ à **"..target.." "..GetPlayerName(target).."**", "money")
        end
    end
end


RegisterNetEvent("rF:GiveDirtyMoneyToPlayer")
AddEventHandler("rF:GiveDirtyMoneyToPlayer", function(tokenToCheck, target, money)
    if CheckToken(tokenToCheck, source, "GiveDirtyMoneyToPlayer") then
        GiveDirtyMoneyToPlayer(source, target, money)
    end
end)


function GiveDirtyMoneyToPlayer(source, target, money)
    local pCache = GetPlayerCache(source)
    local tCache = GetPlayerCache(target)
    if PlayersData[source].dirtyMoney >= money then
        PlayersData[source].dirtyMoney = PlayersData[source].dirtyMoney - money
        PlayersData[target].dirtyMoney = PlayersData[target].dirtyMoney + money
        SendLog("Le joueur **"..source.." "..GetPlayerName(source).."** à donné un/une "..money.."$ (Argent sale) à **"..target.." "..GetPlayerName(target).."**", "money")
    end
end

RegisterNetEvent("rF:SaveSkin")
AddEventHandler("rF:SaveSkin", function(tokenToCheck, skin)
    if CheckToken(tokenToCheck, source, "SaveSkin") then
        PlayersData[source].skin = skin
    end
end)

RegisterNetEvent("rF:SaveCloth")
AddEventHandler("rF:SaveCloth", function(tokenToCheck, _name, cloth)
    if CheckToken(tokenToCheck, source, "SaveCloth") then
        PlayersData[source].cloths[_name] = {name = _name, data = cloth}
        TriggerClientEvent("rF:RefreshCloths", source, PlayersData[source].cloths)
    end
end)

-- Table to send
--
--   Identity = {
--       nom = pNom, -- String
--       prenom = pPrenom, -- String
--       age = page, -- String
--   }
RegisterNetEvent("rF:ChangePlayerIdentity")
AddEventHandler("rF:ChangePlayerIdentity", function(tokenToCheck, _identity)
    if CheckToken(tokenToCheck, source, "rF:ChangePlayerIdentity") then
        PlayersData[source].identity = _identity
        TriggerClientEvent("rF:UpdateIdentity", source, _identity) -- Refresh the player identity in ressource
        local license = _player_get_identifier(source)
        SetNotFirstSpawn(license)
        SendLog("Nouvelle identité de ["..source.."] **"..GetPlayerName(source).."**. nom: **".._identity.nom.."** prénom: **".._identity.prenom.."** age: **".._identity.age.."**", "identity")
    end
end)

function GetPlayerJob(id)
    return PlayersData[id].job
end


function SetPlayerDeathStatus(id, status)
    if status then
        PlayersData[tonumber(id)].dead = 1
    else
        PlayersData[tonumber(id)].dead = 0
    end
end

RegisterNetEvent("rF:ChangePlayerGroup")
AddEventHandler("rF:ChangePlayerGroup", function(tokenToCheck, id, _group)
    if CheckToken(tokenToCheck, id, "rF:ChangePlayerGroup") then
        PlayersData[tonumber(id)].group = _group
        TriggerClientEvent("rF:UpdateGroup", tonumber(id), PlayersData[tonumber(id)].group) -- Refresh the player identity in ressource
        SendLog("``Le joueur ["..source.."] "..GetPlayerName(source).." à changer le groupe de ["..tonumber(id).."] "..GetPlayerName(tonumber(id)).." en : ".._group.."``", "group")
    end
end)


local stafffmod = {}
RegisterNetEvent("rF:Staffmod")
AddEventHandler("rF:Staffmod", function(tokenToCheck, staffmod)
    if CheckToken(tokenToCheck, id, "rF:Staffmod") then
        if staffmod then
            SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." à activer son menu staff``", "staffmod")
            stafffmod[source] = {time = os.time()}
        else
            local min, sec = GetTime(os.difftime(os.time(), stafffmod[source].time))
            SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." à désactiver son menu staff après "..min.."m et "..sec.."s en staffmod``", "staffmod")
            stafffmod[source] = nil
        end
    end
end)

function GetTime(time)
    local time = time
    local min = 0
    while time > 60 do
        time = time - 60
        min = min + 1
    end
    return min, time
end

-- Callback exemple
RegisterNetEvent("core:CallBackReady")
AddEventHandler("core:CallBackReady", function()

    
    RegisterServerCallback('rF:TestCallback', function(source, cb)
        local money = PlayersData[source].money -- GetPlayerMoney
        local job = PlayersData[source].job -- GetPlayerJob
    	cb(money, job) -- Send back those data
    end)

end)