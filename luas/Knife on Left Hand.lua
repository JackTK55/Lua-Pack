local a,b,c = entities.GetLocalPlayer,client.Command,string.format

local d = gui.Checkbox(gui.Reference("MISC","GENERAL","Main"),"msc_knifelefthand","Knife On Left Hand",false)

local function i()
	if not d:GetValue() or a() == nil then
		return
	end

	local e = a():GetPropEntity("m_hActiveWeapon")
	local f = e ~= nil and a():IsAlive()
	local g = f and e:GetClass() == "CKnife"
	local h = c('cl_righthand %i',g and 0 or 1)

	b(h, true)
end

callbacks.Register("Draw",i)
