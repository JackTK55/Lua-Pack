local GetLocalPlayer, client_exec, string_format = entities.GetLocalPlayer, client.Command, string.format

local K_O_L_H = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_knifelefthand", "Knife On Left Hand", false)

callbacks.Register("Draw", 'Knife on Left Hand', function()
	if not K_O_L_H:GetValue() or GetLocalPlayer() == nil then
		return
	end
	
	local weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
	local alive = weapon ~= nil and GetLocalPlayer():IsAlive()
	local _val = alive and weapon:GetClass() == "CKnife"
	local command = string_format('cl_righthand %i', _val and 0 or 1)

	client_exec(command, true)
end)