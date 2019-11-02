local Get, lp, Text, entindex, is_enemy, screen_size = ui.get, entity.get_local_player, renderer.text, client.userid_to_entindex, entity.is_enemy, client.screen_size

local TeamDamageShow = ui.new_checkbox('LUA', 'A', 'Show Team Damage')
local S = {0, 0}

local am_attacker = function(a, b)
	return entindex(a) == lp() and entindex(b) ~= lp() and not is_enemy(entindex(b))
end

client.set_event_callback('player_hurt', function(e)
	if am_attacker(e.attacker, e.userid) then
		S[1] = S[1] + e.dmg_health
	end
end)

client.set_event_callback('player_death', function(e)
	if am_attacker(e.attacker, e.userid) then
		S[2] = S[2] + 1
	end
end)

client.set_event_callback('paint', function()
	if not Get(TeamDamageShow) then
		return
	end

	if lp() == nil then
		return
	end

	local _,y = screen_size()
	local Y = y / 2

	Text(10, Y - 5, 255,255,255,255, nil, 0, 'Damage Done: ', S[1])
	Text(10, Y + 5, 255,255,255,255, nil, 0, 'Teammates Killed: ', S[2])
end)

client.set_event_callback('game_init', function(e)
	S = {0, 0}
end)
