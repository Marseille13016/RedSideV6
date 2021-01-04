RegisterNetEvent("rF:AddSocietyMoney")
AddEventHandler("rF:AddSocietyMoney", function(token, society, amount)
    if CheckToken(token, source) then
        AddSocietyMoney(society, amount)
    end
end)

RegisterNetEvent("rF:WashMoneyOnSociety")
AddEventHandler("rF:WashMoneyOnSociety", function(token, society, amount)
    if CheckToken(token, source) then
        WashMoneyFromBossMenu(source, society, amount)
    end
end)

RegisterNetEvent("rF:RemoveSocietyMoney")
AddEventHandler("rF:RemoveSocietyMoney", function(token, society, amount)
    if CheckToken(token, source) then
        RemoveSocietyMoney(society, amount)
    end
end)

RegisterNetEvent("rF:PaySociety")
AddEventHandler("rF:PaySociety", function(token, society, amount, banque)
    if CheckToken(token, source) then
        PaySociety(source, society, amount, banque)
    end
end)

RegisterNetEvent("rF:TakeMoneyFromSociety")
AddEventHandler("rF:TakeMoneyFromSociety", function(token, society, amount)
    if CheckToken(token, source) then
        TakeMoneyFromSociety(source, society, amount)
    end
end) 

 
RegisterNetEvent("rF:GetSocietyInfos")
AddEventHandler("rF:GetSocietyInfos", function(token, society)
    if CheckToken(token, source) then
        TriggerClientEvent("rF:SendSocietyInfo", source, SocietyCache[society])
    end
end)

RegisterNetEvent("rF:TransferItemFromInvToSociety")
AddEventHandler("rF:TransferItemFromInvToSociety", function(token, society, _item, _label, _olabel, _count)
    if CheckToken(token, source) then
        TransferItemFromInvToSociety(source, society, _item, _label, _olabel, _count)
    end
end)

RegisterNetEvent("rF:TransferItemFromSocietyToInv")
AddEventHandler("rF:TransferItemFromSocietyToInv", function(token, society, _item, _label, _olabel, _count, countSee)
    if CheckToken(token, source) then
        TransferItemFromSocietyToInv(source, society, _item, _label, _olabel, _count, countSee)
    end
end)