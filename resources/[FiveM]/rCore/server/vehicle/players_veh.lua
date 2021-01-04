

PlayersVehCache = {}
local LspdVehsCache = {}

RegisterNetEvent("core:GetPlayersVehicle")
AddEventHandler("core:GetPlayersVehicle", function(token, _nom, _prenom)
    if not exports.rFramework:CheckToken(token, source, "GetPlayersVehicle") then return end
    local source = source
    local id = GetLicense(source)
    if PlayersVehCache[id] ~= nil then
        TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
        return
    end

    local info = MySQL.Sync.fetchAll("SELECT player_vehs.props, player_vehs.plate, player_vehs.lspd, player_vehs.vip FROM `player_vehs` WHERE owner = @ids", {
        ['@ids'] = id
    })

    if #info > 0 then
        PlayersVehCache[id] = {}
        for i = 1, #info do
            if info[i].lspd == 1 then
                table.insert(PlayersVehCache[id], {
                    plate = info[i].plate,
                    props = info[i].props, 
                    ranger = true, 
                    vip = info[i].vip,
                    NetID = nil,
                    lspd = true,
                    nom = _nom,
                    prenom = _prenom,
                })
                table.insert(LspdVehsCache, {
                    plate = info[i].plate,
                    props = info[i].props, 
                    ranger = true, 
                    vip = info[i].vip,
                    NetID = nil,
                    lspd = true,
                    nom = _nom,
                    prenom = _prenom,
                })
            else
                table.insert(PlayersVehCache[id], {
                    plate = info[i].plate,
                    props = info[i].props, 
                    ranger = true, 
                    vip = info[i].vip,
                    NetID = nil,
                    lspd = false,
                    nom = _nom,
                    prenom = _prenom,
                })
            end
            print("^2Added ^7["..info[i].plate.."] to ["..source.."] vehicles cache.")
        end
        TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
        return
    else
        PlayersVehCache[id] = {}
        print("^2Creating vehs dynamic cache for ^7["..id.."] with "..#info .." vehicles.")
        
    end
    return {}
end)

RegisterNetEvent("core:SetVehStatus")
AddEventHandler("core:SetVehStatus", function(token, _plate, net)
    if not exports.rFramework:CheckToken(token, source, "SetVehStatus") then return end
    local id = GetLicense(source)
    if PlayersVehCache[id] == nil then GetPVehsToCache() end
    for k,v in pairs(PlayersVehCache[id]) do
        if v.plate == _plate then
            PlayersVehCache[id][k].ranger = false
            PlayersVehCache[id][k].NetID = net
        end
    end
    TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
end)

RegisterNetEvent("core:SetVehStatusLSPD")
AddEventHandler("core:SetVehStatusLSPD", function(token, _plate, net)
    if not exports.rFramework:CheckToken(token, source, "SetVehStatus") then return end
    for k,v in pairs(PlayersVehCache) do
        for j,i in pairs(PlayersVehCache[k]) do
            if i.plate == _plate then
                if PlayersVehCache[k][j].lspd ~= true then
                    PlayersVehCache[k][j].ranger = false
                    PlayersVehCache[k][j].NetID = net
                    PlayersVehCache[k][j].lspd = true
                    MySQL.Async.execute('UPDATE `player_vehs` SET player_vehs.lspd = @lspd WHERE player_vehs.plate = @plate', {
                        ["@lspd"] = true,
                        ["@plate"] = _plate,
                    }, function(rowsChanged) end)
                end
            end
        end
    end
    DeleteEntityYes(net)

    TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
end)

RegisterNetEvent("core:lspdCheckPlate")
AddEventHandler("core:lspdCheckPlate", function(token, _plate)
    if not exports.rFramework:CheckToken(token, source, "lspdCheckPlate") then return end
    for k,v in pairs(PlayersVehCache) do
        for j,i in pairs(PlayersVehCache[k]) do
            if PlayersVehCache[k][j].plate == _plate then
                if PlayersVehCache[k][j].lspd ~= true then
                    PlayersVehCache[k][j].NetID = net
                    TriggerClientEvent("rF:notification", source, "~o~Information véhicule\n~w~Plaque: ".._plate.."\nEnregistré au nom de: ~b~".. PlayersVehCache[k][j].nom.." ".. PlayersVehCache[k][j].prenom)
                    return
                end
            end
        end
    end
    TriggerClientEvent("rF:notification", source, "~o~Information véhicule\n~w~Plaque: ".._plate.."\nEnregistré au nom de: ~b~Jean Moldu")

    TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
end)

RegisterNetEvent("core:RemoveVehStatusLSPD")
AddEventHandler("core:RemoveVehStatusLSPD", function(token, _plate, net)
    if not exports.rFramework:CheckToken(token, source, "SetVehStatus") then return end
    for k,v in pairs(PlayersVehCache) do
        for j,i in pairs(PlayersVehCache[k]) do
            if i.plate == _plate then
                if PlayersVehCache[k][j].lspd == true then
                    PlayersVehCache[k][j].ranger = false
                    PlayersVehCache[k][j].NetID = net
                    PlayersVehCache[k][j].lspd = false
                    MySQL.Async.execute('UPDATE `player_vehs` SET player_vehs.lspd = @lspd WHERE player_vehs.plate = @plate', {
                        ["@lspd"] = 0,
                        ["@plate"] = _plate,
                    }, function(rowsChanged) end)
                end
                break
            end
        end
    end

    TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
end)



function RegisterLspdCallback()
    exports.rFramework:RegisterServerCallback('core:GetAllLspdVeh', function(source, cb)
        local VehToSend = {}
        for k,v in pairs(PlayersVehCache) do
            for j,i in pairs(PlayersVehCache[k]) do
                if i.lspd == true then
                    table.insert(VehToSend, i)
                end
            end
        end
        for k,v in pairs(VehToSend) do
            if type(v.props) ~= "table" then
                VehToSend[k].props = json.decode(v.props)
            end
        end
        cb(VehToSend)
    end)

    exports.rFramework:RegisterServerCallback('core:GetVehInFourriere', function(source, cb)
        local VehToSend = {}
        local id = GetLicense(source)
        if PlayersVehCache[id] ~= nil then
            for k,v in pairs(PlayersVehCache[id]) do
                if v.lspd == false or v.lspd == nil then
                    if NetworkGetEntityFromNetworkId(v.NetID) == 0 or GetEntityCoords(NetworkGetEntityFromNetworkId(v.NetID)) == vector3(0, 0, 0) then
                        table.insert(VehToSend, {plate = v.plate, props = v.props, can = true})
                    else
                        table.insert(VehToSend, {plate = v.plate, props = v.props, can = false})
                    end
                end
            end

            for k,v in pairs(VehToSend) do
                if type(v.props) ~= "table" then
                    VehToSend[k].props = json.decode(v.props)
                end
            end
        end
        cb(VehToSend)
    end)
end


local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end


function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	Citizen.Wait(2)
	math.randomseed(GetGameTimer())

	generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))

	return generatedPlate
end

Citizen.CreateThread(function()
    while not CallBackReady do Wait(1000) end
    exports.rFramework:RegisterServerCallback('core:GeneratePlate', function(source, cb, token)
        if not exports.rFramework:CheckToken(token, source, "core:GeneratePlate") then return end

        local found = false
        local plate = ""
        while not found do
            plate = GeneratePlate()
            local info = MySQL.Sync.fetchAll("SELECT * FROM player_vehs WHERE plate = @plate", {
                ['@plate'] = plate
            })

            if info[1] == nil then
                found = true
            end

        end
    	cb(plate) -- Send back those data
    end)
end)

RegisterNetEvent("core:SaveVehToGarage")
AddEventHandler("core:SaveVehToGarage", function(token, _id, name, plate, props, _vip)
    if exports.rFramework:GetPlayerJob(source) ~= "concessionnaire" then exports.rFramework:AddPlayerLog(source, "Give de vehicule", 5) end
    if not exports.rFramework:CheckToken(token, source, "SaveVehToGarage") then return end
    local id = GetLicense(_id)
    local vprops = json.encode(props)
    MySQL.Async.execute('INSERT INTO `player_vehs` VALUES (@owner, @vip, @lspd, @plate, @model, @props)', {
        ["@owner"] = id,
        ["@vip"] = _vip,
        ["@lspd"] = false,
        ["@plate"] = plate,
        ["@model"] = name,
        ["@props"] = vprops,
    }, function(rowsChanged) end)
    if PlayersVehCache[id] ~= nil then
        table.insert(PlayersVehCache[id], {
            plate = plate,
            props = vprops, 
            ranger = true, 
            vip = _vip,
            NetID = nil
        })
    end
    exports.rFramework:SendLog("``Le joueur ["..source.."] "..GetPlayerName(source).." à vendu le véhicule "..name.." à ["..tonumber(_id).."] "..GetPlayerName(tonumber(_id)).."``", "concess")
end)



RegisterNetEvent("core:DelVehToGarage")
AddEventHandler("core:DelVehToGarage", function(token, _plate, price, name, _net)
    if not exports.rFramework:CheckToken(token, source, "DelVehToGarage") then return end
    local id = GetLicense(source)
    
    if PlayersVehCache[id] ~= nil then
        for k,v in pairs(PlayersVehCache[id]) do
            if v.plate == _plate then
                table.remove(PlayersVehCache[id], k)

                MySQL.Async.execute('DELETE FROM `player_vehs` WHERE plate = @plate', {
                    ["@plate"] = _plate,
                }, function(rowsChanged) end)

                DeleteEntityYes(_net)
                exports.rFramework:_player_add_money(token, source, price)
                exports.rFramework:SendLog("``Le joueur ["..source.."] "..GetPlayerName(source).." à vendu le véhicule [".._plate.."] "..name.." pour "..price.."``", "veh-vente")
                return
            end
        end
    end
    TriggerClientEvent("rF:notification", source, "~r~Action impossible.\n~w~Ce véhicule n'est pas le tien.")
end)


RegisterNetEvent("core:GetBackToGarage")
AddEventHandler("core:GetBackToGarage", function(token, name, plate, propss, net)
    if not exports.rFramework:CheckToken(token, source, "GetBackToGarage") then return end
    local id = GetLicense(source)
    local vprops = json.encode(propss)

    for k,v in pairs(PlayersVehCache[id]) do
        if v.plate == plate then
            if v.props ~= vprops then
                local _props
                if type(v.props) ~= "table" then
                    _props = json.decode(v.props)
                else
                    _props = v.props
                end
                if _props.model == propss.model then
                    MySQL.Async.execute('UPDATE `player_vehs` SET player_vehs.props = @props WHERE player_vehs.plate = @plate', {
                        ["@props"] = vprops,
                        ["@plate"] = plate,
                    }, function(rowsChanged) end)  
                    print("^2UPDATING ^7Vehs props for veh "..plate..".")
                    for k,v in pairs(PlayersVehCache[id]) do
                        if v.plate == plate then
                            PlayersVehCache[id][k].props = vprops
                            PlayersVehCache[id][k].ranger = true
                        end
                    end
                    DeleteEntityYes(net)
                    TriggerClientEvent("rF:notification", source, "~w~Véhicule ranger\n~o~Utilisé le garage pour réparer vos véhicule est passible d'un ban.")
                    TriggerClientEvent("core:GetPlayersVehicle", source, PlayersVehCache[id])
                else
                    exports.rFramework:AddPlayerLog(source, "Garage: Modèle différent de l'original (Cheat Engine)\nOriginal: "..GetDisplayNameFromVehicleModel(_props.model).." Nouveau: "..GetDisplayNameFromVehicleModel(props.model), 5)
                end
            else
                for k,v in pairs(PlayersVehCache[id]) do
                    if v.plate == plate then
                        PlayersVehCache[id][k].ranger = true
                    end
                end
                DeleteEntityYes(net)
                print("^2UPDATING NOT NEEDED ^7Vehs props for veh "..plate..".")
            end
            return
        end
    end
    TriggerClientEvent("rF:notification", source, "~r~Action impossible.\n~w~Ce véhicule n'est pas le tien.")
end)