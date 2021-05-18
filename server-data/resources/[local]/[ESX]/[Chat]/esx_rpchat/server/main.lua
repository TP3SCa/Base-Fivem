ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then

		local name = GetPlayerName(source)
		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('oocl_prefix', " [" .. source .. "] " .. name), message, {229, 152, 0})
	end
	CancelEvent()
end)

RegisterCommand('ooc', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local name = GetPlayerName(playerId)

		TriggerClientEvent('chat:addMessage', -1, {args = {_U('ooc_prefix', " [" .. playerId .. "] " .. name), args}, color = {128, 128, 128}})
	end
end, false)

--PARA UTILIZAR TODO ESTO TIENES QUE QUITARLE EL COMENTARIO 

--[[RegisterCommand('twitta', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('chat:addMessage', -1, {args = {_U('twta_prefix', playerName), args}, color = {0, 153, 204}})
	end
end, false)

RegisterCommand('twitter', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('chat:addMessage', -1, {args = {_U('twt_prefix', playerName), args}, color = {0, 153, 204}})
	end
end, false) --]]



RegisterCommand('me', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', playerName), args, {255, 0, 0})
	end
end, false)

RegisterCommand('do', function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', playerName), args, {0, 0, 255})
	end
end, false)



function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end
