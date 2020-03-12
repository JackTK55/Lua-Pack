local Register, GetLocalPlayerIndex, Color, CreateFont, GetScreenSize, GetTextSize, SetFont, TextShadow, FindByClass, GetLocalPlayer, GetPlayerResources, Checkbox, Reference = callbacks.Register, client.GetLocalPlayerIndex, draw.Color, draw.CreateFont, draw.GetScreenSize, draw.GetTextSize, draw.SetFont, draw.TextShadow, entities.FindByClass, entities.GetLocalPlayer, entities.GetPlayerResources, gui.Checkbox, gui.Reference

local enabled = Checkbox(Reference('Misc', 'General', 'Extra'), 'spec_list', 'Spectator List', false)
enabled:SetDescription('Shows who is spectating you/whoever you are spectating')

local font = CreateFont('Verdana', 12, 200)

local get_spectators = function()
	local spectators, N = {}, 1
	local lp = GetLocalPlayer()

	if not lp then
		return spectators
	end

	local lp_index = GetLocalPlayerIndex()
	local lp_alive = lp:IsAlive()
	local lp_obs_target = lp:GetPropEntity('m_hObserverTarget')
	local players = FindByClass('CCSPlayer')
	local player_resources = GetPlayerResources()

	for i=1, #players do
		local ent = players[i]
		local ent_index = ent:GetIndex()
		local obs_target = ent:GetPropEntity('m_hObserverTarget')

		if obs_target and player_resources:GetPropInt('m_iPing', ent_index) > 0 and ent_index ~= lp_index then
			local target_index = obs_target:GetIndex()

			if lp_alive then
				if not ent:IsAlive() and target_index == lp_index then
					spectators[N] = ent
					N = N + 1
				end
			else
				if ent:IsAlive() and lp_obs_target then
					if target_index == lp_obs_target:GetIndex() then
						spectators[N] = ent
						N = N + 1
					end
				end
			end
		end
	end

	return spectators
end

local function draw_spectators()
	if not enabled:GetValue() then
		return
	end

	local spectators = get_spectators()
	local X = GetScreenSize()
	local x = X - 5

	for i=1, #spectators do
		local entity = spectators[i]
		local name = entity:GetName()

		SetFont(font)
		Color(255, 255, 255, 255)

		local tW, tH = GetTextSize(name)

		TextShadow(x - tW, i * (tH + 5), name)
	end
end

Register('Draw', draw_spectators)
