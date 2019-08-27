local GetPlayerResources, vector_Distance, PlayerNameByUserID, g_curtime, entities_GetByIndex, draw_GetScreenSize, string_format, draw_SetFont, draw_GetTextSize, draw_Color, draw_Text, draw_FilledRect, entities_FindByClass, GetLocalPlayer = entities.GetPlayerResources, vector.Distance, client.GetPlayerNameByUserID, globals.CurTime, entities.GetByIndex, draw.GetScreenSize, string.format, draw.SetFont, draw.GetTextSize, draw.Color, draw.Text, draw.FilledRect, entities.FindByClass, entities.GetLocalPlayer

local BombTimer = gui.Checkbox(gui.Reference("VISUALS", "OTHER", "Options"), "esp_other_better_c4timer", "Bomb Timer", false)

local Vf30 = draw.CreateFont("Verdana", 30)

local lerp_pos = function(x1, y1, z1, x2, y2, z2, percentage)
	local x = (x2 - x1) * percentage + x1
	local y = (y2 - y1) * percentage + y1
	local z = (z2 - z1) * percentage + z1

	return x, y, z
end

local get_site_name = function(site)
	local a_x, a_y, a_z = GetPlayerResources():GetProp("m_bombsiteCenterA")
	local b_x, b_y, b_z = GetPlayerResources():GetProp("m_bombsiteCenterB")

	local site_x1, site_y1, site_z1 = site:GetMins()
	local site_x2, site_y2, site_z2 = site:GetMaxs()

	local site_x, site_y, site_z = lerp_pos(site_x1, site_y1, site_z1, site_x2, site_y2, site_z2, 0.5)

	local distance_a = vector_Distance(site_x, site_y, site_z, a_x, a_y, a_z)
	local distance_b = vector_Distance(site_x, site_y, site_z, b_x, b_y, b_z)

	return distance_b > distance_a and "A" or "B"
end

function bombEvents(e)
	if not BombTimer:GetValue() or e:GetName() ~= "bomb_beginplant" and
	e:GetName() ~= "bomb_abortplant" and e:GetName() ~= "bomb_planted" and
	e:GetName() ~= "bomb_begindefuse" and e:GetName() ~= "bomb_abortdefuse" and
	e:GetName() ~= "bomb_defused" and e:GetName() ~= "round_officially_ended" and e:GetName() ~= "round_prestart" then
		return
	end

	if e:GetName() == "bomb_beginplant" then
		planter = PlayerNameByUserID(e:GetInt("userid"))
		plantPercent = 0
		plantingStarted = g_curtime()
		plantingSite = get_site_name(entities_GetByIndex(e:GetInt("site")))
		drawPlant = true
	end

	if e:GetName() == "bomb_abortplant" then
		drawPlant = false
	end

	if e:GetName() == "bomb_planted" then
		drawPlant = false
		plantedPercent = 0
		plantedAt = g_curtime()
		drawBombPlanted = true
	end

	if e:GetName() == "bomb_begindefuse" then
		defuser = PlayerNameByUserID(e:GetInt("userid"))
		defusePercent = 0
		defuseStarted = g_curtime()
		drawDefuse = true
	end

	if e:GetName() == "bomb_abortdefuse" then
		drawDefuse = false
	end

	if e:GetName() == "bomb_defused" or e:GetName() == "round_officially_ended" or e:GetName() == "round_prestart" then
		drawBombPlanted, drawDefuse, drawPlant = false, false, false
	end
end

function drawBombTimers()
	if not BombTimer:GetValue() then
		return
	end

	local screenX, screenY = draw_GetScreenSize()

	if drawPlant then
		local plantTime = string_format("%s - %0.1fs", planter, plantingStarted - g_curtime() + 3.125)
		local plantingInfo = string_format("%s - Planting", plantingSite)
		local plantPercent = (g_curtime() - plantingStarted) / 3.125
		draw_SetFont(Vf30)

		local tW, tH = draw_GetTextSize(plantingInfo)
		draw_Color(124, 195, 13, 255)
		draw_Text(20, 0, plantingInfo)
		draw_Color(255, 255, 255, 255)
		draw_Text(20, tH, plantTime)

		if plantPercent < 1 and plantPercent > 0 then
			local plantingBar = (1 - plantPercent) * screenY
			draw_Color(13, 13, 13, 70)
			draw_FilledRect(0, 0, 16, screenY)
			draw_Color(0, 150, 0, 255)
			draw_FilledRect(1, plantingBar, 15, screenY+plantingBar)
		end
	end

	if drawBombPlanted and entities_FindByClass("CPlantedC4")[1] ~= nil then
		local plantedBomb = entities_FindByClass("CPlantedC4")

		for i=1, #plantedBomb do
			bLength = plantedBomb[i]:GetPropFloat("m_flTimerLength")
			dLength = plantedBomb[i]:GetPropFloat("m_flDefuseLength")
			bSite = plantedBomb[i]:GetPropInt("m_nBombSite") == 0 and "A" or "B"
		end

		local plantedInfo = string_format("%s - %0.1fs", bSite, (plantedAt - g_curtime()) + bLength)
		local plantedPercent = (g_curtime() - plantedAt) / bLength

		if plantedAt - g_curtime() + bLength > 0 then
			draw_SetFont(Vf30)
			pTW, pTH = draw_GetTextSize(plantedInfo)

			if GetLocalPlayer():GetTeamNumber() == 3 and (not GetLocalPlayer():GetPropBool("m_bHasDefuser") and (plantedAt - g_curtime()) + bLength < 10.1 or
			GetLocalPlayer():GetPropBool("m_bHasDefuser") and (plantedAt - g_curtime()) + bLength < 5.1) then
				r, g, b, a = 255,13,13,255
			else
				r, g, b, a = 124, 195, 13, 255
			end

			draw_Color(r, g, b, a)
			draw_Text(20, 0, plantedInfo)
			if plantedPercent < 1 and plantedPercent > 0 then
				local plantedBar = (1 - plantedPercent) * screenY
				draw_Color(13, 13, 13, 70)
				draw_FilledRect(0, 0, 16, screenY)
				draw_Color(0, 150, 0, 255)
				draw_FilledRect(1, screenY-plantedBar, 15, screenY)
			end
		end
	end

	if drawDefuse and entities_FindByClass("CPlantedC4")[1] ~= nil then
		local plantedBomb = entities_FindByClass("CPlantedC4")

		for i=1, #plantedBomb do
			dLength = plantedBomb[i]:GetPropFloat("m_flDefuseLength")
		end

		local defuseInfo = string_format("%s - %0.1fs", defuser, (defuseStarted - g_curtime()) + dLength)
		local defusePercent = (g_curtime() - defuseStarted) / dLength

		if (defuseStarted - g_curtime()) + dLength > 0 then
			draw_SetFont(Vf30)
			draw_Color(255, 255, 255, 255)
			draw_Text(20, pTH+pTH, defuseInfo)

			if defusePercent < 1 and defusePercent > 0 then
				local defuseBar = (1 - defusePercent) * screenY
				draw_Color(13, 13, 13, 70)
				draw_FilledRect(0, 0, 16, screenY)
				draw_Color(0, 0, 150, 255)
				draw_FilledRect(1, screenY-defuseBar, 15, screenY)
			end
		end
	end
end

callbacks.Register("Draw", drawBombTimers)
callbacks.Register("FireGameEvent", bombEvents)

client.AllowListener("bomb_beginplant")
client.AllowListener("bomb_abortplant")
client.AllowListener("bomb_planted")
client.AllowListener("bomb_begindefuse")
client.AllowListener("bomb_abortdefuse")
client.AllowListener("bomb_defused")
client.AllowListener("round_officially_ended")
client.AllowListener("round_prestart")
