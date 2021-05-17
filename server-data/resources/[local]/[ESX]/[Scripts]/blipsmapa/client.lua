local blips = {

	 {title="Basurero", colour=52, id=318, x = -314.35, y = -1525.09, z = 27.58},
   {title="Cockatoos", colour=27, id=93, x = -430.46, y = -35.05, z = 46.24},
   {title="Bahamas", colour=27, id=93, x = -1388.27, y = -586.96, z = 30.22},
   {title="Vanilla", colour=27, id=93, x = 128.85, y = -1298.63, z = 29.23},
   {title="Yellow Jack", colour=27, id=93, x = 1989.76, y = 3052.65, z = 47.22},
  }

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
