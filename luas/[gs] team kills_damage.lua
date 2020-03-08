local key_state, userid_to_entindex, read, write, get_local_player, get_player_name, get_prop, get_steam64, rectangle, text, get, is_menu_open, mouse_position, new_checkbox, pairs, set_callback, mp_td_dmgtokick = client.key_state, client.userid_to_entindex, database.read, database.write, entity.get_local_player, entity.get_player_name, entity.get_prop, entity.get_steam64, renderer.rectangle, renderer.text, ui.get, ui.is_menu_open, ui.mouse_position, ui.new_checkbox, pairs, ui.set_callback, cvar.mp_td_dmgtokick
local _set, _unset = client.set_event_callback, client.unset_event_callback
local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end
local num_in_table = function(t)local n=0 for _ in pairs(t)do n=n+1 end return n end

local enable = new_checkbox('lua', 'a', 'Show Teammates Damage/Kills')

local pos = read('teamdmg_pos') or {300, 30}
local tX, tY = pos[1], pos[2]
local offsetX, offsetY, _drag
local drag_menu = function(x, y, w, h)
	if not is_menu_open() then
		return tX, tY
	end

	local mouse_down = key_state(0x01)

	if mouse_down then
		local X, Y = mouse_position()

		if not _drag then
			local w, h = x + w, y + h
			if is_inside(X, Y, x, y, w, h) then
				offsetX, offsetY = X - x, Y - y
				_drag = true
			end
		else
			tX, tY = X - offsetX, Y - offsetY
		end
	else
		_drag = false
	end

	return tX, tY
end

local players = {}
local function on_player_stuff(e)
	local attacker, victim, local_player = userid_to_entindex(e.attacker), userid_to_entindex(e.userid), get_local_player()

	if attacker == victim then
		return
	end

	local local_player_team = get_prop(local_player, 'm_iTeamNum')
	local attacker_team = get_prop(attacker, 'm_iTeamNum')
	local victim_team = get_prop(victim, 'm_iTeamNum')

	if attacker_team ~= local_player_team or victim_team ~= local_player_team then
		return
	end

	local steamID3 = get_steam64(attacker)
	if steamID3 == 0 then
		return
	end

	if players[steamID3] == nil then
		players[steamID3] = {0, 0, get_player_name(attacker)}
	end

	if e.health == nil then
		players[steamID3][1] = players[steamID3][1] + 1
	else
		players[steamID3][2] = players[steamID3][2] + e.dmg_health
	end
end

local function on_paint()
	local x, y = drag_menu(tX, tY, 200, 20)

	if not key_state(0x09) then
		return
	end

	rectangle(x, y, 200, 20, 37, 37, 37, 250)
	text(x + 100, y + 10, 255,255,255,255, 'c', 0, 'Player List')

	rectangle(x, y + 20, 200, num_in_table(players) * 10, 33, 33, 33, 180)

	local y = y + 25
	local dmg_to_kick = mp_td_dmgtokick:get_int()

	local gap = 0
	for steamid, stuff in pairs(players) do
		local m = stuff[2] / dmg_to_kick

		text(x + 5, y + gap, 255,255,255,255, '', 42, stuff[3])

		rectangle(x + 65, y + gap - 2, 130, 4, 13, 13, 13, 230)
		rectangle(x + 66, y + gap - 1, 132*m, 2, 49, 233, 93, 255)

		text(x + 100, y + gap, 255,255,255,255, 'c-', 0, stuff[2]..'/'..dmg_to_kick)

		text(x + 195, y + gap, 255,255,255,255, 'r', 0, stuff[1].. ' Kills')

		gap = gap + 10
	end
end

local function on_player_connect_full(e) if userid_to_entindex(e.userid) ~= get_local_player() then return end players={} end
local function on_shutdown() write('teamdmg_pos', {tX, tY}) end

local function on_change(s)
	local callback = get(s) and _set or _unset
	callback('player_hurt', on_player_stuff)
	callback('player_death', on_player_stuff)
	callback('paint', on_paint)
	callback('player_connect_full', on_player_connect_full)
	callback('shutdown', on_shutdown)
end

on_change(enable)
set_callback(enable, on_change)
