local GetLocalPlayer, draw_GetScreenSize, g_curtime, draw_SetFont, draw_GetTextSize, draw_Text, draw_Color, string_format = entities.GetLocalPlayer, draw.GetScreenSize, globals.CurTime, draw.SetFont, draw.GetTextSize, draw.Text, draw.Color, string.format

local Flash_percentage = gui.Checkbox(gui.Reference('VISUALS', 'Shared'), 'vis_flash_percentage', 'Flashbang Percentage', false)
local Font = draw.CreateFont("Tahoma", 15)
local flashed_at = 0

callbacks.Register('Draw', 'Hides Flashbangs and shows a percentage of how much time is left', function()
	GetLocalPlayer():SetProp('m_flFlashMaxAlpha', Flash_percentage:GetValue() and 0 or 255)
	
	if GetLocalPlayer() == nil or not Flash_percentage:GetValue() then 
		return 
	end

	local X, Y = draw_GetScreenSize()
	local flashDuration = GetLocalPlayer():GetProp('m_flFlashDuration')

	if flashDuration == 0.0 then
		flashed_at = g_curtime()
	end

	local duration_left = (flashed_at - g_curtime()) + flashDuration
	local percent = (duration_left / flashDuration) * 100
	local str = string_format('%0.0f', percent)

	if duration_left > 0 then
		draw_SetFont(Font)
		local tW, tH = draw_GetTextSize(str)
		draw_Color(255,255,255,255)
		draw_Text(X/2 - (tW/2), Y/2 - (tH/2) - 100, str..'%')
	end
end)