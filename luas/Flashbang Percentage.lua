local GetLocalPlayer, LocalPlayerIndex, draw_GetScreenSize, g_curtime, draw_SetFont, draw_GetTextSize, draw_Text, draw_Color, string_format, GetPlayerIndexByUserID = entities.GetLocalPlayer, client.GetLocalPlayerIndex, draw.GetScreenSize, globals.CurTime, draw.SetFont, draw.GetTextSize, draw.Text, draw.Color, string.format, client.GetPlayerIndexByUserID

local Flash_percentage = gui.Checkbox(gui.Reference('VISUALS', 'Shared'), 'vis_flash_percentage', 'Flashbang Percentage', false)
local Font = draw.CreateFont("Tahoma", 15)
local flashed = {}

client.AllowListener('player_blind')
callbacks.Register('FireGameEvent', function(e)
	if not Flash_percentage:GetValue() or e:GetName() ~= 'player_blind' then 
		return 
	end

	local index = GetPlayerIndexByUserID(e:GetInt('userid'))
	if index == LocalPlayerIndex() then
		flashed[0] = {e:GetFloat('blind_duration'), g_curtime()}
	end
end)

callbacks.Register('Draw', 'Hides Flashbangs and shows a percentage of how much time is left', function()
	if GetLocalPlayer() == nil then 
		return
	end

	GetLocalPlayer():SetProp('m_flFlashMaxAlpha', Flash_percentage:GetValue() and 0 or 255)

	if not Flash_percentage:GetValue() or flashed[0] == nil then 
		return 
	end

	local X, Y = draw_GetScreenSize()

	local dur_left = (flashed[0][2] - g_curtime()) + flashed[0][1]
	local percent = (dur_left / flashed[0][1]) * 100
	if dur_left > 0.0 then
		draw_SetFont(Font)
		local str = string_format('%0.0f', percent)
		local tW, tH = draw_GetTextSize(str)
		draw_Color(255,255,255,255)
		draw_Text(X/2 - (tW/2), Y/2 - (tH/2) - 100, str..'%')
	else
		flashed[0] = nil
	end
end)