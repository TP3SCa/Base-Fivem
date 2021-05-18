RegisterNetEvent('mythic_notify:client:SendAlert')
AddEventHandler('mythic_notify:client:SendAlert', function(data)
	DoCustomHudText(data.type, data.text, data.length, data.style)
end)

RegisterNetEvent('mythic_notify:client:PersistentHudText')
AddEventHandler('mythic_notify:client:PersistentHudText', function(data)
	PersistentHudText(data.action, data.id, data.type, data.text, data.style)
end)

RegisterNetEvent('mythic_notify:client:PersistentAlert')
AddEventHandler('mythic_notify:client:PersistentAlert', function(data)
	PersistentAlert(data.action, data.id, data.type, data.text, data.style)
end)

function SendAlert(type, text, length, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = length,
		style = style
	})
end

function PersistentAlert(action, id, type, text, style)
	if action:upper() == 'START' then
		SendNUIMessage({
			persist = action,
			id = id,
			type = type,
			text = text,
			style = style
		})
	elseif action:upper() == 'END' then
		SendNUIMessage({
			persist = action,
			id = id
		})
	end
end

RegisterNetEvent('DoLongHudText')
AddEventHandler('DoLongHudText', function(text,color)
	if color == 2 then
		DoLongHudText("error", text)
	else
		DoLongHudText("inform", text)
	end
end)

RegisterCommand("test", function(src,arg)
	if tonumber(arg[1]) == 1 then
		DoHudText('error',"prueba prueba prueba")
	elseif tonumber(arg[1]) == 2 then
		DoHudText('success',"prueba prueba")
	else
		DoHudText('inform',"prueba prueba prueba")
	end
end, false)

function DoShortHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 4000,
		style = style
	})
end

function DoHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 6500,
		style = style
	})
end

function DoLongHudText(type, text, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = 9000,
		style = style
	})
end

function DoCustomHudText(type, text, length, style)
	SendNUIMessage({
		type = type,
		text = text,
		length = length,
		style = style
	})
end

function PersistentHudText(action, id, type, text, style)
	if action:upper() == 'START' then
		SendNUIMessage({
			persist = action,
			id = id,
			type = type,
			text = text,
			style = style
		})
	elseif action:upper() == 'END' then
		SendNUIMessage({
			persist = action,
			id = id
		})
	end
end