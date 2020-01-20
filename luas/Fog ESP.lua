local SetConVar, FindByClass, GetLocalPlayer, format = client.SetConVar, entities.FindByClass, entities.GetLocalPlayer, string.format
local m, m2, m3 = 1 / 100, 1 / 50, 1 / 255

local ref = gui.Reference('VISUALS', 'MISC', 'Yourself Extra')
local opt = {
	bloom = {
		bloom = gui.Slider(ref, 'world_clr_bloom', 'Bloom', 20, 1, 100),
		value = gui.Slider(ref, 'world_clr_bloom_value', 'Bloom Value', 1, 1, 100)
	},

	fog = {
		enable = gui.Checkbox(ref, 'world_fog_enable', 'Fog Active', true),
		_start = gui.Slider(ref, 'world_fog_start', 'Fog Start', 100, 1, 1000),
		_end = gui.Slider(ref, "world_fog_end", 'Fog End', 1000, 1, 1000),
		max_density = gui.Slider(ref, "world_fog_max_density", 'Fog Max Density', 1, 1, 100),
		zoom_scale = gui.Slider(ref, "world_fog_zoom_scale", "Fog Zoom Scale", 1, 1, 100),
		color = gui.ColorEntry('world_fog_clr', 'Fog Color', -1, -1, -1, 255)
	},

	ghost_meme = gui.Checkbox(ref, 'world_ghost_meme', 'Ghost meme', true),
	world_color = gui.ColorEntry('world_clr', 'World Color', 0, 0, 0, 255),
	map_color = gui.Checkbox(ref, 'world_map_clr', 'World color', true)
}

local function on_game_event(event)
	if event:GetName() ~= 'round_start' then
		return
	end

	local FOG, BLOOM = opt.fog, opt.bloom
	local map_clr_active = opt.map_color:GetValue()
	local map_control = FindByClass('CEnvTonemapController')[1]
	local fog_control = FindByClass('CFogController')[1]

	local S, E, MD = FOG._start:GetValue(), FOG._end:GetValue(), FOG.max_density:GetValue()
	local ghost = opt.ghost_meme:GetValue()
	local local_player = GetLocalPlayer()

	if fog_control then
		local A, ZM = FOG.enable:GetValue(), FOG.zoom_scale:GetValue()

		fog_control:SetProp('m_fog.enable', A)
		fog_control:SetProp('m_fog.start',S)
		fog_control:SetProp('m_fog.end', E)
		fog_control:SetProp('m_fog.maxdensity', MD * m)
		fog_control:SetProp('m_fog.ZoomFogScale', ZM * m)
	end

	if map_control then
		local B, BV = BLOOM.bloom:GetValue(), BLOOM.bloom_value:GetValue()

		map_control:SetProp('m_flCustomBloomScale', B * m2)
		SetConvar('r_modelAmbientMin', BV, true)
		SetConVar('fog_override', 1, true)
		SetConVar('fog_enableskybox', 1, true)
		SetConVar('fog_startskybox', S, true)
		SetConVar('fog_endskybox', E, true)
		SetConVar('fog_maxdensityskybox', MD * m, true)
		local_player:SetProp('m_bIsPlayerGhost', ghost)
	end

	local fR, fG, fB,_ = FOG.color:GetValue()
	local strC = format('%i %i %i', fR, fG, fB)
	SetConVar('fog_color', strC, true)
	SetConVar('fog_colorskybox', strC, true)

	if not map_clr_active then
		SetConVar('mat_ambient_light_r', 0, true)
		SetConVar('mat_ambient_light_g', 0, true)
		SetConVar('mat_ambient_light_b', 0, true)
		return
	end

	local wR, wG, wB,_ = opt.world_color:GetValue()
	SetConVar('mat_ambient_light_r', wR * m3, true)
	SetConVar('mat_ambient_light_g', wG * m3, true)
	SetConVar('mat_ambient_light_b', wB * m3, true)
end

client.AllowListener('round_start')
callbacks.Register('FireGameEvent', on_game_event)
