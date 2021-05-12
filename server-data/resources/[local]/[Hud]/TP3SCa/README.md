<h1 align="center">
	<img src="https://i.imgur.com/DzoMF06.png" alt="Rocademption" width="500">
  <br/>
  <br/>
</h1>


Citizen.CreateThread(function()

	if Config.ui.showVoice == true then

	    RequestAnimDict('facials@gen_male@variations@normal')
	    RequestAnimDict('mp_facial')

	    while true do
	        Citizen.Wait(300)
	        local playerID = PlayerId()

	        for _,player in ipairs(GetActivePlayers()) do
	            local boolTalking = NetworkIsPlayerTalking(player)

	            if player ~= playerID then
	                if boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
	                elseif not boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
	                end
	            end
	        end
	    end

	end
end)



Citizen.CreateThread(function()
	if Config.ui.showVoice == true then



		local isTalking = false
		local voiceDistance = nil

		while true do
			Citizen.Wait(1)




			if NetworkIsPlayerTalking(PlayerId()) and not isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			elseif not NetworkIsPlayerTalking(PlayerId()) and isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			end



			if IsControlJustPressed(1, Keys[Config.voice.keys.distance]) then

				Config.voice.levels.current = (Config.voice.levels.current + 1) % 3

				if Config.voice.levels.current == 0 then
					NetworkSetTalkerProximity(Config.voice.levels.default)
					voiceDistance = 'normal'
				elseif Config.voice.levels.current == 1 then
					NetworkSetTalkerProximity(Config.voice.levels.shout)
					voiceDistance = 'shout'
				elseif Config.voice.levels.current == 2 then
					NetworkSetTalkerProximity(Config.voice.levels.whisper)
					voiceDistance = 'whisper'
				end

				SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
			end

			if Config.voice.levels.current == 0 then
				voiceDistance = 'normal'
			elseif Config.voice.levels.current == 1 then
				voiceDistance = 'shout'
			elseif Config.voice.levels.current == 2 then
				voiceDistance = 'whisper'
			end


		end





	end
end)


## **Features**

[**FR**]

	- Système de rocade (file d'attente) intégrant un système de points,
	- Le joueur ayant le plus de points entre dès qu'une place se libère sur le serveur,
	- Les joueurs gagnent des points au fur et à mesure de leur attente sur la rocade,
	- Les joueurs perdent des points au fur et à mesure dès qu'ils entrent sur le serveur,
	- Accès privilégiés via steamid (points supplémentaires dès l'entrée sur la rocade),
	- Système d'emojis pour permettre une visibilité en cas de freeze client,
	- Système de loterie avec des points supplémentaires si 3 emojis identiques,
	- Système anti-spam,
	- Vérification de Steam ouvert.

[**EN**]

	- Waiting/Queue list integrating a points system,
	- The player with the most points enters as soon as a place is released on the server,
	- Players gradually earn points as they wait on the queue list,
	- Players gradually lose points as soon as they enter in the server,
	- Privileged access with steamid (additional points) settable,
	- Emoji system to allow visibility in case of client freeze,
	- Lottery system with additional points if 3 identical emojis,
	- Anti-spam system,
	- Check if Steam is open.


## **Installation**

- Copier-coller le dossier **rocademption** dans votre dossier resources de FiveM,
- Dans votre server.cfg : ```start rocademption```,
- Désactivez la resource **hardcap** (déjà incluse dans la rocade),
- Configurez le config.lua comme vous le souhaitez,
- Enjoy ♥.
---------
- Drag'N Drop the **rocademption** folder in your FiveM's resources folder,
- In your server.cfg: ```start rocademption```,
- Desactivate the **hardcap** resource (already included in rocademption),
- Set the config.lua the way you want,
- Enjoy ♥.


## **Terms of use**

- Si vous utilisez cette rocade, merci de ne pas changer le nom de la ressource ♥
- If you use this queue system, please do not change the name of the resource ♥

## **Credits**

- **SatansTool**
- **Delduwaht**

========================== REDEMPTION ==========================
