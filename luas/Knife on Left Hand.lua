local GetLocalPlayer, client_exec = entities.GetLocalPlayer, client.Command

local K_O_L_H = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_knifelefthand", "Knife On Left Hand", false)

callbacks.Register("Draw", 'Knife on Left Hand', function()
	if not K_O_L_H:GetValue() or GetLocalPlayer() == nil then
		return
	end

	if not GetLocalPlayer():IsAlive() then
		client_exec("cl_righthand 1", true)
	end

	local wep = GetLocalPlayer():GetPropEntity("m_hActiveWeapon")

	if wep == nil then
		return
	end

	local cwep = wep:GetClass()

	if cwep == "CKnife" then
		client_exec("cl_righthand 0", true)
	else
		client_exec("cl_righthand 1", true)
	end
end)