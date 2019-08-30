local GetLocalPlayer, gui_GetValue, gui_SetValue = entities.GetLocalPlayer, gui.GetValue, gui.SetValue

local zeusbot = gui.Checkbox(gui.Reference("LEGIT", "Extra"), "lbot_zeusbot_enable", "Zeusbot", false)
local trige, trigaf, trighc, trigm
local set_values = false

callbacks.Register("Draw", 'Uses Triggerbot to autoshoot Zeus', function()
	if not zeusbot:GetValue() or GetLocalPlayer() == nil then 
		return 
	end 

	local weapon = GetLocalPlayer():GetPropEntity("m_hActiveWeapon")
	local alive = weapon ~= nil and GetLocalPlayer():IsAlive()
	local ready = alive and weapon:GetClass() == "CWeaponTaser"

	if ready then 
		gui_SetValue("lbot_trg_enable", 1) 
		gui_SetValue("lbot_trg_autofire", 1)
		gui_SetValue("lbot_trg_hitchance", gui_GetValue("rbot_taser_hitchance"))
		gui_SetValue("lbot_trg_mode", 0) 
		set_values = true
	else
		if not set_values then
			trige, trigaf, trighc, trigm = gui_GetValue("lbot_trg_enable"), gui_GetValue("lbot_trg_autofire"), gui_GetValue("lbot_trg_hitchance"), gui_GetValue("lbot_trg_mode")
		else
			gui_SetValue("lbot_trg_enable", trige)
			gui_SetValue("lbot_trg_autofire", trigaf)
			gui_SetValue("lbot_trg_hitchance", trighc)
			gui_SetValue("lbot_trg_mode", trigm)
		end
	end 
end)