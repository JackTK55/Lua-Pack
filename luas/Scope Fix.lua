local GetLocalPlayer, gui_GetValue, gui_SetValue = entities.GetLocalPlayer, gui.GetValue, gui.SetValue

local s_fovfix = gui.Checkbox(gui.Reference("VISUALS", "Shared"), "vis_fixfov", "Fix Scoped FOV", false)
local new_fov_val, new_vmfov_val, is_scoped
local set_fov = false

callbacks.Register("Draw", "Fixes Scoped FOV", function()
	if not s_fovfix:GetValue() or GetLocalPlayer() == nil then
		return
	end

	local is_scoped = GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257

	if is_scoped then
		gui_SetValue("vis_view_fov", 0)
		gui_SetValue("vis_view_model_fov", 0)
		set_fov = true
	else
		if not set_fov then
			new_fov_val, new_vmfov_val = gui_GetValue("vis_view_fov"), gui_GetValue("vis_view_model_fov")
		else
			gui_SetValue("vis_view_fov", new_fov_val)
			gui_SetValue("vis_view_model_fov", new_vmfov_val)
			set_fov = false
		end
	end
end)
