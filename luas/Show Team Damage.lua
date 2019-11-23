local lpi, lp, Text, Color, entindex, screen_size, GetByIndex = client.GetLocalPlayerIndex, entities.GetLocalPlayer, draw.Text, draw.Color, client.GetPlayerIndexByUserID, draw.GetScreenSize, entities.GetByIndex
local enabled = gui.Checkbox(gui.Reference('VISUALS', 'Shared'), 'show_team_damage', 'Show Team Damage')
local S = {0, 0}

local am_attacker = function(a, b)
	local l, v = lpi(), entindex(b)
	return entindex(a) == l and v ~= l and GetByIndex(v):GetTeamNumber() == lp():GetTeamNumber()
end

client.AllowListener('player_hurt')
callbacks.Register('player_hurt', function(e)
	if am_attacker(e:GetInt('attacker'), e:GetInt('userid')) then
		S[1] = S[1] + e:GetInt('dmg_health')
	end
end)

client.AllowListener('player_death')
callbacks.Register('player_death', function(e)
	if am_attacker(e:GetInt('attacker'), e:GetInt('userid')) then
		S[2] = S[2] + 1
	end
end)

callbacks.Register('Draw', function()
	if not enabled:GetValue() then
		return
	end

	if lp() == nil then
		return
	end

	local _,y = screen_size()
	local Y = y / 2

	Color(255, 255, 255, 255)
	Text(10, Y - 6, 'Damage Done: ', S[1])
	Text(10, Y + 6, 'Teammates Killed: ', S[2])
end)

client.AllowListener('game_init')
callbacks.Register('FireGameEvent', function(e)
	if e:GetName() == 'game_init' then
		S = {0, 0}
	end
end)
