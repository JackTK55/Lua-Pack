local LocalPlayer,PlayerIndexByUserID,LocalPlayerIndex,g_curtime,WorldToScreen,Color,OutlinedCircle,OutlinedRect,abs,Register = entities.GetLocalPlayer,client.GetPlayerIndexByUserID,client.GetLocalPlayerIndex,globals.CurTime,client.WorldToScreen,draw.Color,draw.OutlinedCircle,draw.OutlinedRect,math.abs,callbacks.Register

local ref = gui.Reference('VISUALS','MISC','Assistance')
local BulletImpacts_Local = gui.Checkbox(ref,"vis_bullet_impact_local", "Bullet Impacts Local", false)
local BulletImpacts_Type = gui.Combobox(ref,"vis_bullet_impact_type", "Bullet Impacts Type", 'Circle', 'Square')
local BulletImpacts_color_Local = gui.ColorEntry('clr_vis_bullet_impact_local','Bullet Impacts Local', 255,255,255,255)
local BulletImpacts_Time = gui.Slider(ref,'vis_bullet_impact_time','Bullet Impact Time', 4, 0, 10)
local bulletimpacts = {}

local function draw_Thing(a, b, c)
	local X, Y = WorldToScreen(a, b, c)
	local _,Y1 = WorldToScreen(a, b, c - 2.3)
	local _,Y2 = WorldToScreen(a, b, c + 2.3)

	if X == nil or Y == nil or Y1 == nil or Y2 == nil then
		return
	end

	local h = abs(Y2 - Y1) / 2

	Color(BulletImpacts_color_Local:GetValue())

	if BulletImpacts_Type:GetValue() == 0 then
		OutlinedCircle(X, Y, h)
	elseif BulletImpacts_Type:GetValue() == 1 then
		OutlinedRect(X - h, Y - h, X + h, Y + h)
	end
end

client.AllowListener('bullet_impact')
local function bulletimpact(e)
	if not BulletImpacts_Local:GetValue() or e:GetName() ~= "bullet_impact" then
		return
	end

	local x = e:GetFloat("x")
	local y = e:GetFloat("y")
	local z = e:GetFloat("z")
	local player_index = PlayerIndexByUserID(e:GetInt("userid"))

	if player_index == LocalPlayerIndex() then
		bulletimpacts[#bulletimpacts + 1] = {g_curtime(), x, y, z}
	end
end

local function showimpacts()
--	client.SetConVar('sv_showimpacts', BulletImpacts_Local:GetValue() and 2 or 0, true)
	if not BulletImpacts_Local:GetValue() or LocalPlayer() == nil then
		return
	end

	local val = BulletImpacts_Time:GetValue()

	for k, v in pairs(bulletimpacts) do
		if v[1] - g_curtime() + val > 0 then
			draw_Thing(v[2], v[3], v[4])
		else
			bulletimpacts[k] = nil
		end
	end
end

Register("Draw", showimpacts)
Register("FireGameEvent", bulletimpact)