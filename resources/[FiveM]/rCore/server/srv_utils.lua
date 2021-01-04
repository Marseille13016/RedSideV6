
RegisterNetEvent("DeleteEntity")
AddEventHandler("DeleteEntity", function(token, list)
    if token == nil then return end
    if not exports.rFramework:CheckToken(token, source, "DeleteEntity") then return end
    local entity = NetworkGetEntityFromNetworkId(list)
    Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
end) 


function DeleteEntityYes(net)
    local entity = NetworkGetEntityFromNetworkId(net)
    Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
end


RegisterNetEvent("DeleteEntityTable")
AddEventHandler("DeleteEntityTable", function(token, list)
    if not exports.rFramework:CheckToken(token, source, "DeleteEntityTable") then return end
    for k,v in pairs(list) do
        local entity = NetworkGetEntityFromNetworkId(v)
        Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
    end
end)


RegisterNetEvent("SendCoordToWeb")
AddEventHandler("SendCoordToWeb", function(token, coords, heading)
    if not exports.rFramework:CheckToken(token, source, "SendCoordToWeb") then return end
    local message = "{pos = "..coords..",heading = "..heading..",},"


	local webhook = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end) 

RegisterNetEvent("SendVocToWeb")
AddEventHandler("SendVocToWeb", function(token, coords, chan)
    if not exports.rFramework:CheckToken(token, source, "SendCoordToWeb") then return end
    local message = "{pos = "..coords..",channel = \""..chan.."\", id = "..math.random(100001,999999).."},"


	local webhook = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end) 


RegisterNetEvent("SendInfoToWeb")
AddEventHandler("SendInfoToWeb", function(token, msg)
    if not exports.rFramework:CheckToken(token, source, "SendCoordToWeb") then return end


	local webhook = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
	end
end)


RegisterNetEvent("core:AskNumPlayers")
AddEventHandler("core:AskNumPlayers", function(token)
    if not exports.rFramework:CheckToken(token, source, "core:AskNumPlayers") then return end
    local players = #GetPlayers()
    TriggerClientEvent("core:GetPlayersNumber", source, players)
end)