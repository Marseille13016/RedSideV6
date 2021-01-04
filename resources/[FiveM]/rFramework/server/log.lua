local img = "https://media.discordapp.net/attachments/717811885864517713/720626444740591746/271590_20200610135036_1.png?width=812&height=457"

local webhooks = {
    ["group"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["staffmod"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["concess"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["veh-vente"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["identity"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["items"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["money"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["society"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["society-money"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["give-staff"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["veh"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["gross-transaction"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["connexion"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["connexion-extra"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["transaction-louche"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["kill"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["superette"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["facture"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
    ["tel-msg"] = {w = "https://discord.com/api/webhooks/772438370219589652/boiQOmR3X5EMEdBEUrXJCTeeJVHUPGSiGZPStnxKZUxnE9cm_i8fACveJTD9VMI-NMVn"},
}

function SendLog(msg, type)
    local webhook = webhooks[type].w

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = type, content = msg, avatar_url = img, tts = false}), { ['Content-Type'] = 'application/json' })
end

local DeathType = {
    [1] = {name = "mêlée"},
    [2] = {name = "tiré sur"},
    [3] = {name = "tranché"},
    [4] = {name = "renversé"},
    [5] = {name = "tué par un animal"},
    [6] = {name = "tué par dégats de chute"},
    [7] = {name = "tué par une explosion"},
    [8] = {name = "tué avec du fuel"},
    [9] = {name = "brulé"},
    [10] = {name = "noyé"},
    [11] = {name = "Inconnu"},
}


RegisterNetEvent("rF:LogPlayerDeath") 
AddEventHandler("rF:LogPlayerDeath", function(type, killerName, killerId)
    if type == 1 or type == 2 or type == 3 or type == 4 then
        SendLog("**["..killerId.."]** "..killerName.." "..DeathType[type].name.." **["..source.."]** "..GetPlayerName(source), "kill")
    else
        SendLog("**["..source.."]** "..GetPlayerName(source) .. " "..DeathType[type].name, "kill")
    end
end)