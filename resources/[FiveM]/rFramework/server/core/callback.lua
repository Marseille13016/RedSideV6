local callbackDebug = true -- Display prints or not
ServerCallbacks = {}

function RegisterServerCallback(name, cb)
    ServerCallbacks[name] = cb
    if callbackDebug then
        print("Callback "..name.." ^2REGISTERED^7")
    end
end

function TriggerServerCallback(name, requestId, source, cb, ...)
    if ServerCallbacks[name] then
        if callbackDebug then
            print("Callback "..name.." ^2CALLED^7 by "..source)
        end
		ServerCallbacks[name](source, cb, ...)
	else
		print(('^1ERROR:^7 Server callback "%s" does not exist.'):format(name))
	end
end



RegisterServerEvent('triggerServerCallback')
AddEventHandler('triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('serverCallback', playerId, requestId, ...)
	end, ...)
end)

Citizen.CreateThread(function()
    Wait(2000)
    print("^2Callback ready to use.^7")
    TriggerEvent("core:CallBackReady")
    TriggerClientEvent("core:CallBackReady", -1)
end)