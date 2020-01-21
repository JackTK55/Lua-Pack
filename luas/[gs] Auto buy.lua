local userid_to_entindex, get_local_player, get, exec, delay_call, _set, _unset, set_visible, get_prop, get_class, pairs, sort, concat = client.userid_to_entindex, entity.get_local_player, ui.get, client.exec, client.delay_call, client.set_event_callback, client.unset_event_callback, ui.set_visible, entity.get_prop, entity.get_classname, pairs, table.sort, table.concat
local new_checkbox, new_combobox, new_multiselect, set_callback = ui.new_checkbox, ui.new_combobox, ui.new_multiselect, ui.set_callback

local in_table = function(t, i) for a=1, #t do if t[a] == i then return true end end return false end
local get_keys = function(t) local k, b = {}, 1 for a in pairs(t) do k[b]=a b=b+1 end sort(k) return k end

local primary_weapons = {
	['-'] 						= '',
	['Nova']					= 'nova',
	['XM1014']					= 'xm1014',
	['Sawed-Off / MAG-7']		= 'mag7',
	['M249']					= 'm249',
	['Negev'] 					= 'negev',
	['MAC-10 / MP9'] 			= 'mac10',
	['MP7 / MP5-SD'] 			= 'mp7',
	['UMP-45'] 					= 'ump45',
	['P90'] 					= 'p90',
	['PP-Bizon'] 				= 'bizon',
	['Galil / Famas']			= 'galilar',
	['AK-47 / M4A1']			= 'm4a1',
	['Scout'] 					= 'ssg08',
	['SG 553 / Aug']			= 'sg556',
	['AWP'] 					= 'awp',
	['Auto-Sniper'] 			= 'scar20'
}

local secondary_weapons = {
	['-'] 						= '',
	['Dual Berettas']			= 'elite',
	['P250']					= 'p250',
	['FN57 / Tec9 / CZ75-Auto'] = 'fn57',
	['R8 Revolver / Deagle'] 	= 'deagle'
}

local gear_utilites = {
	['Kevlar'] 					= 'vest',
	['Helmet'] 					= 'vesthelm',
	['Defuse Kit'] 				= 'defuser',
	['Grenade'] 				= 'hegrenade',
	['Molotov'] 				= 'incgrenade',
	['Smoke'] 					= 'smokegrenade',
	['Flashbang'] 				= 'flashbang',
	['Taser'] 					= 'taser'
}

local enabled = new_checkbox('lua', 'b', 'Auto-Buy')
local primary = new_combobox('lua', 'b', 'Primary Weapons', get_keys(primary_weapons))
local secondary = new_combobox('lua', 'b', 'Secondary Weapons', get_keys(secondary_weapons))
local gear = new_multiselect('lua', 'b', 'Gear', get_keys(gear_utilites))
local allow_send = true

local function on_event(e)
	if not allow_send then
		return
	end
	allow_send = false

	local me, inv = get_local_player(), {}

	if e.userid ~= nil then
		if userid_to_entindex( e.userid ) ~= me then
			return
		end
	else
		local A = 1
		for i=0, 16 do
			local w = get_prop(me, 'm_hMyWeapons', i)
			if w ~= nil then
				local c = get_class(w):lower():gsub('cweapon', ''):gsub('molotovgrenade', 'incgrenade'):gsub('incendiarygrenade', 'incgrenade'):gsub('g3sg1', 'scar20'):gsub('famas', 'galilar'):gsub('cde', 'de'):gsub('fiveseven', 'fn57'):gsub('ak47', 'm4a1')
				inv[A] = c:sub(1,1) == 'c' and c:sub(2) or c
				A = A + 1
			end
		end
	end

	local buy, N = {}, 1
	local pri, sec, gear = primary_weapons[ get(primary) ], secondary_weapons[ get(secondary) ], get(gear)

	if pri ~= '' and not in_table( inv, pri ) then 
		buy[N] = 'buy '.. pri
		N = N + 1
	end

	if sec ~= '' and not in_table( inv, sec ) then
		buy[N] = 'buy '.. sec
		N = N + 1
	end

	for i=1, #gear do
		local util = gear_utilites[ gear[i] ]
		if not in_table( inv, util ) then
			buy[N] = 'buy '.. util
			N = N + 1
		end 
	end

	local b = concat(buy, '; ')
	exec(b)

	delay_call(0.1, function() allow_send = true end)
end

local events = {'player_spawn', 'round_end_upload_stats', 'round_officially_ended'}
local function on_enable_change(s)
	local v = get(s)
	local callback = v and _set or _unset
	for i=1, #events do callback(events[i], on_event) end

	set_visible(primary, v)
	set_visible(secondary, v)
	set_visible(gear, v)
end

on_enable_change(enabled)
set_callback(enabled, on_enable_change)