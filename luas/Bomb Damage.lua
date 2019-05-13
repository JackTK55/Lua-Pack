local entities_FindByClass, g_curtime, GetLocalPlayer, string_format, draw_SetFont, draw_Color, draw_Text, math_sqrt, math_exp, math_ceil = entities.FindByClass, globals.CurTime, entities.GetLocalPlayer, string.format, draw.SetFont, draw.Color, draw.Text, math.sqrt, math.exp, math.ceil

local Bomb_Damage = gui.Checkbox(gui.Reference("VISUALS", "OTHER", "Options"), "esp_other_bombdamage", "Bomb Damage", false)

local Vf30 = draw.CreateFont("Verdana", 30)

function BombDamageIndicator()
	if not Bomb_Damage:GetValue() or entities_FindByClass("CPlantedC4")[1] == nil then
		return
	end

	local Bomb = entities_FindByClass("CPlantedC4")[1]

	if Bomb:GetPropBool("m_bBombTicking") and g_curtime() - 1 < Bomb:GetPropFloat("m_flC4Blow") and not Bomb:GetPropBool("m_bBombDefused") then
		local bDamage = DamagefromBomb(Bomb, GetLocalPlayer())
		local bDmgInfo = string_format("-%i", bDamage)

		if bDamage >= GetLocalPlayer():GetHealth() then
			draw_SetFont(Vf30)
			draw_Color(255, 0, 0, 255)
			draw_Text(20, 30, "FATAL")
		elseif bDamage < GetLocalPlayer():GetHealth() and bDamage - 1 > 0 then
			draw_SetFont(Vf30)
			draw_Color(255,255,255,255)
			draw_Text(20, 30, bDmgInfo)
		end
	end
end

function DamagefromBomb(Bomb, Player)
	if not Bomb_Damage:GetValue() then
		return
	end

	local Bxyz = {Bomb:GetAbsOrigin()}
	local Pxyz = {Player:GetAbsOrigin()}
	local ArmorValue = Player:GetPropInt("m_ArmorValue")
	local C4Distance = math_sqrt((Bxyz[1] - Pxyz[1]) ^2 + (Bxyz[2] - Pxyz[2]) ^2 + (Bxyz[3] - Pxyz[3]) ^2)
	local d = ((C4Distance-75.68) / 789.2)
	local f1Damage = 450.7*math_exp(-d * d)

	if ArmorValue > 0 then
		local f1New = f1Damage * 0.5
		local f1Armor = (f1Damage - f1New) * 0.5

		if f1Armor > ArmorValue then
			f1Armor = ArmorValue * 2
			New = f1Damage - f1Armor
		end

		f1Damage = f1New
	end

	return math_ceil(f1Damage + 0.5)
end

callbacks.Register("Draw", BombDamageIndicator)