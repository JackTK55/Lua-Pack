local GetLocalPlayer, GetPlayerIndexByUserID, entities_GetByIndex, client_GetConVar, math_random, g_curtime, g_maxclients, client_WorldToScreen, string_format, draw_SetFont, draw_GetTextSize, draw_Color, draw_TextShadow, Register = entities.GetLocalPlayer, client.GetPlayerIndexByUserID, entities.GetByIndex, client.GetConVar, math.random, globals.CurTime, globals.MaxClients, client.WorldToScreen, string.format, draw.SetFont, draw.GetTextSize, draw.Color, draw.TextShadow, callbacks.Register

local better_grenades = gui.Checkbox(gui.Reference("VISUALS","OTHER","Options"),"esp_other_better_grenades","Better Grenades",false)
local Vf11 = draw.CreateFont("Verdana", 11)

local listeners = {'round_prestart', 'grenade_thrown', 'smokegrenade_detonate', 'molotov_detonate', 'inferno_startburn', 'inferno_expire', 'inferno_extinguish'}
for i=1, #listeners do
	client.AllowListener(listeners[i])
end

local smokes, molotovs, flashes, grenades = {}, {}, {}, {}
local function events(e)
	local event_name = e:GetName()

	if not better_grenades:GetValue() or event_name ~= "round_prestart" and
	event_name ~= "grenade_thrown" and event_name ~= "smokegrenade_detonate" and
	event_name ~= "molotov_detonate" and event_name ~= "inferno_startburn" and
	event_name ~= "inferno_expire" and event_name ~= "inferno_extinguish" then
		return
	end

	local entityid = e:GetInt("entityid")
	local x = e:GetFloat("x")
	local y = e:GetFloat("y")
	local z = e:GetFloat("z")
	local userid_to_index = GetPlayerIndexByUserID(e:GetInt("userid"))

	if event_name == "round_prestart" then
		smokes, molotovs = {}, {}
	end

	if event_name == "smokegrenade_detonate" then
		smokes[#smokes + 1] = {g_curtime(), x, y, z}
	end

	if event_name == "molotov_detonate" then
		user_index = userid_to_index
	end

	if event_name == "inferno_startburn" then
		molotovs[#molotovs + 1] = {g_curtime(), entityid, x, y, z, user_index}
	end

	if event_name == "inferno_expire" or event_name == "inferno_extinguish" then
		for k,v in pairs(molotovs) do
			if v[2] == entityid then
				molotovs[k] = nil
			end
		end
	end

	if event_name == "grenade_thrown" then
		randnumber = math_random(1, client_GetConVar("ammo_grenade_limit_total")*g_maxclients())
		if e:GetString("weapon") == "flashbang" then
			flashes[#flashes + 1] = {g_curtime(), randnumber * 1.77}
		end

		if e:GetString("weapon") == "hegrenade" then
			grenades[#grenades + 1] = {g_curtime(), randnumber * 2.10}
		end
	end
end

local function sm_timers()
	if not better_grenades:GetValue() or GetLocalPlayer() == nil then
		return
	end

	for k,v in pairs(smokes) do
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
			smokes[k] = nil
		end
	end
	
	for k,v in pairs(molotovs) do
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
					r, g, b, a = 251, 82, 79, 255
				else
					r, g, b, a = 153, 153, 255, 255
				end

				draw_Color(r, g, b, a)
				draw_TextShadow(X - (tW2/2), Y - (tH2/2) + tH2, "MOLLY")
			end
		else
			molotovs[k] = nil
		end
	end
end

local function gf_timers(b)
	if not better_grenades:GetValue() or b:GetEntity():GetClass() ~= "CBaseCSGrenadeProjectile" then
		return
	end

	for k,v in pairs(flashes) do
		if v[1] - g_curtime() + 1.65 > 0 then
			if v[2] == randnumber * 1.77 then
				b:AddBarBottom(v[1] - g_curtime() + 1.65)
			end
		else
			flashes[k] = nil
		end
	end 

	for k,v in pairs(grenades) do 
		if v[1] - g_curtime() + 1.65 > 0 then
			if v[2] == randnumber * 2.10 then
				b:AddBarBottom(v[1] - g_curtime() + 1.65)
			end
		else
			grenades[k] = nil
		end
	end
end

Register("Draw", sm_timers)
Register("DrawESP", gf_timers)
Register("FireGameEvent", events)