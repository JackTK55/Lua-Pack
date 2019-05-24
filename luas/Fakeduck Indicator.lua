local fake_duck_indicator = gui.Checkbox(gui.Reference('VISUALS', 'ENEMIES', 'Options'), 'esp_enemy_fakeduck_ind', 'Is Fakeducking', false)
local fake_duck_indicator_color = gui.ColorEntry('clr_esp_enemy_fakeduck_ind', 'Fake duck', 255, 255, 0, 255)

local function is_fakeducking(entity)
	local storedTick = 0
	local crouchedTicks = {}

	local duckamount = entity:GetProp('m_flDuckAmount')
	local duckspeed = entity:GetProp('m_flDuckSpeed')
	local on_ground = entity:GetProp('m_fFlags') == 257 or entity:GetProp('m_fFlags') == 259 or entity:GetProp('m_fFlags') == 261 or entity:GetProp('m_fFlags') == 263

	if crouchedTicks[entity:GetIndex()] == nil then
		crouchedTicks[entity:GetIndex()] = 0
	end

	if storedTick ~= g_tickcount() then
		crouchedTicks[entity:GetIndex()] = crouchedTicks[entity:GetIndex()] + 1
		storedTick = g_tickcount()
	end

	return duckspeed == 8 and duckamount <= 0.9 and duckamount > 0.01 and on_ground and crouchedTicks[entity:GetIndex()] >= 5
end

function fakeduck(b)
	if not fake_duck_indicator:GetValue() or b:GetEntity() == nil or not b:GetEntity():IsPlayer() or not b:GetEntity():IsAlive() then
		return
	end

	if is_fakeducking(b:GetEntity()) then
		b:Color(fake_duck_indicator_color:GetValue())
		b:AddTextBottom('Fake Ducking')
	end
end

callbacks.Register('DrawESP', fakeduck)