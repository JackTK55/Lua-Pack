local SetConVar, GetMapName = client.SetConVar, engine.GetMapName
local new_modes = gui.Combobox(gui.Reference('VISUALS', 'MISC', 'World'), 'vis_holiday', 'Holiday Mode', 'None', 'Halloween', 'Christmas')
local mode

callbacks.Register('Draw', function()
	local new_mode = GetMapName() ~= nil and new_modes:GetValue() or 0

	if mode ~= new_mode then
		SetConVar('sv_holiday_mode', new_mode)
		mode = new_mode
	end
end)