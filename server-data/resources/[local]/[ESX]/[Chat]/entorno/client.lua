-----------------------------------------------------------------------------------------------------------------------------------

-- Players

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		PlayerData = ESX.GetPlayerData()
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------

-- Job General Command

RegisterCommand('fa', function(source, args, rawCommand)
	local msg = rawCommand:sub(5)
	local job = PlayerData.job.name
    TriggerServerEvent('esx_jobChat:chat', job, msg)
end, false)

-----------------------------------------------------------------------------------------------------------------------------------

-- 911 Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/911', '¡Envío de un aviso a las autoridades con el 911!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('911', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [CNP] " , {26, 83, 255},   "Se ha enviado un aviso a las Autoridades" )
		
	msg = table.concat(args, " ")
	
	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '911'
    TriggerServerEvent('esx_jobChat:911',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
    }, msg, streetName, emergency)
end, false)

-----------------------------------------------------------------------------------------------------------------------------------

-- 112 Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/112', 'Envío de un aviso a las Unidades de UCI con 112!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('112', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [EMS] ", {255,0,0},   "Se ha enviado un aviso a las Unidades de EMS" )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '311'
    TriggerServerEvent('esx_jobChat:311',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)
-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic Command

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/mech', '¡Envía una alerta a los mecánicos con mech!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('mech', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [MECÁNICO] ", {230, 115, 0},   "Se ha enviado un aviso al mecánico." )

	msg = table.concat(args, " ")

	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(5)
	local emergency = 'mech'
    TriggerServerEvent('esx_jobChat:mech',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
	}, msg, streetName, emergency)
end, false)

-----------------------------------------------------------------------------------------------------------------------------------

-- Job General Chat

RegisterNetEvent('esx_jobChat:Send')
AddEventHandler('esx_jobChat:Send', function(messageFull, job)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == job then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic Emergency

RegisterNetEvent('esx_jobChat:mechEmergencySend')
AddEventHandler('esx_jobChat:mechEmergencySend', function(messageFull)
    	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'mechanic' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Mechanic Emergency Alert

RegisterNetEvent('esx_jobChat:mechEmergencySend')
AddEventHandler('esx_jobChat:mechEmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'mechanic' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CARSITE3", "CHAR_CARSITE3", true, 8, "~y~Aviso mecánico~s~", "Ubicación GPS enviada");
		DrawNotification(false, true);
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Emergency 911 

RegisterNetEvent('esx_jobChat:911EmergencySend')
AddEventHandler('esx_jobChat:911EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Emergency 911 Alert Message

RegisterNetEvent('esx_jobChat:911EmergencySend')
AddEventHandler('esx_jobChat:911EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CALL911", "CHAR_CALL911", true, 8, "~y~Aviso 911~s~", "Ubicación GPS enviada");
		DrawNotification(false, true);
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- NonEmergency 311

RegisterNetEvent('esx_jobChat:311EmergencySend')
AddEventHandler('esx_jobChat:311EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'ambulance' then
		TriggerEvent('chat:addMessage', messageFull)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- NonEmergency 311 Alert Message

RegisterNetEvent('esx_jobChat:311EmergencySend')
AddEventHandler('esx_jobChat:311EmergencySend', function(messageFull)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'ambulance' then
		SetNotificationTextEntry("STRINGS");
		AddTextComponentString(normalString);
		SetNotificationMessage("CHAR_CHAT_CALL", "CHAR_CHAT_CALL", true, 8, "~y~Aviso EMS~s~", "Ubicación GPS enviada");
		DrawNotification(false, true);
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker 911

RegisterNetEvent('esx_jobChat:911Marker')
AddEventHandler('esx_jobChat:911Marker', function(targetCoords, type)
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then
        local alpha = 250
        local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == '911' then
			SetBlipColour (call, 38)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('911')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker 311

RegisterNetEvent('esx_jobChat:311Marker')
AddEventHandler('esx_jobChat:311Marker', function(targetCoords, type)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'ambulance' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == '311' then
			SetBlipColour (call, 1)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Help')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

-- Marker Mechanic

RegisterNetEvent('esx_jobChat:mechMarker')
AddEventHandler('esx_jobChat:mechMarker', function(targetCoords, type)
    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'mechanic' then
		local alpha = 250
		local call = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)
		
		SetBlipSprite (call, 480)
		SetBlipDisplay(call, 4)
		SetBlipScale  (call, 1.6)
        SetBlipAsShortRange(call, true)
        SetBlipAlpha(call, alpha)

        SetBlipHighDetail(call, true)
		SetBlipAsShortRange(call, true)

		if type == 'mech' then
			SetBlipColour (call, 64)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Help Mechanic')
			EndTextCommandSetBlipName(call)
		end

		while alpha ~= 0 do
			Citizen.Wait(100 * 4)
			alpha = alpha - 1
			SetBlipAlpha(call, alpha)

			if alpha == 0 then
				RemoveBlip(call)
				return
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/entorno', '¡Envío de un aviso a las autoridades!', {
    { name="Complaint", help="Write your complaint here!" }
})
end)

msg = nil
RegisterCommand('entorno', function(source, args, rawCommand)
	TriggerEvent("chatMessage"," [Entorno] " , {123, 123, 123},   "Se ha enviado un aviso a las Autoridades" )
		
	msg = table.concat(args, " ")
	
	PedPosition		= GetEntityCoords(GetPlayerPed(-1))
	
    local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
        streetName = GetStreetNameFromHashKey(streetName)
	local msg = rawCommand:sub(4)
	local emergency = '911'
    TriggerServerEvent('esx_jobChat:911',{
        x = ESX.Math.Round(playerCoords.x, 1),
        y = ESX.Math.Round(playerCoords.y, 1),
        z = ESX.Math.Round(playerCoords.z, 1)
    }, msg, streetName, emergency)
end, false)