local GetLocalPlayer, PlayerIndexByUserID, LocalPlayerIndex, g_curtime, table_remove, client_WorldToScreen, draw_Color, draw_RoundedRect = entities.GetLocalPlayer, client.GetPlayerIndexByUserID, client.GetLocalPlayerIndex, globals.CurTime, table.remove, client.WorldToScreen, draw.Color, draw.RoundedRect

local BulletImpacts_Local = gui.Checkbox(gui.Reference('VISUALS', 'MISC', 'Assistance'), "vis_bullet_impact_local", "Bullet Impacts Local", false)
local BulletImpacts_color_Local = gui.ColorEntry('clr_vis_bullet_impact_local', 'Bullet Impacts Local', 255,255,255,255)
local BulletImpacts_Time = gui.Slider(gui.Reference('VISUALS', 'MISC', 'Assistance'), 'vis_bullet_impact_time', 'Bullet Impact Time', 4, 0, 10)
local bulletimpacts = {}

function bulletimpact(e)
	if e:GetName() ~= "bullet_impact" or not BulletImpacts_Local:GetValue() then 
		return 
	end

	local x = e:GetFloat("x") 
	local y = e:GetFloat("y") 
	local z = e:GetFloat("z") 
	local player_index = PlayerIndexByUserID(e:GetInt("userid"))
	local bulletimpacts_n = #bulletimpacts

	if player_index == LocalPlayerIndex() then 
		bulletimpacts[bulletimpacts_n + 1] = {g_curtime(), x, y, z, BulletImpacts_color_Local:GetValue()}
	end 
end

function showimpacts() 
	client.SetConVar('sv_showimpacts', BulletImpacts_Local:GetValue() and 2 or 0, true)
	
	if GetLocalPlayer() == nil or not BulletImpacts_Local:GetValue() then 
		return 
	end 

	for k, v in pairs(bulletimpacts) do
		if g_curtime() - v[1] > BulletImpacts_Time:GetValue() then 
			bulletimpacts[k] = nil
		else
			local X, Y = client_WorldToScreen(v[2], v[3], v[4]) 
			if X ~= nil and Y ~= nil then 
				draw_Color(v[5], v[6], v[7], v[8]) 
				draw_RoundedRect(X-3, Y-3, X+3, Y+3)
			end 
		end
	end 
end

callbacks.Register("Draw", showimpacts)
callbacks.Register("FireGameEvent", bulletimpact)
client.AllowListener('bullet_impact')
