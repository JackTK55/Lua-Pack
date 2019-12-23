local SetConVar = client.SetConVar
local modes = gui.Combobox(gui.Reference('VISUALS', 'MISC', 'World'), 'vis_holiday', 'Holiday Mode', 'None', 'Halloween', 'Christmas')
local new_mode

callbacks.Register('CreateMove', function(_)
	local mode = modes:GetValue()

	if new_mode ~= mode then
		SetConVar('sv_holiday_mode', mode)
		new_mode = mode
	end
end)