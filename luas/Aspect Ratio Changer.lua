local ref = gui.Reference('Misc', 'General')
local active = gui.Checkbox(ref, 'aspect_ratio_active', 'Aspect Ratio Changer', false)
local ratio = gui.Slider(ref, 'aspect_ratio_value', 'Aspect Ratio', 100, 1, 199)
local GetScreenSize, SetConVar = draw.GetScreenSize, client.SetConVar

local last
local function main()
	if not active:GetValue() then
		if last then
			SetConVar('r_aspectratio', 0, true)
			last = nil
		end
		return
	end

	local new = 2 - (ratio:GetValue() * 0.01)
	if last ~= new then
		local w, h = GetScreenSize()
		local v = new == 1 and 0 or ( (w * new) / h )
		SetConVar('r_aspectratio', v, true)
		last = new
	end
end

callbacks.Register('Draw', main)
