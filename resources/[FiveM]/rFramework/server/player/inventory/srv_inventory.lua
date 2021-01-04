

function AddItemToPlayerInvBypass(id, item, _count, _label, _olabel)
    if DoesItemExist(item) then
        local countOld = PlayersData[id].inventory[_label]

        if countOld == nil then
            --table.insert(inv, {name = item, label = _label, olabel = _olabel, count = _count})
            PlayersData[id].inventory[_label] = {name = item, label = _label, olabel = _olabel, count = _count}
            TriggerClientEvent("rF:addItem", id, item.." x".._count)
        else
            PlayersData[id].inventory[_label].name = item
            PlayersData[id].inventory[_label].label = _label
            PlayersData[id].inventory[_label].olabel = _olabel
            PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count + _count
            TriggerClientEvent("rF:addItem", id, _label.." x".._count)
        end
    end
end

function AddItemToPlayerInv(id, item, _count, _label) 
    if DoesItemExist(item) then
        local inv =  PlayersData[id].inventory
        local invWeight = GetInvWeight(inv)
        local itemWeight, itemLabel = GetItemWeight(item, _count)
        
        if _label == nil then 
            _label = itemLabel
        end

        if invWeight + itemWeight <= framework._default_player_max_weight then
            local countOld = PlayersData[id].inventory[_label]

            if countOld == nil then
                PlayersData[id].inventory[_label] = {name = item, label = itemLabel, olabel = itemLabel, count = _count}
                TriggerClientEvent("rF:addItem", id, _label.." x".._count)

                local weight = GetInvWeight(PlayersData[id].inventory)
                TriggerClientEvent("rF:SendPlayerInventory", id, PlayersData[id].inventory, weight)
            else                  
                PlayersData[id].inventory[_label].name = item
                PlayersData[id].inventory[_label].label = _label
                PlayersData[id].inventory[_label].olabel = itemLabel
                PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count + _count
                TriggerClientEvent("rF:addItem", id, _label.." x".._count)


                local weight = GetInvWeight(PlayersData[id].inventory)
                TriggerClientEvent("rF:SendPlayerInventory", id, PlayersData[id].inventory, weight)
            end
        else
            TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu porte trop de chose.")
        end
    end
end

-- This bypass weight calculation
function AddItemIfNotAlreadyHave(id, item, _count)
    local oLabel = GetOriginalLabel(item)
    local count = PlayersData[id].inventory[oLabel]
    if count == nil then
        PlayersData[id].inventory[oLabel] = {name = item, label = oLabel, olabel = oLabel, count = _count}
        TriggerClientEvent("rF:addItem", id, oLabel.." x".._count)
    else
        TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu possède déja l'objets ~g~"..oLabel.."~w~.")
    end
end

function RenameItem(id, item, _label, _olabel)
    if _label ~= nil then
        local countOld = PlayersData[id].inventory[_olabel].count

        if PlayersData[id].inventory[_label] ~= nil then
            TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu possède déja un item rename ~g~".._label.."~w~.")
            return
        end

        if countOld - 1 > 0 then


            PlayersData[id].inventory[_olabel].name = item
            PlayersData[id].inventory[_olabel].label = _olabel
            PlayersData[id].inventory[_olabel].olabel = _olabel
            PlayersData[id].inventory[_olabel].count = PlayersData[id].inventory[_olabel].count - 1

            if PlayersData[id].inventory[_label] ~= nil then
                PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count + 1
            else
                PlayersData[id].inventory[_label] = {name = item, label = _label, olabel = _olabel, count = 1}
            end
            TriggerClientEvent("rF:addItem", id, _label.." x1")
        else
            PlayersData[id].inventory[_olabel] = nil
            if PlayersData[id].inventory[_label] ~= nil then
                PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count + 1
            else
                PlayersData[id].inventory[_label] = {name = item, label = _label, olabel = _olabel, count = 1}
            end
            TriggerClientEvent("rF:addItem", id, _label.." x1")
        end
    end
end

function ResetRenameItem(id, item, _label, oldLabel)
    local countOld = PlayersData[id].inventory[oldLabel].count
    local count = PlayersData[id].inventory[_label]
    
    
    if countOld - 1 == 0 then
        PlayersData[id].inventory[oldLabel] = nil
    else
        PlayersData[id].inventory[oldLabel].name = item
        PlayersData[id].inventory[oldLabel].label = oldLabel
        PlayersData[id].inventory[oldLabel].olabel = _label
        PlayersData[id].inventory[oldLabel].count = PlayersData[id].inventory[oldLabel].count - 1
    end

    if count == nil then
        PlayersData[id].inventory[_label] = {name = item, label = _label, olabel = _label, count = 1}
        TriggerClientEvent("rF:addItem", id, _label.." x1")
    else
        PlayersData[id].inventory[_label].name = item
        PlayersData[id].inventory[_label].label = _label
        PlayersData[id].inventory[_label].olabel = _label
        PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count + 1
        TriggerClientEvent("rF:addItem", id, _label.." x1")
    end
end


function BuyItemIfCanHoldIt(id, item, _count, price)
    if DoesItemExist(item) then
        local inv = GetInventoryFromCache(id)
        local invWeight = GetInvWeight(inv)
        local itemWeight, itemLabel = GetItemWeight(item, _count)

        if invWeight + itemWeight <= framework._default_player_max_weight then
            local pMoney = PlayersData[id].money
            if pMoney >= price * _count then
                RemovePlayerMoneyNoToken(id, price * _count)
                local countOld = PlayersData[id].inventory[itemLabel]
                if countOld == nil then
                    PlayersData[id].inventory[itemLabel] = {name = item, label = itemLabel, olabel = itemLabel, count = _count}
                    TriggerClientEvent("rF:addItem", id, itemLabel.." x".._count)
                else
                    PlayersData[id].inventory[itemLabel].name = item
                    PlayersData[id].inventory[itemLabel].label = itemLabel
                    PlayersData[id].inventory[itemLabel].olabel = itemLabel
                    PlayersData[id].inventory[itemLabel].count = PlayersData[id].inventory[itemLabel].count + _count
                    TriggerClientEvent("rF:addItem", id, itemLabel.." x".._count)
                end

            else
                TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu n'a pas assez d'argent.")
            end
        else
            TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu porte trop de chose.")
        end
    end
end

function TransferItemIfTargetCanHoldIt(id, target, item, _count, _label, countSee)
    local inv = PlayersData[target].inventory
    local sInv = GetInventoryFromCache(id)
    local invWeight = GetInvWeight(inv)
    local itemWeight, itemLabel = GetItemWeight(item, _count)
    
    if invWeight + itemWeight <= framework._default_player_max_weight then
        local countOld, num =  PlayersData[target].inventory[_label]
        local sCountOld, sNum =  PlayersData[id].inventory[_label].count
        if sCountOld ~= countSee then if sCountOld ~= countSee then AddPlayerLog(id, "Desync inventaire. Item: "..item.."\nCount Serveur: "..sCountOld.."\nCount client: "..countSee.."\nDemande: -".._count, 4)  return end return end
        if countOld == nil then
            PlayersData[target].inventory[_label] = {name = item, label = _label, olabel = itemLabel, count = _count}
            TriggerClientEvent("rF:addItem", target, _label.." x".._count)
        else
            PlayersData[target].inventory[_label].count = PlayersData[target].inventory[_label].count + _count
            TriggerClientEvent("rF:addItem", target, _label.." x".._count)
        end

        if sCountOld - _count == 0 then
            PlayersData[id].inventory[_label] = nil
            TriggerClientEvent("rF:rmvItem", id, _label.." x".._count)
        else
            PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count - _count
            TriggerClientEvent("rF:rmvItem", id, item.." x".._count)
        end

        SendLog("Le joueur **"..id.." "..GetPlayerName(id).."** à donné un/une "..item.." *".._label.." x".._count.." à **"..target.." "..GetPlayerName(target).."**", "items")
    else
        TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~La personne porte trop de chose.")
    end
end


function TransferItemIfTargetCanHoldItReverse(id, target, item, _count, _label, countSee)
    local inv = PlayersData[target].inventory
    local sInv = GetInventoryFromCache(id)
    local invWeight = GetInvWeight(inv)
    local itemWeight, itemLabel = GetItemWeight(item, _count)
    
    if invWeight + itemWeight <= framework._default_player_max_weight then
        local countOld, num =  PlayersData[target].inventory[_label]
        local sCountOld, sNum =  PlayersData[id].inventory[_label].count
        if sCountOld ~= countSee then AddPlayerLog(id, "Desync inventaire. Item: "..item.."\nCount Serveur: "..sCountOld.."\nCount client: "..countSee.."\nDemande: -".._count, 4)  return end
        if countOld == nil then
            PlayersData[target].inventory[_label] = {name = item, label = _label, olabel = itemLabel, count = _count}
            TriggerClientEvent("rF:addItem", target, _label.." x".._count)
        else
            PlayersData[target].inventory[_label].count = PlayersData[target].inventory[_label].count + _count
            TriggerClientEvent("rF:addItem", target, _label.." x".._count)
        end

        if sCountOld - _count == 0 then
            PlayersData[id].inventory[_label] = nil
            TriggerClientEvent("rF:rmvItem", id, _label.." x".._count)
        else
            PlayersData[id].inventory[_label].count = PlayersData[id].inventory[_label].count - _count
            TriggerClientEvent("rF:rmvItem", id, item.." x".._count)
        end

    else
        TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~La personne porte trop de chose.")
    end
end


function ExhangeItem(id, OriginalItem, ItemToGet)
    local invWeight = GetInvWeight(PlayersData[id].inventory)
    local oWheight, oLabel = GetItemWeight(OriginalItem, 1)
    if oLabel == nil then oLabel = GetOriginalLabel(itemToSell) end
    local iWheight, iLabel = GetItemWeight(ItemToGet, 1)
    if invWeight - oWheight + iWheight <= framework._default_player_max_weight then
        local oCount = PlayersData[id].inventory[oLabel]
        if oCount ~= nil then
            if PlayersData[id].inventory[oLabel].count - 1 <= 0 then
                PlayersData[id].inventory[oLabel] = nil
                TriggerClientEvent("rF:rmvItem", id, oLabel.." x1")
            else
                PlayersData[id].inventory[oLabel].count = PlayersData[id].inventory[oLabel].count - 1
                TriggerClientEvent("rF:rmvItem", id, oLabel.." x1")
            end

            local iCount = PlayersData[id].inventory[iLabel]
            if iCount == nil then
                PlayersData[id].inventory[iLabel] = {name = ItemToGet, label = iLabel, olabel = iLabel, count = 1}
                TriggerClientEvent("rF:addItem", id, iLabel.." x1")
            else
                PlayersData[id].inventory[iLabel].count = PlayersData[id].inventory[iLabel].count + 1
                TriggerClientEvent("rF:addItem", id, iLabel.." x1")
            end

            
        else
            TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu ne possède pas assez de ~g~"..oLabel.."~w~.") 
        end
    else
        TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~La personne porte trop de chose.")
    end
end

function SellItem(id, itemToSell, price, _count, clean)
    if _count == nil then _count = 1 end
    local inv = GetInventoryFromCache(id)
    local _, oLabel = GetItemWeight(itemToSell, 1)
    if oLabel == nil then oLabel = GetOriginalLabel(itemToSell) end
    local oCount = PlayersData[id].inventory[oLabel]
    if oCount ~= nil then
        if PlayersData[id].inventory[oLabel].count < _count then AddPlayerLog(id, "Desync inventaire. Item: "..itemToSell.."\nCount Serveur: "..PlayersData[id].inventory[oLabel].count.."\nCount client: ".._count.."\nDemande: -".._count, 4) return end
        if PlayersData[id].inventory[oLabel].count - _count <= 0 then
            PlayersData[id].inventory[oLabel] = nil
            if clean == nil or clean then
                PlayersData[id].money = PlayersData[id].money + price
            else
                PlayersData[id].dirtyMoney = PlayersData[id].dirtyMoney + price
            end
        else
            PlayersData[id].inventory[oLabel].count = PlayersData[id].inventory[oLabel].count - _count
            if clean == nil or clean then
                PlayersData[id].money = PlayersData[id].money + price
            else
                PlayersData[id].dirtyMoney = PlayersData[id].dirtyMoney + price
            end
        end
    else
        TriggerClientEvent("rF:notification", id, "~r~Action impossible.\n~w~Tu ne possède pas assez de ~g~"..oLabel.."~w~.") 
    end
end

function RemoveItemFromPlayerInv(id, item, _count)
    local count = PlayersData[id].inventory[item]
    if count ~= nil then
        if PlayersData[id].inventory[item].count - _count <= 0 then
            PlayersData[id].inventory[item] = nil
            TriggerClientEvent("rF:rmvItem", id, item.." x".._count)
            RefreshPlayerInventory(id)
        else
            PlayersData[id].inventory[item].count = PlayersData[id].inventory[item].count - _count
            TriggerClientEvent("rF:rmvItem", id, item.." x".._count)
            RefreshPlayerInventory(id)
        end
    end
end

function GetInventoryFromCache(id)
    return PlayersData[id].inventory
end

function GetInvWeight(inv)
    local weight = 0
    for _,v in pairs(inv) do
        local ItemWeight = GetItemWeight(v.name, v.count)
        weight = weight + ItemWeight
    end
    return weight
end

function GetWeight(id)
    local inv = GetInventoryFromCache(id)
    local weight = 0
    for _,v in pairs(inv) do
        local ItemWeight = GetItemWeight(v.name, v.count)
        weight = weight + ItemWeight
    end
    return weight
end


function GetItemWeight(item, count)
    for _,v in pairs(items) do
        if item == v.name then
            return v.weight * count, v.label
        end
    end
end

function GetItemWeightWithLabel(label, count)
    for _,v in pairs(items) do
        if label == v.label then
            return v.weight * count
        end
    end
end

function GetOriginalLabel(item)
    for k,v in pairs(items) do
        if v.name == item then
            return v.label
        end
    end
end


function GetItemCountWithLabel(_, inv, label)
    for k,v in pairs(inv) do 
        if v.label == label then
            print("GetItemCountWithLabel looking for ("..label.." and found ("..v.name, v.label, v.count..")")
            return v.count, k
        end
    end
    return 0
end


function GetItemCount(item, inv)
    local found = false
    for k,v in pairs(inv) do 
        if v.name == item then
            found = true
            return v.count, k
        end
    end
    -- Not sure if the if is needed, i think the return stop the for, not sure tho
    if not found then
        return 0
    end
end


function DoesItemExist(item)
    local exist = false
    for k,v in pairs(items) do
        if v.name == item then
            exist = true
            return exist
        end
    end
    return exist
end

function EncodeInventory(inv)
    local invToJson = json.encode(inv)
    return invToJson
end


function DecodeInventory(inv)
    local JsonToTable = json.decode(inv)
    return JsonToTable
end 


local debug = false
function DebugPrint(text)
    if debug then
        print(text)
    end
end