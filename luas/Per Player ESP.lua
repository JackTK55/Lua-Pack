local GetLocalPlayer, GetPlayerResources, MaxClients, GetPlayerInfo, Checkbox, RoundedRect = entities.GetLocalPlayer, entities.GetPlayerResources, globals.MaxClients, client.GetPlayerInfo, gui.Checkbox, draw.RoundedRect

local tab = gui.Tab(gui.Reference('Visuals'), 'per_player_esp', 'Per Player ESP')
local group = gui.Groupbox(tab, 'Player ESP', 16, 16, 168, 184)
local PLAYERS = {}

local function get_players()
	local local_player = GetLocalPlayer()

	if not local_player then
		for k, v in pairs(PLAYERS) do
			v.IsSelected:Remove()
			PLAYERS[k] = nil
		end
		return
	end

	local player_resources = GetPlayerResources()
	local local_team = local_player:GetTeamNumber()

	for i=1, MaxClients() do
		local info = GetPlayerInfo(i)
		local team = player_resources:GetPropInt('m_iTeam', i)

		if info and team > 1 and team ~= local_team then
			local SteamID = info['SteamID']

			if not PLAYERS[SteamID] then
				PLAYERS[SteamID] = {Name = info['Name'], IsSelected = gui.Checkbox(group, 'temp_'..i, 'ESP for '.. info.Name, false), Index = i}
			end
		end
	end
end

callbacks.Register('DrawESP', function(b)
	local x,y,w,h = b:GetRect()
	local ent = b:GetEntity()

	if ent:GetClass() ~= 'CCSPlayer' then
		return
	end

	local ind, hp = ent:GetIndex(), ent:GetHealth()*0.01
	local c = 255*hp

	for k, v in pairs(PLAYERS) do
		if not GetPlayerInfo(v.Index) then
			v.IsSelected:Remove()
			PLAYERS[k] = nil
		end

		if v.IsSelected and v.IsSelected:GetValue() then
			local name, i = v.Name, v.Index
			if ind == i then
				b:AddTextTop(name)
				RoundedRect(x,y,w,h)
				b:Color(-c,c,0,220)
				b:AddBarLeft(hp)
			end
		end
	end
end)

local last = -1
callbacks.Register('Draw', function()
	last = (last + 1) % 30

	if last == 0 then
		get_players()
	end
end)
