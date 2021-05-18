ESX  = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('chatarra:moneyloot')
AddEventHandler('chatarra:moneyloot', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(50, 500)
    xPlayer.addMoney(random)
    TriggerClientEvent("esx:showNotification", xPlayer.source, ('~g~Has encontrado ~g~$' .. random .. ' dolares'))
end)

RegisterServerEvent('chatarra:itemloot')
AddEventHandler('chatarra:itemloot', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
	local random = math.random(1,3)
    if xPlayer.canCarryItem(item, random) then
        xPlayer.addInventoryItem(item, random)
        TriggerClientEvent("esx:showNotification", xPlayer.source, ('~g~Has encontrado ~y~' .. random .. 'x ~b~' .. item))
    else
        xPlayer.showNotification('Tienes el inventario lleno!')
    end
end)
