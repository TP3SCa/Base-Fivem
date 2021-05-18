-- © This Script Coded By Mr.Itchy#2223 And Elior#0590 © --

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('trabajo', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local joblabel = xPlayer.job.label
	local jobgradelabel = xPlayer.job.grade_label
	local result = "Tu trabajo es : " .. joblabel .. " - " .. jobgradelabel
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = result })
end, false)

RegisterCommand('dinero', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getMoney()
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu dinero efectivo : " .. money .. ' $'})
end, false)

RegisterCommand('banco', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bank = xPlayer.getAccount("bank")["money"]
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu dinero en banco : " .. bank .. ' $'})
end, false)

RegisterCommand('dineronegro', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local dirty = xPlayer.getAccount("black_money")["money"]
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu dinero en negro : " .. dirty .. ' $'})
end, false)

RegisterCommand('salario', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local jobsalary = xPlayer.job.grade_salary
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu salario : " .. jobsalary .. ' $'})
end, false)


RegisterCommand('id', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu id : " .. source})
end, false)

RegisterCommand('ping', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local ping = GetPlayerPing(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu ping : " .. ping .. ' ms' })
end, false)

RegisterCommand('sociedad', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.job.grade_name
	if job == 'boss' then
		TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Dinero de la Sociedad :" .. account.money .. ' $'})
	      end)
	   end)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Necesitas ser el Jefe'})
	end
end, false)

RegisterCommand('info', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local jobsalary = xPlayer.job.grade_salary
	local job = xPlayer.job.grade_name
   	local joblabel = xPlayer.job.label
	local jobgradelabel = xPlayer.job.grade_label
	local money = xPlayer.getMoney()
	local bank = xPlayer.getAccount("bank")["money"]
	local dirty = xPlayer.getAccount("black_money")["money"]
	local result = "Tu trabajo es : " .. joblabel .. " - " .. jobgradelabel
	local ping = GetPlayerPing(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu dinero efectivo : " .. money .. ' $'})
	Citizen.Wait(3000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu dinero en banco : " .. bank .. ' $'})
	Citizen.Wait(3000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu dinero en negro : " .. dirty .. ' $'})
	Citizen.Wait(3000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = result })
	Citizen.Wait(3000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu salario : " .. jobsalary .. ' $'})
	Citizen.Wait(3000)
	if job == 'boss' then
		TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
		TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Dinero de la Sociedad :" .. account.money .. ' $'})
	     end)
	  end)
	end
	Citizen.Wait(3000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu id : " .. source})
	Citizen.Wait(3000)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = "Tu ping : " ..ping .. ' ms'})
end, false)
