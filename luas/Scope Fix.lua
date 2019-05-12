local gui_GetValue, gui_SetValue, GetLocalPlayer = gui.GetValue, gui.SetValue, entities.GetLocalPlayer

local s_fovfix = gui.Checkbox(gui.Reference("VISUALS", "Shared"), "vis_fixfov", "Fix Scoped FOV", false)
local fov_cache, vm_fov_cache = gui_GetValue("vis_view_fov"), gui_GetValue("vis_view_model_fov")

function scopefov()
	if not s_fovfix:GetValue() or GetLocalPlayer() == nil then 
		return 
	end

	local view_fov = gui_GetValue("vis_view_fov") 
	local view_model_fov = gui_GetValue("vis_view_model_fov")

	if view_fov ~= 0 then 
		fov_cache = gui_GetValue("vis_view_fov") 
	end

	if view_model_fov ~= 0 then 
		vm_fov_cache = gui_GetValue("vis_view_model_fov") 
	end
	
	if GetLocalPlayer():GetProp("m_bIsScoped") == 1 or GetLocalPlayer():GetProp("m_bIsScoped") == 257 then 
		gui_SetValue("vis_view_fov", 0) 
		gui_SetValue("vis_view_model_fov", 0)

	elseif view_fov == 0 then 
		gui_SetValue("vis_view_fov", fov_cache) 
		gui_SetValue("vis_view_model_fov", vm_fov_cache) 
	end 
end

callbacks.Register("Draw", "fixes scoped fov", scopefov)