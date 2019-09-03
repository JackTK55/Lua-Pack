local lowHPIndicator = gui.Checkbox(gui.Reference('SETTINGS', 'Miscellaneous'), 'lua_lowhp_ind', "Low HP Indicator", false)
local font = draw.CreateFont("Tahoma", 13, 200)

local pos = 0
function drawLowHP()
	if not lowHPIndicator:GetValue() then
		return
	end

	local screenx, screeny = draw.GetScreenSize()
	local pos = 0
	local players = entities.FindByClass('CCSPlayer')
	for i=1, #players do
		local player = players[i]
		if player:GetTeamNumber() ~= entities.GetLocalPlayer():GetTeamNumber() then
			local playername = player:GetName()
			local HP = player:GetProp("m_iHealth")
			local location = player:GetProp('m_szLastPlaceName')

			local str = string.format("%s - %s (%i HP)", location, playername, HP)
			draw.SetFont(font)
			local tW, tH = draw.GetTextSize(playername)
			if HP < 5 and HP > 0 then
				draw.Color(255, 255, 255, 255)
				draw.Text(3, (screeny/2) + pos, str)
				pos = pos + tH
			end
		end
	end
end

callbacks.Register('Draw', drawLowHP)