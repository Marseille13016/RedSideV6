

PlayersCache = {}

RegisterNetEvent("rF:AddToCache")
AddEventHandler("rF:AddToCache", function()
    if PlayersCache[source] == nil then
        local ids = GetPlayerIdentifiers(source)
        PlayersCache[source] = {}
        PlayersCache[source].ids = {}
        for k,v in pairs(ids) do
            table.insert(PlayersCache[source].ids, v)
        end
        PlayersCache[source].name = GetPlayerName(source)
    else
        AddPlayerLog(source, "Adding to cache when already in it.", 2)
    end
end)



function GetIdsFromCache(id)
    local id = tonumber(id)
    if PlayersCache[id] ~= nil then
        return PlayersCache[id]
    else
        return false
    end
end