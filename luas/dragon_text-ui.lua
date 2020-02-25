--[[
	Name: Text-UI
	Created by: Dragon
	Edited by: zack
--]]

local user_name = 'Zack' -- Change this to your name

local Color, TextShadow, SetFont, GetValue, type = draw.Color, draw.TextShadow, draw.SetFont, gui.GetValue, type
local font = draw.CreateFont('Consolas', 15)

local left_side = {
	{'lbot_enable', 'LegitBot'},
	{'lbot_trg_enable', 'TriggerBot'},
	{'esp_enemy_box', 'Box ESP'},
	{'esp_enemy_box_outline', 'Box Outline'},
	{'esp_enemy_box_precise', 'Box Precision'},
	{'esp_enemy_health', 'Health ESP'},
	{'esp_enemy_armor', 'Armor ESP'},
	{'esp_enemy_weapon', 'Weapon ESP'},
	{'esp_enemy_ammo', 'Ammo ESP'},
	{'esp_enemy_skeleton', 'Skeleton ESP'},
	{'esp_enemy_hitbox', 'Hitbox ESP'},
	{'esp_enemy_chams', 'Chams'},
	{'esp_enemy_xqz', 'Chams XQZ'},
	{'esp_enemy_glow', 'Glow'},
	{'esp_enemy_headspot', 'Headspot'},
	{'esp_enemy_barrel', 'Barrel'},
	{'vis_historyticks', 'History Ticks'},
	{'esp_weaponstyle', 'Weapon Style'},
	{'vis_antiobs', 'Anti-OBS'},
	{'vis_preservekillfeed', 'Preserve Killfeed'},
	{'esp_outofview', 'Out of View Indicators'}
}

local top_right_side = {
	{'msc_autojump', 'Auto Jump'},
	{'msc_autostrafer_mode', 'Auto Strafe'},
	{'msc_knifebot', 'KnifeBot'},
	{'msc_logevents', 'Log Events'},
	{'msc_fakelag_mode', 'Fakelag'},
	{'msc_fakelatency_enable', 'Fakelatency'},
	{'msc_hitmarker_enable', 'Hitmarker'},
	{'msc_clantag', 'Clantag'}
}

local right_side = {
	{'rbot_enable', 'RageBot'},
	{'rbot_speedlimit', 'Speed Limit'},
	{'rbot_silentaim', 'Silent Aim'},
	{'rbot_resolver', 'Resolver'},
	{'rbot_positionadjustment', 'Backtrack'},
	{'rbot_delayshot', 'Delay Shot'},
	{'rbot_doublefire', 'DoubleTap'},
	{'rbot_antiaim_stand_pitch_real', 'Anti-Aim Pitch'},
	{'rbot_antiaim_stand_real', 'Anti-Aim Yaw'},
	{'rbot_antiaim_stand_desync', 'Desync'},
	{'rbot_antiaim_at_targets', 'At Targets'},
	{'rbot_antiaim_autodir', 'Auto Direction'}
}

local var_to_mode = {
	esp_enemy_box = {'Off', '2D', '3D', 'Edges', 'Machine', 'Pentagon', 'Hexagon'},
	esp_enemy_health = {'Off', 'Bar', 'Number', 'Both'},
	esp_enemy_weapon = {'Off', 'Show Active', 'Show All'},
	esp_enemy_ammo = {'Off', 'Number', 'Bar'},
	esp_enemy_hitbox = {'Off', 'White', 'Color'},
	esp_enemy_chams = {'Off', 'Color', 'Material', 'Color Wireframe', 'Mat Wireframe', 'Invisible', 'Metallic', 'Flat'},
	esp_enemy_glow = {'Off', 'Team Color', 'Health Color'},
	vis_historyticks = {'Off', 'All Ticks', 'Last Tick', 'First Tick'},
	esp_weaponstyle = {'Icons', 'Names'},

	msc_autojump = {'Off', 'Perfect', 'Legit'},
	msc_autostrafer_mode = {'Silent', 'Normal', 'Sideways', 'W-Only', 'Mouse'},
	msc_knifebot = {'Off', 'On', 'Backstab Only', 'Trigger', 'Quick'},
	msc_fakelag_mode = {'Factor', 'Switch', 'Adaptive', 'Random', 'Peek', 'Rapid Peek'},

	rbot_speedlimit = {'Off', 'On', 'Auto'},
	rbot_silentaim = {'Off', 'Client-Side', 'Server-Side'},
	rbot_positionadjustment = {'Off', 'Low', 'Medium', 'High', 'Very High', 'Adaptive', 'Last Record'},
	rbot_delayshot = {'Off', 'Accurate Unlag', 'Accurate History'},
	rbot_antiaim_stand_pitch_real = {'Off', 'Emotion', 'Down', 'Up', 'Zero', 'Mixed', 'Custom', 'Shift'},
	rbot_antiaim_stand_real = {'Off', 'Static', 'Spinbot', 'Jitter', 'Zero', 'Switch', 'Shift'},
	rbot_antiaim_stand_desync = {'Off', 'Still', 'Balance', 'Stretch', 'Jitter'},
	rbot_antiaim_at_targets = {'Off', 'Average', 'Closest'},
	rbot_antiaim_autodir = {'Off', 'Default', 'Desync', 'Desync Jitter'}
}

local function welcome()
	Color(252, 211, 3)
	TextShadow(320, 64, 'Hello, '..user_name..'!')
end

local function main()
	SetFont(font)
	welcome()
	Color(255, 255, 255)

	for i=1, #left_side do
		local typ = left_side[i]
		local var = typ[1]
		local str = type( GetValue(var) ) == 'boolean' and ( GetValue(var) and 'On' or 'Off' ) or var_to_mode[var][GetValue(var) + 1]

		TextShadow(320, 81 + (i * 15), typ[2]..': '.. str)
	end

	local autostrafer = GetValue('msc_autostrafer_enable')
	local fakelag = GetValue('msc_fakelag_enable')

	for i=1, #top_right_side do
		local typ = top_right_side[i]
		local var = typ[1]
		local str = type( GetValue(var) ) == 'boolean' and ( GetValue(var) and 'On' or 'Off' ) or var_to_mode[var][GetValue(var) + 1]

		if var == 'msc_autostrafer_mode' then
			str = autostrafer and str or 'Off'
		elseif var == 'msc_fakelag_mode' then
			str = fakelag and str or 'Off'
		end

		TextShadow(550, 81 + (i * 15), typ[2]..': '.. str)
	end

	local rbot_aa_enabled = GetValue('rbot_antiaim_enable')

	for i=1, #right_side do
		local typ = right_side[i]
		local var = typ[1]
		local str = type( GetValue(var) ) == 'boolean' and ( GetValue(var) and 'On' or 'Off' ) or var_to_mode[var][GetValue(var) + 1]

		if var == 'rbot_antiaim_stand_pitch_real' or var == 'rbot_antiaim_stand_real' or var == 'rbot_antiaim_stand_desync' or var == 'rbot_antiaim_at_targets' or var == 'rbot_antiaim_autodir' then
			str = rbot_aa_enabled and str or 'Off'
		end

		TextShadow(550, 216 + (i * 15), typ[2]..': '.. str)
	end
end

callbacks.Register('Draw', main)
