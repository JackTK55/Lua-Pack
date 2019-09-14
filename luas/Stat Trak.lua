local file_Open, gui_GetValue, gui_SetValue, GetByUserID, PlayerIndexByUserID, LocalPlayer, LocalPlayerIndex, string_format, math_floor, client_exec = file.Open, gui.GetValue, gui.SetValue, entities.GetByUserID, client.GetPlayerIndexByUserID, entities.GetLocalPlayer, client.GetLocalPlayerIndex, string.format, math.floor, client.Command
local stat_trak = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_stattrak_count", "Stattrak Counter", false)
local stat_trak_saving = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_stattrak_saving", "Save Stattrak to File", false)

local current_tracked, killed_someone = {}, false
local bad_weapons = {'inferno', 'hegrenade', 'smokegrenade', 'flashbang', 'decoy', 'knife', 'knife_t', 'taser', 'shield'}
local weapons_table = {'deagle', 'elite', 'fiveseven', 'glock', 'ak47', 'aug', 'awp', 'famas', 'g3sg1', 'galilar', 'm249', 'm4a1', 'mac10', 'p90', 'mp5sd', 'ump45', 'xm1014', 'bizon', 'mag7', 'negev', 'sawedoff', 'tec9', 'hkp2000', 'mp7', 'mp9', 'nova', 'p250', 'shield', 'scar20', 'sg556', 'ssg08', 'm4a1_silencer', 'usp_silencer', 'cz75a', 'revolver', 'bayonet', 'knife_flip', 'knife_gut', 'knife_karambit', 'knife_m9_bayonet', 'knife_tactical', 'knife_falchion', 'knife_survival_bowie', 'knife_butterfly', 'knife_push', 'knife_ursus', 'knife_gypsy_jackknife', 'knife_stiletto', 'knife_widowmaker'}
local knife_table = {[500]='bayonet', [505]='knife_flip', [506]='knife_gut', [507]='knife_karambit', [508]='knife_m9_bayonet', [509]='knife_tactical', [512]='knife_falchion', [514]='knife_survival_bowie', [515]='knife_butterfly', [516]='knife_push', [519]='knife_ursus', [520]='knife_gypsy_jackknife', [522]='knife_stiletto', [523]='knife_widowmaker'}

local get_knife_from_id = function(knife)
	for id, name in pairs(knife_table) do
		if id == knife then
			return name
		end
	end
	return 'knife'
end

local update_settings = function(action)
	if action == 'load' then
		local settings_file = file_Open('stattrak_values.dat', 'r')

		if settings_file == nil then
			return
		end

			local settings = settings_file:Read()
				gui.Command(settings)
		settings_file:Close()

		for i=1, #weapons_table do
			local weapon = string_format('skin_%s_stattrak', weapons_table[i])
			current_tracked[weapon] = gui_GetValue(weapon)
		end
	end

	if not stat_trak_saving:GetValue() then
		return
	end

	if action == 'save' then
		local settings_file = file_Open('stattrak_values.dat', 'w')
		for weapon, value in pairs(current_tracked) do
			local data = string_format('%s %i;', weapon, value)
			settings_file:Write(data)
		end

		settings_file:Close()
	end
end
update_settings('load')

local table_contains = function(t, m)
    for i=1, #t do
        if t[i] == m then
            return true
        end
    end
    return false
end

local killed_enemy = function(att, id)
	return GetByUserID(id):GetTeamNumber() ~= LocalPlayer():GetTeamNumber() and PlayerIndexByUserID(att) == LocalPlayerIndex() and PlayerIndexByUserID(id) ~= LocalPlayerIndex()
end

callbacks.Register("FireGameEvent", 'StatTrak', function(e)
	local e_name = e:GetName()
	if not stat_trak:GetValue() or not gui_GetValue("skin_active") or (e_name ~= 'player_death' and e_name ~= 'round_prestart') then
		return
	end

	if e_name == "player_death" and killed_enemy(e:GetInt("attacker"), e:GetInt("userid")) then

		local weapon = e:GetString("weapon")

		if weapon == 'knife' or weapon == 'knife_t' then
			weapon = get_knife_from_id(LocalPlayer():GetWeaponID())
		end

		if not table_contains(bad_weapons, weapon) then
			local skin_enabled = gui_GetValue(string_format("skin_%s_enable", weapon))
			local _weapon = string_format("skin_%s_stattrak", weapon)
			local stattrak_val = tonumber(gui_GetValue(_weapon))

			if skin_enabled and stattrak_val > 0 then
				gui_SetValue(_weapon, stattrak_val + 1)
				current_tracked[_weapon] = gui_GetValue(_weapon)
				killed_someone = true
			end
		end
	end

	if e_name == "round_prestart" then
		if killed_someone then
			client_exec("cl_fullupdate", true)
			update_settings('save')
			killed_someone = false
		end
	end
end)

client.AllowListener('player_death')
client.AllowListener('round_prestart')