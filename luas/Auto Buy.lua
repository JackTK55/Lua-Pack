local PlayerIndexByUserID, LocalPlayerIndex, GetLocalPlayer, table_concat, client_exec = client.GetPlayerIndexByUserID, client.GetLocalPlayerIndex, entities.GetLocalPlayer, table.concat, client.Command

local AB_Show = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_autobuy", "Auto Buy", false)
local AB_W = gui.Window("AB_W", "Auto Buy", 100, 200, 200, 306)
local AB_GB = gui.Groupbox(AB_W, "Auto Buy Settings", 16, 17)
local AB_E = gui.Checkbox(AB_GB, "AB_Active", "Active", false)
local PrimaryWeapons = gui.Combobox(AB_GB, "AB_Primary_Weapons", "Primary Weapons", '-', "AK | M4", "Scout", "SG553 | AUG", "AWP", "Auto")
local SecondaryWeapons = gui.Combobox(AB_GB, "AB_Secondary_Weapons", "Secondary Weapons", '-', "Elite", "P250", "Tec-9 | Five-Seven", "R8 | Deagle")
local AB_M = gui.Multibox(AB_GB, 'Gear')
local Kev = gui.Checkbox(AB_M, "AB_Armor_K", "Kevlar", false)
local Kev_Hel = gui.Checkbox(AB_M, "AB_Armor_KH", "Helmet", false)
local Defuser = gui.Checkbox(AB_M, "AB_Defuser", "Defuse Kit", false)
local GNade = gui.Checkbox(AB_M, "AB_GNade", "Grenade", false)
local MNade = gui.Checkbox(AB_M, "AB_MNade", "Molotov", false)
local SNade = gui.Checkbox(AB_M, "AB_SNade", "Smoke", false)
local FNade = gui.Checkbox(AB_M, "AB_FNade", "Flashbang", false)
local Zeus = gui.Checkbox(AB_M, "AB_Zeus", "Zeus", false)
local AB_buyAbove = gui.Slider(AB_GB, 'AB_buyAboveAmount', 'Buy if $ is Above (value*1000)', 3.7, 0, 16)

callbacks.Register('Draw', 'autobuy show menu', function()
	AB_W:SetActive(AB_Show:GetValue() and gui.Reference('MENU'):IsActive())
end)

local primary_weapon = {'', 'buy "ak47"; ', 'buy "ssg08"; ', 'buy "sg556"; ', 'buy "awp"; ', 'buy "scar20"; '}
local secondary_weapon = {'', 'buy "elite"; ', 'buy "p250"; ', 'buy "tec9"; ', 'buy "deagle"; '}

client.AllowListener('player_spawn')
callbacks.Register("FireGameEvent", 'Auto Buy', function(e)
	if not AB_E:GetValue() or GetLocalPlayer() == nil or e:GetName() ~= 'player_spawn' or PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then
		return
	end

	local money = GetLocalPlayer():GetProp('m_iAccount')
	local buy_items = table_concat({primary_weapon[PrimaryWeapons:GetValue() + 1] or '', secondary_weapon[SecondaryWeapons:GetValue() + 1] or '', Kev:GetValue() and 'buy "vest"; ' or '', Kev_Hel:GetValue() and 'buy "vesthelm"; ' or '', Defuser:GetValue() and 'buy "defuser"; ' or '', GNade:GetValue() and 'buy "hegrenade"; ' or '', MNade:GetValue() and 'buy "molotov"; buy "incgrenade"; ' or '', SNade:GetValue() and 'buy "smokegrenade"; ' or '', FNade:GetValue() and 'buy "flashbang"; ' or '', Zeus:GetValue() and 'buy "taser"; ' or ''}, '')

	if money >= AB_buyAbove:GetValue()*1000 or money < 1 then
		client_exec(buy_items, true)
	end
end)