local GetLocalPlayer, GetPlayerResources, FindByClass = entities.GetLocalPlayer, entities.GetPlayerResources, entities.FindByClass

local get_spectators = function()
	local spectators = {}
	local local_player = GetLocalPlayer()

	if not local_player then
		return spectators
	end

	local alive = local_player:IsAlive()
	local index = GetLocalPlayerIndex()
	local target = local_player:GetPropEntity('m_hObserverTarget')
	local resources = GetPlayerResources()
	local players = FindByClass('CCSPlayer')

	for i=1, #players do
		local ent = players[i]
		local ent_index = ent:GetIndex()

		if not ent:IsAlive() and resources:GetPropInt('m_iPing', ent_index) ~= 0 and ent_index ~= index then
			local ent_target = ent:GetPropEntity('m_hObserverTarget'):GetIndex()

			if alive then
				if ent_target == index then
					spectators[#spectators + 1] = ent:GetName()
				end
			else
				if target then
					if target:GetIndex() == ent_target then
						spectators[#spectators + 1] = ent:GetName()
					end
				end
			end
		end
	end

	return spectators
end
