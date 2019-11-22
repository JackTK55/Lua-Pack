-- If you want it to do it automatically remove lines with -- on them

local GetLocalPlayer, IsButtonDown = entities.GetLocalPlayer, input.IsButtonDown
local r = gui.Reference('MISC', 'AUTOMATION', 'Other')
local enabled = gui.Checkbox(r, 'fast_plant', 'Fast Plant', false)
local hotkey = gui.Keybox(r, 'fast_plant_key', 'Fast Plant Key', 0) -- Don't make it "e" or "mouse 1"

callbacks.Register('CreateMove', function(cmd)
	if not enabled:GetValue() then
		return
	end

	local key = hotkey:GetValue() --
	if key == 0 or not IsButtonDown( key ) then --
		return --
	end --

	local lp = GetLocalPlayer()
	local weapon = lp:GetPropEntity('m_hActiveWeapon')
	local weapon = weapon ~= nil and weapon:GetClass() == 'CC4'
	local in_zone = weapon and lp:GetPropInt('m_bInBombZone') == 1 

	if in_zone then 
		cmd:SetButtons( (1 << 5) )
	end 
end)
