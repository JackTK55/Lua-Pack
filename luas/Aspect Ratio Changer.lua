local SS,S,s,r,ref=draw.GetScreenSize,client.SetConVar,false,'r_aspectratio',gui.Reference('MISC','GENERAL','Main')

local enabled = gui.Checkbox(ref,'lua_aspect_ratio_changer_enable','Aspect Ratio Changer',false)
local ratio = gui.Slider(ref,'lua_aspect_ratio_changer_value','Force aspect ratio',100, 1, 199)

local function on_aspect_ratio_changed()
	if enabled:GetValue() then
		local w, h = SS()
		local a = 2 - (ratio:GetValue() * 0.01)
		local ar = (w * a) / h
		local v = a == 1 and 0 or ar
		S(r,v,true)
		s = true
	else
		if s then
			S(r,0,true)
			s = false
		end
	end
end

callbacks.Register('Draw', on_aspect_ratio_changed)