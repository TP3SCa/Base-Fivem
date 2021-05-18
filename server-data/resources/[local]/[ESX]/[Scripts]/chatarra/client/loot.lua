ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

objects = {}

if Config.ObjectDropLoot then
	Citizen.CreateThread(function()
	    while true do
	        Wait(0)
	        for k,v in pairs(Config.ObjectsLoot) do
		        	local player = GetPlayerPed(-1)
		        	local distanceobject = 2.2
		            local obj = GetClosestObjectOfType(GetEntityCoords(player).x, GetEntityCoords(player).y, GetEntityCoords(player).z, distanceobject, v, false, true ,true)
		            local distance = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(obj), true)
		    


			    if distance <= distanceobject then

		            local ObjectCoords = GetEntityCoords(obj)

		            if not objects[obj] then
		            ESX.Game.Utils.DrawText3D(ObjectCoords + vector3(0.0, 0.0, 0.5), '~c~Presiona ~b~[E]~c~ para buscar', 1, 4)
		        	end

		            if IsControlJustReleased(0, 38) then
						if not objects[obj] then
							
							exports.esx_xp:ESXP_Add(100)	

		                    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, true)
		                    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
							while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
								Citizen.Wait(10)
							end
							TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 2.0, 4000, 30, 0, 0, 0, 0)
							Citizen.Wait(4000)
							randomChance = math.random(1, 100)
							randomItem = Config.ItemLootObject[math.random(1, #Config.ItemLootObject)]

							if randomChance >= Config.ProbabilityWeaponLootObject and randomChance < Config.ProbabilityMoneyLootObject then
								TriggerServerEvent('chatarra:moneyloot')
							elseif randomChance >= Config.ProbabilityMoneyLootObject and randomChance < Config.ProbabilityItemLootObject then
								TriggerServerEvent('chatarra:itemloot', randomItem)
							elseif randomChance >= Config.ProbabilityItemLootObject and randomChance < 100 then
								ESX.ShowNotification('~r~No has encontrado nada')
							end
							objects[obj] = true
		               	end
		            end
		        end
		    end
		end
	end)
end