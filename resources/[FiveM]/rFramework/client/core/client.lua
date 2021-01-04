local firstSpawn = true

Citizen.CreateThread(function()
	TriggerServerEvent('rF:spawn')
	TriggerServerEvent("rF:AddToCache")
end)

RegisterNetEvent('rF:initializeinfo')
AddEventHandler('rF:initializeinfo', function(money,dirtymoney,bankbalance, job, _, skin)
	Wait(3000)
	SendNUIMessage({
		initialise = true,
		money = money,
		dirtymoney = dirtymoney,
		bankbalanceinfo = bankbalance,
		job = job,
	})

	if skin ~= nil then
		TriggerEvent("skinchanger:LoadForTheFirsTime", json.decode(skin))
	end

end)

RegisterNetEvent('rF:job')
AddEventHandler('rF:job', function(rslt)

	SendNUIMessage({
		jobinfo = rslt
	})

end)

RegisterNetEvent('rF:bankbalance')
AddEventHandler('rF:bankbalance', function(rslt)

	SendNUIMessage({
		bankbalanceinfo = rslt
	})

end)

RegisterNetEvent('rF:dirtymoney')
AddEventHandler('rF:dirtymoney', function(rslt)

	SendNUIMessage({
		dirtymoneyinfo = rlst
	})

end)

RegisterNetEvent('rF:money')
AddEventHandler('rF:money', function(rslt)

	SendNUIMessage({
		moneyinfo = rslt
	})

end)

RegisterNetEvent('rF:rmvMoney')
AddEventHandler('rF:rmvMoney', function(rslt)

	SendNUIMessage({
		rmvMoney = rslt
	})

end)

RegisterNetEvent('rF:addMoney')
AddEventHandler('rF:addMoney', function(rslt)

	SendNUIMessage({ 
		addMoney = rslt
	})

end)

RegisterNetEvent('rF:rmvBank')
AddEventHandler('rF:rmvBank', function(rslt)

	SendNUIMessage({
		rmvBank = rslt
	})

end)

RegisterNetEvent('rF:addBank')
AddEventHandler('rF:addBank', function(rslt)

	SendNUIMessage({
		addBank = rslt
	})

end)

RegisterNetEvent('rF:removeMoneyForBank')
AddEventHandler('rF:removeMoneyForBank', function(rslt)

	SendNUIMessage({
		rmvMoneyForBank = rslt
	})

end)

RegisterNetEvent("rF:MoneyToBank")
AddEventHandler("rF:MoneyToBank", function(money)
	SendNUIMessage({
		rmvMoney = money
	})
	SendNUIMessage({
		addBank = money
	})
end)

RegisterNetEvent("rF:BankToMoney")
AddEventHandler("rF:BankToMoney", function(money)
	SendNUIMessage({ 
		addMoney = money
	})
	SendNUIMessage({
		rmvBank = money
	})
end)

RegisterNetEvent('rF:removeBankForMoney')
AddEventHandler('rF:removeBankForMoney', function(rslt)

	SendNUIMessage({
		rmvBankForMoney = rslt
	})

end)


RegisterNetEvent('rF:addDirtyMoney')
AddEventHandler('rF:addDirtyMoney', function(rslt)

	SendNUIMessage({
		addDirtyMoney = rslt
	})

end)


RegisterNetEvent('rF:rmvDirtyMoney')
AddEventHandler('rF:rmvDirtyMoney', function(rslt)

	SendNUIMessage({
		rmvDirtyMoney = rslt
	})

end)


RegisterNetEvent('rF:setDirtyMoney')
AddEventHandler('rF:rmvDirtyMoney', function(rslt)

	SendNUIMessage({
		dirtymoneyinfo = rslt
	})

end)

RegisterNetEvent('rF:rmvItem')
AddEventHandler('rF:rmvItem', function(rslt)
	SendNUIMessage({
		rmvItem = rslt
	})

end)

RegisterNetEvent('rF:addItem')
AddEventHandler('rF:addItem', function(rslt)
	SendNUIMessage({ 
		addItem = rslt
	})

end)

local hud = false
RegisterNetEvent("rF:HudToogle")
AddEventHandler("rF:HudToogle", function()
	hud = not hud
	SendNUIMessage({ 
		hud = hud
	})
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load vehicleshop
	RequestIpl("rc12b_default") -- Pillbox Hospital (hole in map)
end)

 -- Exemple 
RegisterNetEvent("rF:SendPlayerAccounts")
AddEventHandler("rF:SendPlayerAccounts", function(money, bank, dirty)
	print(money, bank, dirty)
end)