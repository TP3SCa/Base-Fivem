Config = {}

----------------------------------------------------
-------- Intervalles en secondes -------------------
----------------------------------------------------

-- Temps d'attente Antispam / Waiting time for antispam
Config.AntiSpamTimer = 2

-- Vérification et attribution d'une place libre / Verification and allocation of a free place
Config.TimerCheckPlaces = 3

-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one
Config.TimerRefreshClient = 3

-- Mise à jour du nombre de points / Number of points updating
Config.TimerUpdatePoints = 6

----------------------------------------------------
------------ Nombres de points ---------------------
----------------------------------------------------

-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting
Config.AddPoints = 1

-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server
Config.RemovePoints = 1

-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)
Config.LoterieBonusPoints = 25

-- Accès prioritaires / Priority access
Config.Points = {
	-- {'steamID', points},
	{'steam:110000102ce2c81', 5000}, --Sempere
	{'steam:1100001346ed7e9', 5000}, --Libanes
	{'steam:1100001160105e1', 5000}, --haki
	{'steam:110000101a414ce', 5000}, --Nomare
	{'steam:11000010d12155d', 5000}, --Campos
	{'steam:110000101a82f36', 5000}, --Chaky
	{'steam:110000106d1e48b', 5000}, --Dario
	{'steam:11000010c070f6c', 5000}, --Bochito
	{'steam:11000010ab2cfaf', 5000}, --Socio
	{'steam:11000010b219f16', 5000}, --Rasta
	{'steam:11000010c1236b2', 5000}, --Joanet
	{'steam:1100001096cb5ee', 3000}, --inferzZ(Dona30)
	{'steam:110000114d4f842', 5000} --Malii(Dona30)
}

----------------------------------------------------
------------- Textes des messages ------------------
----------------------------------------------------

-- Si steam n'est pas détecté / If steam is not detected
Config.NoSteam = "No se detectó Steam. Porfavor Reinicie Steam y FiveM e intente de nuevo.."
-- Config.NoSteam = "Steam was not detected. Please (re)launch Steam and FiveM, and try again."

-- Message d'attente / Waiting text
Config.EnRoute = "Usted está en su camino. Ya has viajado"
-- Config.EnRoute = "You are on the road. You have already traveled"

-- "points" traduits en langage RP / "points" for RP purpose
Config.PointsRP = "kilometros"
-- Config.PointsRP = "kilometers"

-- Position dans la file / position in the queue
Config.Position = "Estas en posicion "
-- Config.Position = "You are in position "

-- Texte avant les emojis / Text before emojis
Config.EmojiMsg = "Si los emojis están congelados, reinicie su FiveM. : "
-- Config.EmojiMsg = "If the emojis are frozen, restart your client: "

-- Quand le type gagne à la loterie / When the player win the lottery
Config.EmojiBoost = "!!! estupendo, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " ganado !!!"
-- Config.EmojiBoost = "!!! Yippee, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " won !!!"

-- Anti-spam message / anti-spam text
Config.PleaseWait_1 = "Espere por favor "
Config.PleaseWait_2 = " La conexión se iniciará automáticamente. !"
--Config.PleaseWait_1 = "Por favor espere "
--Config.PleaseWait_2 = " seconds. The connection will start automatically!"

-- Me devrait jamais s'afficher / Should never be displayed
Config.Accident = "Vaya, acabas de tener un accidente ... Si esto vuelve a suceder, puedes informar a la administracion :)"
-- Config.Accident = "Oops, you just had an accident ... If it happens again, you can inform the support :)"

-- En cas de points négatifs / In case of negative points
Config.Error = " ERROR: REINICIA FiveM O SU PC Y PÓNGASE EN CONTACTO CON EL SOPORTE DEL SERVIDOR "
-- Config.Error = " ERROR : RESTART THE QUEUE SYSTEM AND CONTACT THE SUPPORT "


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}
