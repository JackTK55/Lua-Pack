local FindByClass, SetConVar, format = entities.FindByClass, client.SetConVar, string.format
local m, m1, m2 = 1 / 100, 1 / 50, 1 / 255

local tab = gui.Tab(gui.Reference('Visuals'), 'world_modulation', 'World Modulation')
local group = gui.Groupbox(tab, 'Modulation', 16, 16)

local opts = {
	gui.Slider(group, 'bloom_scale', 'Bloom Scale', 20, 1, 100),
	gui.Slider(group, 'bloom_value', 'Bloom Value', 1, 1, 100),

	gui.Slider(group, 'fog_start', 'Fog Start', 100, 1, 1000),
	gui.Slider(group, 'fog_end', 'Fog End', 1000, 1, 1000),
	gui.ColorPicker(group, 'fog_color', 'Fog Color', 255, 255, 255),

	gui.Slider(group, 'max_density', 'Max Density', 1, 1, 100),
	gui.Slider(group, 'zoom_scale', 'Zoom Scale', 1, 1, 100),
	gui.Slider(group, 'bloom_exposure', 'World Exposure', 100, 1, 100),

	gui.Slider(group, 'modulation_red', 'Modulation: Red', 255, 0, 255),
	gui.Slider(group, 'modulation_green', 'Modulation: Green', 255, 0, 255),
	gui.Slider(group, 'modulation_blue', 'Modulation: Blue', 255, 0, 255)
}

local b, f, o, o2 = 0, 0, 0, 0
for i=1, #opts do
	local obj = opts[i]
	local name = obj:GetName()
	obj:SetWidth(170)

	if name:find('Bloom') then
		obj:SetPosY(0)
		obj:SetPosX(b)
		b = b + 186
	elseif name:find('Fog') then
		obj:SetPosY(60)
		obj:SetPosX(f)
		f = f + 186
	elseif name:find('Modulation') then
		obj:SetPosY(124)
		obj:SetPosX(o)
		o = o + 186
	else
		obj:SetPosY(188)
		obj:SetPosX(o2)
		o2 = o2 + 186
	end
end

local bloom_scale, bloom_value, fog_start, fog_end, fog_color, max_density, zoom_scale, sli_exposure, mod_r, mod_g, mod_b = unpack(opts)
local last = -1

local function main()
	last = (last + 1) % 10

	if last ~= 0 then
		return
	end

	pcall(function()
		local CFogController = FindByClass('CFogController')[1]
		local CEnvTonemapController = FindByClass('CEnvTonemapController')[1]
		local start, _end, maxdensity = fog_start:GetValue(), fog_end:GetValue(), max_density:GetValue() * m

		CFogController:SetProp('m_fog.enable', 1)
		CFogController:SetProp('m_fog.start', start)
		CFogController:SetProp('m_fog.end', _end)
		CFogController:SetProp('m_fog.maxdensity', maxdensity)
		CFogController:SetProp('m_fog.ZoomFogScale', zoom_scale:GetValue() * m)

		CEnvTonemapController:SetProp('m_flCustomBloomScale', bloom_scale:GetValue() * m1)
			SetConVar('r_modelAmbientMin', bloom_value:GetValue(), true)

		CEnvTonemapController:SetProp('m_bUseCustomAutoExposureMin', 1)
		CEnvTonemapController:SetProp('m_bUseCustomAutoExposureMax', 1)

		local sli_exposure = sli_exposure:GetValue() * m
			CEnvTonemapController:SetProp('m_flCustomAutoExposureMin', sli_exposure)
			CEnvTonemapController:SetProp('m_flCustomAutoExposureMax', sli_exposure)

		SetConVar('fog_override', 1, true)
		SetConVar('fog_enableskybox', 1, true)
		SetConVar('fog_startskybox', start, true)
		SetConVar('fog_endskybox', _end, true)
		SetConVar('fog_maxdensityskybox', maxdensity, true)

		SetConVar('mat_ambient_light_r', mod_r:GetValue() * m2, true)
		SetConVar('mat_ambient_light_g', mod_g:GetValue() * m2, true)
		SetConVar('mat_ambient_light_b', mod_b:GetValue() * m2, true)

		local color = format('%i %i %i', fog_color:GetValue())
			SetConVar('fog_color', color, true)
			SetConVar('fog_colorskybox', color, true)
	end)
end

callbacks.Register('Draw', main)
