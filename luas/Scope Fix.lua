local a,b,c = entities.GetLocalPlayer,gui.GetValue,gui.SetValue
local d = gui.Checkbox(gui.Reference("VISUALS","Shared"),"vis_fixfov","Fix Scoped FOV",false)
local e, f, g, h
local i = false

local function j()
	if not d:GetValue() or a() == nil then
		return
	end

	local g = a():GetProp("m_bIsScoped")
	local h = g == 1 or g == 257

	if h then
		c("vis_view_fov", 0)
		c("vis_view_model_fov", 0)
		i = true
	else
		if not i then
			e, f = b("vis_view_fov"), b("vis_view_model_fov")
		else
			c("vis_view_fov", e)
			c("vis_view_model_fov", f)
			i = false
		end
	end
end

callbacks.Register("Draw",j)
