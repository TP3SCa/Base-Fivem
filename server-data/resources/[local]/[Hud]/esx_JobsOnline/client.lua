----------------------------------------------------------------
-- Made By: Guy293
-- GitHub: https://github.com/Guy293
-- Fivem Forum: https://forum.fivem.net/u/guy293/
----------------------------------------------------------------

--Get ESX Data
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Store data for later
emsonline = 0
policeonline = 0
taxionline = 0
mechaniconline = 0


-- Get jobs data every 10 secconds
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		ESX.TriggerServerCallback('guy293_getJobsOnline', function(ems, police, taxi, mechanic)
			emsonline    = ems
			policeonline = police
			taxionline   = taxi
			mechaniconline   = mechanic
		end)
	end
end)
			
-- Print text
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			DrawText2(0.674, 1.390, 1.0,1.0,0.35, "👮: " .. policeonline , 0 ,119, 255, 150)
			DrawText2(0.674, 1.362, 1.0,1.0,0.35, "🚑  : " .. emsonline , 246 ,56, 56, 150)
			DrawText2(0.674, 1.290, 1.0,1.0,0.35, "🚕     : " .. taxionline , 239 ,255, 0, 150)
			DrawText2(0.677, 1.330, 1.0,1.0,0.35, "🔧: " .. mechaniconline , 239 ,255, 30, 150)
	end
end)


function DrawText2(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(3, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end