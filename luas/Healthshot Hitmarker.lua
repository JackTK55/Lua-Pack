--[[
    Created by: iSun
    Edited by: zack
]]

local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime, client_exec, ref, Checkbox, Combobox, Groupbox = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime, client.Command, gui.Reference, gui.Checkbox, gui.Combobox, gui.Groupbox
local h_sounds = {"bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "rifk.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3"}

local show_window = Checkbox(ref('MISC', 'GENERAL', 'MAIN'), 'lua_hs_show_window', 'Show Hitsound and Hitmarker Window', false)
local window = gui.Window('lua_hitsound_and_healthshot_window', 'Hitsound and Hitmarker', 200, 200, 200, 347)
local all_enabled = Checkbox(window, 'lua_hitsound_enabled', 'Hitsound/marker enabled', false)

local group = Groupbox(window, 'Hitsound', 16, 45)
local hs_enabled = Checkbox(group, 'lua_hitsound_enabled', 'Custom hitsound', false)
local hs_sounds = Combobox(group, 'lua_hitsound_combobox', 'Hit', "bass.wav", "bf4.wav", "Bowhit.wav", "bruh.wav", "uagay.wav", "rifk.wav", "Cookie.wav", "windows-error.wav", "roblox.mp3", "vitas.wav", "mhit1.mp3", "gachi.wav", "metro2033.mp3", "minecraft.mp3")

local group = Groupbox(window, 'Hitmarker', 16, 156)
local hs_hm_enabled = Checkbox(group, 'lua_healthshot_hitmarker_enabled', 'Healthshot hitmarker', false)
local hs_hm_slider = gui.Slider(group, 'lua_healthshot_hitmarker_slider', 'Healthshot duration (sec)', 1, 0, 10)
local hs_hm_combo = Combobox(group, 'lua_healthshot_hitmarker_combobox', 'Healthshot hitmarker', 'On hit', 'On kill')

callbacks.Register('Draw', 'Shows the Window', function()
	window:SetActive(show_window:GetValue() and ref('MENU'):IsActive())
end)

listen('player_hurt')
listen('player_death')
local function healthshot_hitmarker(e)
	if not all_enabled:GetValue() then
		return
	end

	local event_name = e:GetName()

	if event_name ~= 'player_hurt' and event_name ~= 'player_death' then
		return
	end

	local me = localplayerindex()
	local victim = GetPlayerIndexByUserID(e:GetInt('userid'))
	local attacker = GetPlayerIndexByUserID(e:GetInt('attacker'))
	local im_attacker = attacker == me and victim ~= me
	local duration = hs_hm_slider:GetValue()
	local hs_hm_on = hs_hm_combo:GetValue()

	if not im_attacker then
		return
	end

	if hs_hm_enabled:GetValue() then
		if (hs_hm_on == 0 and event_name == 'player_hurt') or (hs_hm_on == 1 and event_name == 'player_death') then
			localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
		end
	end

	if hs_enabled:GetValue() then
		if event_name == 'player_hurt' then
			local cmd = 'play ' .. h_sounds[hs_sounds:GetValue() + 1]
			client_exec(cmd, true)
		end
	end
end

callbacks.Register('FireGameEvent', healthshot_hitmarker)