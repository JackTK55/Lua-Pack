local GetLocalPlayer, GetPlayerIndexByUserID, entities_GetByIndex, table_insert, table_remove, client_GetConVar, math_random, g_curtime, g_maxclients, client_WorldToScreen, string_format, draw_SetFont, draw_GetTextSize, draw_Color, draw_TextShadow = entities.GetLocalPlayer, entities.GetByIndex, client.GetPlayerIndexByUserID, table.insert, table.remove, client.GetConVar, math.random, globals.CurTime, globals.MaxClients, client.WorldToScreen, string.format, draw.SetFont, draw.GetTextSize, draw.Color, draw.TextShadow

local better_grenades = gui.Checkbox(gui.Reference("VISUALS", "OTHER", "Options"), "esp_other_better_grenades", "Better Grenades", false)
local Vf11 = draw.CreateFont("Verdana", 11)

local smokes, molotovs, flashes, grenades = {}, {}, {}, {}
function grenade_timer_events(e)
	if not better_grenades:GetValue() or e:GetName() ~= "round_prestart" and 
	e:GetName() ~= "grenade_thrown" and e:GetName() ~= "smokegrenade_detonate" and 
	e:GetName() ~= "molotov_detonate" and e:GetName() ~= "inferno_startburn" and 
	e:GetName() ~= "inferno_expire" and e:GetName() ~= "inferno_extinguish" then 
		return 
	end 
	
	local entityid = e:GetInt("entityid") 
	local x = e:GetFloat("x") 
	local y = e:GetFloat("y") 
	local z = e:GetFloat("z") 
	local userid_to_index = GetPlayerIndexByUserID(e:GetInt("userid"))

	if e:GetName() == "round_prestart" then 
		smokes, molotovs = {}, {} 
	end
		
	if e:GetName() == "smokegrenade_detonate" then 
		table_insert(smokes, {g_curtime(), entityid, x, y, z}) 
	end
		
	if e:GetName() == "molotov_detonate" then 
		user_index = userid_to_index
	end 
		
	if e:GetName() == "inferno_startburn" then 
		table_insert(molotovs, {g_curtime(), entityid, x, y, z, user_index}) 
	end
		
	if e:GetName() == "inferno_expire" or e:GetName() == "inferno_extinguish" then 
		for k, v in pairs(molotovs) do 
			if v[2] == entityid then 
				table_remove(molotovs, k) 
			end 
		end 
	end
				
	if e:GetName() == "grenade_thrown" then 
		randnumber = math_random(1, client_GetConVar("ammo_grenade_limit_total")*g_maxclients()) 
		if e:GetString("weapon") == "flashbang" then 
			table_insert(flashes, {g_curtime(), randnumber * 1.77}) 
		end
			
		if e:GetString("weapon") == "hegrenade" then 
			table_insert(grenades, {g_curtime(), randnumber * 2.10}) 
		end 
	end 
end

function smoke_and_molotov_timers()
	if not better_grenades:GetValue() or GetLocalPlayer() == nil then 
		return 
	end 
	
	for k, v in pairs(smokes) do 
		if v[1] - g_curtime() + 17.6 > 0 then 
			local X, Y = client_WorldToScreen(v[3], v[4], v[5]) 
			local smoke_timeleft = string_format("%0.1f",  v[1] - g_curtime() + 17.6) 
			if X ~= nil and Y ~= nil then 
				draw_SetFont(Vf11) 
				local tW, tH = draw_GetTextSize(smoke_timeleft) 
				local tW2, tH2 = draw_GetTextSize("SMOKE") 
				draw_Color(255, 255, 255, 255) 
				draw_TextShadow(X - (tW/2), Y - (tH/2), smoke_timeleft) 
				draw_Color(255, 255, 255, 255) 
				draw_TextShadow(X - (tW2/2), Y - (tH2/2) + tH2, "SMOKE") 
			end
		else 
			table_remove(smokes, k)
		end 
	end 
				
	for k, v in pairs(molotovs) do 
		if v[1] - g_curtime() + 7 > 0 then 
			local X, Y = client_WorldToScreen(v[3], v[4], v[5]) 
			local molotov_timeleft = string_format("%0.1f",  v[1] - g_curtime() + 7) 
			
			if X ~= nil and Y ~= nil then
				draw_SetFont(Vf11) 
				local tW, tH = draw_GetTextSize(molotov_timeleft) 
				local tW2, tH2 = draw_GetTextSize("MOLLY") 
				draw_Color(255, 255, 255, 255) 
				draw_TextShadow(X - (tW/2), Y - (tH/2), molotov_timeleft)
				
				if entities_GetByIndex(v[6]):GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber() then
					r, g, b, a = 153, 153, 255, 255 
				else 
					r, g, b, a = 251, 82, 79, 255 
				end 
					
				draw_Color(r, g, b, a) 
				draw_TextShadow(X - (tW2/2), Y - (tH2/2) + tH2, "MOLLY") end 
			
		else 
			table_remove(molotovs, k) 
		end 
	end 
end

function grenade_and_flash_timers(b)
	if not better_grenades:GetValue() or b:GetEntity():GetClass() ~= "CBaseCSGrenadeProjectile" then 
		return 
	end
	
	for k, v in pairs(flashes) do 
		if v[1] - g_curtime() + 1.65 > 0 then 
			if v[2] == randnumber * 1.77 then 
				b:AddBarBottom(v[1] - g_curtime() + 1.65) 
			end 
		else 
			table_remove(flashes, k) 
		end 
	end 
	
	for k, v in pairs(grenades) do 
		if v[1] - g_curtime() + 1.65 > 0 then 
			if v[2] == randnumber * 2.10 then 
				b:AddBarBottom(v[1] - g_curtime() + 1.65) 
			end 	
		else 
			table_remove(grenades, k) 
		end 
	end 
end
	
callbacks.Register("Draw", smoke_and_molotov_timers) 
callbacks.Register("DrawESP", grenade_and_flash_timers) 
callbacks.Register("FireGameEvent", grenade_timer_events)

client.AllowListener("round_prestart")
client.AllowListener("grenade_thrown")
client.AllowListener("smokegrenade_detonate") 
client.AllowListener("molotov_detonate") 
client.AllowListener("inferno_startburn") 
client.AllowListener("inferno_expire") 
client.AllowListener("inferno_extinguish") 