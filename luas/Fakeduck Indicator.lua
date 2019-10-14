local fake_duck_indicator = gui.Checkbox(gui.Reference('VISUALS', 'ENEMIES', 'Options'), 'esp_enemy_fakeduck_ind', 'Is Fakeducking', false)
local fake_duck_indicator_color = gui.ColorEntry('clr_esp_enemy_fakeduck_ind', 'Fake duck', 255, 255, 0, 255)
local g_tickcount = globals.TickCount

local function is_fakeducking(ent)
	local storedTick, crouchedTicks = 0, {}

	local index = ent:GetIndex()
	local duckamount, duckspeed = ent:GetProp('m_flDuckAmount'), ent:GetProp('m_flDuckSpeed')
	local flag = ent:GetProp('m_fFlags')
	local on_ground = flag == 257 or flag == 259 or flag == 261 or flag == 263

	if crouchedTicks[index] == nil then
		crouchedTicks[index] = 0
	end

	if storedTick ~= g_tickcount() then
		crouchedTicks[index] = crouchedTicks[index] + 1
		storedTick = g_tickcount()
	end

	return duckspeed == 8 and duckamount <= 0.9 and duckamount > 0.01 and on_ground and crouchedTicks[index] >= 5
end

local function fakeduck(b)
	local ent = b:GetEntity()
	if not fake_duck_indicator:GetValue() or ent == nil or not ent:IsPlayer() or not ent:IsAlive() then
		return
	end

	if is_fakeducking(ent) then
		b:Color(fake_duck_indicator_color:GetValue())
		b:AddTextBottom('FD')
	end
end

callbacks.Register('DrawESP', fakeduck)
