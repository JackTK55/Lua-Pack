local get_spectators = function()
	local spectators, N = {}, 1
	local lp = entities.GetLocalPlayer()

	if not lp then
		return spectators
	end

	local lp_index = client.GetLocalPlayerIndex()
	local lp_alive = lp:IsAlive()
	local lp_obs_target = lp:GetPropEntity('m_hObserverTarget')
	local players = entities.FindByClass('CCSPlayer')
	local player_resources = entities.GetPlayerResources()

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
