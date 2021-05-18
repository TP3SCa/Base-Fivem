ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


-- OOC CHAT
TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
    local player = GetPlayerName(source)
    local msg = table.concat(args, " ")
    local group = user.getGroup()
    local permlevel = user.getPermissions()
    local tag = ""
    
    if permlevel == 10 then
        tag = "[Owner]"
    elseif group == "superadmin" then
        tag = "[SuperAdmin]"
    elseif group == "admin" then
        tag = "[Admin]"
    elseif group == "mod" then
        tag = "[Moderator]"
    elseif group == "user" then
        tag = "[Member]"
    end

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(85, 255, 129, 0.6); border-radius: 8px;"><span style ="color: black"><i class="far fa-comment-dots"></i> {0} {1} [{2}]: {3}</span></div>',
		args = { tag, player, source, msg }
	})

end, {help = "OOC chat", params = {{name = "text", help = "type."}}})


-- ADMIN CHAT
TriggerEvent('es:addGroupCommand', 'a', "mod", function(source, args, user)
	local player = GetPlayerName(source)
	local msg = table.concat(args, " ")
	local group = user.getGroup()
	local permlevel = user.getPermissions()
	local tag = ""

	if permlevel == 10 then
		tag = "[Owner]"
	elseif group == "superadmin" then
		tag = "[SuperAdmin]"
	elseif group == "admin" then
		tag = "[Admin]"
	elseif group == "mod" then
		tag = "[Moderator]"
	end
    
    if permlevel == 10 or group == "mod" or group == "admin" or group == "superadmin" then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 90, 90, 0.7); border-radius: 8px;"><span style ="color: black"><i class="fas fa-comment-slash"></i> [AdminChat] - {0} - {1}<br>{2}</span></div>',
            args = { player, tag, msg }
        })

        TriggerEvent("es:getPlayers", function(pl)
            for k,v in pairs(pl) do
                TriggerEvent("es:getPlayerFromId", k, function(user)
                    if(user.getPermissions() > 0 and k ~= source)then
                        TriggerClientEvent('chat:addMessage', k, {
                            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 90, 90, 0.7); border-radius: 8px;"><span style ="color: black"><i class="fas fa-comment-slash"></i> [AdminChat] - {0} - {1}<br>{2}</span></div>',
                            args = { player, tag, msg }
                        })
                    end
                end)
            end
        end)
    elseif group == "user" then
        TriggerClientEvent('chat:addMessage', Source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(234, 42, 38, 0.7); border-radius: 8px;"><span style ="color: black"><i class="fas fa-exclamation-triangle"></i> You dont have permission to do this.</span></div>',
            args = {  }
        })
    end
end, {help = "AdminChat", params = {{name = "text", help = "type"}}})

-- REPORT
TriggerEvent('es:addCommand', 'report', function(source, args, user)
	local player = GetPlayerName(source)
	local msg = table.concat(args, " ")
	TriggerClientEvent('chat:addMessage', source, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 199, 29, 0.7); border-radius: 8px;"><span style ="color: black"><i class="fas fa-user-shield"></i> [REPORT] {1} | ID: {0}<br>{2}</span></div>',
		args = { source, player, msg }
	})

	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chat:addMessage', k, {
						template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 199, 29, 0.7); border-radius: 8px;"><span style ="color: black"><i class="fas fa-user-shield"></i> [REPORT] {1} | ID: {0}<br>{2}</span></div>',
						args = { source, player, msg }
					})
				end
			end)
		end
	end)
end, {help = "Report to the admins", params = {{name = "Reason", help = "Type"}}})