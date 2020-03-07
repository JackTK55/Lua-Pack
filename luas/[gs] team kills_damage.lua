-- local variables for API functions. any changes to the line below will be lost on re-generation
local key_state, userid_to_entindex, read, write, get_local_player, get_player_name, get_prop, get_steam64, measure_text, rectangle, text, format, get, is_menu_open, mouse_position, new_checkbox, pairs, set_callback, mp_td_dmgtokick = client.key_state, client.userid_to_entindex, database.read, database.write, entity.get_local_player, entity.get_player_name, entity.get_prop, entity.get_steam64, renderer.measure_text, renderer.rectangle, renderer.text, string.format, ui.get, ui.is_menu_open, ui.mouse_position, ui.new_checkbox, pairs, ui.set_callback, cvar.mp_td_dmgtokick
local is_inside = function(a, b, x, y, w, h) return a >= x and a <= w and b >= y and b <= h end

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

	local local_player_team = get_prop(local_player, 'm_iTeamNum')
	local attacker_team = get_prop(local_player, 'm_iTeamNum')
	local victim_team = get_prop(local_player, 'm_iTeamNum')

	if attacker == victim or attacker_team ~= victim_team or attacker_team ~= local_player_team then
		return
	end

	local steamID3 = get_steam64(attacker)
	if steamID3 == 0 then
		return
	end

	if not players[steamID3] then
		players[steamID3] = {0, 0, get_player_name(attacker)}
	end

	if e.health == nil then
		players[steamID3][1] = players[steamID3][1] + 1
	else
		players[steamID3][2] = players[steamID3][2] + e.dmg_health
	end
end

local gap, gap2 = 0, 0
local function on_paint()
	local x, y = drag_menu(tX, tY, gap2, gap)

	if not key_state(0x09) then
		return
	end

	rectangle(x, y, gap2, gap, 33,33,33,230)
	local gap = 0

	for steamid, stuff in pairs(players) do
		local str = format('%s - %i kills, %i/%i dmg', stuff[3], stuff[1], stuff[2], mp_td_dmgtokick:get_int())
		local tW, tH = measure_text('', str)
		text(x, y + gap, 255,255,255,255, '', 0, str)
		gap = gap + tH
		gap2 = tW
	end
end

local function on_paint_menu() players={} end
local function on_shutdown()write('teamdmg_pos', {tX, tY})end

local function on_change(s)
	local callback = get(s) and client.set_event_callback or client.unset_event_callback
	callback('player_hurt', on_player_stuff)
	callback('player_death', on_player_stuff)
	callback('paint', on_paint)
	callback('paint_menu', on_paint_menu)
	callback('shutdown', on_shutdown)
end

on_change(enable)
set_callback(enable, on_change)
