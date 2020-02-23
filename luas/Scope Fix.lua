local GetLocalPlayer, GetValue, SetValue = entities.GetLocalPlayer, gui.GetValue, gui.SetValue
local enable = gui.Checkbox(gui.Reference('VISUALS', 'Shared'), 'vis_fixfov', 'Fix Scoped FOV', false)
local fov, set = {}

callbacks.Register('Draw', 'Fov fix', function()
	if not enable:GetValue() then
		return
	end

	local local_player = GetLocalPlayer()
	local is_scoped = local_player and local_player:GetProp("m_bIsScoped")
	local scoped = is_scoped == 1 or is_scoped == 257

	if scoped then
		SetValue('vis_view_fov', 0)
		SetValue('vis_view_model_fov', 0)
		set = true
	else
		if not set then
			fov = {GetValue('vis_view_fov'), GetValue('vis_view_model_fov')}
		else
			SetValue('vis_view_fov', fov[1])
			SetValue('vis_view_model_fov', fov[2])
			set = false
		end
	end
end)
