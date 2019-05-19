local PlayerIndexByUserID, LocalPlayerIndex, GetLocalPlayer, table_concat, client_exec = client.GetPlayerIndexByUserID, client.GetLocalPlayerIndex, entities.GetLocalPlayer, table.concat, client.Command

local AB_Show = gui.Checkbox(gui.Reference("MISC", "GENERAL", "Main"), "msc_autobuy", "Auto Buy", false)
local AB_W = gui.Window("AB_W", "Auto Buy", 100, 200, 200, 258)
local AB_GB = gui.Groupbox(AB_W, "Auto Buy Settings", 16, 17)
local AB_E = gui.Checkbox(AB_GB, "AB_Active", "Active", false)
local PrimaryWeapons = gui.Combobox(AB_GB, "AB_Primary_Weapons", "Primary Weapons", "-", "AK | M4", "Scout", "SG553 | AUG", "AWP", "Auto")
local SecondaryWeapons = gui.Combobox(AB_GB, "AB_Secondary_Weapons", "Secondary Weapons", "-", "Elite", "P250", "Tec-9 | Five-Seven", "R8 | Deagle")
local AB_M = gui.Multibox(AB_GB, 'Gear')
local Kev = gui.Checkbox(AB_M, "AB_Armor_K", "Kevlar", false)
local Kev_Hel = gui.Checkbox(AB_M, "AB_Armor_KH", "Helmet", false)
local Defuser = gui.Checkbox(AB_M, "AB_Defuser", "Defuse Kit", false)
local GNade = gui.Checkbox(AB_M, "AB_GNade", "Grenade", false)
local MNade = gui.Checkbox(AB_M, "AB_MNade", "Molotov", false)
local SNade = gui.Checkbox(AB_M, "AB_SNade", "Smoke", false)
local FNade = gui.Checkbox(AB_M, "AB_FNade", "Flashbang", false)
local Zeus = gui.Checkbox(AB_M, "AB_Zeus", "Zeus", false)

callbacks.Register('Draw', 'autobuy show menu', function()
	if AB_Show:GetValue() then
		AB_W:SetActive(gui.Reference('MENU'):IsActive())
	else
		AB_W:SetActive(0)
	end
end)

function auto_buy(e)
	if not AB_E:GetValue() or e:GetName() ~= 'player_spawn' or PlayerIndexByUserID(e:GetInt("userid")) ~= LocalPlayerIndex() then
		return
	end

	money = GetLocalPlayer():GetProp('m_iAccount') 
	if money >= 3000 or money < 1 then 
		PWb = true 
	end

	if (SecondaryWeapons:GetValue() == 0) then 
		SecondaryWeapon = ""
	elseif (SecondaryWeapons:GetValue() == 1) then 
		SecondaryWeapon = 'buy "elite"; '
	elseif (SecondaryWeapons:GetValue() == 2) then 
		SecondaryWeapon = 'buy "p250"; '
	elseif (SecondaryWeapons:GetValue() == 3) then 
		SecondaryWeapon = 'buy "tec9"; '
	elseif (SecondaryWeapons:GetValue() == 4) then 
		SecondaryWeapon = 'buy "deagle"; ' 
	end

	if PWb then 
		if (PrimaryWeapons:GetValue() == 0) then 
			PrimaryWeapon = ""
			
		elseif (PrimaryWeapons:GetValue() == 1) then 
			PrimaryWeapon = 'buy "ak47"; '
			
		elseif (PrimaryWeapons:GetValue() == 2) then 
			PrimaryWeapon = 'buy "ssg08"; '
			
		elseif (PrimaryWeapons:GetValue() == 3) then 
			PrimaryWeapon = 'buy "sg556"; '
			
		elseif (PrimaryWeapons:GetValue() == 4) then 
			PrimaryWeapon = 'buy "awp"; '
			
		elseif (PrimaryWeapons:GetValue() == 5) then 
			PrimaryWeapon = 'buy "scar20"; ' 
		end 
		
		local buy_items = table_concat({SecondaryWeapon or '', PrimaryWeapon or '', Kev:GetValue() and 'buy "vest"; ' or '', Kev_Hel:GetValue() and 'buy "vesthelm"; ' or '', Defuser:GetValue() and 'buy "defuser"; ' or '', GNade:GetValue() and 'buy "hegrenade"; ' or '', MNade:GetValue() and 'buy "molotov"; buy "incgrenade"; ' or '', SNade:GetValue() and 'buy "smokegrenade"; ' or '', FNade:GetValue() and 'buy "flashbang"; ' or '', Zeus:GetValue() and 'buy "taser"; ' or ''}, '')
		PWb = false 
		client_exec(buy_items, true) 
	end
end

callbacks.Register("FireGameEvent", auto_buy)
client.AllowListener('player_spawn')