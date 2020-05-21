local GetLocalPlayer, IsButtonDown = entities.GetLocalPlayer, input.IsButtonDown
local r = gui.Reference('Misc', 'Movement', 'Other')
local enabled = gui.Checkbox(r, 'fast_plant', 'Fast Plant', false)
local hotkey = gui.Keybox(r, 'fast_plant_key', 'Fast Plant Key', 0)
hotkey:SetDescription("Don't use \"E\" or \"Mouse1\"")

local in_use = bit.lshift(1, 5)
callbacks.Register('CreateMove', function(cmd)
	if not enabled:GetValue() then
		return
	end

	local key = hotkey:GetValue()
	if key == 0 or not IsButtonDown( key ) then
		return
	end

	local lp = GetLocalPlayer()
	local weapon = lp:GetPropEntity('m_hActiveWeapon')
	local weapon = weapon ~= nil and weapon:GetClass() == 'CC4'
	local in_zone = weapon and lp:GetPropInt('m_bInBombZone') == 1
	local flag = lp:GetProp('m_fFlags')
	local in_air = flag == 256 or flag == 262

	if in_zone and not in_air then 
		cmd:SetButtons( in_use )
	end 
end)
