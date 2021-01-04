

RegisterNetEvent("rF:GetPlayerInventory")
AddEventHandler("rF:GetPlayerInventory", function(token)
    if CheckToken(token, source, "GetPlayerInventory") then
        local weight = GetInvWeight(PlayersData[source].inventory)
        TriggerClientEvent("rF:SendPlayerInventory", source, PlayersData[source].inventory, weight)
    end
end)


function RefreshPlayerInventory(target)
    local weight = GetInvWeight(PlayersData[target].inventory)
    TriggerClientEvent("rF:SendPlayerInventory", target, PlayersData[target].inventory, weight)
end


RegisterNetEvent("rF:GetOtherPlayerInventory")
AddEventHandler("rF:GetOtherPlayerInventory", function(token, target)
    if CheckToken(token, source, "GetOtherPlayerInventory") then
        local weight = GetInvWeight(PlayersData[target].inventory)
        TriggerClientEvent("rF:SendPlayerInventory", source, PlayersData[target].inventory, weight)
        TriggerClientEvent("rF:notification", target, "Quelqu'un te fouille ...")
    end
end)

RegisterServerCallback('rF:GetOtherPlayerData', function(source, cb, target)
    local weight = GetInvWeight(PlayersData[target].inventory)
	cb(PlayersData[target].inventory, weight, PlayersData[target].money, PlayersData[target].dirtyMoney) -- Send back those data
end)

RegisterNetEvent("rF:GiveItem")
AddEventHandler("rF:GiveItem", function(token, item, count, id)
    if not CheckItemId(item, id, source) then return end
    if CheckToken(token, source, "GiveItem") then
        AddItemToPlayerInv(source, item, count)
    end
end)

RegisterNetEvent("rF:GiveItemToPlayer")
AddEventHandler("rF:GiveItemToPlayer", function(token, target, item, count, id)
    if not CheckItemId(item, id, source) then return end
    if CheckToken(token, source, "GiveItemToPlayer") then
        AddItemToPlayerInv(target, item, count)
    end
end)


RegisterNetEvent("rF:RemoveItem")
AddEventHandler("rF:RemoveItem", function(token, item, count)
    if CheckToken(token, source, "RemoveItem") then
        RemoveItemFromPlayerInv(source, item, count)
    end
end)


RegisterNetEvent("rF:RemoveItemToPlayer")
AddEventHandler("rF:RemoveItemToPlayer", function(token, target, item, count)
    if CheckToken(token, source, "RemoveItemToPlayer") then
        RemoveItemFromPlayerInv(target, item, count)
    end
end)


RegisterNetEvent("rF:BuyItemIfCan")
AddEventHandler("rF:BuyItemIfCan", function(token, item, count, price, id) 
    if not CheckItemId(item, id, source) then return end
    if CheckToken(token, source, "BuyItemIfCan") then
        if count == nil then return end
        BuyItemIfCanHoldIt(source, item, count, price)
    end
end)


RegisterNetEvent("rF:RenameItem")
AddEventHandler("rF:RenameItem", function(token, item, label, olabel)
    if CheckToken(token, source, "RenameItem") then
        RenameItem(source, item, label, olabel)
    end
end)

RegisterNetEvent("rF:ResetRenameItem")
AddEventHandler("rF:ResetRenameItem", function(token, item, label, oldlabel)
    if CheckToken(token, source, "ResetRenameItem") then
        ResetRenameItem(source, item, label, oldlabel)
    end
end)

RegisterNetEvent("rF:TransferItemIfTargetCanHoldIt")
AddEventHandler("rF:TransferItemIfTargetCanHoldIt", function(token, target, item, count, label, countSee)
    if CheckToken(token, source, "TransferItemIfTargetCanHoldIt") then
        TransferItemIfTargetCanHoldIt(source, target, item, count, label, countSee)
        RefreshPlayerInventory(target)
    end
end)

RegisterNetEvent("rF:TransferItemIfTargetCanHoldItReverse")
AddEventHandler("rF:TransferItemIfTargetCanHoldItReverse", function(token, target, item, count, label, countSee)
    if CheckToken(token, source, "TransferItemIfTargetCanHoldItReverse") then
        TransferItemIfTargetCanHoldItReverse(target, source, item, count, label, countSee)
        RefreshPlayerInventory(target)
    end
end)


RegisterNetEvent("rF:AddItemIfNotAlreadyHave")
AddEventHandler("rF:AddItemIfNotAlreadyHave", function(token, item, count)
    if CheckToken(token, source, "AddItemIfNotAlreadyHave") then
        AddItemIfNotAlreadyHave(source, item, count)
    end
end)

RegisterNetEvent("rF:ExhangeItem")
AddEventHandler("rF:ExhangeItem", function(token, OriginalItem, ItemToGet)
    if CheckToken(token, source, "ExhangeItem") then
        ExhangeItem(source, OriginalItem, ItemToGet)
        RefreshPlayerInventory(source)
    end
end)

RegisterNetEvent("rF:SellItem")
AddEventHandler("rF:SellItem", function(token, item, price, count, clean, id)
    if not CheckItemId(item, id, source) then return end
    if CheckToken(token, source, "SellItem") then
        SellItem(source, item, price, count, clean)
    end
end)