local file_Open, gui_GetValue, gui_SetValue, entities_GetByIndex, PlayerIndexByUserID, GetLocalPlayer, LocalPlayerIndex, string_format, math_floor, client_exec = file.Open, gui.GetValue, gui.SetValue, entities.GetByIndex, client.GetPlayerIndexByUserID, entities.GetLocalPlayer, client.GetLocalPlayerIndex, string.format, math.floor, client.Command
local stat_trak = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_stattrak_count", "Stattrak Counter", false)
local stat_trak_saving = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_stattrak_saving", "Save Stattrak to File", false)

local bad_weapons = {'inferno', 'hegrenade', 'smokegrenade', 'flashbang', 'decoy', 'knife', 'knife_t', 'taser'}
local current_tracked, killed_someone = {}, false
local weapons_table = {'skin_deagle_stattrak', 'skin_elite_stattrak', 'skin_fiveseven_stattrak', 'skin_glock_stattrak', 'skin_ak47_stattrak', 'skin_aug_stattrak', 'skin_awp_stattrak', 'skin_famas_stattrak', 'skin_g3sg1_stattrak', 'skin_galilar_stattrak', 'skin_m249_stattrak', 'skin_m4a1_stattrak', 'skin_mac10_stattrak', 'skin_p90_stattrak', 'skin_mp5sd_stattrak', 'skin_ump45_stattrak', 'skin_xm1014_stattrak', 'skin_bizon_stattrak', 'skin_mag7_stattrak', 'skin_negev_stattrak', 'skin_sawedoff_stattrak', 'skin_tec9_stattrak', 'skin_hkp2000_stattrak', 'skin_mp7_stattrak', 'skin_mp9_stattrak', 'skin_nova_stattrak', 'skin_p250_stattrak', 'skin_shield_stattrak', 'skin_scar20_stattrak', 'skin_sg556_stattrak', 'skin_ssg08_stattrak', 'skin_m4a1_silencer_stattrak', 'skin_usp_silencer_stattrak', 'skin_cz75a_stattrak', 'skin_revolver_stattrak', 'skin_bayonet_stattrak', 'skin_knife_flip_stattrak', 'skin_knife_gut_stattrak', 'skin_knife_karambit_stattrak', 'skin_knife_m9_bayonet_stattrak', 'skin_knife_tactical_stattrak', 'skin_knife_falchion_stattrak', 'skin_knife_survival_bowie_stattrak', 'skin_knife_butterfly_stattrak', 'skin_knife_push_stattrak', 'skin_knife_ursus_stattrak', 'skin_knife_gypsy_jackknife_stattrak', 'skin_knife_stiletto_stattrak', 'skin_knife_widowmaker_stattrak'}
local knife_table = {[500] = 'bayonet', [505] = 'knife_flip', [506] = 'knife_gut', [507] = 'knife_karambit', [508] = 'knife_m9_bayonet', [509] = 'knife_tactical', [512] = 'knife_falchion', [514] = 'knife_survival_bowie', [515] = 'knife_butterfly', [516] = 'knife_push', [519] = 'knife_ursus', [520] = 'knife_gypsy_jackknife', [522] = 'knife_stiletto', [523] = 'knife_widowmaker'}

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
			local weapon = weapons_table[i]
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

local function table_contains(table, item)
    for i=1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end

function StatTrak(e)
	if not stat_trak:GetValue() or not gui_GetValue("skin_active") then
		return
	end

	if e:GetName() == "player_death" and entities_GetByIndex(PlayerIndexByUserID(e:GetInt("userid"))):GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() and 
	   PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then

		local weapon = e:GetString("weapon")

		if weapon == 'knife' or weapon == 'knife_t' then
			weapon = get_knife_from_id(GetLocalPlayer():GetWeaponID())
		end

		if not table_contains(bad_weapons, weapon) then
			local skin_enabled = gui_GetValue(string_format("skin_%s_enable", weapon))
			local _weapon = string_format("skin_%s_stattrak", weapon)
			local stattrak_val = tonumber(gui_GetValue(_weapon))

			if skin_enabled and stattrak_val > 0 then
				gui_SetValue(_weapon, math_floor(stattrak_val) + 1)
				current_tracked[_weapon] = gui_GetValue(_weapon)
				killed_someone = true
			end
		end
	end

	if e:GetName() == "round_prestart" then
		if killed_someone then
			client_exec("cl_fullupdate", true)
			update_settings('save')
			killed_someone = false
		end
	end
end

callbacks.Register("FireGameEvent", StatTrak)
client.AllowListener('round_prestart')
