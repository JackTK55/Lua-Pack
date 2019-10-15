--[[ 
	Created by: iSun
	Edited by: zack
]]--

local localplayer, localplayerindex, listen, GetPlayerIndexByUserID, g_curtime = entities.GetLocalPlayer, client.GetLocalPlayerIndex, client.AllowListener, client.GetPlayerIndexByUserID, globals.CurTime

local msc_ref = gui.Reference('MISC', 'ENHANCEMENT', 'HITMARKERS')
local enabled = gui.Checkbox(msc_ref, 'lua_healthshot_hitmarker_enabled', 'Healthshot hitmarker', false)
local slider = gui.Slider(msc_ref, 'lua_healthshot_hitmarker_slider', 'Healthshot duration (sec)', 1, 0, 10)
local combo = gui.Combobox(msc_ref, 'lua_healthshot_hitmarker_combobox', 'Healthshot hitmarker', 'On hit', 'On kill')

listen('player_hurt')
listen('player_death')
local function healthshot_hitmarker(e)
	if not enabled:GetValue() then
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
	local duration = slider:GetValue()

	if not im_attacker then
		return
	end

	if (combo:GetValue() == 0 and event_name == 'player_hurt') or (combo:GetValue() == 1 and event_name == 'player_death') then
		localplayer():SetProp('m_flHealthShotBoostExpirationTime', g_curtime() + duration)
	end
end

callbacks.Register('FireGameEvent', healthshot_hitmarker)