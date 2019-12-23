local SetConVar = client.SetConVar
local new_modes = gui.Combobox(gui.Reference('VISUALS', 'MISC', 'World'), 'vis_holiday', 'Holiday Mode', 'None', 'Halloween', 'Christmas')
local mode

callbacks.Register('CreateMove', function(_)
	local new_mode = new_modes:GetValue()

	if mode ~= new_mode then
		SetConVar('sv_holiday_mode', new_mode)
		mode = new_mode
	end
end)