--[[
	Team Based Skins has many more options -> https://github.com/Zack2kl/Team-Based-Skins/
]]

local GetLocalPlayer, client_exec, GetValue, SetValue, LocalPlayerIndex, PlayerIndexByUserID, MENU = entities.GetLocalPlayer, client.Command, gui.GetValue, gui.SetValue, client.GetLocalPlayerIndex, client.GetPlayerIndexByUserID, gui.Reference("MENU")

local Knife_Glove_Changer = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_knifechanger", "Knife & Glove Changer", false)

local Knife_W = gui.Window("tb_knife", "Knife Changer", 200, 200, 200, 245)
local knife_G = gui.Groupbox(Knife_W, "Team Knife Changer", 16, 16)
local active = gui.Checkbox(knife_G, 'knife_active', 'Active', false)
local knife_ct = gui.Combobox(knife_G, "knife_CT", "CT Knife", 'Bayonet','Classic Knife','Flip Knife','Gut Knife','Karambit','M9 Bayonet','Huntsman Knife','Falchion Knife','Bowie Knife','Butterfly Knife','Shadow Daggers','Pancord Knife','Survival Knife','Ursus Knife','Navaja Knife','Nomad Knife','Stiletto Knife','Talon Knife','Skeleton Knife')
local knife_t = gui.Combobox(knife_G, "knife_T", "T Knife", 'Bayonet','Classic Knife','Flip Knife','Gut Knife','Karambit','M9 Bayonet','Huntsman Knife','Falchion Knife','Bowie Knife','Butterfly Knife','Shadow Daggers','Pancord Knife','Survival Knife','Ursus Knife','Navaja Knife','Nomad Knife','Stiletto Knife','Talon Knife','Skeleton Knife')

local Glove_W = gui.Window("tb_glove", "Glove Changer", 300, 200, 200, 245)
local glove_G = gui.Groupbox(Glove_W, 'Team Glove Changer', 16, 16)
local active2 = gui.Checkbox(glove_G, 'glove_active', 'Active', false)
local gloves_ct = gui.Combobox(glove_G, 'glove_CT', 'CT Gloves', 'Bloodhound Gloves', 'Sport Gloves', 'Driver Gloves', 'Hand Wraps', 'Moto Gloves', 'Specialist Gloves', 'Hydra Glove')
local gloves_t = gui.Combobox(glove_G, 'glove_T', 'T Gloves', 'Bloodhound Gloves', 'Sport Gloves', 'Driver Gloves', 'Hand Wraps', 'Moto Gloves', 'Specialist Gloves', 'Hydra Glove')

gui.Button(knife_G, 'Update', function()
	client_exec('cl_fullupdate', true)
end)
gui.Button(glove_G, 'Update', function()
	client_exec('cl_fullupdate', true)
end)

local function _set(v, v2)
	if GetValue('skin_knife') ~= v or GetValue('skin_gloves') ~= v2 then
		if active:GetValue() then
			SetValue('skin_knife', v)
		end
		if active2:GetValue() then
			SetValue('skin_gloves', v2)
		end
	end
end

callbacks.Register('Draw', function()
	local opened = Knife_Glove_Changer:GetValue() and MENU:IsActive()
	Knife_W:SetActive(opened)
	Glove_W:SetActive(opened)

	if not active:GetValue() and not active2:GetValue() then
		return
	end

	if GetLocalPlayer() == nil then
		return
	end

	if GetLocalPlayer():GetTeamNumber() == 1 then 
		return

	elseif GetLocalPlayer():GetTeamNumber() == 2 then
		_set(knife_t:GetValue(), gloves_t:GetValue())

	elseif GetLocalPlayer():GetTeamNumber() == 3 then
		_set(knife_ct:GetValue(), gloves_ct:GetValue())
	end
end)

client.AllowListener('player_spawn')
callbacks.Register("FireGameEvent", function(e)
	if not active:GetValue() or e:GetName() ~= 'player_spawn' or PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then
		return
	end

	client_exec('cl_fullupdate', true)
end)
