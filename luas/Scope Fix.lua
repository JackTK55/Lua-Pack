local a,b,c = entities.GetLocalPlayer,gui.GetValue,gui.SetValue
local d = gui.Checkbox(gui.Reference("VISUALS","Shared"),"vis_fixfov","Fix Scoped FOV",false)
local i,e

callbacks.Register("Draw",function()
	if not d:GetValue() then
		return
	end

	local lp = a()
	if lp == nil then
		return
	end

	local g = lp:GetProp("m_bIsScoped")
	local h = g == 1 or g == 257

	if h then
		c("vis_view_fov", 0)
		i = true
	else
		if not i then
			e = b("vis_view_fov")
		else
			c("vis_view_fov", e)
			i = false
		end
	end
end)
