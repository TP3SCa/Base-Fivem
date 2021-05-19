-- ESX --
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Eventos --

RegisterServerEvent('prueba:prueba')
AddEventHandler('prueba:prueba', function(job)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('esx:showNotification', source, '~g~Funciono Bien~w~')
end)

ESX.RegisterServerCallback('bahamas:getOnlinePlayers', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source = xPlayer.source,
			identifier = xPlayer.identifier,
			name = xPlayer.name,
			job = xPlayer.job
		})
	end

	cb(players)
end)

ESX.RegisterServerCallback('bahamas:setJob', function(source, cb, identifier, job, grade, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local isBoss = xPlayer.job.grade_name == 'jefe' 

	if isBoss then
		local xTarget = ESX.GetPlayerFromIdentifier(identifier)

		if xTarget then
			xTarget.setJob(job, grade)

			if type == 'hire' then
				xTarget.showNotification('', job)
			end

			cb()
		else
			MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
				['@job']        = job,
				['@job_grade']  = grade,
				['@identifier'] = identifier
			}, function(rowsChanged)
				cb()
			end)
		end
	else
		print(('bahamas: %s attempted to setJob'):format(xPlayer.identifier))
		cb()
	end
end)

RegisterNetEvent('bahamas:giveItem')
AddEventHandler('bahamas:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'bahamas' then
		print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		xPlayer.showNotification('No tienes suficiente espacio')
	end
end)

RegisterNetEvent('bahamas:sellItem')
AddEventHandler('bahamas:sellItem', function(itemName, amount, price)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.canCarryItem(itemName, amount) and xPlayer.getMoney() > 50 then
		xPlayer.addInventoryItem(itemName, amount)
		xPlayer.removeMoney(price)
	else
		xPlayer.showNotification('No tienes suficiente espacio o dinero')
	end
end)
