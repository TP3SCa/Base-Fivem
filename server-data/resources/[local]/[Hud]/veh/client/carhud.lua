local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

autopilotActive = false
seatbeltIsOn = false

-- Vehicle Info
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local beltWarningSet = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local speedBuffer  	  = {}
local velBuffer  	  = {}
local isBlackedOut = false
local seatbeltSpeedPedOut = 1.6
local MinSpeedBelt = 45
local lastVehCache
local PedVehIsHeli = false
local PedVehIsPlane = false
local PedVehIsBoat = false 
local PedVehIsBike = false 
local PedVehIsCar = false
local PedVehIsMotorcycle = false


WichVehicleItIs = function(veh)
	if(lastVehCache == nil or lastVehCache ~= veh) then
		lastVehCache = veh
		PedVehIsHeli = false
		PedVehIsPlane = false
		PedVehIsBoat = false 
		PedVehIsBike = false 
		PedVehIsCar = false
		PedVehIsMotorcycle = false
		local vc = GetVehicleClass(veh)
		if( (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)) then
			PedVehIsCar = true
		elseif(vc == 8) then
			PedVehIsMotorcycle = true
		elseif(vc == 13) then
			PedVehIsBike = true
		elseif(vc == 14) then
			PedVehIsBoat = true
		elseif(vc == 15) then
			PedVehIsHeli = true
		elseif(vc == 16) then
			PedVehIsPlane = true
		end
	end
end
Fwv = function (entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local MyPed = GetPlayerPed(-1)
        local MyPedVeh = GetVehiclePedIsIn(MyPed, false)
        if IsPedInAnyVehicle(MyPed, false) then
            WichVehicleItIs(MyPedVeh)
            speedBuffer[2] = speedBuffer[1]
            speedBuffer[1] = GetEntitySpeed(MyPedVeh)
            
            velBuffer[2] = velBuffer[1]
            velBuffer[1] = GetEntityVelocity(MyPedVeh)
            
            -- perform extreme stunting exercise
            if ((speedBuffer[2] ~= nil and velBuffer[2] ~= nil) and ((speedBuffer[2] > (MinSpeedBelt / 3.6) and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * seatbeltSpeedPedOut)) or (speedBuffer[1] > (MinSpeedBelt / 7.2) and (speedBuffer[1] - speedBuffer[2]) > (speedBuffer[2] * seatbeltSpeedPedOut)))) then
                if(PedVehIsMotorcycle == false and PedVehIsBike == false and PedVehIsHeli == false and PedVehIsPlane == false and PedVehIsBoat == false) then
                    if(not seatbeltIsOn)then
                        local co = GetEntityCoords(MyPed)
                        local fw = Fwv(MyPed)
                        if (IsVehicleWindowIntact(MyPedVeh, 6)) then
                            SmashVehicleWindow(MyPedVeh, 6)
                        end
						SetEntityCoords(MyPed, co.x + fw.x, co.y + fw.y, co.z-0.47, true, true, true)
                        Citizen.Wait(1)
                        SetPedToRagdoll(MyPed, 1000, 1000, 0, 0, 0, 0)
                        SetEntityVelocity(MyPed, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
                    else
                        blackout()
                    end
                end
                local pedIsDriver = (GetPedInVehicleSeat(MyPedVeh, -1) == MyPed)
                if(pedIsDriver)then
                    if(autopilotActive)then
                        DeactivateAutopilot()
                    end
                    if(not seatbeltIsOn)then
                        TriggerEvent("esx_status:add","stress",600000)
                    else
                        TriggerEvent("esx_status:add","stress",300000)
                    end
                end
            end
        end
    end
end)
local function roundToNthDecimal(num, n)
    local mult = 10^(n or 0)
    return math.floor(num * mult + 0.5) / mult
  end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local position = GetEntityCoords(player)
		local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		local vehicleInfo

		if IsPedInAnyVehicle(player, false) then
			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			local vehicleSpeed
			vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
			-- Vehicle Nail Speed
			local vehicleNailSpeed

			vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			-- Vehicle Fuel and Gear
			local vehicleFuel = GetVehicleFuelLevel(vehicle)
			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end
			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
            end
            
            -- Vehicle Indicators
			local indicatorLights  = GetVehicleIndicatorLights(vehicle)
			if indicatorLights == 1 then
                vehicleSignalIndicator = 'left'
			elseif (indicatorLights == 2) then
                vehicleSignalIndicator = 'right'
            elseif (indicatorLights == 3) then
                vehicleSignalIndicator = 'both'   
            else
                vehicleSignalIndicator = 'off'
			end
			-- Vehicle Seatbelt
			if PedVehIsCar == true then

				local prevSpeed = currSpeed
                currSpeed = vehicleSpeedSource

                SetPedConfigFlag(PlayerPedId(), 32, true)

                if not seatbeltIsOn then
                	local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if(beltWarningSet == false) then
                        if(currSpeed > 1 or currSpeed < -1) then
                            beltWarningSet = true
                            exports['mythic_notify']:DoHudText('inform', 'Acuerdate de ponerte el cinturón')
							DisableControlAction(0, 75, false)
						end
                    end
					if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then
						SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end
                else
					DisableControlAction(0, 75, true)
				
                end
            end
            
            rpm = GetVehicleCurrentRpm(vehicle)
            rpm = math.ceil(rpm * 10000, 2)
            vehicleNailRpm = 280 - math.ceil( math.ceil((rpm-2000) * 140) / 10000)
            cardamage = GetVehicleEngineHealth(vehicle) / 10 
            vehicleInfo = {
				updateVehicle = true,
                status = true,
                speed = vehicleSpeed,
                nail = vehicleNailSpeed,
                gear = vehicleGear,
                fuel = vehicleFuel,
                lights = vehicleIsLightsOn,
                signals = vehicleSignalIndicator,
               -- currentKM = roundToNthDecimal(DecorGetFloat(vehicle,'TOTALKM')*100,1),
				seatbelt = Config.vehicle.seatbelt,
				haveBelt = PedVehIsCar,
                damage = cardamage,
                rpmnail = vehicleNailRpm,
                rpm = rpm,
                config = {
                    speedUnit = Config.vehicle.speedUnit,
                    maxSpeed = Config.vehicle.maxSpeed
                }
			}
			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
		else

			vehicleNailSpeed = 0
            vehicleSignalIndicator = 'off'
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
			if(beltWarningSet)then
				TriggerServerEvent('esx_mole_misiones:StopSoundOnSource')
			end
            seatbeltIsOn = false
            beltWarningSet = false

			vehicleInfo = {
				updateVehicle = true,
                status = false,
                nail = 0,
                rpmnail = 0,
                seatbelt = { status = seatbeltIsOn },
                signals = vehicleSignalIndicator
			}
		end
		SendNUIMessage(vehicleInfo)
	end
end)


-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function ()

	while true do
		Citizen.Wait(0)

		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehicleClass = GetVehicleClass(vehicle)
		if seatbeltIsOn then 
			DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
			DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
		end
		-- Vehicle Seatbelt
		if IsPedInAnyVehicle(player, false) then
			if IsControlJustReleased(0,  Keys['B']) then
				WichVehicleItIs(vehicle)
				if(PedVehIsCar)then
					seatbeltIsOn = not seatbeltIsOn
					if seatbeltIsOn then
						if(beltWarningSet)then
							TriggerServerEvent('esx_mole_misiones:StopSoundOnSource')
						end
						exports['mythic_notify']:DoHudText('success', 'Cinturón puesto')
					else
						exports['mythic_notify']:DoHudText('error', 'Cinturón quitado')
						beltWarningSet = false
						if(autopilotActive)then
							DeactivateAutopilot()
						end
					end
				end
			end
		end

        if IsControlJustPressed(1, Config.vehicle.keys.signalLeft) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'left'
			else
				vehicleSignalIndicator = 'off'
			end
			TriggerEvent('esx_mole_status:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Config.vehicle.keys.signalRight) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'right'
			else
				vehicleSignalIndicator = 'off'
			end

			TriggerEvent('esx_mole_status:setCarSignalLights', vehicleSignalIndicator)
		end

		if IsControlJustPressed(1, Config.vehicle.keys.signalBoth) then
			if vehicleSignalIndicator == 'off' then
				vehicleSignalIndicator = 'both'
			else
				vehicleSignalIndicator = 'off'
			end
			TriggerEvent('esx_mole_status:setCarSignalLights', vehicleSignalIndicator)
        end
	end
end)

RegisterNetEvent('esx_mole_status:setBeltOn')
AddEventHandler('esx_mole_status:setBeltOn', function()
	if not seatbeltIsOn then
		seatbeltIsOn = true
		exports['mythic_notify']:DoHudText('error', 'Cinturón abrochado')
	end
end)
RegisterNetEvent('esx_mole_status:setBeltOff')
AddEventHandler('esx_mole_status:setBeltOff', function()
	if  seatbeltIsOn then
		seatbeltIsOn = false
		exports['mythic_notify']:DoHudText('error', 'Cinturón quitado')
		beltWarningSet = false
	end
end)

function blackout()
	-- Only blackout once to prevent an extended blackout if both speed and damage thresholds were met
	if not isBlackedOut then
		isBlackedOut = true
		-- This thread will black out the user's screen for the specified time
		Citizen.CreateThread(function()
			DoScreenFadeOut(100)
			while not IsScreenFadedOut() do
				Citizen.Wait(0)
			end
			Citizen.Wait(Config.BlackoutTime)
			DoScreenFadeIn(250)
			isBlackedOut = false
			doTheEffect()
		end)
	end
end

function doTheEffect()
	SetTimecycleModifier('BarryFadeOut')
	SetTimecycleModifierStrength(math.min(0.1 / 10, 0.6))
	local myPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsUsing(myPed,false)
	SetVehicleEngineOn(vehicle, false, false, true)
	SetVehicleUndriveable(vehicle, true)
	
	SetTimecycleModifier("REDMIST_blend")
	ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
	Wait(5000)
			
	SetTimecycleModifier("hud_def_desat_Trevor")
	
	Wait(3000)
	
	SetTimecycleModifier("")
	SetTransitionTimecycleModifier("")
	StopGameplayCamShaking()
	SetVehicleUndriveable(vehicle, false)
	SetVehicleEngineOn(vehicle, true, false, true)

end


AddEventHandler('esx_mole_status:setCarSignalLights', function (status)
	local driver = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver,vehicleTrailer)
	local leftLight
	local rightLight

	if status == 'left' then
		leftLight = false
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'right' then
		leftLight = true
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'both' then
		leftLight = true
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	else
		leftLight = false
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	end

	TriggerServerEvent('esx_mole_status:syncCarLights', status)

	SetVehicleIndicatorLights(driver, 0, leftLight)
	SetVehicleIndicatorLights(driver, 1, rightLight)
end)



RegisterNetEvent('esx_mole_status:syncCarLights')
AddEventHandler('esx_mole_status:syncCarLights', function (driver, status)
	local target = GetPlayerFromServerId(driver)
	if target == nil or target == -1 then
		return
	  end
	if target ~= PlayerId() then
		local driver = GetVehiclePedIsIn(GetPlayerPed(target), false)

		if status == 'left' then
			leftLight = false
			rightLight = true

		elseif status == 'right' then
			leftLight = true
			rightLight = false

		elseif status == 'both' then
			leftLight = true
			rightLight = true

		else
			leftLight = false
			rightLight = false
		end

		SetVehicleIndicatorLights(driver, 0, leftLight)
		SetVehicleIndicatorLights(driver, 1, rightLight)

	end
end)

function GetVehicleHandlingMaxSpeed(vehicle)
	local handlingMaxSpeed =  GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
	return handlingMaxSpeed
end

-- CINE

CinematicCamCommand = "cine" -- [[The name of the command called to toggle the cinematic cam]]

CinematicCamMaxHeight = 0.20 -- [[The height of the rects. Keep below 1 and keep as a float however I recommend you keep it as it is as this is the best height I could find]]

CinematicCamBool = false

w = 0

RegisterCommand(CinematicCamCommand, function()
	if CinematicCamBool == false then
		CinematicCamBool = not CinematicCamBool
		CinematicCamDisplay(CinematicCamBool)
		SendNUIMessage({ action = 'setLogo', value = 'https://i.imgur.com/uzRmFZp.png' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'voice' })
	else
		CinematicCamBool = not CinematicCamBool
		CinematicCamDisplay(CinematicCamBool)
		SendNUIMessage({ action = 'setLogo', value = Config.serverLogo })
		SendNUIMessage({ action = 'element', task = 'enable', value = 'voice' })
	end
end)

--==--==--==--==--
--Main Thread--
--==--==--==--==--

Citizen.CreateThread(function() -- [[Requests the minimap scaleform and actually calls the rect function allong with the hud components function.]]
    while true do
        Citizen.Wait(1)
        if w > 0 then
            DrawRects()
        end
    end
end)

--==--==--==--==--
--Functions--
--==--==--==--==--

function DrawRects() -- [[Draw the Black Rects]]
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end

function CinematicCamDisplay(bool) -- [[Handles Displaying Radar, Body Armour and the rects themselves.]]
    if bool then
        for i = 0, CinematicCamMaxHeight, 0.01 do 
            Wait(10)
            w = i
        end
    else
        for i = CinematicCamMaxHeight, 0, -0.01 do
            Wait(10)
            w = i
        end 
    end
end