local gui_GetValue, gui_SetValue, entities_GetByIndex, PlayerIndexByUserID, GetLocalPlayer, LocalPlayerIndex, string_format, math_floor, client_exec = gui.GetValue, gui.SetValue, entities.GetByIndex, client.GetPlayerIndexByUserID, entities.GetLocalPlayer, client.GetLocalPlayerIndex, string.format, math.floor, client.Command

local stat_trak = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_stattrak_count", "Stattrak Counter", false)

local function table_contains(table, item)
    for i=1, #table do
        if table[i] == item then
            return true
        end
    end
    return false
end

local bad_weapons = {'inferno', 'hegrenade', 'smokegrenade', 'flashbang', 'decoy', 'knife', 'knife_t', 'taser'}

function StatTrak(e) 
	if not stat_trak:GetValue() or not gui_GetValue("skin_active") then 
		return 
	end 

	if e:GetName() == "player_death" and entities_GetByIndex(PlayerIndexByUserID(e:GetInt("userid"))):GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() and
	PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then 

		if not table_contains(bad_weapons, e:GetString("weapon")) then 	
			act = string_format("skin_%s_enable", e:GetString("weapon"))
			wep = string_format("skin_%s_stattrak", e:GetString("weapon"))
			
			if gui_GetValue(act) then
				if tonumber(gui_GetValue(wep)) > 0 then 
					gui_SetValue(wep, math_floor(gui_GetValue(wep)) + 1) 
				end 
			end
		end 
	end
 
	if e:GetName() == "round_prestart" then 
		client_exec("cl_fullupdate", true) 
	end 
end 

callbacks.Register("FireGameEvent", StatTrak)
client.AllowListener('round_prestart')