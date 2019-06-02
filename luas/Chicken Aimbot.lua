local ui_get, get_classname, get_player_weapon, get_local_player, is_alive, get_all, set_visible, eye_position, get_prop, set_prop, camera_angles, trace_line, math_sqrt, math_atan2, math_pi, table_insert = ui.get, entity.get_classname, entity.get_player_weapon, entity.get_local_player, entity.is_alive, entity.get_all, ui.set_visible, client.eye_position, entity.get_prop, entity.set_prop, client.camera_angles, client.trace_line, math.sqrt, math.atan2, math.pi, table.insert
local aimbotEnabled, aimbotActive = ui.reference("RAGE", "Aimbot", "Enabled")
local antirecoil = ui.reference("RAGE", "Other", "Remove recoil")
local automaticweapons = ui.reference("MISC", "Miscellaneous", "Automatic weapons")
local chicken_aimbot = ui.new_checkbox("RAGE", "Other", "Chicken Aimbot")
local silent_aim = ui.new_checkbox("RAGE", "Other", "Chicken Silent aim")
local autofire = ui.new_checkbox("RAGE", "Other", "Chicken Auto fire")
local autostop = ui.new_checkbox("RAGE", "Other", "Chicken Auto stop")
local autocrouch = ui.new_checkbox("RAGE", "Other", "Chicken Auto crouch")
local target = ui.new_combobox("RAGE", "Other", "Chicken Target", "All", "Owned", "Not Owned")
local chickenGLOW = ui.new_checkbox("RAGE", "Other", "Chicken Glow ESP")
local auto, stop, attack = false, true, false

local function hide_on_load()
	set_visible(silent_aim, false)
	set_visible(autofire, false)
	set_visible(autostop, false)
	set_visible(autocrouch, false)
	set_visible(target, false)
	set_visible(chickenGLOW, false)
end
hide_on_load()

ui.set_callback(chicken_aimbot, function()
	local aimbot_enabled = ui_get(chicken_aimbot)
	set_visible(silent_aim, aimbot_enabled)
	set_visible(autofire, aimbot_enabled)
	set_visible(autostop, aimbot_enabled)
	set_visible(autocrouch, aimbot_enabled)
	set_visible(target, aimbot_enabled)
	set_visible(chickenGLOW, aimbot_enabled)
end)

local function calculateAngles(x1, y1, z1, x2, y2, z2)
	x_delta = x1 - x2
	y_delta = y1 - y2
	z_delta = z1 - z2

    hyp = math_sqrt((x_delta^2) + (y_delta^2))
	angle_x = (math_atan2(z_delta, hyp)) * (180 / math_pi)
	angle_y = (math_atan2(y_delta , x_delta)) * (180 / math_pi)
	angle_y = angle_y - 180

    return angle_x, angle_y
end

client.set_event_callback("setup_command", function(cmd)
	if not ui_get(chicken_aimbot) or not ui_get(aimbotEnabled) or not ui_get(aimbotActive) then 
		return 
	end 

	local local_player = get_local_player()
	if local_player == nil or not is_alive(local_player) then 
		return 
	end

	local chickens = get_all("CChicken")
	if chickens == nil then 
		return 
	end
	
	local weapon = get_classname(get_player_weapon(local_player))
	if weapon == "CWeaponAWP" or weapon == "CWeaponSSG08" or weapon == "CWeaponTaser" then 
		return 
	end
	
	local lp_eyepos_x, lp_eyepos_y, lp_eyepos_z = eye_position()
	local recoil, spread = get_prop(local_player, "m_aimPunchAngle")
	local flag = get_prop(local_player, "m_fFlags")
	local ammo = get_prop(get_player_weapon(local_player), "m_iClip1") > 0
	local in_air = flag == 256

	for i = 1, #chickens do
        local chicken = chickens[i]
        local chicken_x, chicken_y, chicken_z = get_prop(chicken, "m_vecOrigin")
        local chicken_leader = get_prop(chicken, "m_leader")
		local chicken_z = chicken_z + 8.45
		local x, y = calculateAngles(lp_eyepos_x, lp_eyepos_y, lp_eyepos_z, chicken_x, chicken_y, chicken_z)
		local distance = math_sqrt( (lp_eyepos_x-chicken_x)^2 + (lp_eyepos_y-chicken_y)^2 + (lp_eyepos_z-chicken_z)^2 ) < 2569
		local f, e = trace_line(local_player, lp_eyepos_x, lp_eyepos_y, lp_eyepos_z, chicken_x, chicken_y, chicken_z)
		local aimed_at_chicken = e == chicken
		local chicken_is_visible = f > 0.9
		
		if ui.get(chickenGLOW) then
			set_prop(chicken, "m_bShouldGlow", 1)
			set_prop(chicken, "m_nGlowStyle", 1)
			set_prop(chicken, "m_flGlowMaxDist", math.huge)
		else
			set_prop(chicken, "m_bShouldGlow", 0)
		end
		
		if ui_get(antirecoil) then
			x = x
			y = y
		else
			x = x - (recoil*2)
			y = y - (spread*2)
		end

		if (ui_get(target) == "All" and chicken_leader == nil) or (ui_get(target) == "Owned" and chicken_leader == -1) or (ui_get(target) == "Not Owned" and chicken_leader > 0) or in_air or not ammo or not distance then
			stop = true
		else
			stop = false
		end

		if chicken_is_visible and aimed_at_chicken and not stop then
			if ui_get(silent_aim) then
				cmd.pitch = x
				cmd.yaw = y
			else
				camera_angles(x, y)
			end
			attack = true
		end
	end

	if attack then
		if not ui.get(automaticweapons) and not auto then
			ui.set(automaticweapons, true)
			auto = true
		end
		if ui_get(autostop) then
			cmd.forwardmove = 0.0
			cmd.sidemove = 0.0
		end
		if ui_get(autocrouch) then
			cmd.in_duck = 1
		end
		if ui_get(autofire) then
			cmd.in_attack = 1
		end

		attack = false
	else
		if ui.get(automaticweapons) and auto then
			ui.set(automaticweapons, false)
			auto = false
		end
	end 
end)