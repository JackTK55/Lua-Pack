local gui_GetValue, gui_SetValue, entities_GetByIndex, PlayerIndexByUserID, GetLocalPlayer, string_format, math_floor, client_exec = 
gui.GetValue, gui.SetValue, entities.GetByIndex, client.GetPlayerIndexByUserID, entities.GetLocalPlayer, string.format, math.floor, client.Command

local stat_trak = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_stattrak_count", "Working Stattrak", false)

function StatTrak(e) 
	if not Working_Stattrak:GetValue() or not gui_GetValue("skin_active") then 
		return 
	end 

	if e:GetName() == "player_death" and entities_GetByIndex(PlayerIndexByUserID(e:GetInt("userid"))):GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() and
	PlayerIndexByUserID(e:GetInt("attacker")) == LocalPlayerIndex() and PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then 

		if e:GetString("weapon") ~= "inferno" and e:GetString("weapon") ~= "hegrenade" and 
			e:GetString("weapon") ~= "smokegrenade" and e:GetString("weapon") ~= "flashbang" and 
			e:GetString("weapon") ~= "decoy" and e:GetString("weapon") ~= "knife" and e:GetString("weapon") ~= "knife_t" then 
			
			wep = string_format("skin_%s_stattrak", e:GetString("weapon"))
			
			if tonumber(gui_GetValue(wep)) > 0 then 
				gui_SetValue(wep, math_floor(gui_GetValue(wep)) + 1) 
			end 
		end 
	end
 
	if e:GetName() == "round_prestart" then 
		client_exec("cl_fullupdate", true) 
	end 
end 
callbacks.Register("FireGameEvent", StatTrak)
