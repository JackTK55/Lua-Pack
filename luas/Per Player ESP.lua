local GetLocalPlayer, GetPlayerResources, MaxClients, GetPlayerInfo, Checkbox, GetByIndex, Color, RoundedRect = entities.GetLocalPlayer, entities.GetPlayerResources, globals.MaxClients, client.GetPlayerInfo, gui.Checkbox, entities.GetByIndex, draw.Color, draw.RoundedRect
local in_game=function(s) for a=1, MaxClients() do local info = GetPlayerInfo(a) if info and s == info.SteamID then return true end end end
local _player_with_c4, _box, _name, _health, _has_c4, _armor, _scoped, _money
local PLAYERS = {}

local tab = gui.Tab(gui.Reference('Visuals'), 'per_player_esp', 'Per Player ESP')
local group = gui.Groupbox(tab, 'Players', 16, 16, 168, 184)
local group2 = gui.Groupbox(tab, 'Options', 200, 16, 200, 184)

local opt = {
	box = gui.Checkbox(group2, 'box', 'Box', true),
	name = gui.Checkbox(group2, 'name', 'Name', true),
	health = gui.Checkbox(group2, 'health', 'Health', false),
	has_c4 = gui.Checkbox(group2, 'has_c4', 'Has C4', false),
	armor = gui.Checkbox(group2, 'has_kevlar', 'Has Kevlar', false),
	scoped = gui.Checkbox(group2, 'is_scoped', 'Is Scoped', false),
	money = gui.Checkbox(group2, 'money', 'Money', false),

	box_clr = gui.ColorPicker(group2, 'box_clr', '', 255, 255, 255, 255),
	name_clr = gui.ColorPicker(group2, 'name_clr', '', 255, 255, 255, 255),
	has_c4_clr = gui.ColorPicker(group2, 'has_c4_clr', '', 255, 255, 255, 255),
	armor_clr = gui.ColorPicker(group2, 'armor_clr', '', 255, 255, 255, 255),
	scoped_clr = gui.ColorPicker(group2, 'scoped_clr', '', 255, 255, 255, 255),
	money_clr = gui.ColorPicker(group2, 'money_clr', '', 255, 255, 255, 255)
}
	opt.box_clr:SetPosY(4) opt.name_clr:SetPosY(40) opt.has_c4_clr:SetPosY(112) opt.armor_clr:SetPosY(148) opt.scoped_clr:SetPosY(184) opt.money_clr:SetPosY(220) 

local function get_players()
	local local_player = GetLocalPlayer()

	if not local_player then
		for k, v in pairs(PLAYERS) do
			v.IsSelected:Remove()
			PLAYERS[k] = nil
		end
		return
	end

	local my_team = local_player:GetTeamNumber()
	local resources = GetPlayerResources()
	_player_with_c4 = resources:GetPropInt('m_iPlayerC4')

	for k,v in pairs(PLAYERS) do
		if not in_game(k) or v.Team == my_team then
			PLAYERS[k].IsSelected:Remove()
			PLAYERS[k] = nil
		end
	end

	for i=1, MaxClients() do
		local info = GetPlayerInfo(i)
		local team = resources:GetPropInt('m_iTeam', i)

		if info and team > 1 and team ~= my_team then
			local SteamID = info.SteamID
			if not PLAYERS[SteamID] then
				PLAYERS[SteamID] = {
					Name = info.Name, 
					IsSelected = Checkbox(group, '', info.Name, false), 
					Index = i,
					Team = team
				}
			end
		end
	end
end

local _last = -1
callbacks.Register('Draw', function()
	_last = (_last + 1) % 72

	if _last == 0 then
		_box, _name, _health, _has_c4, _armor, _scoped, _money = opt.box:GetValue(), opt.name:GetValue(), opt.health:GetValue(), opt.has_c4:GetValue(), opt.armor:GetValue(), opt.scoped:GetValue(), opt.money:GetValue()

		get_players()
	end
end)

callbacks.Register('DrawESP', function(b)
	local x,y,w,h = b:GetRect()
	local ent = b:GetEntity()

	if ent:GetClass() ~= 'CCSPlayer' then
		return
	end

	local ent_index = ent:GetIndex()

	for k, v in pairs(PLAYERS) do
		if v.IsSelected and v.IsSelected:GetValue() then
			local name, index = v.Name, v.Index

			if ent_index == index then
				if _box then
					Color( opt.box_clr:GetValue() )
					RoundedRect(x,y,w,h)
				end

				if _name then
					b:Color( opt.name_clr:GetValue() )
					b:AddTextTop(name)
				end

				if _health then
					local hp = ent:GetHealth() * 0.01
					local c = 255 * hp
					b:Color(-c,c,0,220)
					b:AddBarLeft(hp)
				end

				if _money then
					local cash = ent:GetProp('m_iAccount')
					b:Color( opt.money_clr:GetValue() )
					b:AddTextRight('$'..cash)
				end

				if _armor then
					local f = ent:GetProp('m_ArmorValue')
					if f > 0 then
						b:Color( opt.armor_clr:GetValue() )
						b:AddTextRight('Armor: '.. f)
					end
				end

				if _scoped then
					local f = ent:GetProp('m_bIsScoped')
					if f == 1 or f == 257 then
						b:Color( opt.scoped_clr:GetValue() )
						b:AddTextRight('Scoped')
					end
				end

				if _has_c4 then
					if _player_with_c4 == index then
						b:Color( opt.has_c4_clr:GetValue() )
						b:AddTextRight('C4')
					end
				end
			end
		end
	end
end)
