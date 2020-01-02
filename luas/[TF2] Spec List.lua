local GetLocalPlayer, LocalPlayerIndex, FindByClass, GetScreenSize, GetTextSize, Color, TextShadow, SetFont = entities.GetLocalPlayer, client.GetLocalPlayerIndex, entities.FindByClass, draw.GetScreenSize, draw.GetTextSize, draw.Color, draw.TextShadow, draw.SetFont
local font = draw.CreateFont('Tahoma', 14)
local r, g, b  = 255, 255, 255

local X, Y = 1920, 1080 -- Screen Width, Height
local X, Y = X * 0.5, (Y * 0.5) + 5

local get_spectators = function()
	local s = {}

	local players = FindByClass('CTFPlayer')
	local lpi = LocalPlayerIndex()
	local lp = GetLocalPlayer()

	if lp == nil then
		return s
	end

	for i=1, #players do
		local player = players[i]
		local obsTarget = player:GetPropEntity('m_hObserverTarget')
		local iSpec = lp:GetPropEntity('m_hObserverTarget')

		if obsTarget ~= nil and i ~= lpi and not player:IsAlive() then
			local TargetIndex = obsTarget:GetIndex()	

			if lp:IsAlive() and TargetIndex == lpi then
				local name = player:GetName()
				local obsMode = player:GetProp('m_iObserverMode') == 4 -- 4 is first person
				s[#s + 1] = {name, obsMode}

			elseif lp:IsAlive() and iSpec ~= nil and TargetIndex == iSpec:GetIndex() then
				local name = player:GetName()
				local obsMode = player:GetProp('m_iObserverMode') == 4 -- 4 is first person
				s[#s + 1] = {name, obsMode}
			end
		end
	end

	return s
end

callbacks.Register('Draw', function()
	local spectators = get_spectators()

	for i=1, #spectators do
		local n = spectators[i]
		SetFont(font)
		local tW, tH = GetTextSize(n[1])

		if n[2] then
			r, g, b = 200, 63, 63
		else
			r, g, b = 230, 230, 230
		end

		Color(r, g, b, 255)
		TextShadow(X - (tW * 0.5), Y + (tH * i), n[1])
	end
end)
