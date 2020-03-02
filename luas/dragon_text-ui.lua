--[[
	Name: Text-UI
	Created by: Dragon
	Edited by: zack
--]]

local user_name = 'Zack' -- Change this to your name

local Color, TextShadow, SetFont, GetValue, type = draw.Color, draw.TextShadow, draw.SetFont, gui.GetValue, type
local font = draw.CreateFont('Consolas', 15)

local left_side = {
	{'lbot.enable', 'LegitBot'},
	{'lbot.trg.enable', 'TriggerBot'},
	{'esp.enemy.box', 'Box ESP'},
	{'esp.enemy.box.outline', 'Box Outline'},
	{'esp.enemy.box.precise', 'Box Precision'},
	{'esp.enemy.health', 'Health ESP'},
	{'esp.enemy.armor', 'Armor ESP'},
	{'esp.enemy.weapon', 'Weapon ESP'},
	{'esp.enemy.ammo', 'Ammo ESP'},
	{'esp.enemy.skeleton', 'Skeleton ESP'},
	{'esp.enemy.hitbox', 'Hitbox ESP'},
	{'esp.enemy.chams', 'Chams'},
	{'esp.enemy.xqz', 'Chams XQZ'},
	{'esp.enemy.glow', 'Glow'},
	{'esp.enemy.headspot', 'Headspot'},
	{'esp.enemy.barrel', 'Barrel'},
	{'vis.historyticks', 'History Ticks'},
	{'esp.weaponstyle', 'Weapon Style'},
	{'vis.antiobs', 'Anti-OBS'},
	{'vis.preservekillfeed', 'Preserve Killfeed'},
	{'esp.outofview', 'Out of View Indicators'}
}

local top_right_side = {
	{'msc.autojump', 'Auto Jump'},
	{'msc.autostrafer.mode', 'Auto Strafe'},
	{'msc.knifebot', 'KnifeBot'},
	{'msc.logevents', 'Log Events'},
	{'msc.fakelag.mode', 'Fakelag'},
	{'msc.fakelatency.enable', 'Fakelatency'},
	{'msc.hitmarker.enable', 'Hitmarker'},
	{'msc.clantag', 'Clantag'}
}

local right_side = {
	{'rbot.enable', 'RageBot'},
	{'rbot.speedlimit', 'Speed Limit'},
	{'rbot.silentaim', 'Silent Aim'},
	{'rbot.resolver', 'Resolver'},
	{'rbot.positionadjustment', 'Backtrack'},
	{'rbot.delayshot', 'Delay Shot'},
	{'rbot.doublefire', 'DoubleTap'},
	{'rbot.antiaim.stand.pitch.real', 'Anti-Aim Pitch'},
	{'rbot.antiaim.stand.real', 'Anti-Aim Yaw'},
	{'rbot.antiaim.stand.desync', 'Desync'},
	{'rbot.antiaim.at.targets', 'At Targets'},
	{'rbot.antiaim.autodir', 'Auto Direction'}
}

local var_to_mode = {
	['esp.enemy.box'] = {'Off', '2D', '3D', 'Edges', 'Machine', 'Pentagon', 'Hexagon'},
	['esp.enemy.health'] = {'Off', 'Bar', 'Number', 'Both'},
	['esp.enemy.weapon'] = {'Off', 'Show Active', 'Show All'},
	['esp.enemy.ammo'] = {'Off', 'Number', 'Bar'},
	['esp.enemy.hitbox'] = {'Off', 'White', 'Color'},
	['esp.enemy.chams'] = {'Off', 'Color', 'Material', 'Color Wireframe', 'Mat Wireframe', 'Invisible', 'Metallic', 'Flat'},
	['esp.enemy.glow'] = {'Off', 'Team Color', 'Health Color'},
	['vis.historyticks'] = {'Off', 'All Ticks', 'Last Tick', 'First Tick'},
	['esp.weaponstyle'] = {'Icons', 'Names'},

	['msc.autojump'] = {'Off', 'Perfect', 'Legit'},
	['msc.autostrafer.mode'] = {'Silent', 'Normal', 'Sideways', 'W-Only', 'Mouse'},
	['msc.knifebot'] = {'Off', 'On', 'Backstab Only', 'Trigger', 'Quick'},
	['msc.fakelag.mode'] = {'Factor', 'Switch', 'Adaptive', 'Random', 'Peek', 'Rapid Peek'},

	['rbot.speedlimit'] = {'Off', 'On', 'Auto'},
	['rbot.silentaim'] = {'Off', 'Client-Side', 'Server-Side'},
	['rbot.positionadjustment'] = {'Off', 'Low', 'Medium', 'High', 'Very High', 'Adaptive', 'Last Record'},
	['rbot.delayshot'] = {'Off', 'Accurate Unlag', 'Accurate History'},
	['rbot.antiaim.stand.pitch.real'] = {'Off', 'Emotion', 'Down', 'Up', 'Zero', 'Mixed', 'Custom', 'Shift'},
	['rbot.antiaim.stand.real'] = {'Off', 'Static', 'Spinbot', 'Jitter', 'Zero', 'Switch', 'Shift'},
	['rbot.antiaim.stand.desync'] = {'Off', 'Still', 'Balance', 'Stretch', 'Jitter'},
	['rbot.antiaim.at.targets'] = {'Off', 'Average', 'Closest'},
	['rbot.antiaim.autodir'] = {'Off', 'Default', 'Desync', 'Desync Jitter'}
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

	local autostrafer = GetValue('msc.autostrafer.enable')
	local fakelag = GetValue('msc.fakelag.enable')

	for i=1, #top_right_side do
		local typ = top_right_side[i]
		local var = typ[1]
		local str = type( GetValue(var) ) == 'boolean' and ( GetValue(var) and 'On' or 'Off' ) or var_to_mode[var][GetValue(var) + 1]

		if var == 'msc.autostrafer.mode' then
			str = autostrafer and str or 'Off'
		elseif var == 'msc.fakelag.mode' then
			str = fakelag and str or 'Off'
		end

		TextShadow(550, 81 + (i * 15), typ[2]..': '.. str)
	end

	local rbot_aa_enabled = GetValue('rbot.antiaim.enable')

	for i=1, #right_side do
		local typ = right_side[i]
		local var = typ[1]
		local str = type( GetValue(var) ) == 'boolean' and ( GetValue(var) and 'On' or 'Off' ) or var_to_mode[var][GetValue(var) + 1]

		if var == 'rbot.antiaim.stand.pitch.real' or var == 'rbot.antiaim.stand.real' or var == 'rbot.antiaim.stand.desync' or var == 'rbot.antiaim.at.targets' or var == 'rbot.antiaim.autodir' then
			str = rbot_aa_enabled and str or 'Off'
		end

		TextShadow(550, 216 + (i * 15), typ[2]..': '.. str)
	end
end

callbacks.Register('Draw', main)
