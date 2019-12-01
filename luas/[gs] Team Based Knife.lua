local get, set, userid_to_entindex, get_local_player, set_visible = ui.get, ui.set, client.userid_to_entindex, entity.get_local_player, ui.set_visible

local enable, combo = ui.reference('skins', 'knife options', 'Override knife')
set_visible(combo, false)

local knives = {
	'Bayonet',
	'Flip',
	'Gut',
	'Karambit',
	'M9 Bayonet',
	'Tactical',
	'Butterfly',
	'Falchion',
	'Shadow dagger',
	'Survival bowie',
	'Ursus',
	'Navaja',
	'Stiletto',
	'Talon',
	'Classic knife',
	'Paracord',
	'Survival',
	'Nomad',
	'Skeleton',
}

local T_Knife = ui.new_combobox('skins', 'knife options', 'Override T Knife', knives)
local CT_Knife = ui.new_combobox('skins', 'knife options', 'Override CT Knife', knives)

local get_prop = entity.get_prop
ui.set_callback(T_Knife, function()
	if get_prop(get_local_player(), 'm_iTeamNum') == 2 then set(combo, get(T_Knife)) end
end)

ui.set_callback(CT_Knife, function()
	if get_prop(get_local_player(), 'm_iTeamNum') == 3 then set(combo, get(CT_Knife)) end
end)

client.set_event_callback('player_team', function(e)
	if get(enable) and userid_to_entindex( e.userid ) == get_local_player() then
		local team = e.team

		if team == 2 then
			set(combo, get(T_Knife))
		elseif team == 3 then
			set(combo, get(CT_Knife))
		end
	end
end)

client.set_event_callback('shutdown', function(_)
	set_visible(combo, true)
end)
