local GetLocalPlayer,draw_GetScreenSize,string_format,draw_SetFont,draw_GetTextSize,draw_Color,draw_Text,entities_FindByClass,pos=entities.GetLocalPlayer,draw.GetScreenSize,string.format,draw.SetFont,draw.GetTextSize,draw.Color,draw.Text,entities.FindByClass,0
local lowHPIndicator = gui.Checkbox(gui.Reference('SETTINGS','Miscellaneous'), 'lua_lowhp_ind', "Low HP Indicator", false)
local font = draw.CreateFont('Tahoma', 12)
local hp_max = 5

local function drawLowHP()
	if not lowHPIndicator:GetValue() then
		return
	end

	local _,y = draw_GetScreenSize()
	local y_half, pos = y/2, 0
	local players = entities_FindByClass('CCSPlayer')

	for i=1, #players do
		local player = players[i]
		local is_enemy = player:GetTeamNumber() ~= GetLocalPlayer():GetTeamNumber()

		if is_enemy and player:IsAlive() then
			local playername, hp, location = player:GetName(), player:GetPropInt('m_iHealth'), player:GetPropString('m_szLastPlaceName')

			if location == 'unknown' then
				location = 'Nearby'
			end

			local str = string_format('%s - %s (%i HP)', location, playername, hp)
			local low = hp <= hp_max

			draw_SetFont(font)
			local _,tH = draw_GetTextSize(str)

			if low then
				draw_Color(255, 255, 255, 255)
				draw_Text(3, y_half + pos, str)
				pos = pos + tH
			end
		end
	end
end

callbacks.Register('Draw', drawLowHP)
