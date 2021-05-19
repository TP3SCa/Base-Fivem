-- ESX --

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Menu F6 --

local options = {
    {label = "Miembros", value= 'miembros'},
    {label = "Reclutar Miembro", value= 'reclutar'},
}

function CockatoosMenu()
    local playerPed = PlayerPedId()
	local grade = ESX.PlayerData.job.grade_name
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cockatoos_menu', {
        title = "Cockatoos",
        align = "top-left",
        elements = options
    }, function(data, menu)
        if data.current.value == 'miembros' then
			MiembrosMenu()
        end
        if data.current.value == 'reclutar' then
            ReclutarMenu()
        end  
    end, 
    function(data, menu)
        menu.close()    
    end)

end

function ReclutarMenu()
	ESX.TriggerServerCallback('cockatoos:getOnlinePlayers', function(players)
		local elements = {}
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		
		for i=1, #players, 1 do
			if players[i].job.name ~= society and closestPlayer ~= -1 and closestDistance <= 3.0 then
				table.insert(elements, {
					label = players[i].name,
					value = players[i].source,
					name = players[i].name,
					identifier = players[i].identifier
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reclutar_menu' , {
			title    = 'Reclutar',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reclutar_confirmar' , {
				title    = '¿Estas Seguro?', data.current.name,
				align    = 'top-left',
				elements = {
					{label = 'Si', value = 'si'},
					{label = 'No', value = 'no'}
			}}, function(data2, menu2)
				menu2.close()

				if data2.current.value == 'si' then
					ESX.ShowNotification('~g~Nuevo miembro reclutado', data.current.name)

					ESX.TriggerServerCallback('cockatoos:setJob', function()
						ReclutarMenu()
					end, data.current.identifier, 'cockatoos', 1, 'hire')
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function MiembrosMenu()
	ESX.TriggerServerCallback('cockatoos:getOnlinePlayers', function(players)
		local elements = {}
		
		for i=1, #players, 1 do
			if players[i].job.name == 'cockatoos' then
				table.insert(elements, {
					label = players[i].name,
					value = players[i].source,
					name = players[i].name,
					identifier = players[i].identifier
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'miembros_menu' , {
			title    = 'Miembros',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'opciones_menu' , {
				title    = 'Opciones',
				align    = 'top-left',
				elements = {
					{label = 'Ascender/Descender a Camarero', value = 'camarero'},
					{label = 'Ascender/Descender a Barman', value = 'barman'},
					{label = 'Ascender/Descender a Seguridad', value = 'seguridad'}, 
					{label = 'Echar', value = 'echar'}
			}}, function(data2, menu2)
				menu2.close()

				if data2.current.value == 'camarero' then
					ESX.ShowNotification('~g~Miembro ascendido', data.current.name)
					ESX.UI.Menu.CloseAll()
					ESX.TriggerServerCallback('cockatoos:setJob', function()
					end, data.current.identifier, 'cockatoos', 1)
				end
				if data2.current.value == 'barman' then
					ESX.ShowNotification('~g~Miembro ascendido', data.current.name)
					ESX.UI.Menu.CloseAll()
					ESX.TriggerServerCallback('cockatoos:setJob', function()
					end, data.current.identifier, 'cockatoos', 2)
				end
				if data2.current.value == 'seguridad' then
					ESX.ShowNotification('~g~Miembro ascendido', data.current.name)
					ESX.UI.Menu.CloseAll()
					ESX.TriggerServerCallback('cockatoos:setJob', function()
					end, data.current.identifier, 'cockatoos', 3)
				end
				if data2.current.value == 'echar' then
					ESX.ShowNotification('~r~Echaste a un miembro', data.current.name)
					ESX.UI.Menu.CloseAll()
					ESX.TriggerServerCallback('cockatoos:setJob', function()
					end, data.current.identifier, 'unemployed', 0)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function BarmanMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'barman_menu', {
		title    = 'Cockatoos',
		align    = 'top-left',
		elements = {
			{label = '<span style="color:blue;">Zumo</span>', item = 'jusfruit', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Agua</span>', item = 'water', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Gaseosa</span>', item = 'soda', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Mojito</span>', item = 'mojito', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Cerveza</span>', item = 'beer', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Whisky</span>', item = 'whisky', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Whisky Cola</span>', item = 'whiskycoca', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Vodka</span>', item = 'vodka', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Vodka Energy</span>', item = 'vodkaenergy', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Vodka con Zumo de frutas</span>', item = 'vodkafruit', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Ron</span>', item = 'rhum', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Ron Cola</span>', item = 'rhumcoca', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Ron con Zumo de frutas</span>', item = 'rhumfruit', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Tequila</span>', item = 'tequila', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Martini Blanco</span>', item = 'martini', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Jägermeister</span>', item = 'jager', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">JägerBomb</span>', item = 'jagerbomb', type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Jäger Cerveza</span>', item = 'jagercerbere', type = 'slider', value = 1, min = 1, max = 100}

	}}, function(data, menu)
		TriggerServerEvent('cockatoos:giveItem', data.current.item, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function CockatooscompraMenu()
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'barman_menu', {
		title    = 'Cockatoos',
		align    = 'top-left',
		elements = {
			{label = '<span style="color:blue;">Zumo</span> - 35$', item = 'jusfruit', price = 35, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Agua</span> - 20$', item = 'water', price = 20, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Gaseosa</span> - 35$', item = 'soda', price = 35, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Mojito</span> - 40$', item = 'mojito', price = 40, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:blue;">Cerveza</span> - 50$', item = 'beer', price = 50, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Whisky</span> - 100$', item = 'whisky', price = 100, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Whisky Cola</span> - 75$', item = 'whiskycoca', price = 75, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Vodka</span> - 100$', item = 'vodka', price = 100, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Vodka Energy</span> - 125$', item = 'vodkaenergy', price = 125, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Vodka con Zumo de frutas</span> - 75$', item = 'vodkafruit', price = 75, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Ron</span> - 100$', item = 'rhum', price = 100, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Ron Cola</span> - 75$', item = 'rhumcoca', price = 75, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Ron con Zumo de frutas</span> - 75$', item = 'rhumfruit', price = 75, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Tequila</span> - 125$', item = 'tequila', price = 125, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:green;">Martini Blanco</span> - 75$', item = 'martini', price = 75, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Jägermeister</span> - 125$', item = 'jager', price = 125, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">JägerBomb</span> - 175$', item = 'jagerbomb', price = 175, type = 'slider', value = 1, min = 1, max = 100},
			{label = '<span style="color:red;">Jäger Cerveza</span> - 150$', item = 'jagercerbere', price = 150, type = 'slider', value = 1, min = 1, max = 100}

	}}, function(data, menu)
		TriggerServerEvent('cockatoos:sellItem', data.current.item, data.current.value, data.current.price)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

-- Menu F6 Control --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 167) and ESX.PlayerData.job.name == 'cockatoos' and ESX.PlayerData.job.grade_name == 'jefe' then
            cockatoosMenu()
        end
    end
end)

-- Marker --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local trabajo = ESX.PlayerData.job.name == 'cockatoos'
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -441.69, -35.98, 46.2, true) <= 1 then
			ESX.ShowHelpNotification('Presiona ~y~E~w~ para acceder al menu')
		end
		if trabajo then
			DrawMarker(1, -441.69, -35.98, 43.2 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 0.5, 8, 0, 255, 100, false, true, 2, nil, nil, false)
			if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -441.69, -35.98, 46.2, true) <= 2 then
				BarmanMenu()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local trabajo = ESX.PlayerData.job.name == 'cockatoos'
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -435.56, -34.53, 40.88, true) <= 1 then
			ESX.ShowHelpNotification('Presiona ~y~E~w~ para acceder al menu')
		end
		if trabajo then
			DrawMarker(1, -435.56, -34.53, 37.88 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 0.5, 8, 0, 255, 100, false, true, 2, nil, nil, false)
			if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -435.56, -34.53, 40.88, true) <= 2 then
				BarmanMenu()
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, -438.76, -35.33, 43.2 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 0.5, 8, 0, 255, 100, false, true, 2, nil, nil, false)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -438.76, -35.33, 46.2, true) <= 1 then
			ESX.ShowHelpNotification('Presiona ~y~E~w~ para acceder al menu')
		end
		if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -438.76, -35.33, 46.2, true) <= 2 then
			CockatooscompraMenu()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, -432.92, -30.02, 37.88 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 0.5, 8, 0, 255, 100, false, true, 2, nil, nil, false)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -432.92, -30.02, 40.88, true) <= 1 then
			ESX.ShowHelpNotification('Presiona ~y~E~w~ para acceder al menu')
		end
		if IsControlJustReleased(0, 38) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -432.92, -30.02, 40.88, true) <= 2 then
			CockatooscompraMenu()
		end
	end
end)
