local old_steal = gui.Reference( 'Misc', 'Enhancement', 'Appearance', 'Steal Name' )
	old_steal:SetInvisible( 1 )
	callbacks.Register( 'Unload', function()
		old_steal:SetInvisible( 0 )
	end)

local ref = gui.Reference( 'Misc', 'Enhancement', 'Appearance' )
local modes = gui.Combobox( ref, 'namesteam_mode', 'Namesteal', 'Off', 'All', 'Enemies', 'Teammates' )
local delay = gui.Slider( ref, 'namesteal_delay', 'Namesteal Delay', 0.5, 0, 10, 0.1 )
local name_changes, next_change, last_change = 0, 0, 1

local function set_name( str )
	if name_changes < 5 then
		client.SetConVar( 'name', '\n\xAD\xAD\xAD', true )
		name_changes = name_changes + 1
	else
		client.SetConVar( 'name', str .. '\r', true )
	end
end

local get_names = function( mode )
	local my = entities.GetLocalPlayer()
	if not my then
		name_changes = 0
		return
	end

	local names = {}
	local player_resources = entities.GetPlayerResources()
	local my_index = my:GetIndex()
	local my_team = my:GetTeamNumber()
	local n = 1

	for i=0, globals.MaxClients() do
		local team = player_resources:GetPropInt( 'm_iTeam', i )

		if team ~= 0 and my_index ~= i then
			if ( mode == 'All' ) or 
			   ( mode == 'Enemies' and team ~= my_team ) or 
			   ( mode == 'Teammates' and team == my_team )
			then
				names[ n ] = client.GetPlayerNameByIndex( i )
				n = n + 1
			end
		end
	end

	return names
end

callbacks.Register( 'Draw', function()
	local mode = modes:GetString()
	if mode == 'Off' then
		return
	end

	local current = globals.CurTime()
	if next_change > current then
		return
	end

	local names = get_names( mode )
	if not names then
		return
	end

	if last_change > #names then
		last_change = 1
	end

	set_name( names[last_change] )
	last_change = last_change + 1
	next_change = current + delay:GetValue()
end)