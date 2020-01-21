-- Nexxed original lua
-- Cheeseot edited original
-- zack edited that edit

local SetConVar, FindByClass, GetLocalPlayer, pairs = client.SetConVar, entities.FindByClass, entities.GetLocalPlayer, pairs
local m, m2 = 1 / 255, 1 / 100

local r = gui.Reference("VISUALS", "MISC", "World")
local colors = gui.ColorEntry('clr_world_modulation', 'World Modulation', 255, 0, 0, 255)
local sli_exposure = gui.Slider(r, "nex_bloom_exposure", "World Exposure", 100, 1, 100)
local sli_modelAmbient = gui.Slider(r, "nex_bloom_model_ambient", "Model Ambient", 1, 1, 100)
local sli_bloom = gui.Slider(r, "nex_bloom_scale", "Bloom Scale", 20, 1, 100)

local var = {
	R = 0,
	G = 0,
	B = 0,
	Ambient = 0,
	Props = 0,
	Exposure = 0,
	Bloom = 0
}

callbacks.Register("Draw", "Modulation", function()
	if not GetLocalPlayer() then
		return
	end

	local r, g, b, a = colors:GetValue()
	local r, g, b, a = r * m, g * m, b * m, a * m

	if var.R ~= r then
		SetConVar("mat_ambient_light_r", r, true)
		var.R = r
	end

	if var.G ~= g then
		SetConVar("mat_ambient_light_g", g, true)
		var.G = g
	end

	if var.B ~= b then
		SetConVar("mat_ambient_light_b", b, true)
		var.B = b
	end

	local con = FindByClass("CEnvTonemapController")[1]

	if not con then
		return
	end

	local sli_e = sli_exposure:GetValue() * m2
	local sli_b = sli_bloom:GetValue() * m2
	local sli_mA = sli_modelAmbient:GetValue()

	if var.Props == 0 then
		con:SetProp("m_bUseCustomAutoExposureMin", 1)
		con:SetProp("m_bUseCustomAutoExposureMax", 1)
		con:SetProp("m_bUseCustomBloomScale", 1)
		var.Props = 1
	end

	if var.Exposure ~= sli_e and var.Props == 1 then
		con:SetProp("m_flCustomAutoExposureMin", sli_e)
		con:SetProp("m_flCustomAutoExposureMax", sli_e)
		var.Exposure = sli_e
	end

	if var.Bloom ~= sli_b and var.Props == 1 then
		con:SetProp("m_flCustomBloomScale", sli_b)
		var.Bloom = sli_b
	end

	if var.Ambient ~= sli_mA then
		SetConVar("r_modelAmbientMin", sli_mA, true)
		var.Ambient = sli_mA
	end
end)