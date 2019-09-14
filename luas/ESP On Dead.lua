local GetLocalPlayer, string_format, gui_GetValue, gui_SetValue, PlayerIndexByUserID, LocalPlayerIndex = entities.GetLocalPlayer, string.format, gui.GetValue, gui.SetValue, client.GetPlayerIndexByUserID, client.GetLocalPlayerIndex
local ESP_On_Dead = gui.Checkbox(gui.Reference('VISUALS', 'ENEMIES', 'Filter'), 'lua_esp_on_dead', 'ESP On Dead', false)
local alive_esp, dead_esp, visibility, loaded = {}, {}, nil, false

local window = gui.Window('esp_on_dead_window', 'Esp On Dead', 200, 200, 242, 520)
local group = gui.Groupbox(window, 'Options', 16, 16, 212, 457)
local ESP_On_Dead_enabled = gui.Checkbox(group, 'lua_esp_on_dead_enabled', 'Active', false)
local esp_elements = {
	box = gui.Combobox(group, 'esp_on_dead_box', 'Box', 'Off', '2D', '3D', 'Edges', 'Machine', 'Pentagon', 'Hexagon'),
	box_outline = gui.Checkbox(group, 'esp_on_dead_box_outline', 'Box Outline', false),
	box_precise = gui.Checkbox(group, 'esp_on_dead_box_precise', 'Box Precision', false),
	name = gui.Checkbox(group, 'esp_on_dead_name', 'Name', false),
	health = gui.Combobox(group, 'esp_on_dead_health', 'Health', 'Off', 'Bar', 'Number', 'Both'),
	armor = gui.Checkbox(group, 'esp_on_dead_armor', 'Armor', false),
	weapon = gui.Combobox(group, 'esp_on_dead_weapon', 'Weapon', 'Off', 'Show Active', 'Show All'),
	ammo = gui.Combobox(group, 'esp_on_dead_ammo', 'Ammo', 'Off', 'Number', 'Bar'),
	skeleton = gui.Checkbox(group, 'esp_on_dead_skeleton', 'Skeleton', false),
	hitbox = gui.Combobox(group, 'esp_on_dead_hitbox', 'Hitbox', 'Off', 'White', 'Color'),
	chams = gui.Combobox(group, 'esp_on_dead_chams', 'Chams', 'Off', 'Color', 'Material', 'Color Wireframe', 'Mat Wireframe', 'Invisible', 'Metallic', 'Flat'),
	xqz = gui.Checkbox(group, 'esp_on_dead_xqz', 'XQZ', false),
	glow = gui.Combobox(group, 'esp_on_dead_glow', 'Glow', 'Off', 'Team Color', 'Health Color'),
	headspot = gui.Checkbox(group, 'esp_on_dead_headspot', 'Head Spot', false),
	aimpoints = gui.Checkbox(group, 'esp_on_dead_aimpoints', 'Aim Points', false),
	hasc4 = gui.Checkbox(group, 'esp_on_dead_hasc4', 'Has C4', false),
	hasdefuser = gui.Checkbox(group, 'esp_on_dead_hasdefuser', 'Has Defuser', false),
	defusing = gui.Checkbox(group, 'esp_on_dead_defusing', 'Is Defusing', false),
	flashed = gui.Checkbox(group, 'esp_on_dead_flashed', 'Is Flashed', false),
	scoped = gui.Checkbox(group, 'esp_on_dead_scoped', 'Is Scoped', false),
	reloading = gui.Checkbox(group, 'esp_on_dead_reloading', 'Is Reloading', false),
	comprank = gui.Checkbox(group, 'esp_on_dead_comprank', 'Competitive Rank', false),
	barrel = gui.Checkbox(group, 'esp_on_dead_barrel', 'Barrel', false),
	money = gui.Checkbox(group, 'esp_on_dead_money', 'Money', false),
	damage = gui.Checkbox(group, 'esp_on_dead_damage', 'Damage', false)
}

local set_tables = function()
	visibility = gui_GetValue('esp_visibility_enemy')

	for var, val in pairs(esp_elements) do
		local aw_var = string_format('esp_enemy_%s', var)
		local aw_val = gui_GetValue(aw_var)
		local lua_var = string_format('esp_on_dead_%s', var)
		local lua_val = gui_GetValue(lua_var)

		dead_esp[aw_var] = lua_val
		alive_esp[aw_var] = aw_val
	end
end

local esp_switch = function(from_table, to_table)
	for var, val in pairs(esp_elements) do
		local aw_var = string_format('esp_enemy_%s', var)
		local lua_var = string_format('esp_on_dead_%s', var)
		gui_SetValue(lua_var, from_table[aw_var])
	end

	for var, val in pairs(to_table) do
		gui_SetValue(var, val)
	end
end

callbacks.Register('Draw', 'Esp On dead', function()
	window:SetActive( ESP_On_Dead:GetValue() and gui.Reference('MENU'):IsActive() )

	if not ESP_On_Dead_enabled:GetValue() then
		return
	end

	if GetLocalPlayer() == nil then 
		return
	end

	local dead = not GetLocalPlayer():IsAlive()

	if dead then
		return
	end

	set_tables()
end)

callbacks.Register('FireGameEvent', 'player death/spawn', function(e)
	local event_name = e:GetName()
	local no_esp = not gui_GetValue('esp_filter_enemy') or not gui_GetValue('esp_active')

	if not ESP_On_Dead_enabled:GetValue() or no_esp or (event_name ~= 'player_death' and event_name ~= 'player_spawn') or PlayerIndexByUserID(e:GetInt('userid')) ~= LocalPlayerIndex() then 
		return 
	end
	
	if loaded then
		if event_name == 'player_death' then
			gui_SetValue('esp_visibility_enemy', 0)
			esp_switch(alive_esp, dead_esp)
		end

		if event_name == 'player_spawn' then
			gui_SetValue('esp_visibility_enemy', visibility)
			esp_switch(dead_esp, alive_esp)
		end
	end

	if not loaded then
		set_tables()
		loaded = true
	end

end)

client.AllowListener('player_spawn')
client.AllowListener('player_death')
