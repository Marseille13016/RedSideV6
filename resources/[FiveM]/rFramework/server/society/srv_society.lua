MySQL.ready(function ()
    GetSocietyToCache()
end)


SocietyCache = {}

local second = 1000
local minute = 60*second
Citizen.CreateThread(function()
    while true do
        Wait(5*minute)
        SaveSocietyCache()
    end
end)


function SaveSocietyCache()
    for k,v in pairs(SocietyCache) do
        MySQL.Async.execute("UPDATE society SET money = @money, money = @money, inventory = @inv WHERE society_name = @name", {
            ['@name'] = v.society,
            ['@inv'] = json.encode(v.inventory),
            ['@money'] = v.money,
        })
        print("^2Society ["..v.society.."] ^7saved to DB with "..v.money.."^2$^7 and "..#v.inventory.." items.")
    end
end

function GetSocietyToCache()
    local info = MySQL.Sync.fetchAll("SELECT society_name, money, inventory FROM society", {})
    for k,v in pairs(info) do
        local sInv = json.decode(v.inventory)
        SocietyCache[v.society_name] = {society = v.society_name, money = v.money, inventory = sInv}
        if framework._display_logs then
            print("^2Loading ^7society ["..v.society_name.."] to dynamic cache with "..v.money.."^2$^7 and "..#sInv.." items.")
        end
    end
end
  

function AddSocietyMoney(name, money)
    SocietyCache[name].money = SocietyCache[name].money + money
end

function PaySociety(id, name, money, banque)
    if not banque then
        PlayersData[id].money = PlayersData[id].money - money
        SocietyCache[name].money = SocietyCache[name].money + money
        TriggerClientEvent('rF:rmvMoney', id, money)
    else
        PlayersData[id].bankBalance = PlayersData[id].bankBalance - money
        SocietyCache[name].money = SocietyCache[name].money + money
        TriggerClientEvent('rF:rmvBank', id, money)
    end
end

function WashMoneyFromBossMenu(id, name, money)
    PlayersData[id].dirtyMoney = PlayersData[id].dirtyMoney - money
    SocietyCache[name].money = SocietyCache[name].money + money / 2
    SendLog("Le joueur **["..id.."]** "..GetPlayerName(id).." à déposer **"..(money / 2).."$** ("..money.." / taxe) dans la société **"..name.."** depuis un revenu inconnu", "society-money")
    TriggerClientEvent("rF:notification", id, "Blanchiment terminé, ~g~"..(money / 2).."$~s~ déposé dans le coffre entreprise (50% taxe)")
end

function TakeMoneyFromSociety(id, name, money)
    PlayersData[id].money = PlayersData[id].money + money
    SocietyCache[name].money = SocietyCache[name].money - money
    TriggerClientEvent('rF:addMoney', id, money)
    SendLog("Le joueur **["..id.."]** "..GetPlayerName(id).." à pris **"..money.."$** depuis la société **"..name.."**", "society-money")
end

function RemoveSocietyMoney(name, money)
    SocietyCache[name].money = SocietyCache[name].money - money
end


function GetSocietyItems(name)
    return SocietyCache[name].inventory
end


function TransferItemFromInvToSociety(id, _name, _item, _label, _olabel, _count)
    local itemCount = SocietyCache[_name].inventory[_label]
    if itemCount == nil then
        SocietyCache[_name].inventory[_label] = {name = _item, label = _label, olabel = _olabel, count = _count}
    else
        SocietyCache[_name].inventory[_label].count = SocietyCache[_name].inventory[_label].count + _count
    end
    local itemCount = PlayersData[id].inventory[_label].count
    if itemCount - _count <= 0 then
        PlayersData[id].inventory[_label] = nil
    else
        PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count - _count
    end
    SendLog("Le joueur **["..id.."]** "..GetPlayerName(id).." à déposé ".._item.." *".._label.."* x".._count.." dans la société ".._name, "society")
end


function TransferItemFromSocietyToInv(id, _name, _item, _label, _olabel, _count, countSee)
    
    local invWeight = GetInvWeight(PlayersData[id].inventory)
    local itemWeight, itemLabel = GetItemWeight(_item, _count)
    if invWeight + itemWeight <= framework._default_player_max_weight then
        local itemCount = SocietyCache[_name].inventory[_label]
        
        if itemCount == nil then
            print("The player ["..id.."] tried to remove an item ^1that do not exist^7 in ".._name.." inventory.")
            TriggerClientEvent("rF:notification", id, "~r~Désync inventaire / client serveur. Merci de fermer t'es menus et de les ouvrir de nouveau.")
            --AddPlayerLog(id, "Desync inventaire society. Society: ".._name.."\nItem: ".._item.."\nCount Serveur: 0\nCount client: "..countSee.."\nDemande: -".._count, 2)
            return
        else
            if SocietyCache[_name].inventory[_label].count ~= countSee then
                TriggerClientEvent("rF:notification", id, "~r~Désync inventaire / client serveur. Merci de fermer t'es menus et de les ouvrir de nouveau.")
                --AddPlayerLog(id, "Desync inventaire society. Society: ".._name.."\nItem: ".._item.."\nCount Serveur: "..SocietyCache[_name].inventory[_label].count.."\nCount client: "..countSee.."\nDemande: -".._count, 4)
                return
            end
        end
            
        if SocietyCache[_name].inventory[_label].count - _count == 0 then
            SocietyCache[_name].inventory[_label] = nil
        else
            SocietyCache[_name].inventory[_label].count = SocietyCache[_name].inventory[_label].count - _count
        end

        local itemCount = PlayersData[id].inventory[_label]
        if itemCount == nil then
            PlayersData[id].inventory[_label] = {name = _item, label = _label, olabel = _olabel, count = _count}
        else
            PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count + _count
        end

        SendLog("Le joueur **["..id.."]** "..GetPlayerName(id).." à pris ".._item.." *".._label.."* x".._count.." dans la société ".._name, "society")
    else
        TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu porte trop de chose.")
    end
end